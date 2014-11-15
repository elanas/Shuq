//
//  ShuqModel.m
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "ShuqModel.h"

@implementation ShuqModel

-(id)init {
    self = [super init];
    if (self) {
        primaryUser = [[User alloc] initWithUsername:@"BestUserEver" andWishlist:[[Wishlist alloc] init] andInventory:[[Inventory alloc] init] andSettings:0 andLocation:@"Baltimore" andPassword:@"hello"];
        users = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*)getUsers {
    return users;
}

-(User*)getPrimaryUser {
    return primaryUser;
}

+(id)getModel {
    static ShuqModel *model = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model = [[self alloc] init];
    });
    return model;
}

@end
