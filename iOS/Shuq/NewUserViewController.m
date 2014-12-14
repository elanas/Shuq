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
    
    FRAME_SIZE = 45;
    ANIMATION_SPEED = .3;
    JUMP = 70;
    BIG_JUMP = 135;
    UIColor *placeholderColor = [UIColor colorWithRed:141/255.0 green:150/255.0 blue:164/255.0 alpha:1];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _newuserTextField.delegate = self;
    _newpassTextField.delegate = self;
    _newcontactTextField.delegate = self;
    _locationField.delegate = self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //formatting text fields
    CGRect frameRect = _newuserTextField.frame;
    frameRect.size.height = FRAME_SIZE;
    _newuserTextField.frame = frameRect;
    _newuserTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"username" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    
    
    frameRect = _newpassTextField.frame;
    frameRect.size.height = FRAME_SIZE;
    _newpassTextField.frame = frameRect;
    _newpassTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"password" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    
    frameRect = _newcontactTextField.frame;
    frameRect.size.height = FRAME_SIZE;
    _newcontactTextField.frame = frameRect;
    _newcontactTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"555-123-4567" attributes:@{NSForegroundColorAttributeName: placeholderColor}];
    
    frameRect = _locationField.frame;
    frameRect.size.height = FRAME_SIZE;
    _locationField.frame = frameRect;
    _locationField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"enter your zipcode" attributes:@{NSForegroundColorAttributeName: placeholderColor}];


    
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
    NSNumber* num = [NSNumber numberWithInteger:[_newcontactTextField.text integerValue]];
    
    //    NSLog(password);
    if ([model authenticateUser:username andPassword: password isNewUser:TRUE]) {
        [[model getPrimaryUser] setContact:num];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Invalid Username" message:@"Username already exists. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
}


-(void)dismissKeyboard {
    [_newuserTextField resignFirstResponder];
    [_newpassTextField resignFirstResponder];
    [_newcontactTextField resignFirstResponder];
    [_locationField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(void)addLocation {
    NSString *loc = _locationField.text;
    
    
    [[model getPrimaryUser] setLocation:loc];
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
