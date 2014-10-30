//
//  User.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Wishlist.h"

@interface User : NSObject {
    NSString* name;
    NSString* username;
    Wishlist* wishlist;
}


-(id)initWithName:(NSString*)n andUsername:(NSString*)u andWishlist:(Wishlist*)w;
-(NSString*) getName;
-(NSString*) getUsername;
-(Wishlist*) getWishlist;

@end
