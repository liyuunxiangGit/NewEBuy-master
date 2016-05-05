//
//  HotelOrderBaseViewController.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-3.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelOrderBaseViewController.h"

@implementation HotelOrderBaseViewController

@synthesize webView = _webView;

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_webView);
    
}

- (id)init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)loadView{
    
    [super loadView];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
//
//    UIButton *phoneBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];        
//    
//    phoneBtn.backgroundColor = [UIColor clearColor];
//    
//    [phoneBtn addTarget:self action:@selector(callHotLine) forControlEvents:UIControlEventTouchUpInside];
//    
//    [phoneBtn setBackgroundImage:[UIImage imageNamed:@"hotel_phone.png"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:phoneBtn];
//    
//    self.navigationItem.rightBarButtonItem = right;
//    
//    [right release];
//    [phoneBtn release];
    
}

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
    }
    return _webView;
}


//- (BOOL)checkHardWareIsSupportCallHotLine
//{
//    
//    BOOL isSupportTel = NO;
//    
//    NSURL *telURL = [NSURL URLWithString:@"tel://4006766766"];
//    
//    isSupportTel = [[UIApplication sharedApplication] canOpenURL:telURL];
//    
//    return isSupportTel;
//    
//}
//
//- (void)callHotLine
//{
//    if ([self checkHardWareIsSupportCallHotLine]) {
//        
//        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4006766766"]]];
//    
//    }else{
//    
//        BBAlertView *alert = [[BBAlertView alloc] 
//                              initWithTitle:L(@"Tips")
//                              message:L(@"Sorry, Unsupport call tel \n hotline:4006766766") 
//                              delegate:nil
//                              cancelButtonTitle:L(@"Ok")
//                              otherButtonTitles:nil]; 
//        [alert show];
//        [alert release];
//    }
//}


@end
