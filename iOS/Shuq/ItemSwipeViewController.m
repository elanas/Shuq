//
//  ItemSwipeViewController.m
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "ItemSwipeViewController.h"

@interface ItemSwipeViewController ()

@end

@implementation ItemSwipeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *itemView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                [UIScreen mainScreen].bounds.size.width/6 + 7,
                                [UIScreen mainScreen].bounds.size.height/3, 200, 200)];
    [itemView setImage:[UIImage imageNamed:@"iphone.png"]];
    
    [self.view addSubview:itemView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
