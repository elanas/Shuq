//
//  User.m
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "User.h"

@implementation User

-(id)initWithUserName:(NSString*)u andWishlist:(Wishlist*)w andInventory:(Inventory*)i andSettings:(Settings*)s andLocation:(NSString*) l andPassWord:(NSString*)p {
    self = [super init];
    
    if (self) {
        username = u;
        wishlist = w;
        inventory = i;
        settings = s;
        location = l;
        password = p;
    }
    return self;
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

-(NSString*) getLocation {
    return location;
}

-(Boolean) checkPassword: (NSString*) p {
    return password == p;
}


@end
