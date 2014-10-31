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

@interface User : NSObject {
    NSString* name;
    NSString* username;
    Wishlist* wishlist;
    Inventory* inventory;
}


-(id)initWithName:(NSString*)n andUsername:(NSString*)u andWishlist:(Wishlist*)w andInventory:(Inventory*)i;
-(NSString*) getName;
-(NSString*) getUsername;
-(Wishlist*) getWishlist;
-(Inventory*) getInventory;

@end
