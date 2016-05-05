//
//  WebModelViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-7-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "WebModelViewController.h"
#import "ProductViewController.h"
#import "SearchListViewController.h"
#import "AppDelegate.h"
#import "PurchaseDetailViewController.h"
#import "DJGroupListItemDTO.h"
#import "DJGroupDetailViewController.h"
#import "FilterRootViewController.h"
#import "JASidePanelController.h"
#import "DJGroupRuleView.h"
#import "FilterNavigationController.h"
#import "PaymentModeViewController.h"
#import "PaymentCenterViewController.h"

@interface WebModelViewController ()
{
    BOOL  isClick;
    BOOL  isFirst;
}

@property (nonatomic, strong) UIButton *navItemButton;
@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UIView *tipBackView;
@property (nonatomic, strong) UIImageView *tipTitleView;
@property (nonatomic, strong) UIView *tipContentView;
@property (nonatomic, strong) UILabel *tipTitelLbl;
@property (nonatomic, strong) UIButton *tipCloseBtn;
@property (nonatomic, strong) UITextView *tipContentTextView;

@end

@implementation WebModelViewController

@synthesize navItemButton = _navItemButton;
@synthesize activeName = activeName_;
@synthesize blackView = _blackView;
@synthesize tipBackView = _tipBackView;
@synthesize tipTitleView = _tipTitleView;
@synthesize tipContentView = _tipContentView;
@synthesize tipTitelLbl = _tipTitelLbl;
@synthesize tipCloseBtn = _tipCloseBtn;
@synthesize tipContentTextView = _tipContentTextView;

- (void)dealloc {
    TT_RELEASE_SAFELY(activeName_);
    
    TT_RELEASE_SAFELY(_navItemButton);
    TT_RELEASE_SAFELY(_blackView);
    TT_RELEASE_SAFELY(_tipBackView);
    TT_RELEASE_SAFELY(_tipTitleView);
    TT_RELEASE_SAFELY(_tipContentTextView);
    TT_RELEASE_SAFELY(_tipTitelLbl);
    TT_RELEASE_SAFELY(_tipCloseBtn);
    TT_RELEASE_SAFELY(_tipContentTextView);
    
}

- (id)initWithRequest:(NSURLRequest *)request
{
    if (self = [super init]) {
        _request = request;
		// Create toolbar (to make sure that we can access it at any time)
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        self.hidesBottomBarWhenPushed = YES;
    }
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
		
		NSURL *_url =[[NSURL alloc ]initWithString:link];
		
		
        _request = [[NSURLRequest alloc ]initWithURL:_url];
		
        
		// Create toolbar (to make sure that we can access it at any time)
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        self.hidesBottomBarWhenPushed = YES;
    }
    
    
    return self;
}


