//
//  Item.h
//  Shuq
//
//  Created by Elana Stroud on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject {
    NSString* title;
    NSString* pathname;
    NSString* desc;
    
}



-(id)initWithName:(NSString *)name andPath:(NSString*) path andDesc:(NSString*) d;
-(NSString*) getPath;
-(NSString*) getName;
-(NSString*) getDesc;

@end
