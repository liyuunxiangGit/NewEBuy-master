//
//  PromotionInfoDetailController.m
//  SuningEBuy
//
//  Created by huangtf on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Preferences.h"
#import "PromotionInfoDetailController.h"


@implementation PromotionInfoDetailController
@synthesize pageInTime = pageInTime_;
@synthesize infoTitle = _infoTitle;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_infoTitle);
    
}

- (id)init
{
	
    
    self = [super init];
	
    if (self) 
    {
		
        self.title = L(@"PromotionInfo");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
	
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
        
    _webView.scalesPageToFit = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    self.title = self.infoTitle;
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
    DLog(@"Connection did fail %@",[error localizedDescription]);
    
}
@end
