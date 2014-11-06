//
//  Wishlist.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
/**
 This class contains the items that the local user would like to trade for
 */
@interface Wishlist : NSObject {
    /**
     List of items in the wishlist
     */
    NSMutableArray* items;
}

/**
 create new wishlist
 */
-(id)init;
/**
 Returns a list of all of the items in the wishlist
 @return items in wishlist
 */
-(NSMutableArray*) getWishlistItems;
/**
 Adds a new item to the wishlist
 @param i item to add
 */
-(void) addItem:(Item*)i;
/**
 Returns the item at the specific position in the wishlist
 @param i index
 @return the item at index i
 */
-(Item*) getItem:(NSUInteger*)i;
/**
 Removes the item at the specific position in the wishlist
 @param i index
 @return the delted item
 */
-(Item*) removeItem:(NSUInteger*)i;
/**
 Removes all items in the wishlist
 */
-(void) emptyWishlist;



@end
