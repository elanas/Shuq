//
//  NewInventoryItemViewController.h
//  Shuq
//
//  Created by Joseph Min on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewInventoryItemViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

/**
 The soon-to-be item name
 */
@property NSString* itemName;
/**
 The soon-to-be item description
 */
@property NSString* itemDescription;
/**
 The soon-to-be item value
 */
@property NSString* itemValue;
/**
 The soon-to-be item photo
 */
@property UIImage* photo;
/**
 The name text field
 */
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
/**
 The description text field
 */
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
/**
 The value text field
 */
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
/**
 The method to get ready to go back to the inventory (soon it will send data back without having to use a segue)
 */

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

/**
 This method is called by the add photo button and will take a photo
*/
- (IBAction)TakePhoto:(UIButton *)sender;

@end
