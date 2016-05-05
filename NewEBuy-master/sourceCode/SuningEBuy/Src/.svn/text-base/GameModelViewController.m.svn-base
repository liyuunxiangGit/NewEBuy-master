//
//  GameModelViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-7-29.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GameModelViewController.h"
#import "LoginViewController.h"
#import "PaymentCenterViewController.h"

@interface GameModelViewController ()

@end

@implementation GameModelViewController

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    self.title = L(@"choosePayWayFor40");
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    NSString *requestString = [[request URL] absoluteString];
    DLog(@"requestString %@",requestString);

    NSRange range = [requestString rangeOfString:@"isSNMobileLogin"];
    if (range.length > 0 && ![UserCenter defaultCenter].isLogined) {
        LoginViewController *_LoginViewController=[[LoginViewController alloc]init];
        _LoginViewController.loginDelegate = self;
        _LoginViewController.loginDidCancelSelector = @selector(loginCancel);
        _LoginViewController.loginDidOkSelector = @selector(loginOK);
        _LoginViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:_LoginViewController];
        [self presentModalViewController:userNav animated:YES];
//        return NO;
    }
    
    NSRange loginRange = [requestString rangeOfString:@"suningredirect:login" options:NSCaseInsensitiveSearch];
    
    if (loginRange.location != NSNotFound && ![UserCenter defaultCenter].isLogined )
    {
        NSRange range = [requestString rangeOfString:@"?"];
        NSString *result = [requestString substringFromIndex:range.location+1];
        NSDictionary *paramDic = [result queryDictionaryUsingEncoding:NSUTF8StringEncoding];
        NSString *redirectUrlStr = paramDic[@"URL"];
        NSURL *redirectUrl = [NSURL URLWithString:redirectUrlStr];
        
        if (redirectUrl)
        {
            [self checkLoginWithLoginedBlock:^{
                
                NSURLRequest *redirectRequest = [NSURLRequest requestWithURL:redirectUrl];
                [self.webView loadRequest:redirectRequest];
                
            } loginCancelBlock:^{
                //do nothing
            }];
        }
        else
        {
            DLog(@"invalid redirect url %@", redirectUrlStr);
        }
        
        return NO;
    }
    
    if ([requestString rangeOfString:@"suningredirect:rechargecenter" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        //充值中心
        PaymentCenterViewController *paymentCenterViewController = [[PaymentCenterViewController alloc] init];
        paymentCenterViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:paymentCenterViewController animated:YES];
        return NO;
    }
    
	return YES;
}

- (void)loginCancel{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loginOK{
	[self.webView reload];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
}

@end
