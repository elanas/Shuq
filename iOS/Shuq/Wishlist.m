//
//  Wishlist.m
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "Wishlist.h"
#import "ShuqModel.h"
#define safeSet(d,k,v) if (v) d[k] = v;

@implementation Wishlist

-(id)init {
    return [super init];
}

- (instancetype) initWithDictionary:(NSDictionary*)dictionary {
    self = [super init];
    if (self)
    {
        items = [[NSMutableArray alloc] init];
        NSMutableArray* itemJSON = dictionary[@"items"];
        ShuqModel *model = [ShuqModel getModel];
        for (NSUInteger i=0; i< [itemJSON count]; i++)
        {
            Item* item = [[Item alloc] initWithName:[itemJSON objectAtIndex:i][@"name"] andValue: [itemJSON objectAtIndex:i][@"value"]];
            [item setImageId:[itemJSON objectAtIndex:i][@"imageId"]];
            
            if([item getImageID] != nil) {
                //load image
                [model loadImage:item];
            }
            

            NSMutableArray* tagJSON = [itemJSON objectAtIndex:i][@"taglist"];
            for(NSUInteger n=0; n< [tagJSON count]; n++)
            {
                [item addTag:[tagJSON objectAtIndex:n][@"tagname"]];
            }
            [self addItem:item];
        }
    }
    return self;
}

-(void) addItem:(Item*)i {
    [super addItem:i];
}

-(Item*) getItem:(NSUInteger*)i {
    return [super getItem:i];
}

-(void) emptyWishlist {
    for (NSUInteger i = 0; i < [items count]; i++) {
        [items removeObjectAtIndex:i];
    }
}

- (NSDictionary*) toDictionary
{
    NSMutableDictionary* jsonable = [NSMutableDictionary dictionary];
    NSMutableArray* itemJSON =[[NSMutableArray alloc] init];
    
    for (NSUInteger i = 0; i < [items count]; i++) {
        NSMutableDictionary* item = [[items objectAtIndex:i] toDictionary];
        [itemJSON addObject:item];
    }
    safeSet(jsonable, @"items", itemJSON);
    return jsonable;
}


@end
