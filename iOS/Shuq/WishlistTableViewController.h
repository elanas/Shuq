//
//  WishlistTableViewController.h
//  Shuq
//
//  Created by Joseph Min on 11/15/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShuqModel.h"
#import "ListTableTableViewController.h"

@interface WishlistTableViewController : ListTableTableViewController {
//    /**
//     The user whose inventory this view will represent
//     */
//    User* user;
//    /**
//     The array of items to populate the cells of the table
//     */
//    NSMutableArray *items;
}

/**
 The model
 */
@property ShuqModel* model;

/**
 An item to view as a single item
 */
@property Item* toSend;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
