//
//  MyEppWebViewController.m
//  SuningEBuy
//
//  Created by  liukun on 13-7-29.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EppWebViewController.h"
#import "NSObject+BoardManage.h"
#import "SNSwitch.h"

@interface EppWebViewController()


@end

/*********************************************************************/

@implementation EppWebViewController

- (void)lostKeyboard
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
}

- (void)dealloc
{
    //清除webView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

//我的易付宝
- (id)initAsMyEpp
{
    NSString *url = [NSString stringWithFormat:@"%@/%@", kEppHostAddress, kMobileEppMyEpp];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    self = [self initWithRequest:request];
    self.webType = kEppWebMyEpp;
    self.showToolBar = NO;
    self.pageTitle = @"会员-我的易购-我的易付宝";
    //self.pageTitle = @"会员-我的易购-我的易付宝web版";
    self.title = @"我的易付宝";
    return self;
}

//web收银台
- (id)initAsWebCashier:(NSString *)formString
{
    NSString *htmlString = [NSString stringWithFormat:@"<html><body onload=\"document.forms[0].submit()\">%@</body></html>", formString];
    self = [self initWithHtmlString:htmlString];
    self.webType = kEppWebPayCachier;
    self.showToolBar = NO;
    self.pageTitle = @"购物流程-购物-web收银台";
    self.title = @"易付宝在线支付";
    return self;
}

- (id)initAsWebCashierForCaiPiao:(NSString *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    self = [self initWithRequest:request];
    self.webType = kEppWebPayCachierCaiPiao;
    self.showToolBar = NO;
    self.pageTitle = @"虚拟-彩票-web收银台";
    self.title = @"易付宝在线支付";
    return self;
}

- (id)initAsWebCashierForPlanePiao:(NSString *)url
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    self = [self initWithRequest:request];
    self.webType = kEppWebPayCachierPlanePiao;
    self.showToolBar = NO;
    self.pageTitle = @"虚拟-机票-web收银台";
    self.title = @"易付宝在线支付";
    return self;
}

- (id)init
{
    self.bSupportPanUI = NO;
    return [self initAsMyEpp];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//  isNetReachable 不可用
//    if (!self.appDelegate.isNetReachable) {
//        [self presentSheet:@"ASI_CONNECTION_FAILURE_ERROR"];
//    }
}

#pragma mark -
#pragma mark web view delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[self displayOverFlowActivityView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self removeOverFlowActivityView];
    
    NSString *errorMsg = [error localizedFailureReason];
    
    if ([errorMsg length])
    {
        [self presentSheet:errorMsg];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self removeOverFlowActivityView];
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    DLog(@"request: %@",request);
    
    NSString *urlStr = [[request URL] absoluteString];
    if ([urlStr hasPrefix:@"http://itunes.apple.com"])
    {
        [self presentSheet:@"您正在使用易购客户端，无需再下载"];
        return NO;
    }
    else if ([urlStr rangeOfString:@"SNMobileEppPayCallBack"].location != NSNotFound &&
              ([urlStr rangeOfString:@"epp-m"].location == NSNotFound))
    {
        //支付成功的回调
        if ((self.webType == kEppWebPayCachier)||(self.webType == kEppWebPayCachierPlanePiao))
        {
//            if (self.isCOrder) {
//                BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
//                                                                message:@"支付成功，请至网站查看您的订单"
//                                                               delegate:nil
//                                                      cancelButtonTitle:@"去逛逛"
//                                                      otherButtonTitles:nil];
//                
//                __unsafe_unretained EppWebViewController *weakSelf = self;
//                [alert setCancelBlock:^{
//                    [weakSelf goAroundWithCompleteBlock:^{
//                        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
//                    }];
//                }];
//                [alert show];
//            }else{
            
                BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                                message:@"订单已支付成功，您可以"
                                                               delegate:nil
                                                      cancelButtonTitle:@"查看订单"
                                                      otherButtonTitles:@"去逛逛"];
                
                __unsafe_unretained EppWebViewController *weakSelf = self;
                
                [alert setCancelBlock:^{
                    [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                    [weakSelf jumpToOrderCenterBoard];
                }];
                
                [alert setConfirmBlock:^{
                    
                    [weakSelf goAroundWithCompleteBlock:^{
                        
                        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                    }];
                }];
                
                [alert show];    
            }
//        }
        
        return NO;
    }else if([urlStr rangeOfString:@"suningredirect:paysuccess:flight"].location != NSNotFound)
    {
        if (self.webType == kEppWebPayCachierPlanePiao)
        {
            BBAlertView *alertView = [[BBAlertView alloc]
                                      initWithTitle:nil
                                      message:@"订单付款成功"
                                      delegate:self
                                      cancelButtonTitle:nil
                                      otherButtonTitles:L(@"ok")];
            [alertView setConfirmBlock:^{
                self.appDelegate.tabBarViewController.selectedIndex = 4;
                [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                                    object:nil];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }];
            [alertView show];
            TT_RELEASE_SAFELY(alertView);
        }
    }

    return YES;
}

- (void)backForePage
{
    if ((self.webType == kEppWebPayCachier)||(self.webType == kEppWebPayCachierPlanePiao))
    {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                        message:@"支付尚未完成，返回将重新选择支付方式，是否确认？"
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Cancel")
                                              otherButtonTitles:L(@"Ok")];
        [alert setConfirmBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alert show];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
