//
//  Wishlist.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface Wishlist : NSObject {
    NSMutableArray* items;
}


-(id)init;
-(NSMutableArray*) getWishlistItems;
-(void) addItem:(Item*)i;
-(Item*) getItem:(NSUInteger*)i;
-(Item*) removeItem:(NSUInteger*)i;
-(void) emptyWishlist;



@end
