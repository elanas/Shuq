//
//  Wishlist.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "ItemList.h"
/**
 This class contains the items that the local user would like to trade for
 */
@interface Wishlist : ItemList

/**
 create new wishlist
 */
-(id)init;
/**
 Iniatiates the object from a JSON
 */
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;
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
 Removes all items in the wishlist
 */
-(void) emptyWishlist;
/**
 Convert to JSONable object
 */
- (NSDictionary*) toDictionary;


@end
