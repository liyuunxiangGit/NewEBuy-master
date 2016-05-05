//
//  SNGameViewController.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNGameViewController.h"
#import "LoginViewController.h"
#import "PaymentCenterViewController.h"

@interface SNGameViewController ()

@property(nonatomic,strong) NSURLRequest  *oldRequest;
@end

@implementation SNGameViewController

- (id)init
{
    self = [super initWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kHostWBGameForHttp]]];
    if (self) {
        
        self.showToolBar = NO;
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
	NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
	self.title = title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    
    NSComparisonResult comparR = [[[request URL] absoluteString] compare:@"redirect:login"
                                                                 options:NSCaseInsensitiveSearch
                                                                   range:NSMakeRange(0, 14)];
    
    if (comparR == NSOrderedSame && ![UserCenter defaultCenter].isLogined )
    {
        LoginViewController *_LoginViewController=[[LoginViewController alloc]init];
        _LoginViewController.loginDelegate = self;
        _LoginViewController.loginDidCancelSelector = @selector(loginCancel);
        _LoginViewController.loginDidOkSelector = @selector(loginOK);
        _LoginViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:_LoginViewController];
        [self presentModalViewController:userNav animated:YES];
        return NO;
    }
    
    NSString *requestString = [[request URL] absoluteString];
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
    
    self.oldRequest = request;
    
    return YES;
    
}

- (void)loginCancel{
    //    [self showTabBar];
    [self backToFore];
    //    [self performSelector:@selector(backToFore) withObject:self afterDelay:0.1];
}
- (void)backToFore
{
    [self.navigationController popViewControllerAnimated:NO];
}


- (void)loginOK{
    
}
@end
