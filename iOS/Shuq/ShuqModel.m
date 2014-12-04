//
//  ShuqModel.m
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "ShuqModel.h"

@implementation ShuqModel

static NSString* const kBaseURL = @"http://localhost:3000/";
static NSString* const kLocations = @"user";

-(id)init {
    self = [super init];
    if (self) {
        users = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*)getUsers {
    return users;
}

-(User*)getPrimaryUser {
    return primaryUser;
}

+(id)getModel {
    static ShuqModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[self alloc] init];
    });
    return model;
}

-(Boolean)authenticateUser:(NSString*)username andPassword:(NSString*)password isNewUser:(BOOL)newUser{

    BOOL isValid;
    
    //checking if in database
    if ([username length] == 0) {
        return false;
    }    if(newUser) {
        isValid = [self addNewUserToServerWithUsername:username andPassword:password];
    } else {
        isValid = [self getUserFromServerWithUsername:username andPassword:password];
    }
    
    if(isValid) {
        //will eventually return a user above
        if(newUser) {
        primaryUser = [[User alloc] initWithUsername:username andWishlist:[[Wishlist alloc] init] andInventory:[[Inventory alloc] init] andSettings:0 andLocation:@"Baltimore" andPassword:password];
        }
        return TRUE;
    } else {
        //do something to alert user
        return FALSE;
    }
    
}
- (void) updateUser:(User*)user
{
    if (!user ) {
        return; //input safety check
    }
    
    
    
    NSString* locations = [kBaseURL stringByAppendingPathComponent:kLocations];
    
    BOOL isExistingLocation = [user getUniqueID] != nil;
    
    NSURL* url = isExistingLocation ? [NSURL URLWithString:[locations stringByAppendingPathComponent:[user getUniqueID]]] :
    [NSURL URLWithString:locations]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = isExistingLocation ? @"PUT" : @"POST"; //2
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:[user toDictionary] options:0 error:NULL]; //3
    request.HTTPBody = data;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (!error) {
//            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
//            NSLog(@"%@", responseArray);
//            [self parseAndGetUsers:responseArray toArray:users];
        } else {
            NSLog(@"ERROR");
        }
    }];
    [dataTask resume];
}

- (void)import
{
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:kLocations]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
            [self parseAndGetUsers:responseArray toArray:users]; //7
            
        }
    }];
    
    [dataTask resume];
    
}

-(BOOL)getUserFromServerWithUsername:(NSString*)user andPassword:(NSString*)pass {
    NSString* userAuth = [@"auth" stringByAppendingPathComponent:user];
    userAuth = [userAuth stringByAppendingString:@":"];
    userAuth = [userAuth stringByAppendingString:pass];

    
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:userAuth]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    __block BOOL validAuth = nil;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        
        if (error == nil) {
            NSString *responseBody = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            if([responseBody rangeOfString:@"error"].location!= NSNotFound) {
            //if([responseBody containsString:@"error"]) {
                
                
                //authentication failed
                validAuth = FALSE;
            } else {
                
                //authentication successful
                NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
                [self getParsePrimaryUser:responseArray];
                validAuth = TRUE;
            }
            dispatch_semaphore_signal(semaphore);

        } else {
            //error
            dispatch_semaphore_signal(semaphore);
        }
    }];
    
    
    [dataTask resume];

    //waiting for the call to be done
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    return validAuth;
}

-(BOOL)addNewUserToServerWithUsername:(NSString*)username andPassword:(NSString*)password {
    
    User *user = [[User alloc]initWithUsername:username andWishlist:[[Wishlist alloc]init] andInventory:[[Inventory alloc]init] andSettings:nil andLocation:@"Baltimore" andPassword:password];
    
    //check if username is valid
    //should check db to see if username already exists
    if (!user || [username length] == 0) {
        return FALSE; //input safety check
    }
    
    NSString* locations = [kBaseURL stringByAppendingPathComponent:kLocations];
    
    BOOL isExistingLocation = [user getUniqueID] != nil;
    
    NSURL* url = isExistingLocation ? [NSURL URLWithString:[locations stringByAppendingPathComponent:[user getUniqueID]]] :
    [NSURL URLWithString:locations]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = isExistingLocation ? @"PUT" : @"POST"; //2
    
    
    NSData* data = [NSJSONSerialization dataWithJSONObject:[user toDictionary] options:0 error:NULL]; //3
    request.HTTPBody = data;
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (!error) {
            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];

            //parse users
            [self parseAndSetPrimaryUser:responseArray];

        }
        else {
            //Do something about same username
        }
    }];
    [dataTask resume];
    return TRUE;
}

- (void) saveNewItemImage:(Item*)item
{
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:@"files"]]; //1
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST"; //2
    [request addValue:@"image/png" forHTTPHeaderField:@"Content-Type"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSData* bytes = UIImagePNGRepresentation([item getImage]); //4
    NSURLSessionUploadTask* task = [session uploadTaskWithRequest:request fromData:bytes completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil && [(NSHTTPURLResponse*)response statusCode] < 300) {
            NSDictionary* responseDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            [item setImageId:responseDict[@"_id"]] ; //6
            
        }
    }];
    [task resume];
}

- (void) loadImage:(Item*)item {
    NSURL* url = [NSURL URLWithString:[[kBaseURL stringByAppendingPathComponent:@"files"] stringByAppendingPathComponent:[item getImageID]]]; //1
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDownloadTask* task = [session downloadTaskWithURL:url completionHandler:^(NSURL *fileLocation, NSURLResponse *response, NSError *error) { //2
        if (!error) {
            NSData* imageData = [NSData dataWithContentsOfURL:fileLocation]; //3
            UIImage* image = [UIImage imageWithData:imageData];
            if (!image) {
                NSLog(@"unable to build image");
            }
            
            [item setImage:image];
            
        }
    }];
    
    [task resume]; //4
}

-(void) parseAndGetUsers:(NSArray*) us toArray:(NSMutableArray*) destinationArray
{
        for (NSDictionary* item in us) {
            User* user = [[User alloc] initWithDictionary:item];
            [destinationArray addObject:user];
        }
}
-(void) parseAndSetPrimaryUser:(NSArray*) us
{
    if([us count] !=1) {
        return;
    }
    for (NSDictionary* item in us) {
        User* user = [[User alloc] initWithDictionary:item];
        primaryUser = user;
        //NSLog(@"%@", [primaryUser getUniqueID]);
    }
}
-(void) getParsePrimaryUser:(NSArray*) us
{
        User* user = [[User alloc] initWithDictionary:us];
        primaryUser = user;
    
        //Potentially load images
    
       // NSLog(@"%@", [primaryUser getUniqueID]);
}

@end
