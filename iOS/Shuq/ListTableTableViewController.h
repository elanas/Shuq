//
//  ListTableTableViewController.h
//  Shuq
//
//  Created by Elana Stroud on 12/14/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TemplateNavViewController.h"
#import "ShuqModel.h"


@interface ListTableTableViewController : TemplateNavViewController  <UITableViewDelegate, UITableViewDataSource>

{
    ItemList* itemList;
    /**
     The user whose inventory this view will represent
     */
    User* user;
    /**
     The array of items to populate the cells of the table
     */
    NSMutableArray *items;
}

/**
 The model
// */
//@property ShuqModel* model;
//
///**
// An item to view as a single item
// */
//@property Item* toSend;
//
//@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
