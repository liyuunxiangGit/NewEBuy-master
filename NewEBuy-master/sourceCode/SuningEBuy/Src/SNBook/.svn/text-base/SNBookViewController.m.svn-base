//
//  SNBookViewController.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-11-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNBookViewController.h"

@interface SNBookViewController ()

@property(nonatomic) BOOL isFirst;
@end

@implementation SNBookViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.hasNav = NO;
        
        self.bSupportPanUI = NO;
    }
    return self;
}

-(UIWebView *)bookWebView{
    
    
    if (!_bookWebView) {
        
        _bookWebView = [[UIWebView alloc] init];
        
        _bookWebView.delegate = self;
        
        _bookWebView.scalesPageToFit = YES;
        
        [self.view addSubview:_bookWebView];
    }
    
    return _bookWebView;
}

- (void)backForePage
{
    if([self.bookWebView canGoBack])
    {
        [self.bookWebView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.isFirst = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.bookWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:KHostWBBookForHttp]]];

    CGRect frame = self.view.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = frame.size.height;
    
    self.bookWebView.frame = frame;
}

-(void)viewWillAppear:(BOOL)animated{
    
    
   [super viewWillAppear:animated];
    

}

//-(void)viewDidAppear:(BOOL)animated{
//    
//    [super viewDidAppear:animated];
//    
//    CGRect frame = self.view.frame;
//    
//    frame.origin.x = 0;
//    
//    frame.origin.y = 0;
//    
//    self.bookWebView.frame = frame;
//    
//}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    

    NSComparisonResult comparR = [[[request URL] absoluteString] compare:@"downloadOrRead:"
                                                       options:NSCaseInsensitiveSearch
                                                                   range:NSMakeRange(0, 15)];

    NSString *openUrl = [NSString stringWithFormat:@"com.suning.reader4iphone://%@",[[request URL] absoluteString]];
    
    NSURL *url  = [NSURL URLWithString:openUrl];

    //[[UIApplication sharedApplication] openURL:url];
    if (comparR == NSOrderedSame)
    {
        if ([[UIApplication sharedApplication] canOpenURL:url]) {
            // 如果已经安装苏宁电子书苏客户端，就使用客户端打开链接
            [[UIApplication sharedApplication] openURL:url];
        } else {
            // 否则使用 去下载
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/cn/app/id568803051?l=en&mt=8"]];
        }        
        return NO;
    }
    
    
    
    //backToClient
    
    comparR = [[[request URL] absoluteString] compare:@"backToClient"
                                                                 options:NSCaseInsensitiveSearch
                                                                   range:NSMakeRange(0, 12)];
    
    //[[UIApplication sharedApplication] openURL:url];
    if (comparR == NSOrderedSame)
    {

        [self.navigationController popViewControllerAnimated:YES];
        return NO;
    }
    
    return YES;
    
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    if (self.isFirst) {
        
        [self displayOverFlowActivityView];
        
        self.isFirst = NO;
    }
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self removeOverFlowActivityView];
    
}
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
@end
