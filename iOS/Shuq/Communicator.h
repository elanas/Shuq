//
//  Communicator.h
//  Shuq
//
//  Created by Joshua Barza on 12/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Communicator : NSObject
/**
 Puts the specified user to the server
 @param user the user to put
 */
-(void)updateUser:(User*)user;
/**
 Makes a call to run the match algorith on the server.
 @param user the user to make matches for
 */
-(void)runUserMatches:(NSString*)user;
/**
 Post a new item image to the server
 @param item the item with an image to call
 */
- (void) saveNewItemImage:(Item*)item;

@end
