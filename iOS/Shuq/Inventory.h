//
//  Inventory.h
//  Shuq
//
//  Created by Joseph Min on 10/30/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Inventory : NSObject {
    NSMutableArray* items;
}


-(id)init;
-(NSMutableArray*) getInventoryItems;
-(void) addItem:(Item*)i;
-(Item*) getItem:(NSUInteger*)i;
-(Item*) removeItem:(NSUInteger*)i;

@end
