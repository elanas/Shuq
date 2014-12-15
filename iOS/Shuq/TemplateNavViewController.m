//
//  TemplateNavViewController.m
//  Shuq
//
//  Created by Elana Stroud on 12/14/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "TemplateNavViewController.h"

@interface TemplateNavViewController ()

@end

@implementation TemplateNavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[UINavigationBar appearance] setBackgroundColor:[UIColor redColor]];
    [[UINavigationBar appearance] setFrame:CGRectMake(0, 0, 320, 75)];

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
