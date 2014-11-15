//
//  Settings.h
//  Shuq
//
//  Created by Joshua Barza on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 This class will represent the settings of a user, such as the privacy settings of what they want to display.
 */
@interface Settings : NSObject {
    
    /**
     Represents the privacy setting of the user, to be implemented later.
     */
    NSUInteger* privacy;
}

/**
 create new settings group
 */
-(id)init;
@end
