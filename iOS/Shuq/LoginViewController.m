//
//  ViewController.m
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        model = [[ShuqModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor clearColor];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"loginSuccess"]){
//        ItemSwipeViewController *controller = (ItemSwipeViewController *)segue.destinationViewController;
//        controller.model = model;
        
    } else if([segue.identifier isEqualToString:@"newUser"]){
        ItemSwipeViewController *controller = (ItemSwipeViewController *)segue.destinationViewController;
        controller.model = model;
        
    }
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
