//
//  WishlistTableViewController.m
//  Shuq
//
//  Created by Joseph Min on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "WishlistTableViewController.h"
#import "SingleWishlistItemViewController.h"

@interface WishlistTableViewController ()

@end

@implementation WishlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Wishlist* wishlist = [[[ShuqModel getModel] getPrimaryUser] getWishlist];
    items = [wishlist getWishlistItems];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog([[items count] stringvalue]);
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WishlistItemCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"WishlistItemCell"];
    cell.textLabel.text = [[items objectAtIndex:(indexPath.row)] getName];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Value Selected by user
    _toSend = [items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier: @"cellSelected" sender: self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"cellSelected"]){
        SingleWishlistItemViewController *destViewController = segue.destinationViewController;
        destViewController.item = _toSend;
    }
}

@end
