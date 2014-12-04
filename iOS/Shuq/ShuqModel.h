//
//  ShuqModel.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
/** This is local model for the application that will run on the iphone. It will handle setting up the connection to the server. It will allow user to login or signup into a local user object. It will also contain a list of Users that have been matched to the local user via an active or passive search.
 
 */
@interface ShuqModel : NSObject {
    /**
    The local user
     */
    User *primaryUser;
    /**
        List of other users that the local user has been matched to
     */
    NSMutableArray *users;
    
    BOOL _isValid;
}

-(BOOL)isValidAuth;

-(void)setIsValid:(BOOL)valid;

/**
    Create the ShuqModel
 */
-(id)init;
/**
 Returns the list of other users that the local user has been matched to
 @return list of other users
 */
-(NSMutableArray*)getUsers;
/**
 Returns the primary user
 @return the primary user
 */
-(User*)getPrimaryUser;
/**
 Authenticate the given username/password combo
 @return a boolean whether or not it was valid
 */
-(Boolean)authenticateUser:(NSString*)username andPassword: (NSString*)password isNewUser:(BOOL)newUser;

-(void)updateUser:(User*)user;


/**
 gets the global varable of the model
 */
+(id)getModel;

/**
 Posts User to the server
 user to post.
 */
- (void) persist:(User*)user;
/**
 imports users from server
 */
- (void) import;
/**
 Gets the users objects from a JSON object
 @param users array of json user items
 @param destinationArray arrray to store users
 */
- (void) parseAndGetUsers:(NSArray*) us toArray:(NSMutableArray*) destinationArray;
/**
 Gets the user objects from a JSON object and sets it to primary user
 @param users array of json user items
 */
- (void) parseAndGetUsers:(NSArray*) us;


@end
