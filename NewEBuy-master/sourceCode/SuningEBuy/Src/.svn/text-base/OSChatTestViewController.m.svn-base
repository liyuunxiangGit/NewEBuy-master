//
//  OSChatTestViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSChatTestViewController.h"
#import "OSChatViewController.h"
#import "OSLeaveMessageViewController.h"

@interface OSChatTestViewController ()
{
    NSArray *datasource;
    NSArray *excuteArray;
}

@end

@implementation OSChatTestViewController

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        self.title = L(@"OnlineService_OnlineCustomerServiceTest");
        
        datasource = @[L(@"OnlineService_CShopService"), L(@"OnlineService_B2CBeforeSell"), L(@"OnlineService_B2COrder"), L(@"OnlineService_B2CSendGoodsInstall"), L(@"OnlineService_B2CReturnGoods"), L(@"OnlineService_B2CSuggestion"), L(@"OnlineService_SellerLeaveMessage")];
        
        excuteArray = [[NSArray alloc] initWithObjects:
                       
                       [^{
            OSChatViewController *vc = [[OSChatViewController alloc] initAsCShop:@"0070055153" ProductName:Nil ProductCode:nil OrderNo:nil];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:NULL];
        } copy],
                       
                       [^{
            OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CShop:@"271506" productName:nil productCode:nil];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:NULL];
        } copy],
                       
                       [^{
            
            OSChatViewController *vc = [[OSChatViewController alloc] initAsB2COrderDetailWithOrderNo:nil];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:NULL];
            
        } copy],
                       
                       [^{
            
            OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CDeliveryInstallWithOrderNo:nil];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:NULL];
            
        } copy],
                       
                       [^{
            
            OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CReturnOrderWithOrderNo:nil];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:NULL];
            
        } copy],
                       
                       [^{
            
            OSChatViewController *vc = [[OSChatViewController alloc] initASB2CFeedBackWithOrderNo:nil];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:NULL];
            
        } copy],
                       
                       [^{
            
            OSLeaveMessageViewController *vc =
            [[OSLeaveMessageViewController alloc]
             initWithShopCode:@"0070055153"
             ShopName:L(@"OnlineService_TestSeller")
             ProductCode:@"1234"
             ProductName:L(@"OnlineService_42CunDianShi")
             OrderId:nil];
            
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentViewController:nav animated:YES completion:NULL];
            
        } copy],
                       
                       nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.groupTableView.frame = [self visibleBoundsShowNav:YES showTabBar:YES];
    [self.view addSubview:self.groupTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [datasource count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [datasource safeObjectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    void(^excuteBlock)(void) = [excuteArray safeObjectAtIndex:indexPath.row];
    excuteBlock();
}


@end
