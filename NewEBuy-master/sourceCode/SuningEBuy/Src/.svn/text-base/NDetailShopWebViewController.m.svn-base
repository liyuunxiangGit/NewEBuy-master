//
//  NDetailShopWebViewController.m
//  SuningEBuy
//
//  Created by xmy on 6/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NDetailShopWebViewController.h"
#import "ProductViewController.h"
#import "SearchListViewController.h"
#import "AppDelegate.h"
#import "PurchaseDetailViewController.h"
#import "DJGroupListItemDTO.h"
#import "DJGroupDetailViewController.h"
#import "LoginViewController.h"
#import "JASidePanelController.h"
#import "FilterRootViewController.h"
#import "FilterNavigationController.h"
#import "ProductDetailViewController.h"
#import "NewHomeViewController.h"
#import "PaymentModeViewController.h"
#import "PaymentCenterViewController.h"

@interface NDetailShopWebViewController ()

@end

@implementation NDetailShopWebViewController

@synthesize activeName = activeName_;

- (void)dealloc
{

}

- (id)initWithRequest:(NSURLRequest *)request shopId:(NSString*)aShopId
{
    if (self = [super init]) {
        _request = request;
		// Create toolbar (to make sure that we can access it at any time)
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        self.hasNav = NO;
        self.pageTitle = [NSString stringWithFormat:@"展示-C店店铺-店铺%@",aShopId];
    }
    self.hidesBottomBarWhenPushed = YES;
    return self;
}

- (id)initWithRequest:(NSURLRequest *)request
{
    if (self = [super init]) {
        _request = request;
		// Create toolbar (to make sure that we can access it at any time)
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        self.hasNav = NO;
    }
    self.hidesBottomBarWhenPushed = YES;
    return self;
}



- (id)initWithRequestUrl:(NSString *)url query:(NSDictionary*)query  {
	
	NSString *link ;
	
	if(query==nil){
		
		
		link = [[NSString alloc] initWithFormat:@"http://%@",url];
		
	}
	else{
		
		link = [query objectForKey:@"link"];
		
	}
	
	
	
    if (self = [super init]) {
		self.hasNav = NO;
		NSURL *_url =[[NSURL alloc ]initWithString:link];
		
		
        _request = [[NSURLRequest alloc ]initWithURL:_url];
		
        
		// Create toolbar (to make sure that we can access it at any time)
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    }
    
    
    self.hidesBottomBarWhenPushed = YES;
    
    return self;
}


- (id)initWithRequestUrl:(NSString *)url
{
    if (self = [super init]) {
		self.hasNav =NO;
		NSString *url1 = [[NSString alloc] initWithFormat:@"http://%@",url];
		
		NSURL *_url =[[NSURL alloc ]initWithString:url1];
		
        _request = [[NSURLRequest alloc ]initWithURL:_url];
		
		
        
		// Create toolbar (to make sure that we can access it at any time)
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    }
    
    self.hidesBottomBarWhenPushed = YES;
    
    return self;
	
}

