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
//    self.view.backgroundColor = [UIColor clearColor];

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
        
        /*Item *i1 = [[Item alloc] initWithName:@"iPhone Charger" andPath:@"iphone.png" andDesc:@"Brand new, just bought from Amazon. Comes with wall attachment." andValue:1];
        Item *i2 = [[Item alloc] initWithName:@"Flask" andPath:@"flask.png" andDesc:@"Only used once. Tastes best with whisky." andValue:1];
        Item *i3 = [[Item alloc] initWithName:@"Sunglasses" andPath:@"glasses.png" andDesc:@"Really great sunglasses, block the sun and make you look like a player." andValue:1];
        Item *i4 = [[Item alloc] initWithName:@"Winter Hat" andPath:@"hat.png" andDesc:@"Super warm and comfy. Get all the guys if you wear it out at night." andValue:1];
        [inventory addItem:i1];
        [inventory addItem:i2];
        [inventory addItem:i3];
        [inventory addItem:i4];*/
        
        [self performSegueWithIdentifier:@"loginSuccess" sender:sender];
//        ItemSwipeViewController *isvc = [[ItemSwipeViewController alloc] init];
//        [self presentModalViewController:isvc animated:YES];
    }
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"newUser"]){
        ItemSwipeViewController *controller = (ItemSwipeViewController *    )segue.destinationViewController;
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
