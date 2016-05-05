//
//  VoiceDetailShareViewController.m
//  SuningEBuy
//
//  Created by xmy on 18/4/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceDetailShareViewController.h"

@interface VoiceDetailShareViewController ()

@end

@implementation VoiceDetailShareViewController

- (void)dealloc
{
    _chooseShareWayView.delegate = nil;
}

- (id)init:(NSString *)urlString WithShareContentStr:(NSString *)content
{
    self = [super init];
    if (self) {
        [self.view addSubview:self.webView];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        self.title =L(@"Activate rule");
        self.shareContent = content;
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"Share")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(share)];
        self.navigationItem.rightBarButtonItem = rightButton;

        // Custom initialization
    }
    return self;
}

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}


//点击分享
- (void)share
{
    [self.shareKit shareWithContent:self.shareContent  image:nil productImageURL:nil];
    
    [self.chooseShareWayView showChooseShareWayView];
    
}

- (ChooseShareWayView *)chooseShareWayView
{
    if (!_chooseShareWayView) {
        _chooseShareWayView = [[ChooseShareWayView alloc] initWithShareTypes:@[SNShareToWeiXin,SNShareToWeiXinFriend,SNShareToSinaWeibo,SNShareToTCWeiBo,SNShareToSMS]];
        _chooseShareWayView.delegate = self;
    }
    return _chooseShareWayView;
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    [self.shareKit didChooseShareWay:shareWay];
}


-(UIWebView*)webView
{
    if(_webView == nil)
    {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height - 68)];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scalesPageToFit = YES;
        
    }
    
    return  _webView;
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

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.chooseShareWayView hideChooseShareWayView];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];

}


@end
