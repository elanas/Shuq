//
//  Wishlist.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Wishlist : NSObject {
    NSArray* items;
}


-(id)initWithName:(NSString *)name;
-(NSArray*) getItems;

@end
