//
//  ShuqModel.h
//  Shuq
//
//  Created by Joseph Min on 10/29/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface ShuqModel : NSObject {
    User *primaryUser;
    NSMutableArray *users;
}
-(id)init;

@end
