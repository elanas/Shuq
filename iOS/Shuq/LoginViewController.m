//
//  ViewController.m
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "LoginViewController.h"
#import "Inventory.h"
#import "ShuqModel.h"
#import "Item.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [_aboutButton addTarget:self action:@selector(showAbout) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)attemptLogin:(id)sender {
    model = [ShuqModel getModel];
    NSString* username = _usernameTextField.text;
    NSString* password = _passwordTextField.text;
    if ([model authenticateUser:username andPassword: password isNewUser:FALSE]) {
        
        Inventory* inventory = [[[ShuqModel getModel] getPrimaryUser] getInventory];
        
        
        [self performSegueWithIdentifier:@"loginSuccess" sender:sender];
//        ItemSwipeViewController *isvc = [[ItemSwipeViewController alloc] init];
//        [self presentModalViewController:isvc animated:YES];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Failed to Login" message: @"Invalid username or password" delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"newUser"]){
        ItemSwipeViewController *controller = (ItemSwipeViewController *    )segue.destinationViewController;
        controller.model = model;
    }
}

-(void)showAbout {
    UIAlertView *about = [[UIAlertView alloc]initWithTitle:@"About this App" message:@"Shuq is a mobile trading post, allowing users to trade what they have for what they want. If you have an account, you can login here. Otherwise, hit the new user button to get started!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [about show];
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
