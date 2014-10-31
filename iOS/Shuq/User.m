//
//  User.m
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithName:(NSString*)n andUsername:(NSString*)u andWishlist:(Wishlist*)w andInventory:(Inventory*)i {
    self = [super init];
    
    if (self) {
        name = n;
        username = u;
        wishlist = w;
        inventory = i;
    }
    return self;
}

-(NSString*) getName {
    return name;
}

-(NSString*) getUsername {
    return username;
}

-(Wishlist*) getWishlist {
    return wishlist;
}

-(Inventory*) getInventory {
    return inventory;
}

@end
