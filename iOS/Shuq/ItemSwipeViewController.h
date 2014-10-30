//
//  ItemSwipeViewController.h
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateViewController.h"

@interface ItemSwipeViewController : TemplateViewController

@property UIImageView* itemView;

@property NSMutableArray* items;

@property (weak, nonatomic) IBOutlet UILabel* itemName;
@property (weak, nonatomic) IBOutlet UITextView* itemDesc;

@property NSInteger itemIndex;

@end
