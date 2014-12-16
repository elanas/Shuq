//
//  ItemList.h
//  Shuq
//
//  Created by Joseph Min on 12/14/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface ItemList : NSObject {
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
-(NSMutableArray*) getItems;
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
 @param i item
 */
-(void) removeItem:(Item*)i;

@end
