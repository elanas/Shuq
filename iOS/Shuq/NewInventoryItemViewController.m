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

@interface NewInventoryItemViewController ()

@end

@implementation NewInventoryItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"backToInventory"]){
        Item* newInventoryItem = [[Item alloc] initWithName:_nameTextField.text andPath:@"" andDesc:_descriptionTextField.text andValue:5];
        Inventory* inventory = [[[ShuqModel getModel] getPrimaryUser] getInventory];
        [inventory addItem:newInventoryItem];
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
