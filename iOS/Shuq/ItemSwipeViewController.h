//
//  ItemSwipeViewController.h
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateViewController.h"

/**
 The Class SwipeScreen. This class represents the screen that handles the main swiping page, and can move to related screens as shown in the GUI sketches.
 */
@interface ItemSwipeViewController : TemplateViewController
/**
 The view for the image associated with the item
 */
@property UIImageView* itemView;
/**
 the list of items that the user will be swipping through
 */
@property NSMutableArray* items;
/**
 View of the name of the item currently being displayed.
 */
@property (weak, nonatomic) IBOutlet UILabel* itemName;
/**
 View of the description of the item currently being displayed.
 */
@property (weak, nonatomic) IBOutlet UITextView* itemDesc;
/**
 Index of the item currently being displayed
 */
@property NSInteger itemIndex;

@end
