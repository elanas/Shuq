//
//  ViewController.m
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "NewUserViewController.h"

@interface NewUserViewController ()

@end

@implementation NewUserViewController

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
    [_continueButton addTarget:self action:@selector(checkUsername) forControlEvents:UIControlEventTouchDown];
    
    [_createAccountButton addTarget:self action:@selector(addLocation) forControlEvents:UIControlEventTouchDown];
    
    model = [ShuqModel getModel];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)checkUsername {
//    model = [ShuqModel getModel];
    NSString* username = _newuserTextField.text;
    NSString* password = _newpassTextField.text;
    //    NSLog(password);
    if ([model authenticateUser:username andPassword: password isNewUser:TRUE]) {
        //segue
    } else {
        //aware user
        //don't segue
    }
}

-(void)addLocation {
//    model = [ShuqModel getModel];
    NSString *loc = _locationField.text;
    
    //check location is valod
    
    [[model getPrimaryUser] setLocation:loc];
    
    NSLog(@"%@", [[model getPrimaryUser]getLocation]);
    
    [model updateUser:[model getPrimaryUser]];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

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
