//
//  GBGoodsInfoViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBGoodsInfoViewController.h"

@interface GBGoodsInfoViewController ()

@end

@implementation GBGoodsInfoViewController

@synthesize gbWebView                       = _gbWebView;

@synthesize urlString                       = _urlString;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_urlString);
    TT_RELEASE_SAFELY(_gbWebView);
    
}

- (id)initWithRequestUrl:(NSString *)urlString titleName:(NSString *)titleName{
    
    self = [super init];
	
    if (self) {
		self.urlString = urlString;
        self.title = titleName;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.hasSuspendButton = YES;
//    self.hasNav = NO;
//    [self useBottomNavBar];
//    self.bottomNavBar.ebuyBtn.hidden = NO;
//    
    [self.view addSubview:self.gbWebView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.gbWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
}

- (UIWebView *)gbWebView{
    if (!_gbWebView) {
        _gbWebView = [[UIWebView alloc]init];
        
        if(IOS7_OR_LATER)
        {
            _gbWebView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 48-20);

        }
        else
        {
            _gbWebView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 48);

        }
        
        _gbWebView.delegate = self;
        _gbWebView.backgroundColor = [UIColor clearColor];
        _gbWebView.scalesPageToFit = YES;
        [self.view addSubview:_gbWebView];
    }
    return _gbWebView;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
	[self displayOverFlowActivityView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
	[self removeOverFlowActivityView];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	[self removeOverFlowActivityView];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self removeOverFlowActivityView];
	[super viewWillDisappear:animated];
}


@end
