//
//  ShuqModelTests.m
//  Shuq
//
//  Created by Joshua Barza on 11/1/14.
//  Copyright (c) 2014 com.cape. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Item.h"
#import "User.h"
#import "Wishlist.h"
#import "Inventory.h"
#import "ShuqModel.h"

@interface ShuqModelTests : XCTestCase

@end

@implementation ShuqModelTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testItem
{
    Item *i1 = [[Item alloc] initWithName:@"iPhone Charger" andPath:@"iphone.png" andDesc:@"Brand new, just bought from Amazon. Comes with wall attachment."];
    XCTAssertEqual(@"iPhone Charger", [i1 getName], @"Names should be equal");
    XCTAssertEqual(@"iphone.png", [i1 getPath], @"Path to image should be equal");
    XCTAssertEqual(@"Brand new, just bought from Amazon. Comes with wall attachment.", [i1 getDesc], @"Descriptions should be equal");
}

- (void)testUser
{
    User *u1 = [[User alloc] initWithName:@"Joshua" andUsername:@"Jcool98" andWishlist:nil andInventory:nil];
    XCTAssertEqual(@"Joshua", [u1 getName],@"Names should be equal");
    XCTAssertEqual(@"Jcool98", [u1 getUsername],@"Usernames should be equal");
}

- (void) testWishlist
{
    Item *i1 = [[Item alloc] initWithName:@"iPhone Charger" andPath:@"iphone.png" andDesc:@"Brand new, just bought from Amazon. Comes with wall attachment."];
    Item *i2 = [[Item alloc] initWithName:@"Flask" andPath:@"flask.png" andDesc:@"Only used once. Tastes best with whisky."];

    Wishlist *w = [[Wishlist alloc] init];
    [w addItem:i1];
    [w addItem:i2];
    
    NSUInteger num = 1;
    
    XCTAssertEqual(i2, [w getItem:&num], @"Testing getItem method");
    XCTAssertEqual(i2, [w removeItem:&num], @"Testing RemoveItem method");
    
    NSMutableArray* items = [w getWishlistItems];
    
    XCTAssertEqual(1, [items count], @"Testing Size reduction after remove");
    
    [w emptyWishlist];
    items = [w getWishlistItems];
    XCTAssertEqual(0, [items count], @"Testing Size reduction after empty");
}

- (void) testInventory
{
    Item *i1 = [[Item alloc] initWithName:@"iPhone Charger" andPath:@"iphone.png" andDesc:@"Brand new, just bought from Amazon. Comes with wall attachment."];
    Item *i2 = [[Item alloc] initWithName:@"Flask" andPath:@"flask.png" andDesc:@"Only used once. Tastes best with whisky."];
    
    Inventory *inv = [[Inventory alloc] init];
    [inv addItem:i1];
    [inv addItem:i2];
    
    NSUInteger num = 1;
    
    XCTAssertEqual(i2, [inv getItem:&num], @"Testing getItem method");
    XCTAssertEqual(i2, [inv removeItem:&num], @"Testing RemoveItem method");
    
    NSMutableArray* items = [inv getInventoryItems];
    
    XCTAssertEqual(1, [items count], @"Testing Size reduction after remove");
    
}

- (void) testShuqModel
{
    ShuqModel *model = [[ShuqModel alloc]init];
    NSMutableArray* users = [model getUsers];
    
    XCTAssertEqual(0, [users count], @"Testing getUsers");

    
}
@end
