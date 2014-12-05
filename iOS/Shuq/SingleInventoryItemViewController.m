//
//  SingleInventoryItemViewController.m
//  Shuq
//
//  Created by Joseph Min on 12/5/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "SingleInventoryItemViewController.h"

@interface SingleInventoryItemViewController ()

@end

@implementation SingleInventoryItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _descriptionText.text = [_item getDesc];
    _valueText.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_item getValue]];
    _navigationBar.title = [_item getName];
    if ([_item getImage] != nil) {
        _pictureImageView.image = [_item getImage];

    }
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