- (id)initWithRequestUrl:(NSString *)url
{
    if (self = [super init]) {
		
		NSString *url1 = [[NSString alloc] initWithFormat:@"http://%@",url];
		
		NSURL *_url =[[NSURL alloc ]initWithString:url1];
		
        _request = [[NSURLRequest alloc ]initWithURL:_url];
		
		
        
		// Create toolbar (to make sure that we can access it at any time)
		_toolbar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
	
}

- (id)init{
	
    self = [super init];
	
    if (self) {
		
        self.title = L(@"RecommendActivity");
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:@"规则"];
    
    _webView.scalesPageToFit = YES;
    
    isFirst = YES;
    
   
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    [self hideTabBar];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
//    [self showTabBar];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [super webViewDidFinishLoad:webView];
    
    self.title = self.activeName;
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

//xie biao zhu
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [super webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    
    if (isFirst) {
        isClick = NO;
        isFirst = !isFirst;
    }else {
        isClick = YES;
    }
    
    NSString *requestString = [[request URL] absoluteString];
    DLog(@"requestString %@",requestString);
    
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
            
            __unsafe_unretained WebModelViewController *weakSelf = self;
            
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
    
    NSRange loginRange = [requestString rangeOfString:@"suningredirect:login" options:NSCaseInsensitiveSearch];
    
    if (loginRange.location != NSNotFound && ![UserCenter defaultCenter].isLogined )
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
        NSString *shopCode = @"";   //默认自营
        
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
    else
        if ([requestString hasPrefix:@"callsearchviewcontroller"])
        {
            [SearchListViewController goToSearchResultWithKeyword:(NSString *)[components safeObjectAtIndex:1]
                                                          fromNav:self.navigationController];
            return YES;
            
        }
        else if ([requestString hasPrefix:@"http://"] || [requestString hasPrefix:@"https://"] || [requestString hasPrefix:@"www://"])
        {
            return YES;
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
            if ([self.activeName isEqualToString:@"单价团"]) {
                
                [self presentSheet:@"暂无活动数据，维护中"];
                
            }
            else{
                
                [self presentSheet:@"请升级客户端参与活动"];
            }
            return YES;
        }	
}



- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [super webView:webView didFailLoadWithError:error];
    self.title = self.activeName;
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
    DLog(@"Connection did fail %@",[error localizedDescription]);
    
    if (!isClick) {
        [self presentSheet:@"暂无活动数据，维护中"];
    }
}

#pragma mark - 规则

- (UIView *)blackView
{
    if (!_blackView) {
        _blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.5;
        _blackView.hidden = YES;
        
        UIButton *btn = [[UIButton alloc] initWithFrame:_blackView.frame];
        btn.backgroundColor = [UIColor clearColor];
        [btn addTarget:self action:@selector(closeRuleTip) forControlEvents:UIControlEventTouchUpInside];
        [_blackView addSubview:btn];
        TT_RELEASE_SAFELY(btn);
    }
    return _blackView;
}

- (UIView *)tipBackView
{
    if (!_tipBackView) {
        _tipBackView = [[UIView alloc] initWithFrame:CGRectMake(42, 55, 238, 290)];
        _tipBackView.backgroundColor = RGBCOLOR(242, 238, 225);
        _tipBackView.hidden = YES;
        _tipBackView.userInteractionEnabled = YES;
        
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 225, 280)];
        textView.backgroundColor = [UIColor clearColor];
        textView.textColor = [UIColor darkGrayColor];
        textView.font = [UIFont boldSystemFontOfSize:15.0];
        textView.delegate = self;
        NSError *error;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"groupBuyRule" ofType:@"txt"];
        NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
        textView.text = shellTitleText;
        [_tipBackView addSubview:textView];
        TT_RELEASE_SAFELY(textView);
    }
    return _tipBackView;
}

- (UIImageView *)tipTitleView
{
    if (!_tipTitleView) {
        _tipTitleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"DJ_List_Rule_Title.png"]];
        _tipTitleView.backgroundColor = [UIColor clearColor];
        _tipTitleView.frame = CGRectMake(38.5, 21, 245, 40);
        _tipTitleView.hidden = YES;
        _tipTitleView.userInteractionEnabled = YES;
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(86, 8, 150, 23)];
        title.backgroundColor = [UIColor clearColor];
        title.text = @"团购规则";
        title.textColor = [UIColor darkGrayColor];
        title.font = [UIFont boldSystemFontOfSize:15.0];
        title.shadowColor = [UIColor whiteColor];
        title.shadowOffset = CGSizeMake(1, 1);
        [_tipTitleView addSubview:title];
        TT_RELEASE_SAFELY(title);
        
        UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(210, 2, 31, 29)];
        closeBtn.backgroundColor = [UIColor clearColor];
        [closeBtn setBackgroundImage:[UIImage imageNamed:@"DJ_List_Rule_Title_Close"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeRuleTip) forControlEvents:UIControlEventTouchUpInside];
        [_tipTitleView addSubview:closeBtn];
        TT_RELEASE_SAFELY(closeBtn);
        
    }
    return _tipTitleView;
}

- (void)closeRuleTip
{
    self.blackView.hidden = YES;
    self.tipTitleView.hidden = YES;
    self.tipBackView.hidden = YES;
}

//- (UIButton *)navItemButton
//{
//    if (!_navItemButton)
//    {
//        _navItemButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
//        [_navItemButton setImage:kDJGroupRuleIcon
//                        forState:UIControlStateNormal];
//        _navItemButton.size = CGSizeMake(50, 30);
//        [_navItemButton addTarget:self action:@selector(groupRuleClick)
//                 forControlEvents:UIControlEventTouchUpInside];
//    }
//    
//    return _navItemButton;
//}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}

#pragma mark - 事件处理方法

- (void)groupRuleClick
{
    self.blackView.hidden = NO;
    self.tipTitleView.hidden = NO;
    self.tipBackView.hidden = NO;
}

- (void)righBarClick
{
//    self.blackView.hidden = NO;
//    self.tipTitleView.hidden = NO;
//    self.tipBackView.hidden = NO;
    UIWindow *window = self.appDelegate.window;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"groupBuyRule" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    DJGroupRuleView *ruleView = [[DJGroupRuleView alloc]initWithFrame:window.bounds andTitle:@"活动规则" andText:shellTitleText];

    [ruleView showInView:window];
}


@end
