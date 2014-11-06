//
//  User.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wishlist.h"
#import "Inventory.h"
/**
    This class that represents a user in the program. The user will have data associated with it, such as name, address, location, etc.. Users will also have ratings. User will have an inventory, which contains items that they want to trade. They will also have an wish list containing items that they want to trade for.
 */
@interface User : NSObject {
    /**
     Name of the user
     */
    NSString* name;
    /**
     username os the user, used for logging in
     */
    NSString* username;
    /**
     wishlist of the user
     */
    Wishlist* wishlist;
    /**
     inventory of the user
     */
    Inventory* inventory;
}

/**
 Create a new user
 @param n name
 @param u username
 @param w wishlist
 @param i inventory
 */
-(id)initWithName:(NSString*)n andUsername:(NSString*)u andWishlist:(Wishlist*)w andInventory:(Inventory*)i;
/**
Returns the name of the user
 @return name
 */
-(NSString*) getName;
/**
 Returns the username
 @return username
 */
-(NSString*) getUsername;
/**
 Returns the wishlist containing the items that the user wants
 @return wishlist
 */
-(Wishlist*) getWishlist;
/**
 Returns the inventory contaning the items that the user has to offer
 @return inventory
 */
-(Inventory*) getInventory;

@end
