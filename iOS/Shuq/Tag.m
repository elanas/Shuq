//
//  Tag.m
//  Shuq
//
//  Created by Joshua Barza on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "Tag.h"
#define safeSet(d,k,v) if (v) d[k] = v;


@implementation Tag

-(id)initWithName: (NSString*) n {
    self = [super init];
    if (self) {
        name = n;
    }
    return self;
}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self) {
        name = dictionary[@"tagname"];
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
