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
        users = [[NSMutableArray alloc] init];
    }
    return self;
}

-(NSMutableArray*)getUsers {
    return users;
}

@end
