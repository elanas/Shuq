//
//  NewWishlistItemViewController.m
//  Shuq
//
//  Created by Joseph Min on 12/4/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "NewWishlistItemViewController.h"
#import "InventoryViewController.h"
#import "Wishlist.h"
#import "Item.h"
#import "ShuqModel.h"

@interface NewWishlistItemViewController ()

@end

@implementation NewWishlistItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"backToWishlist"]){
        Item* newWishlistItem = [[Item alloc] initWithName:_nameTextField.text andPath:@"" andDesc:_descriptionTextField.text andValue:5];
        Wishlist* wishlist = [[[ShuqModel getModel] getPrimaryUser] getWishlist];
        [wishlist addItem:newWishlistItem];
        ShuqModel *model = [ShuqModel getModel];
        //PUT the primary user
        [model updateUser:[model getPrimaryUser]];
    }
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
