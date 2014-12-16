//
//  Inventory.h
//  Shuq
//
//  Created by Joseph Min on 10/30/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "ItemList.h"
/**
 This class will contain all of the items that a user is offering.
 */
@interface Inventory : ItemList 

/**
 Create new inventory
 */
-(id)init;
/**
 Iniatiates the object from a JSON
 */
- (instancetype) initWithDictionary:(NSDictionary*)dictionary;
/**
 Returns a list of all of the items in the inventory
 @return items in inventory */
-(NSMutableArray*) getInventoryItems;
/**
 Adds a new item to the inventory
 @param i item to add
 */
-(void) addItem:(Item*)i;
/**
 Returns the item at the specific position in the inventory
 @param i index
 @return the item at index i
 */
-(Item*) getItem:(NSUInteger*)i;
/**
 Removes the item at the specific position in the inventory
 @param i index
 @return the removed item
 */
-(void) removeItem:(Item*)i;
/**
 Convert to JSONable object
 */
- (NSDictionary*) toDictionary;

@end
