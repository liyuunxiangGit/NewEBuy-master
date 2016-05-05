//
//  NProDetailIntroduceView.m
//  SuningEBuy
//
//  Created by xmy on 20/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailIntroduceView.h"

@implementation NProDetailIntroduceView

- (void)loadView
{
    [super loadView];
    
    self.introduceWebView.frame = self.view.frame;
    
    self.introduceWebView.backgroundColor = RGBCOLOR(242, 238, 225);
    
    self.view.backgroundColor = RGBCOLOR(242, 238, 225);
    
    [self.view addSubview:self.introduceWebView];    
}

- (void)setNProDetailIntroduceView:(DataProductBasic*)dto
{    
    self.webDto = dto;
    
    [self loadWebView];
}

/*//商品介绍
-(void)initWebView{
    UILabel *temTitle = [[UILabel alloc]init];
    temTitle.text = self.webDto.productName;
    temTitle.textAlignment = UITextAlignmentLeft;
    temTitle.textColor = [UIColor blackColor];
    temTitle.backgroundColor = [UIColor clearColor];
    temTitle.font = [UIFont systemFontOfSize:20];
    temTitle.numberOfLines = 0;
    temTitle.lineBreakMode = UILineBreakModeCharacterWrap;
    
    CGSize size_productname = [self.webDto.productName sizeWithFont:[UIFont systemFontOfSize:20]
                                                          constrainedToSize:CGSizeMake(300, MAXFLOAT)
                                                              lineBreakMode:UILineBreakModeCharacterWrap];
    
    temTitle.frame = CGRectMake(10, 0, 300, size_productname.height);
    
}*/

-(void)loadWebView{
    
    NSString *url;
    
    if (self.webDto.isABook) {
        
        url = [NSString stringWithFormat:@"%@/%@?storeId=%@&productId=%@",kHostAddressForHttp,kHttpResponseBookInfoView,kHttpRequestHomeStoreValue,self.webDto.productId];
        
    }else{
        
        url = [NSString stringWithFormat:@"%@/SNiPhoneAppProductDescView?storeId=%@&productId=%@&CatalogId=%@&productCode=%@&shopCode=%@",kHostAddressForHttp,kHttpRequestHomeStoreValue,self.webDto.productId,kHttpRequestHomeCatalogIdValue,self.webDto.productCode,self.webDto.shopCode?self.webDto.shopCode:@""];
        
    }
    
    DLog(@"url = %@", url);
    
	if (self.webDto == nil)
    {
        return;
        
    }
    if (![self.introduceWebView.request.URL.absoluteString isEqualToString:url])
    {
        [self.introduceWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    }
    
}

-(UIWebView *)introduceWebView
{
    if (nil == _introduceWebView)
    {
        _introduceWebView = [[UIWebView alloc]init];
        
        _introduceWebView.delegate = self;
        
        _introduceWebView.scalesPageToFit = YES;
        
        _introduceWebView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_introduceWebView];
        
    }
    return _introduceWebView;
}

#pragma mark -
#pragma mark webview
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
	[self displayOverFlowActivityView];
}

- (void) webViewDidFinishLoad:(UIWebView *)webView
{
    [self removeOverFlowActivityView];
    
    //适应客户端页面
    NSString* js =
    @"var meta = document.createElement('meta'); " \
    "meta.setAttribute( 'name', 'viewport' ); " \
    "meta.setAttribute( 'content', 'width = device-width' ); " \
    "document.getElementsByTagName('head')[0].appendChild(meta)";
    
    [webView stringByEvaluatingJavaScriptFromString: js];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	[self removeOverFlowActivityView];
}



@end
