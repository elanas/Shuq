//
//  ItemSwipeViewController.m
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "ItemSwipeViewController.h"
#import "Item.h"
#import "InventoryViewController.h"
#import "WishlistTableViewController.h"
#import "ShuqModel.h"


@interface ItemSwipeViewController ()

@end

@implementation ItemSwipeViewController

@synthesize itemName;


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
    
    [[self navigationItem] setTitle:@"helllllo"];
    
    _itemIndex = 0;
    _itemDesc.textColor = [UIColor whiteColor];
    
    [self loadItemsArray];
    [self loadItemsImageView];
    [self loadGestures];
    
    
    
    [self.view addSubview:_itemView];
}

- (void) handleSwipe:(UISwipeGestureRecognizer *) swipe {
    
    //loops items
    ShuqModel *model = [ShuqModel getModel];
    /**/
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        _itemIndex = (_itemIndex + 1) % [model.items count];


    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        if (_itemIndex == 0) {
            _itemIndex = [model.items count];

        }
        _itemIndex = (_itemIndex - 1) % [model.items count];


    }
    
    [self setItem];
}

-(void) loadItemsArray {
    
    ShuqModel *model = [ShuqModel getModel];
    [model getMatchItems:[[model getPrimaryUser] getUsername]];
    
   }

-(void) setItem {
    ShuqModel *model = [ShuqModel getModel];
    if([model.items count] ==0){
        return;
    }
    Item *item =[model.items objectAtIndex:_itemIndex];
    
    [_itemView setImage: [item getImage]];
    
    [itemName setText:[item getName]];
    [_itemDesc setText:[item getDesc]];
}

-(void) loadItemsImageView {
    _itemView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                              [UIScreen mainScreen].bounds.size.width/6 + 7,
                                                              [UIScreen mainScreen].bounds.size.height/4, 200, 200)];

    
    [self setItem];
    
    _itemView.layer.masksToBounds = YES;
    _itemView.layer.cornerRadius = 10;
    
}

-(void)loadGestures {
    [_itemView setUserInteractionEnabled:YES];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    // Adding the swipe gesture on image view
    [_itemView addGestureRecognizer:swipeLeft];
    [_itemView addGestureRecognizer:swipeRight];

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
