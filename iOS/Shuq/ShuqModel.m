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

-(Boolean)authenticateUser:(NSString*)username andPassword:(NSString*)password {

    //    [self addNewUserToServerWithUsername:username andPassword:password];
    NSLog(@"HERE");
    NSLog(@"username: %@", username);
    [self addNewUserToServerWithUsername:username andPassword:password];
    
    
    //checking if in database
    if ([username length] == 0) {
        NSLog(@"False");
        return false;
    }
    
    //creates new user
    primaryUser = [[User alloc] initWithUsername:username andWishlist:[[Wishlist alloc] init] andInventory:[[Inventory alloc] init] andSettings:0 andLocation:@"Baltimore" andPassword:@"hello"];
    
    
    return true;
}
- (void) persist:(User*)user
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
    NSLog(@"%@", data);
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        NSLog(@"testing?");
        if (!error) {
            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            [self parseAndGetUsers:responseArray toArray:users];
            NSLog(@"Worked");
        }
        else {
            NSLog(@"Did Not Worked");
        }
    }];
    NSLog(@"heelp");
    [dataTask resume];
    NSLog(@"stop");
}

- (void)import
{
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:kLocations]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    NSLog(@"reached");
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
            [self parseAndGetUsers:responseArray toArray:users]; //7
            NSLog(@"here");
            
        }
    }];
    
    [dataTask resume];
    
}

-(BOOL)getUserFromServer {
    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:kLocations]]; //1
    
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET"; //2
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    NSLog(@"reached");
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        if (error == nil) {
            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
            //Parse user
            [self parseAndSetPrimaryUser:responseArray];
            NSLog(@"here");
            
        }
    }];
    
    [dataTask resume];
    return TRUE;
}

-(BOOL)addNewUserToServerWithUsername:(NSString*)username andPassword:(NSString*)password {
    
    User *user = [[User alloc]initWithUsername:username andWishlist:[[Wishlist alloc]init] andInventory:[[Inventory alloc]init] andSettings:nil andLocation:@"Baltimore" andPassword:password];
    
    if (!user ) {
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
    NSLog(@"%@", data);
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"]; //4
    
    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
        NSLog(@"testing?");
        if (!error) {
            NSArray* responseArray = @[[NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]];
            //parse user
            [self parseAndSetPrimaryUser:responseArray];
            NSLog(@"Worked");
        }
        else {
            NSLog(@"Did Not Worked");
        }
    }];
    NSLog(@"heelp");
    [dataTask resume];
    NSLog(@"stop");
    return TRUE;
}

-(void) parseAndGetUsers:(NSArray*) us toArray:(NSMutableArray*) destinationArray
{
        NSLog(@"%lu",(unsigned long)[us count]);
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
     NSLog(@"before");
    //NSLog(primaryUser);
    for (NSDictionary* item in us) {
        User* user = [[User alloc] initWithDictionary:item];
        primaryUser = user;
    }
     NSLog(@"after");
    NSLog(@"%lu",(unsigned long)[[[primaryUser getInventory] getInventoryItems] count]);
}

@end
