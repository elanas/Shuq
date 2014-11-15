//
//  InventoryViewController.m
//  Shuq
//
//  Created by Joseph Min on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "InventoryViewController.h"
#import "Item.h"
#import "Inventory.h"
#import "User.h"

@interface InventoryViewController ()

@end

@implementation InventoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    inventory = [[_model getPrimaryUser] getInventory];
    items = [[NSMutableArray alloc] init];
    Item *i1 = [[Item alloc] initWithName:@"iPhone Charger" andPath:@"iphone.png" andDesc:@"Brand new, just bought from Amazon. Comes with wall attachment."];
    Item *i2 = [[Item alloc] initWithName:@"Flask" andPath:@"flask.png" andDesc:@"Only used once. Tastes best with whisky."];
    Item *i3 = [[Item alloc] initWithName:@"Sunglasses" andPath:@"glasses.png" andDesc:@"Really great sunglasses, block the sun and make you look like a player."];
    Item *i4 = [[Item alloc] initWithName:@"Winter Hat" andPath:@"hat.png" andDesc:@"Super warm and comfy. Get all the guys if you wear it out at night."];
    
    [items addObject:i1];
    [items addObject:i2];
    [items addObject:i3];
    [items addObject:i4];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog([[items count] stringvalue]);
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InventoryItemCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"InventoryItemCell"];
    }
    //NSString *s = [NSString stringWithFormat: @"%@. %@", items[indexPath.row][@"id"],(items[indexPath.row][@"name"])];
    cell.textLabel.text = [[items objectAtIndex:(indexPath.row)] getName];
    //NSLog([[items objectAtIndex:(indexPath.row)] getName]);
    
    return cell;
}

@end
