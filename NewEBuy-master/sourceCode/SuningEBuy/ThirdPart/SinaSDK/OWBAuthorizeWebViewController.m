//
//  OWBAuthorizeWebViewController.m
//  SuningEBuy
//
//  Created by lanfeng on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "OWBAuthorizeWebViewController.h"



@implementation OWBAuthorizeWebViewController

@synthesize authorizeView = _authorizeView;
@synthesize appKey = _appKey;
@synthesize redirectURI = _redirectURI;
@synthesize delegate;


- (id)init {
    self = [super init];
    if (self) {
        self.title = @"登录新浪微博";
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];

        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(pressReturn:)];
		self.navigationItem.leftBarButtonItem = cancelButton;
        TT_RELEASE_SAFELY(cancelButton);

        self.bSupportPanUI = NO;
    }
    return self;
}


//- (void)backForePage
//{
//    [self.navigationController dismissModalViewControllerAnimated:YES];
//}

- (void)dealloc {
    
    TT_RELEASE_SAFELY(_authorizeView);
    TT_RELEASE_SAFELY(_appKey);
    TT_RELEASE_SAFELY(_redirectURI);
}

- (void)loadView{
    
    [super loadView];
    
    [self.view addSubview:self.authorizeView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super  viewWillAppear:animated];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.appKey, @"client_id",
                                                                      @"code", @"response_type",
                                                                      self.redirectURI, @"redirect_uri", 
                                                                      @"mobile", @"display", nil];
    NSString *urlString = [WBRequest serializeURL:kWBAuthorizeURL
                                           params:params
                                       httpMethod:@"GET"];
    
    [self.authorizeView loadRequestWithURL:[NSURL URLWithString:urlString]];
    
}


-(OWBAuthorizeWebView *)authorizeView{

    if (_authorizeView == nil) {
        
        UIView *contentView = self.view;
        
        CGRect frame = contentView.frame;
        
        frame.origin.x = 0;
        
        frame.origin.y = 0;
        
        frame.size.height = contentView.bounds.size.height - 44;
        
        _authorizeView = [[OWBAuthorizeWebView alloc]initWithFrame:frame];
            
        _authorizeView.delegate = self;

    }
    return _authorizeView;
}

#pragma mark - 
#pragma mark - OWBAuthorizeWebViewDelegate

- (void)authorizeWebView:(OWBAuthorizeWebView *)webView didReceiveAuthorizeCode:(NSString *)code
{
    [self dismissModalViewControllerAnimated:NO];
    
    if ([delegate conformsToProtocol:@protocol(OWBAuthorizeWebViewControllerDelegate) ]) {
        if ([delegate respondsToSelector:@selector(authorizeWebView:didReceiveAuthorizeCode:)]) {
            [delegate authorizeWebView:webView didReceiveAuthorizeCode:code];
        }
    }
    
}


#pragma mark -
#pragma mark - Action

-(void)pressReturn:(id)sender{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

//谢伟 如果有冲突和我说一下
- (void)backForePage
{
    [self dismissModalViewControllerAnimated:YES];
}

@end
