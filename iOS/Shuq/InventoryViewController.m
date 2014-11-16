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
    Inventory* inventory = [[[ShuqModel getModel] getPrimaryUser] getInventory];
    items = [inventory getInventoryItems];
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

//- (void)import
//{
//    NSURL* url = [NSURL URLWithString:[kBaseURL stringByAppendingPathComponent:kLocations]]; //1
//    
//    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
//    request.HTTPMethod = @"GET"; //2
//    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"]; //3
//    
//    NSURLSessionConfiguration* config = [NSURLSessionConfiguration defaultSessionConfiguration]; //4
//    NSURLSession* session = [NSURLSession sessionWithConfiguration:config];
//    NSLog(@"reached");
//    
//    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) { //5
//        if (error == nil) {
//            NSArray* responseArray = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL]; //6
//            [self parseAndGetUsers:responseArray toArray:users]; //7
//            NSLog(@"here");
//            
//        }
//    }];
//    
//    [dataTask resume];
//    
//}

@end
