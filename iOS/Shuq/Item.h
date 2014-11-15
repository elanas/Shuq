//
//  Item.h
//  Shuq
//
//  Created by Elana Stroud on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tag.h"
/**
 This class represents an inventory or wishlist item.
 */
@interface Item : NSObject {
    /**
     Name of the item.
     */
    NSString* title;
    /**
     File path to a photo of the item.
     */
    NSString* pathname;
    /**
     Description of the item
     */
    NSString* desc;
    /**
     Tags of the item
     */
    NSMutableArray* tags;
    /**
     Ranking of the value of the item, from 1-4
     */
    NSUInteger* value;
}


/**
 Constructor to create new item
 @param name name of the item
 @param path file path to a photo
 @param d description of the item
 */
-(id)initWithName:(NSString *)name andPath:(NSString*) path andDesc:(NSString*) d andValue:(NSUInteger*) v;
/**
 Creates a new item
 @param name name of the item
 */
-(id)initWithName:(NSString *)name;
/**
 Resturns the file path to the photo
 @return file path to photo
 */
-(NSString*) getPath;
/**
 Returns name of item
 @return name
 */
-(NSString*) getName;
/** Returns description of item
 @return description
 */
-(NSString*) getDesc;
/** Sets the description of item
 @param
 */
-(void) setDesc: (NSString*) d;
/** Returns value of item
 @return value
 */
-(NSUInteger*) getValue;
/** Returns description of item
 @return tags
 */
-(NSMutableArray*) getTags;
/**
 Add a tag to the item
 @param t name of tag to add
 */
-(void) addTag: (NSString *) t;


@end
