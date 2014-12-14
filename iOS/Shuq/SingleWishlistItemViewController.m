//
//  SingleWishlistItemViewController.m
//  Shuq
//
//  Created by Joseph Min on 12/5/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "SingleWishlistItemViewController.h"

@interface SingleWishlistItemViewController ()

@end

@implementation SingleWishlistItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _descriptionText.text = [_item getDesc];
    _valueText.text = [[_item getValue] stringValue];
    _navigationBar.title = [_item getName];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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