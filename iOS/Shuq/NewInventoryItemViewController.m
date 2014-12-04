//
//  NewInventoryItemViewController.m
//  Shuq
//
//  Created by Joseph Min on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "NewInventoryItemViewController.h"
#import "InventoryViewController.h"
#import "Inventory.h"
#import "Item.h"
#import "ShuqModel.h"

@interface NewInventoryItemViewController ()

@end

@implementation NewInventoryItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"backToInventory"]){
        Item* newInventoryItem = [[Item alloc] initWithName:_nameTextField.text andPath:@"" andDesc:_descriptionTextField.text andValue:5];
        //Set item photo
        [newInventoryItem setImage: self.photo];
        Inventory* inventory = [[[ShuqModel getModel] getPrimaryUser] getInventory];
        [inventory addItem:newInventoryItem];
        ShuqModel *model = [ShuqModel getModel];
        //Post Image
        [model saveNewItemImage:newInventoryItem];
        //PUT the primary user
        [model updateUser:[model getPrimaryUser]];
    }
}

- (IBAction)TakePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.photo = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
