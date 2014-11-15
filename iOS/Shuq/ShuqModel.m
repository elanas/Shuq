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
        primaryUser = [[User alloc] initWithUsername:@"BestUserEver" andWishlist:[[Wishlist alloc] init] andInventory:[[Inventory alloc] init] andSettings:0 andLocation:@"Baltimore" andPassword:@"hello"];
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

    NSLog(@"username: %@", username);

    if ([username length] == 0) {
        NSLog(@"False");
        return false;
    }
    NSLog(@"True");
    return true;
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
            //UPDATE with return
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
            //[self parseAndAddLocations:responseArray toArray:self.objects]; //7
            NSLog(@"here");
            
        }
    }];
    
    [dataTask resume];
    
}

@end
