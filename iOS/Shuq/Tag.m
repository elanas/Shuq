//
//  Tag.m
//  Shuq
//
//  Created by Joshua Barza on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "Tag.h"

@implementation Tag

-(id)initWithName: (NSString*) n {
    self = [super init];
    if (self) {
        name = n;
    }
    return self;
}

-(NSString*) getTagName {
    return name;
}
- (NSDictionary*) toDictionary
{
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    safeSet(jsonable, @"tagname", name);
    
    return jsonable;
}


@end
