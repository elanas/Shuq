//
//  User.m
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "User.h"
#define safeSet(d,k,v) if (v) d[k] = v;

@implementation User

-(id)initWithUsername:(NSString*)u andWishlist:(Wishlist*)w andInventory:(Inventory*)i andSettings:(Settings*)s andLocation:(NSString*) l andPassword:(NSString*)p {
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

- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        username = dictionary[@"username"];
        unid = dictionary[@"userID"];
        location = dictionary[@"location"];
        password = dictionary[@"password"];
        wishlist = [[Wishlist alloc] initWithDictionary: dictionary[@"wishlist"]];
        inventory = [[Inventory alloc] initWithDictionary: dictionary[@"wishlist"]];
        settings = [[Settings alloc] initWithDictionary: dictionary[@"wishlist"]];
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
- (NSDictionary*) toDictionary
{
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    safeSet(jsonable, @"username", username);
    safeSet(jsonable, @"userID", unid);
    safeSet(jsonable, @"location", location);
    safeSet(jsonable, @"password", password);
    safeSet(jsonable, @"wishlist", [wishlist toDictionary]);
    safeSet(jsonable, @"inventory", [inventory toDictionary]);
    safeSet(jsonable, @"settings", [settings toDictionary]);
    
    return jsonable;
}
-(NSString*) getUniqueID {
    return unid;
}


@end
