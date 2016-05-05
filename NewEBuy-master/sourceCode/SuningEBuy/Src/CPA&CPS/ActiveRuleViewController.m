//
//  ActiveRuleViewController.m
//  SuningEBuy
//
//  Created by leo on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ActiveRuleViewController.h"

@interface ActiveRuleViewController ()

@property (nonatomic,copy) NSString              *urlString;

@property (nonatomic,copy) InvitationService     *service;

@end

@implementation ActiveRuleViewController

- (id)init:(NSString *)urlString
{
    self = [super init];
    if (self) {
        self.urlString = urlString;
        
        self.title =L(@"activeRule");
        
        // Custom initialization
    }
    return self;
}

-(UIWebView*)webView
{
    if(_webView == nil)
    {
        NSLog(@"++++++++%f",self.view.frame.size.height);
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        _webView.backgroundColor = [UIColor clearColor];
        _webView.scalesPageToFit = YES;

    }
    
    return  _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];

    if (IsStrEmpty(_urlString))
    {
        [self displayOverFlowActivityView];
        
        [self.service beginInvitationHttpRequest];
        
    }else{
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    }
	// Do any additional setup after loading the view.
}

-(InvitationService *)service
{
    if (!_service) {
        
        _service = [[InvitationService alloc]init];
        
        _service.delegate = self;
    }
    return _service;
}

- (void) InvitationServiceComplete:(InvitationDTO *)service isSuccess:(BOOL) isSuccess
{
    [self removeOverFlowActivityView];
    
    if (isSuccess)
    {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:service.actRuleURL]]];
    }
    else{
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:service.errorMsg?service.errorMsg:L(@"NWRequestError") delegate:self cancelButtonTitle:nil otherButtonTitles:L(@"Ok")];
        
        [alertView setConfirmBlock:^{
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        
        [alertView show];
        
        TT_RELEASE_SAFELY(alertView);
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
