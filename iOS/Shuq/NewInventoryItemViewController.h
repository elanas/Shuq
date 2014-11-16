//
//  NewInventoryItemViewController.h
//  Shuq
//
//  Created by Joseph Min on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewInventoryItemViewController : UIViewController

@property NSString* itemName;
@property NSString* itemDescription;
@property NSString* itemValue;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;

@end
