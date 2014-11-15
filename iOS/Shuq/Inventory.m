//
//  Inventory.m
//  Shuq
//
//  Created by Joseph Min on 10/30/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "Inventory.h"
#define safeSet(d,k,v) if (v) d[k] = v;

@implementation Inventory

-(id)init {
    self = [super init];
    if (self) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self)
    {
        NSMutableArray* itemJSON = dictionary[@"items"];
        for (NSUInteger i=0; i< [itemJSON count]; i++)
        {
            Item* item = [[Item alloc] initWithName:[itemJSON objectAtIndex:i][@"name"]];
            [item setDesc:[itemJSON objectAtIndex:i][@"description"]];
            NSMutableArray* tagJSON = dictionary[@"taflist"];
            for(NSUInteger n=0; n< [tagJSON count]; n++)
            {
                [item addTag:[tagJSON objectAtIndex:n][@"tagname"]];
            }
            [self addItem:item];
        }
    }
    return self;
}


-(NSMutableArray*) getInventoryItems {
    return items;
}

-(void) addItem:(Item*)i {
    [items addObject:i];
}

-(Item*) getItem:(NSUInteger*)i {
    if ([items objectAtIndex:*i] != nil) {
        return [items objectAtIndex:*i];
    }
    return nil;
}

-(Item*) removeItem:(NSUInteger*)i {
    if ([items objectAtIndex:*i] != nil) {
        Item* toReturn = [items objectAtIndex:*i];
        [items removeObjectAtIndex:*i];
        return toReturn;
    }
    return nil;
}
- (NSDictionary*) toDictionary
{
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
     for (NSUInteger i = 0; i < [items count]; i++) {
         NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
         NSMutableArray* itemJSON =[[NSMutableArray alloc] init];
         
         for (NSUInteger i = 0; i < [items count]; i++) {
             
             NSMutableDictionary* item = [NSMutableDictionary dictionary];
             item[@"name"] = [[items objectAtIndex:i] getName];
             
             //Problem with int
             //item[@"value"]= [[items objectAtIndex:i] getValue];
             
             item[@"description"]= [[items objectAtIndex:i] getDesc];
             
             NSMutableArray* tagList = [[items objectAtIndex:i]getTags];
             NSMutableArray* tagJSON =[[NSMutableArray alloc] init];
             for(NSUInteger n = 0; n < [tagList count]; n++) {
                 [tagJSON addObject: [[tagList objectAtIndex:n] toDictionary]];
             }
             item[@"taglist"] = tagJSON;
             [itemJSON addObject:item];
         }
         safeSet(jsonable, @"items", itemJSON);
         return jsonable;

     }
    return jsonable;
}
@end