- (id)init{
	
    self = [super init];
	
    if (self) {
		self.hasNav = NO;
        self.title = L(@"RecommendActivity");
        
        self.bSupportPanUI = NO;
    }
    
    self.hidesBottomBarWhenPushed = YES;
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    _webView.scalesPageToFit = YES;
    
    if (IOS5_OR_LATER) {
        _webView.scrollView.bounces = NO;
    }
    
    CGRect frame = self.view.bounds;
    if (IOS7_OR_LATER) {
        _webView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height - 20);
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *item = [UIBarButtonItem initWithImage:@"home_back_btn.png"];// wihtSel:nil];
    if (item.customView) {
        UIButton *btn = (UIButton *)item.customView;
        [btn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    }
    self.navigationItem.leftBarButtonItem = item;
    
    self.title = self.activeName;
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
}

- (void)backForePage
{
    if ([self.webView canGoBack])
    {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self displayOverFlowActivityView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //    NSRange range = [_request.URL.absoluteString rangeOfString:@"isSNMobileLogin"];
    //    if (range.length > 0 && ![UserCenter defaultCenter].isLogined) {
    //        LoginViewController *_LoginViewController=[[LoginViewController alloc]init];
    //        _LoginViewController.loginDelegate = self;
    //        _LoginViewController.loginDidCancelSelector = @selector(loginCancel);
    //        _LoginViewController.loginDidOkSelector = @selector(loginOK);
    //        _LoginViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
    //                                                 initWithRootViewController:_LoginViewController];
    //        [_LoginViewController release];
    //        [self presentModalViewController:userNav animated:YES];
    //        [userNav release];
    //    }
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //    [self showTabBar];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    [self removeOverFlowActivityView];
    
    if (!self.activeName.length)
    {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
    }
    else
    {
        self.title = self.activeName;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    
    
    NSString *requestString = [[request URL] absoluteString];
    DLog(@"requestString %@",requestString);
    
    NSRange range = [requestString rangeOfString:@"isSNMobileLogin"];
    if (range.length > 0 && ![UserCenter defaultCenter].isLogined) {
        LoginViewController *_LoginViewController=[[LoginViewController alloc]init];
        _LoginViewController.loginDelegate = self;
        _LoginViewController.loginDidCancelSelector = @selector(loginCancel);
        _LoginViewController.loginDidOkSelector = @selector(loginOK);
        _LoginViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        AuthManagerNavViewController *userNav = [[AuthManagerNavViewController alloc]
                                                 initWithRootViewController:_LoginViewController];
        [self presentModalViewController:userNav animated:YES];
        return NO;
    }
    
    if ([requestString rangeOfString:@"mobileGoPay.tp" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        NSRange range = [requestString rangeOfString:@"?"];
        NSString *result = [requestString substringFromIndex:range.location+1];
        NSDictionary *paramDic = [result queryDictionaryUsingEncoding:NSUTF8StringEncoding];
        NSString *paystep = paramDic[@"paystep"];
        NSString *orderId = paramDic[@"b2cOrderId"];
        if ([paystep isEqualToString:@"3"] && orderId.length)
        {
            payFlowDTO *dto = [payFlowDTO payDTOWithOrder:orderId];
            PaymentModeViewController *vc = [[PaymentModeViewController alloc] initWithPayFlowDTO:dto andShipMode:ShipModeSuningSend allPaytype:NO];
            vc.isShowTotalPrice = NO;
            [self.navigationController pushViewController:vc animated:YES];
            return NO;
        }
        else if ([paystep isEqualToString:@"4"])
        {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                            message:@"订单已支付成功，您可以"
                                                           delegate:nil
                                                  cancelButtonTitle:@"查看订单"
                                                  otherButtonTitles:@"去逛逛"];
            
            __unsafe_unretained NDetailShopWebViewController *weakSelf = self;
            
            [alert setCancelBlock:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                [weakSelf jumpToOrderCenterBoard];
            }];
            
            [alert setConfirmBlock:^{
                
                [weakSelf goAroundWithCompleteBlock:^{
                    
                    [weakSelf.navigationController popToRootViewControllerAnimated:NO];
                }];
            }];
            
            [alert show];
        }
        
        return YES;
    }
        
    if ([requestString rangeOfString:@"suningredirect:login" options:NSCaseInsensitiveSearch].location != NSNotFound && ![UserCenter defaultCenter].isLogined )
    {
        NSRange range = [requestString rangeOfString:@"?"];
        NSString *result = [requestString substringFromIndex:range.location+1];
        NSDictionary *paramDic = [result queryDictionaryUsingEncoding:NSUTF8StringEncoding];
        NSString *redirectUrlStr = paramDic[@"URL"];
        NSURL *redirectUrl = [NSURL URLWithString:redirectUrlStr];
        
        if (redirectUrl)
        {
            [self checkLoginWithLoginedBlock:^{
                
                NSURLRequest *redirectRequest = [NSURLRequest requestWithURL:redirectUrl];
                [self.webView loadRequest:redirectRequest];
                
            } loginCancelBlock:^{
                //do nothing
            }];
        }
        else
        {
            DLog(@"invalid redirect url %@", redirectUrlStr);
        }
        
        return NO;
    }
    
    if ([requestString rangeOfString:@"suningredirect:rechargecenter" options:NSCaseInsensitiveSearch].location != NSNotFound)
    {
        //充值中心
        PaymentCenterViewController *paymentCenterViewController = [[PaymentCenterViewController alloc] init];
        paymentCenterViewController.hidesBottomBarWhenPushed =YES;
        [self.navigationController pushViewController:paymentCenterViewController animated:YES];
        return NO;
    }
    
    NSArray *components = [requestString componentsSeparatedByString:@":"];
    if ([components count] > 2 && [(NSString *)[components objectAtIndex:0] isEqualToString:@"callioswebviewcontroller"])
    {
        NSString *productId = nil;
        NSString *productCode = nil;
        int productType = 0;    // 0 普通商品，1 抢购， 2 单品团
        NSString *purchaseId = nil;
        int chanId = 0;
        NSString *shopCode = @"";
        
        productId = [components objectAtIndex:1];
        productCode = [components objectAtIndex:2];
        
        if ([components count] > 3)
        {
            productType = [[components objectAtIndex:3] intValue];
        }
        
        if ([components count] > 4)
        {
            purchaseId = [components objectAtIndex:4];
        }
        
        if ([components count] > 5)
        {
            chanId = [[components objectAtIndex:5] intValue];
        }
        
        if ([components count] > 6)
        {
            shopCode = [components objectAtIndex:6];
        }
        
        switch (productType)
        {
            case 0:   //普通商品
            {
                DataProductBasic *dataProductBasic = [[DataProductBasic alloc] init];
                dataProductBasic.productId = productId;
                dataProductBasic.productCode = productCode;
                dataProductBasic.cityCode = [Config currentConfig].defaultCity;
                dataProductBasic.shopCode = shopCode;
                
                ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
                productViewController.productType = EightBannerProduct;
                
                [self.navigationController pushViewController:productViewController animated:YES];
                
                TT_RELEASE_SAFELY(dataProductBasic);
                TT_RELEASE_SAFELY(productViewController);
                break;
            }
            case 1: //b2c抢购商品
            {
                if ([purchaseId length])
                {
                    PanicPurchaseDTO *dto = [[PanicPurchaseDTO alloc] init];
                    dto.catentryId = productId;
                    dto.partNumber = productCode;
                    dto.rushPurId = purchaseId;
                    dto.shopCode = shopCode;
                    PurchaseDetailViewController *vc = [[PurchaseDetailViewController alloc] initWithPurchaseDTOandIsSK:dto];
                    vc.panicChannel = chanId;  //设置抢购渠道
                    vc.productType = PanicProduct;
                    [self.navigationController pushViewController:vc animated:YES];
                    
                    TT_RELEASE_SAFELY(vc);
                    TT_RELEASE_SAFELY(dto);
                }
                break;
            }
            case 2:  //单品团b2c
            {
                DJGroupListItemDTO *itemDto = [[DJGroupListItemDTO alloc] init];
                itemDto.grpPurId = purchaseId;
                itemDto.catentryId = productId;
                itemDto.channelID = [NSString stringWithFormat:@"%d",chanId];
                DJGroupDetailViewController *detailViewController = [[DJGroupDetailViewController alloc] initWithDto:itemDto];
                [self.navigationController pushViewController:detailViewController animated:YES];
                TT_RELEASE_SAFELY(detailViewController);
                TT_RELEASE_SAFELY(itemDto);
                break;
            }
            default:
                break;
        }
        
        return YES;
        
    }
    else if ([requestString hasPrefix:@"callsearchviewcontroller"])
    {
        [SearchListViewController goToSearchResultWithKeyword:(NSString *)[components safeObjectAtIndex:1]
                                                      fromNav:self.navigationController];
        return YES;
        
    }
    else if ([requestString hasPrefix:@"http://"] || [requestString hasPrefix:@"https://"])
    {
        return YES;
    }
    else if ([requestString hasPrefix:@"about:blank"])
    {
        return YES;
    }
    else if (requestString.trim.length == 0)
    {
        //url为空，一般是url异常
        DLog(@"Warn: null url");
        return NO;
    }
    else if([requestString hasPrefix:@"redirect:back"])
    {
        
        [self.navigationController popViewControllerAnimated:YES];
        return NO;
//        [self backForePage];
    }
    else if ([requestString compare:@"com.suning.SuningEBuy://"
                            options:NSCaseInsensitiveSearch
                              range:NSMakeRange(0, 24)] == NSOrderedSame)
    {
        [self presentSheet:@"您已打开苏宁易购客户端，快去逛逛吧"];
        [self jumpToHomeBoard];
        return NO;
    }
    else
    {
        [self presentSheet:@"请升级客户端参与活动"];
        return YES;
    }
}


- (void)loginCancel{
    //    [self showTabBar];
    [self backToFore];
    //    [self performSelector:@selector(backToFore) withObject:self afterDelay:0.1];
}
- (void)backToFore
{
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)loginOK{
    //    [self.webView loadRequest:_request];
    //	  [self reload];
    //    [self reload];
    NSURL *url = [_request URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _request = request;
    [self.webView loadRequest:_request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //    [super webView:webView didFailLoadWithError:error];
    [self removeOverFlowActivityView];
    //    self.title = self.activeName;
    //
    //    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
    DLog(@"Connection did fail %@",[error localizedDescription]);
    
}


@end
