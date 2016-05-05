//
//  DJGroupDetailIntroduceView.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailIntroduceView.h"

@implementation DJGroupDetailIntroduceView

@synthesize introduceWebView = _introduceWebView;
@synthesize dataProductBasic = _dataProductBasic;
@synthesize isNeedData = _isNeedData;
@synthesize requestURL = _requestURL;
@synthesize productName = _productName;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_dataProductBasic);
    TT_RELEASE_SAFELY(_productName);
    TTVIEW_RELEASE_SAFELY(_introduceWebView);
    TT_RELEASE_SAFELY(_requestURL);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)loadData
{
    NSString *url;
    if (self.dataProductBasic.isABook) {
        url = [NSString stringWithFormat:@"%@/%@?storeId=%@&productId=%@",kHostAddressForHttp,kHttpResponseBookInfoView,kHttpRequestHomeStoreValue,self.dataProductBasic.productId];
        
    }else{
//        url = [NSString stringWithFormat:@"%@/SNiPhoneAppProductDescView?storeId=%@&productId=%@&CatalogId=%@&productCode=%@",kHostAddressForHttp,kHttpRequestHomeStoreValue,self.dataProductBasic.productId,kHttpRequestHomeCatalogIdValue,self.dataProductBasic.productCode];
        
//        if(self.dataProductBasic.isCShop == YES)
//        {
            url = [NSString stringWithFormat:@"%@/SNiPhoneAppProductDescView?storeId=%@&productId=%@&CatalogId=%@&productCode=%@&shopCode=%@",kHostAddressForHttp,kHttpRequestHomeStoreValue,self.dataProductBasic.productId,kHttpRequestHomeCatalogIdValue,self.dataProductBasic.productCode,self.dataProductBasic.shopCode?self.dataProductBasic.shopCode:@""];
//            
//        }
//        else
//        {
//            url = [NSString stringWithFormat:@"%@/SNiPhoneAppProductDescView?storeId=%@&productId=%@&CatalogId=%@&productCode=%@&shopCode=%@",kHostAddressForHttp,kHttpRequestHomeStoreValue,self.dataProductBasic.productId,kHttpRequestHomeCatalogIdValue,self.dataProductBasic.productCode,@""];
//            
//        }

        
    }
    
    DLog(@"%@", url);
    self.requestURL = [NSURL URLWithString:url];
    
    if (self.dataProductBasic == nil)
        return;
    
    if (self.isNeedData) {
        [self.introduceWebView loadRequest:[NSURLRequest requestWithURL:self.requestURL]];
    }
}

#pragma mark-
#pragma mark uiwebView delegate

- (void)initWebView{
//    UILabel *temTitle = [[UILabel alloc]init];
//    temTitle.text = self.productName;
//    temTitle.textAlignment = UITextAlignmentLeft;
//    temTitle.textColor = [UIColor blackColor];
//    temTitle.backgroundColor = [UIColor clearColor];
//    temTitle.font = [UIFont systemFontOfSize:20];
//    temTitle.numberOfLines = 0;
//    temTitle.lineBreakMode = UILineBreakModeCharacterWrap;
//    
//    CGSize size_productname = [self.productName sizeWithFont:[UIFont systemFontOfSize:20]
//                                           constrainedToSize:CGSizeMake(300, MAXFLOAT)
//                                               lineBreakMode:UILineBreakModeCharacterWrap];
//    
//    temTitle.frame = CGRectMake(10, 0, 300, size_productname.height);
//    [self addSubview:temTitle];
//    
//    [temTitle release];
    
    CGRect rect_webview = self.bounds;
    
    self.introduceWebView.frame = CGRectMake(0, 0, rect_webview.size.width, rect_webview.size.height);
}

- (UIWebView *)introduceWebView{
    if (nil == _introduceWebView) {
        _introduceWebView = [[UIWebView alloc]init];
        _introduceWebView.delegate = self;
        _introduceWebView.scalesPageToFit = YES;
        [self addSubview:_introduceWebView];
    }
    return _introduceWebView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
	if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidStartLoad:)]) {
        [self.delegate webViewDidStartLoad:webView];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
	if (self.delegate && [self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)]) {
        [self.delegate webViewDidFinishLoad:webView];
    }
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	if (self.delegate && [self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)]) {
        [self.delegate webView:webView didFailLoadWithError:error];
    }
}


@end