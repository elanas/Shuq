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
    
    _itemIndex = 0;
    _itemDesc.textColor = [UIColor whiteColor];
    
    [self loadItemsArray];
    [self loadItemsImageView];
    [self loadGestures];
    
    [self.view addSubview:_itemView];
}

- (void) handleSwipe:(UISwipeGestureRecognizer *) swipe {
    
    //loops items
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        _itemIndex = (_itemIndex + 1) % [_items count];

    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        if (_itemIndex == 0) {
            _itemIndex = [_items count];
        }
        _itemIndex = (_itemIndex - 1) % [_items count];

    }
    
    [self setItem];
}

-(void) loadItemsArray {
    //read file/json
    
    _items = [[NSMutableArray alloc] init];
    NSUInteger num = 1;
    
    Item *i1 = [[Item alloc] initWithName:@"iPhone Charger" andPath:@"iphone.png" andDesc:@"Brand new, just bought from Amazon. Comes with wall attachment." andValue:&num];
    Item *i2 = [[Item alloc] initWithName:@"Flask" andPath:@"flask.png" andDesc:@"Only used once. Tastes best with whisky." andValue:&num];
    Item *i3 = [[Item alloc] initWithName:@"Sunglasses" andPath:@"glasses.png" andDesc:@"Really great sunglasses, block the sun and make you look like a player." andValue:&num];
    Item *i4 = [[Item alloc] initWithName:@"Winter Hat" andPath:@"hat.png" andDesc:@"Super warm and comfy. Get all the guys if you wear it out at night." andValue:&num];
    
    [_items addObject:i1];
    [_items addObject:i2];
    [_items addObject:i3];
    [_items addObject:i4];


}

-(void) setItem {
    Item *item = [_items objectAtIndex:_itemIndex];
    
    [_itemView setImage:[UIImage imageNamed:[item getPath]]];
    [itemName setText:[item getName]];
    [_itemDesc setText:[item getDesc]];
}

-(void) loadItemsImageView {
    _itemView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                              [UIScreen mainScreen].bounds.size.width/6 + 7,
                                                              [UIScreen mainScreen].bounds.size.height/4, 200, 200)];
//    [_itemView setImage:[UIImage imageNamed:[[_items objectAtIndex:_itemIndex] getPath]]];
//    
//    [itemName setText:[[_items objectAtIndex:_itemIndex] getName]];
    
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"toInventory"]){
        InventoryViewController *controller = (InventoryViewController *)segue.destinationViewController;
        controller.model = _model;
        
    }
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
