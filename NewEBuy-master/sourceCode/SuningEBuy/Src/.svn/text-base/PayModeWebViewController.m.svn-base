//
//  PayModeWebViewController.m
//  SuningEBuy
//
//  Created by xy ma on 12-4-16.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "PayModeWebViewController.h"
#import "ProductViewController.h"
#import "Preferences.h"
#import "SuningMainClick.h"
#import "AppDelegate.h"

#define PAYMENT_BACKTOHOME      300

@implementation PayModeWebViewController

@synthesize orderId=orderId_;
@synthesize isFromPaymentModeViewController=isFromPaymentModeViewController_;
@synthesize orderService = _orderService;

- (void)dealloc {
    TT_RELEASE_SAFELY(orderId_);
    SERVICE_RELEASE_SAFELY(_orderService);
}

- (id)init{
	;
    
    self = [super init];
	
    if (self) {
        self.title = L(@"choosePayWayFor40");
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (OrderDetailService *)orderService
{
    if (!_orderService) {
        _orderService = [[OrderDetailService alloc] init];
        _orderService.delegate = self;
    }
    return _orderService;
}

- (void)loadView
{
    [super loadView];
    /*
     * author:崔正来
     * date：2012-08-29
     * description：判断是否为购物车界面跳转到在线支付页面
     */
    if(isFromPaymentModeViewController_){
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]
                                     initWithTitle:@"返回" 
                                     style:UIBarButtonItemStylePlain 
                                     target:self
                                     action:@selector(backHomePage:)];
        self.navigationItem.leftBarButtonItem = leftItem;
        TT_RELEASE_SAFELY(leftItem);
    }
    _webView.scalesPageToFit = NO;
}


/*
 * author:崔正来
 * date：2012-08-29
 * description：左按钮——返回主界面，并取消订单
 */
#pragma mark -
#pragma mark 左按钮

- (void)backHomePage:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:NO];
    
    [self jumpToOrderCenterBoard];
    
    NSNotification* notificationRefreshOrderCenter = [NSNotification notificationWithName:@"sendRefreshOrderCenterInfo" object:self];
    
    [[NSNotificationCenter defaultCenter] postNotification:notificationRefreshOrderCenter];
    
    
//    BBAlertView *alertView = [[BBAlertView alloc] 
//                              initWithTitle:@"友情提示"
//                              message:@"如您从此页面退出，此订单商品将被取消，订单中使用的券将被锁定24小时后退回到您账户"
//                              delegate:self
//                              cancelButtonTitle:L(@"Cancel")
//                              otherButtonTitles:L(@"Ok")];
//    alertView.tag = PAYMENT_BACKTOHOME;
//    [alertView show];
//    [alertView release];   
    
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    self.title = L(@"choosePayWayFor40");
    
//    [SuningEBuyAppDelegate currentAppDelegate].currentPageTitle=self.title;
//    [UserCenter defaultCenter].currentPageTitle=self.title;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (BOOL)webView:(UIWebView *)webView 
    shouldStartLoadWithRequest:(NSURLRequest *)request 
    navigationType:(UIWebViewNavigationType)navigationType
{    
    
    NSString *requestString = [[request URL] absoluteString];
    DLog(@"requestString %@",requestString);
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 1 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"keycontroller"]) {
        
        NSString *goViewStr = [components objectAtIndex:1];
        
        if (goViewStr == nil || [goViewStr isEqualToString:@""]) {
            
        }else {
            if ([goViewStr isEqualToString:@"home"]) {
                                
                [self.navigationController popToRootViewControllerAnimated:NO];
            }else if ([goViewStr isEqualToString:@"order"]) {
                
                
                [self.navigationController popToRootViewControllerAnimated:NO];
                
                //去订单中心
                [self jumpToOrderCenterBoard];
            }else if ([goViewStr isEqualToString:@"flightOrder"]) {
                                
                [self.navigationController popToRootViewControllerAnimated:NO];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"shouldGoToTicketList" object:nil];
                [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 4;
            }else if ([goViewStr isEqualToString:@"fee"]) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"GoToVirtualProduct" object:nil];
                
            }
            
            
        }
        
    }
	return YES;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
    DLog(@"Connection did fail %@",[error localizedDescription]);
    
}

/*
 * author:崔正来
 * date：2012-08-29
 * description：取消订单操作
 */
//-(void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index
//{
//    
//    
//     if(tag == PAYMENT_BACKTOHOME){
//        
//        if (index == 1) 
//        {
//            NSNotification *notification=[NSNotification notificationWithName:@"shopping ok" object:nil];
//           
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
//            //go to homepage
//            [SettlementUtil showTabBar:self.tabBarController];
//            
////            [SuningEBuyAppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 0;
//            
//            //add by wangjiaxing 
////            [[[SuningEBuyAppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:NO];
//           
//            [self sendCancelOrderHttpRequest];
//        }
//        
//    }
//    
//}

//- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
//{
//    if(alertView.tag == PAYMENT_BACKTOHOME){
//        
//        if (buttonIndex == 1) 
//        {
//            NSNotification *notification=[NSNotification notificationWithName:SHOPPING_OK_MESSAGE object:nil];
//            
//            [[NSNotificationCenter defaultCenter] postNotification:notification];
//            //go to homepage
//            [SettlementUtil showTabBar:self.tabBarController];
//            
//            [AppDelegate currentAppDelegate].tabBarViewController.selectedIndex = 0;
//            
//            //add by wangjiaxing 
//            [[[AppDelegate currentAppDelegate].tabBarViewController.viewControllers objectAtIndex:0] popToRootViewControllerAnimated:NO];
//            
//            [self sendCancelOrderHttpRequest];
//            
//            [self.navigationController popToRootViewControllerAnimated:YES];
//        }
//        
//    }
//}
//
//- (void)sendCancelOrderHttpRequest
//{
//    [self retain];
//    
//    NSString *userId = [UserCenter defaultCenter].userInfoDTO.userId;
//    
//    [self.orderService beginSendCancelOrderHttpRequest:userId orderId:self.orderId];
//}

//- (void)orderCancelHttpRequestCompletedWith:(BOOL)isSucess errorMsg:(NSString *)errorMsg
//{
//    [self release];
//}
@end
