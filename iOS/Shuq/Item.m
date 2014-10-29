//
//  Item.m
//  Shuq
//
//  Created by Elana Stroud on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "Item.h"

@implementation Item

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil


-(id)initWithName:(NSString*)name andPath:(NSString*) path andDesc:(NSString*) d{
    self = [super init];
    
    if (self) {
        title = name;
        pathname = path;
        desc = d;
    }
    return self;
}

-(NSString*) getName {
    return title;
}

-(NSString*) getPath {
    return pathname;
}

-(NSString*) getDesc {
    return desc;
}




@end
