//
//  ItemSwipeViewController.m
//  Shuq
//
//  Created by Elana Stroud on 10/26/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import "ItemSwipeViewController.h"
#import "Item.h"


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
    
    [_itemView setImage:[UIImage imageNamed:[[_items objectAtIndex:_itemIndex] getPath]]];
    [itemName setText:[[_items objectAtIndex:_itemIndex] getName]];
}

-(void) loadItemsArray {
    //read file/json
    
    _items = [[NSMutableArray alloc] init];
    
    Item *i1 = [[Item alloc] initWithName:@"iPhone Charger" andPath:@"iphone.png" andDesc:@"Brand new, just bought from Amazon. Comes with wall attachment."];
//    Item *i2 = [[Item alloc] initWithName:@"Flask" andPath:@"flask.png"];
//    Item *i3 = [[Item alloc] initWithName:@"Sunglasses" andPath:@"glasses.png"];
//    Item *i4 = [[Item alloc] initWithName:@"Winter Hat" andPath:@"hat.png"];
    
    [_items addObject:i1];
//    [_items addObject:i2];
//    [_items addObject:i3];
//    [_items addObject:i4];


}

-(void) loadItemsImageView {
    _itemView = [[UIImageView alloc] initWithFrame:CGRectMake(
                                                              [UIScreen mainScreen].bounds.size.width/6 + 7,
                                                              [UIScreen mainScreen].bounds.size.height/4, 200, 200)];
    [_itemView setImage:[UIImage imageNamed:[[_items objectAtIndex:_itemIndex] getPath]]];
    
    [itemName setText:[[_items objectAtIndex:_itemIndex] getName]];
    
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
