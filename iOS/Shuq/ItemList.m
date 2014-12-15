//
//  ItemList.m
//  Shuq
//
//  Created by Joseph Min on 12/14/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "ItemList.h"
#import "ShuqModel.h"
#define safeSet(d,k,v) if (v) d[k] = v;

@implementation ItemList
-(id)init {
    self = [super init];
    if (self) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*) getItems {
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

@end
