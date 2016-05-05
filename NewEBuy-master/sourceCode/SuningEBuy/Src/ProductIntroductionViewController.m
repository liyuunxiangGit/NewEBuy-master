//
//  ProductIntroductionViewController.m
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductIntroductionViewController.h"

@implementation ProductIntroductionViewController
@synthesize introduceWebView = _introduceWebView;
@synthesize dataProductBasic = _dataProductBasic;
@synthesize isNeedData = _isNeedData;
@synthesize requestURL = _requestURL;
@synthesize productName = _productName;

- (id)init{
    self = [super init];
    if (self) {
        self.title = L(@"Product Description");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail_productIntroduce"),self.title];
    }
    return self;
}
- (void)dealloc
{
    TT_RELEASE_SAFELY(_dataProductBasic);
    TT_RELEASE_SAFELY(_productName);
    TTVIEW_RELEASE_SAFELY(_introduceWebView);
    TT_RELEASE_SAFELY(_requestURL);
    
}

#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    [self initWebView];
    
}
/**
 *  刷新数据
 */

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
    
//    [self hideTabBar];
    
    NSString *url;
    
    if (self.dataProductBasic.isABook) {
        
        url = [NSString stringWithFormat:@"%@/%@?storeId=%@&productId=%@",kHostAddressForHttp,kHttpResponseBookInfoView,kHttpRequestHomeStoreValue,self.dataProductBasic.productId]; 
        
    }else{
        
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

//        url = [NSString stringWithFormat:@"%@/SNiPhoneAppProductDescView?storeId=%@&productId=%@&CatalogId=%@&productCode=%@",kHostAddressForHttp,kHttpRequestHomeStoreValue,self.dataProductBasic.productId,kHttpRequestHomeCatalogIdValue,self.dataProductBasic.productCode];
        
    }  
    
    DLog(@"%@", url);
	self.requestURL = [NSURL URLWithString:url];
    
	if (self.dataProductBasic == nil)
        
		return;
    
    if (self.isNeedData) {
        
		[self.introduceWebView loadRequest:[NSURLRequest requestWithURL:self.requestURL]];
        
	}
}

/**
 *  初始化一个 webview
 */

#pragma mark-
#pragma mark uiwebView delegate
-(void)initWebView{
    UILabel *temTitle = [[UILabel alloc]init];
    temTitle.text = self.productName;
    temTitle.textAlignment = UITextAlignmentLeft;
    temTitle.textColor = [UIColor blackColor];
    temTitle.backgroundColor = [UIColor clearColor];
    temTitle.font = [UIFont systemFontOfSize:20];
    temTitle.numberOfLines = 0;
    temTitle.lineBreakMode = UILineBreakModeCharacterWrap;
    
    CGSize size_productname = [self.productName sizeWithFont:[UIFont systemFontOfSize:20]
                                           constrainedToSize:CGSizeMake(300, MAXFLOAT) 
                                               lineBreakMode:UILineBreakModeCharacterWrap];
    
    temTitle.frame = CGRectMake(10, 0, 300, size_productname.height);
    [self.view addSubview:temTitle];
    
    
    CGRect rect_webview = self.view.bounds;
    
    self.introduceWebView.frame = CGRectMake(0,size_productname.height,rect_webview.size.width,rect_webview.size.height-size_productname.height-kUITabBarFrameHeight);
    
    
}
-(UIWebView *)introduceWebView{
    if (nil == _introduceWebView) {
        _introduceWebView = [[UIWebView alloc]init];
        _introduceWebView.delegate = self;
        _introduceWebView.scalesPageToFit = YES;
        [self.view addSubview:_introduceWebView];
    }
    return _introduceWebView;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
	[self displayOverFlowActivityView];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
	[self removeOverFlowActivityView];
	self.isNeedData = NO;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	[self removeOverFlowActivityView];
    self.isNeedData = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [self removeOverFlowActivityView];
	[super viewWillDisappear:animated];
//    [self showTabBar];
    self.isNeedData = NO;
} 


@end
