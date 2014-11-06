//
//  Item.h
//  Shuq
//
//  Created by Elana Stroud on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
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
}


/**
 Constructor to create new item
 @param name name of the item
 @param path file path to a photo
 @param d description of the item
 */
-(id)initWithName:(NSString *)name andPath:(NSString*) path andDesc:(NSString*) d;
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

@end
