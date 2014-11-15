//
//  Wishlist.m
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "Wishlist.h"
#define safeSet(d,k,v) if (v) d[k] = v;

@implementation Wishlist

-(id)init {
    self = [super init];
    if (self) {
        items = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*) getWishlistItems {
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

-(void) emptyWishlist {
    for (NSUInteger i = 0; i < [items count]; i++) {
        [items removeObjectAtIndex:i];
    }
}
- (NSDictionary*) toDictionary
{
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    
    for (NSUInteger i = 0; i < [items count]; i++) {
        
    }
    return jsonable;
}


@end
