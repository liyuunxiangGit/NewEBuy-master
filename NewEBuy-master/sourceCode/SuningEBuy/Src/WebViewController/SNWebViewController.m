//
//  SNWebViewController.m
//  SuningEBuy
//
//  Created by liukun on 14-5-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SNWebViewController.h"
#import "PaymentModeViewController.h"
#import "PaymentCenterViewController.h"
#import "ProductDetailViewController.h"
#import "PurchaseDetailViewController.h"
#import "DJGroupDetailViewController.h"
#import "SearchListViewController.h"
#import "RegexKitLite.h"
#import "GetUserInfoCommand.h"
#import "DJGroupRuleView.h"
#import "WebViewJavascriptBridge.h"
#import "SNWebViewController+JSBridge.h"


//忽略证书验证的方法，在release时不能要，不然苹果发布不能通过
#if kAllowInvalidHttps

@implementation NSURLRequest (NSURLRequestWithIgnoreSSL)

+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}

@end

#endif

#ifdef kReleaseH
#define kEppTrustOkUrl          @"https://mpay.suning.com/epp-paycore/payGateWay/show.htm?eppwappay"
#define kMyEppTrustUrl          @"http://mpay.suning.com/epp-m/show/userPay.htm"
#else

#define kEppTrustOkUrl          @"https://mpay.cnsuning.com/epp-paycore/payGateWay/show.htm?eppwappay"
#define kMyEppTrustUrl          @"http://mpaypre.cnsuning.com/epp-m/show/userPay.htm"
#endif

@interface SNWebViewController () <ChooseShareWayViewDelegate>
{
    BOOL        _hasPageDisplayed;
}

/** share */
@property (nonatomic, strong) ChooseShareWayView *chooseShareWayView;
@property (nonatomic, strong) SNShareKit *shareKit;

@end

@implementation SNWebViewController

@synthesize webView = _webView;
@synthesize request = _request;
@synthesize webType = _webType;

// 不需要改userAgent
//+ (void)initialize
//{
//    if (self == [SNWebViewController class]) {
//        NSString * useragent =[NSString stringWithFormat:@"%@SNEBUY-APP", [ASIHTTPRequest defaultUserAgentString]];
//        NSDictionary *dictionary = @{@"UserAgent": useragent};
//        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
//    }
//}


- (void)dealloc
{
    _webView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    //清除webView的缓存
//    if (self.shouldClearCacheOnExit) {
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    }
}

- (void)setUp
{
    self.hasNav = YES;
    self.hidesBottomBarWhenPushed = YES;
    self.iOS7FullScreenLayout = YES;
    self.shouldUseDocumentTitle = YES;
    self.shouldClearCacheOnExit = YES;
    self.shouldDisplayOverflow = NO;//修改去掉转圈
    self.shouldGoBackInWebWhenTouchNavBack = YES;
    needShowOverFlowOnce = YES;
    
    _urlPatterns =
    @[
      @{@"regex" : @"isSNMobileLogin",
        @"action" : @"loginAction:",
        },
      @{@"regex" : @"nativeWebBackMethod",
        @"action" : @"handleBackMethod:",
        },
      
      @{@"regex": @"mobileGoPay.tp",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"mobileGoPay:",
        },
      
      @{@"regex": @"^suningredirect:login",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"loginWithRedirect:",
        },
      
      @{@"regex": @"^suningredirect:rechargecenter",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"recharge:",
        },
      
      @{@"regex": @"^callioswebviewcontroller(:\\d*){2,6}$",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"product:",
        },
      
      @{@"regex": @"^callsearchviewcontroller(:[^:]+)?$",
        @"action" : @"search:",
        },
      
      @{@"regex": @"SNMobileEppPayCallBack",
        @"action" : @"eppCallBack:",
        },
      
      @{@"regex": @"suningredirect:paysuccess:flight",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"eppCallBack_flight:"
        },
      
      @{@"regex": @"^downloadOrRead:.*",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"subook_downloadOrRead:"
        },
      //满座Call易购登录
      @{@"regex": @"isNeedTicket=yes",
        @"action" : @"loginActionManzuo:"
        },
      
      //epp信任登陆回调
      @{@"regex": @"^https://mpay\\.(suning|cnsuning)\\.com/epp-paycore/payGateWay/show\\.htm\\?eppwappay",
        @"action" : @"eppTrustLoginOk:"
        },
      
      @{@"regex": @"https://(passportsit\\.cnsuning|passportpre\\.cnsuning|passport\\.suning)\\.com/ids/login",
        @"action" : @"loginActionPassport:",
        },
      
      //红包分享
      @{@"regex": @"^http(s)?://.*suningwapactivityshare.do.*",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"wapActivityShare:"
        },
      
      //摇一摇复制
      @{@"regex": @"^http(s)?://.*\\?yaoyiyaofuzhi*",
        @"action" : @"yaoYiYao_copy:"
        },
      
      @{@"regex": @"^http(s)?://itunes.apple.com/.*(?=424598114).*$",
        @"action" : @"itunes_ebuy:",
        },
      
      @{@"regex": @"^http(s)?://itunes.apple.com/.*",
        @"action" : @"itunes:",
        },
      
      @{@"regex": @"http(s)?://",
        @"action" : @"httpUrls:",
        },
      
      @{@"regex": @"^com.suning.suningebuy://",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"urlScheme_ebuy:",
        },
      
      @{@"regex": @"^ebuyweb://SNIOSWebViewBack$",
        @"action" : @"back2:",
        },
      
      @{@"regex": @"^ebuyweb://SNIOSWebViewShowNavBar$",
        @"action" : @"showNavBar:",
        },
      
      @{@"regex": @"://",
        @"action" : @"otherUrlSchemes:",
        },
      
      @{@"regex": @"^about:",
        @"action" : @"abouts:",
        },
      
      @{@"regex": @"^(redirect:back.*|backtoclient(:.*)?)$",
        @"regularOption" : @(NSRegularExpressionCaseInsensitive),
        @"action" : @"back:",
        },
      ];
}

- (UIWebView *)webView{
    
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
        _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                     UIViewAutoresizingFlexibleHeight |
                                     UIViewAutoresizingFlexibleBottomMargin);
        _webView.backgroundColor = [UIColor clearColor];
        if (!IOS7_OR_LATER) {
            for (UIView *view in [[[_webView subviews] safeObjectAtIndex:0] subviews]) {
                if ([view isKindOfClass:[UIImageView class]]) view.hidden = YES;
            }
        }
    }
    
    return _webView;
}

- (id)initWithRequest:(NSURLRequest *)request
{
    return [self initWithType:SNWebViewTypeCommon attributes:request?@{@"request": request}:nil];
}

- (id)initWithRequestUrl:(NSString *)url
{
    return [self initWithType:SNWebViewTypeCommon attributes:url?@{@"url": url}:nil];
}

- (id)initwithURLArray:(NSArray *)arr1 titleArray:(NSArray *)arr2 {
    urlTitleArray = [[NSArray alloc] initWithArray:arr2];
    urlArray = [[NSArray alloc] initWithArray:arr1];
    
    //默认加载第一个商品预约
    NSString *url = (NSString *)[arr1 objectAtIndex:0];
    return [self initWithType:SNWebViewTypeCommon attributes:url?@{@"url": url}:nil];
    
    //add by zhangbeibei:  蒋亚龙-现在改成商品预约和门店预约
    isDirectBackToAPP = YES;
}

- (id)initWithHtmlString:(NSString *)html
{
    return [self initWithType:SNWebViewTypeCommon attributes:html?@{@"html": html}:nil];
}

- (BOOL)shouldTrushToEpp
{
    if (self.webType == SNWebViewTypeEfubao ||
        self.webType == SNWebViewTypeEppPay ||
        self.webType == SNWebViewTypeEppCharge ||
        self.webType == SNWebViewTypeEppPayPlane)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)loadRequest
{
    if (_request)
    {
        [self.webView loadRequest:self.request];
    }
    else if (_htmlString)
    {
        [self.webView loadHTMLString:_htmlString baseURL:nil];
    }
    else
    {
        DLog(@"Error: `SNWebViewController` need a request");
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//   add by gjf  激活后刷新页面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshWebview) name:@"refreshWeb" object:nil];
    if (urlArray) {
        
        if (IOS7_OR_LATER) {
            segment = [[CustomSegment alloc] initWithFrame:CGRectMake(0, 64, 320, 42)];
            self.webView.frame = CGRectMake(self.view.bounds.origin.x, 64+42, self.view.bounds.size.width, self.view.bounds.size.height-(42+20+44));
        }
        else {
            segment = [[CustomSegment alloc] initWithFrame:CGRectMake(0, 0, 320, 42)];
            self.webView.frame = CGRectMake(self.view.bounds.origin.x, 42, self.view.bounds.size.width, self.view.bounds.size.height-42);
        }
        
        segment.delegate = self;
        [segment setItems:@[L(@"MakeAnAppointmentGood"), L(@"MakeAnAppointmentStore")]];
        [self.view addSubview:segment];
    }
    else {
        self.webView.frame = self.view.bounds;
    }

    self.webView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.webView];
    
    //启动js-bridge引擎
    [self jsBridgeEngineStart];
    
//    [self loadRequest];
    //244 每次进入都需信任登录
    if ([self shouldTrushToEpp]) {
        [self passportTrustLoginToEpp];
    }
    else
    {
        [self loadRequest];
    }
}

-(void)refreshWebview{
    [self.webView reload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self jsBridge_viewWillAppear];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self jsBridge_ViewWillDisappear];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - CustomSegmentDelegate
- (void)segment:(CustomSegment *)segment didSelectAtIndex:(NSInteger)index {
    //add by zhangbeibei:  蒋亚龙-现在改成商品预约和门店预约
    isDirectBackToAPP = YES;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[urlArray objectAtIndex:index]]]];
}


#pragma mark ----------------------------- webView delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if (self.shouldDisplayOverflow || needShowOverFlowOnce) [self displayOverFlowActivityView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (self.shouldDisplayOverflow || needShowOverFlowOnce) [self removeOverFlowActivityView];
    
    needShowOverFlowOnce = NO;
    
    DLog(@"Connection did fail %@", error);
    
    switch (error.code) {
        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorNotConnectedToInternet:
            [self presentSheet:kNetUnreachErrorMsg];
        default:
            break;
    }
//    
//    NSString *errorMsg = [error localizedFailureReason];
//    
//    if ([errorMsg length])
//    {
//        [self presentSheet:errorMsg];
//    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    if (self.shouldDisplayOverflow || needShowOverFlowOnce) [self removeOverFlowActivityView];
    
    needShowOverFlowOnce = NO;
    
    if (!_hasPageDisplayed) {
        _hasPageDisplayed = YES;
    }
    
    if (self.shouldUseDocumentTitle && !self.stableTitle.length)
    {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        self.title = title;
        
        //如果没有页面收集规则，默认收集页面的title
        if (!self.pageTitle.length) {
            if (self.controllerSourceType == 1) {
                self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"show_homePage"), title];
            }
            else if (self.controllerSourceType == 2) {
                self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitlePageSetPrefix"), title];
            }
            else if (self.controllerSourceType == 3) {
                self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitleSalePromotionPrefix"), title];
            }
            else if (self.controllerSourceType == 4) {
                self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitleLianBanZhuanTiPrefix"), title];
            }
            else if (self.controllerSourceType == 5) {
                self.pageTitle = [NSString stringWithFormat:@"%@-%@", L(@"PageTitleProductListPrefix"), title];
            }
            else {
                self.pageTitle = self.title;
            }
            [self snclick_viewWillAppear];
        }
    }
    
    [self checkCanGoBack];
    
    //检查是否在web页面进行了登录或注销
#ifdef kReleaseH
    NSURL *url = [NSURL URLWithString:@"https://www.suning.com"];
#elif kPreTest
    NSURL *url = [NSURL URLWithString:@"https://b2cpre.cnsuning.com"];
#elif kSitTest
    NSURL *url = [NSURL URLWithString:@"https://b2csit.cnsuning.com"];
#endif
    NSArray *cookieArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:url];
    
    //244 注释 gjf
    /*
    if ([UserCenter defaultCenter].isLogined)
    {
        BOOL hasLogout = NO;
        
        for (NSHTTPCookie *cookie in cookieArray)
        {
            NSString *name = [cookie name];
            
            if ([name isEqualToString:@"WC_USERACTIVITY_-1002"])
            {
                hasLogout = YES;
                break;
            }
        }
        
        if (hasLogout)
        {
            //注销
            [[UserCenter defaultCenter] markAsLogout];
        }
    }
    else
     */
    if (![UserCenter defaultCenter].isLogined)
    {
        BOOL hasCookieIden1 = NO;
        BOOL hasCookieIden2 = NO;
        
        for (NSHTTPCookie *cookie in cookieArray)
        {
            NSString *name = [cookie name];
            
            if ([name isMatchedByRegex:@"^WC_USERACTIVITY_((?!-1002)\\d{8,15})$"])
            {
                hasCookieIden1 = YES;
            }
            
            if ([name isMatchedByRegex:@"^WC_AUTHENTICATION_((?!-1002)\\d{8,15})$"])
            {
                hasCookieIden2 = YES;
            }
            
            if (hasCookieIden1 && hasCookieIden2)
            {
                break;
            }
        }
        
        if (hasCookieIden1 && hasCookieIden2)
        {
            //在wap页面中登录成功，获取用户信息
            GetUserInfoCommand *cmd = [GetUserInfoCommand command];
            [CommandManage excuteCommand:cmd completeBlock:nil];
        }
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    //将backType赋值为默认值
    backType = 3;

    NSURL *url = [request URL];
    
    NSString *urlString = [url absoluteString];
    
    if ([urlString isEqualToString:kEBookTradEnrtyHttp])
    {
        urlString = [kEBookTradEnrtyHttp stringByAppendingString:@"?noTitleFlag=1"];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        
        return NO;
        
    }else if ([urlString isEqualToString:kEBookIntactEnrtyHttp]){
        
        urlString = [kEBookIntactEnrtyHttp stringByAppendingString:@"?noTitleFlag=1"];
        
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        
        return NO;
    }
    
    for (NSDictionary *pattern in _urlPatterns)
    {
        NSString *regex = [pattern objectForKey:@"regex"];
        NSRegularExpressionOptions option = [[pattern objectForKey:@"regularOption"] integerValue];
        NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:regex options:option error:NULL];
        if ([expression numberOfMatchesInString:urlString options:NSMatchingReportCompletion range:NSMakeRange(0, urlString.length)] > 0) {
            
            NSString *action = [pattern objectForKey:@"action"];
            SEL selector = NSSelectorFromString(action);
            if ([self respondsToSelector:selector]) {
                IMP imp = [self methodForSelector:selector];
                BOOL (*func)(id, SEL, NSURL*) = (void *)imp;
                BOOL should = func(self, selector, url);
                return should;
            }else{
                return YES;
            }
        }
    }
    
    //未匹配任何链接
//    [self presentSheet:@"请升级客户端参与活动"];
//    return NO;
    return YES;
}

#pragma mark ----------------------------- button actions

- (void)reload
{
	[self.webView reload];
}

- (void)goBack
{
	if (self.webView.canGoBack) {
		// We can go back. So make the web view load the previous page.
		[self.webView goBack];
    }
}

- (void)goForward
{
	if (self.webView.canGoForward) {
		// We can go forward. So make the web view load the next page.
		[self.webView goForward];
	}
}

- (void)backForePage
{
    if (![self jsBridgeBackForePage])
    {
        if (self.webType == SNWebViewTypeEppPay || self.webType == SNWebViewTypeEppPayPlane)
        {
            //支付页面添加判断
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                            message:L(@"PaymentNotFinishWillBack")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"Cancel")
                                                  otherButtonTitles:L(@"Ok")];
            [alert setConfirmBlock:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
            [alert show];
        }
        else
        {
            if (isDirectBackToAPP) {
                //返回到app
                [self.navigationController popViewControllerAnimated:YES];
            }
            else {
                if (backType == BackMethodType_WebMainPage) {
                    //返回主页
                    [self loadBaseRequestFromAttributes:originDict];
                    [self loadRequest];
                }
                else if (backType == BackMethodType_APP) {
                    //返回到app
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else {
                    //返回上一页的逻辑
                    if (self.shouldGoBackInWebWhenTouchNavBack && [self.webView canGoBack])
                    {
                        [self.webView goBack];
                    }
                    else
                    {
                        [self.navigationController popViewControllerAnimated:YES];
                    }
                }
            }
        }
        
        //执行了一次返回按钮的方法过后，将backType赋值为默认值
        backType = 3;
    }
}

- (void)righBarClick
{
    if (self.webType == SNWebViewTypeDJGroup)
    {
        UIWindow *window = self.appDelegate.window;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"groupBuyRule" ofType:@"txt"];
        NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        DJGroupRuleView *ruleView = [[DJGroupRuleView alloc]initWithFrame:window.bounds andTitle:L(@"WC_ActiveRule") andText:shellTitleText];
        [ruleView showInView:window];
    }
}

#pragma mark - utils

- (BOOL)isCShopUrl:(NSString *)url
{
    BOOL isCShop = NO;
    if (url && [url rangeOfString:@"/SNMWCshopInfoView?"].location != NSNotFound) {
        
        isCShop = YES;
        
    } else if ([url hasPrefix:kCShopHostURL]) {
        
        isCShop = YES;
    }
    return isCShop;
}

#pragma mark ----------------------------- inits

- (void)loadBaseRequestFromAttributes:(NSDictionary *)attributes
{
    NSString *urlString = attributes[@"url"];
    NSString *formString = attributes[@"form"];
    NSString *html = attributes[@"html"];
    NSURLRequest *request = attributes[@"request"];
    if (urlString.length)
    {
        NSURL *url = [NSURL URLWithString:urlString];
        if (!url) {
            url = [NSURL URLWithString:[urlString URLEncoding]];
        }
        
        if (url) {
            _request = [[NSURLRequest alloc] initWithURL:url];
        }
    }
    else if (formString.length)
    {
        _htmlString = [NSString stringWithFormat:@"<html><body onload=\"document.forms[0].submit()\">%@</body></html>", formString];
    }
    else if (html.length)
    {
        _htmlString = html;
    }
    else if ([request isKindOfClass:[NSURLRequest class]])
    {
        _request = request;
    }
    else
    {
        DLog(@"no param!");
    }
}

- (instancetype)initWithType:(SNWebViewType)type attributes:(NSDictionary *)attributes
{
    self = [super init];
    
    //edit by gjf 预充值useragent 新增字段SNEBUY-APP
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    if(![secretAgent rangeOfString:@"SNEBUY-APP"].length>0){
        NSString *appVersion = [SystemInfo appVersion];
        NSString *newUagent = [NSString stringWithFormat:@"%@ SNEBUY-APP %@",secretAgent,appVersion];
        NSDictionary *dictionary = [[NSDictionary alloc]
                                    initWithObjectsAndKeys:newUagent, @"UserAgent", nil];
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    }

    if (self) {
        
        _webType = type;
        backType = 3;
        isDirectBackToAPP = NO;
        
        [self setUp];
        [self loadBaseRequestFromAttributes:attributes];
        originDict = [NSDictionary dictionaryWithDictionary:attributes];
        
        switch (type) {
            case SNWebViewTypeCommon:
            {
                self.title = @" "; //保证页面会被数据采集
                self.shouldClearCacheOnExit = NO;
                
                //判断是否是C店店铺
                NSString *url = attributes[@"url"];
                if ([self isCShopUrl:url])
                {
                    _webType = SNWebViewTypeCShop;
                    self.pageTitle = [NSString stringWithFormat:L(@"WC_ShowCStoreShop")];
                    self.hasNav = NO;
                }
                
                break;
            }
            case SNWebViewTypeAdModel:
            {
                NSString *activeName = attributes[@"activeName"];
                if (activeName.trim.length) {
                    self.stableTitle = activeName;
                    self.title = activeName;
                }else{
//                    self.title = L(@"RecommendActivity");
                }
                self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title.length?self.title:L(@"RecommendActivity")];
                self.shouldClearCacheOnExit = NO;
                
                //判断是否是C店店铺
                NSString *url = attributes[@"url"];
                if (!url) {
                    url = [[self.request URL] absoluteString];
                }
                if ([self isCShopUrl:url])
                {
                    _webType = SNWebViewTypeCShop;
                    self.pageTitle = [NSString stringWithFormat:L(@"WC_ShowCStoreShop")];
                    self.hasNav = NO;
                }
                
                break;
            }
            case SNWebViewTypeEfubao:
            {
                NSString *url = [NSString stringWithFormat:@"%@/%@", kEppHostAddress, kMobileEppMyEpp];
                _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
                self.pageTitle = L(@"WC_MenmberMyEBuy");
                self.shouldUseDocumentTitle = NO;
                self.title = L(@"efubao");
                break;
            }
            case SNWebViewTypeGame:
            {
                self.pageTitle = L(@"GameGame");
                self.title = self.pageTitle;
                _request = [NSURLRequest requestWithURL:[NSURL URLWithString:kHostWBGameForHttp]];
                break;
            }
            case SNWebViewTypeAppStore:
            {
                self.title = L(@"ApplicationCenter");
                self.pageTitle = self.title;
                self.shouldUseDocumentTitle = NO;
                self.pageTitle = self.title;
                _request = [NSURLRequest requestWithURL:[NSURL URLWithString:KHostWBWebForHttp]];
                break;
            }
            case SNWebViewTypeEppPay:
            {
                self.pageTitle = L(@"WC_ShopProcess");
                self.title = L(@"WC_EBuyPayOnline");
                self.shouldUseDocumentTitle = NO;
                
                break;
            }
            case SNWebViewTypeEppCharge:
            {
                self.shouldUseDocumentTitle = NO;
                break;
            }
            case SNWebViewTypeCaiPiao:
            {
                self.pageTitle = L(@"virtual_lottery");
                self.title = L(@"LotteryCenter");
                _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[attributes objectForKey:@"url"]]];
                self.shouldUseDocumentTitle = NO;
                self.shouldGoBackInWebWhenTouchNavBack = NO;
                break;
            }
            case SNWebViewTypeEppPayPlane:
            {
                self.pageTitle = L(@"WC_VirtulAirTicketWebCashier");
                self.title = L(@"WC_EBuyPayOnline");
                self.shouldUseDocumentTitle = NO;
                break;
            }
            case SNWebViewTypeCShop:
            {
                NSString *shopId = attributes[@"shopId"];
                self.pageTitle = [NSString stringWithFormat:L(@"WC_ShowCStore-%@"),shopId?shopId:@""];
                self.hasNav = NO;
                if ([attributes[@"SNRouteSourceScan"] isEqualToString:@"1"])
                {
                    sourceTitle = L(@"SNRouteSwitch_QRCode");
                    sourcePageTitle = self.pageTitle;
                }

                break;
            }
            case SNWebViewTypeBook:
            {
                _request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:KHostWBBookForHttp]];
                self.pageTitle = L(@"WC_SNReader");
                //self.title = L(@"WC_SNReader");
                //self.hasNav = NO;
                //self.shouldUseDocumentTitle = NO;
                break;
            }
            case SNWebViewTypeDJGroup:
            {
                NSString *url = attributes[@"url"];
                NSRange foundObj=[url rangeOfString:@"pai" options:NSCaseInsensitiveSearch];
                if (foundObj.length>0)
                {//闪拍的标志
                    self.title = @"";
                    self.shouldClearCacheOnExit = NO;
                }
                else
                {
                    self.title = L(@"WC_UnitPriceGroupBuy");
                    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
                    self.shouldUseDocumentTitle = NO;
                    self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"规则")];
                }
                
                break;
            }
            case SNWebViewTypeYaoYiYao:
            {
                [self setTitle:L(@"WC_InviteFriendsClone")];
                self.pageTitle = [NSString stringWithFormat:L(@"WC_ShakeEasyShake-%@"),self.title];
                break;
                
                //检测passport登录
//                NSMutableArray *patternArr = [_urlPatterns mutableCopy];
//                [patternArr addObject:@{@"regex": kPassportLoginUrl,
//                                        @"action" : @"loginAction2:",
//                                        }];
//                _urlPatterns = patternArr;
            }
            case SNWebViewTypeManZuo:
            {
                [self setTitle:L(@"WC_FullSeat")];
                self.shouldGoBackInWebWhenTouchNavBack = YES;
                self.pageTitle = [NSString stringWithFormat:@"%@",self.title];
                break;
            }
            default:
                break;
        }
    }
    return self;
}

#pragma mark ----------------------------- actions

- (BOOL)loginAction:(NSURL *)url
{
    if (![UserCenter defaultCenter].isLogined)
    {
        [self checkLoginWithLoginedBlock:^{
            
            NSURLRequest *request_ = [NSURLRequest requestWithURL:url];
            [self.webView loadRequest:request_];
            
        } loginCancelBlock:^{
            
            if (!_hasPageDisplayed) {
                [self backForePage];
            }
        }];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)loginAction2:(NSURL *)url
{
    if (![UserCenter defaultCenter].isLogined)
    {
        [self checkLoginWithLoginedBlock:^{
            
            [self.webView loadRequest:_request];
            
        } loginCancelBlock:^{
            
            
        }];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)loginActionManzuo:(NSURL *)url
{
    NSString *regex = @"targetUrl=[\\s\\S]*";
    NSString *targetString = @"";
    NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:regex options:0 error:NULL];
    NSString *urlString = [url absoluteString];
    NSArray *array = [expression matchesInString:urlString options:NSMatchingReportCompletion range:NSMakeRange(0, urlString.length)];
    if (array.count > 0 ) {
        NSTextCheckingResult *result = [array firstObject];
        targetString = [urlString substringWithRange:NSMakeRange(result.range.location+10, result.range.length-10)];
    }
    if (![UserCenter defaultCenter].isLogined)
    {
        [self checkLoginWithLoginedBlock:^{
            NSString *manzuoUrl = [NSString stringWithFormat:@"%@?sysCode=%@&targetUrl=%@&mode=restrict",kPassportTrustLoginUrl,kSysCodeForManzuo,targetString];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:manzuoUrl]]];
            
        } loginCancelBlock:^{
            
            
        }];
    }
    else
    {
        NSString *manzuoUrl = [NSString stringWithFormat:@"%@?sysCode=%@&targetUrl=%@&mode=restrict",kPassportTrustLoginUrl,kSysCodeForManzuo,targetString];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:manzuoUrl]]];
    }
    return NO;
}

- (BOOL)loginActionPassport:(NSURL *)url
{
    NSString *paramString = [url query];
    NSDictionary *paramDic = [paramString queryDictionaryUsingEncoding:NSUTF8StringEncoding];
    NSString *isGateWay = [paramDic objectForKey:@"gateway"];
    if (isGateWay && [isGateWay isEqualToString:@"true"]) {
        //2014-10-14 11:58:20 Joe
        //根据协议，当Passport链接中存在gateway=true逻辑时候，客户端不需要触发登录逻辑。
        return YES;
    }
    NSString *service = [paramDic objectForKey:@"service"];
    NSURL *serviceUrl = [NSURL URLWithString:service];
    NSString *targetUrlStr = [[[serviceUrl query] queryDictionaryUsingEncoding:NSUTF8StringEncoding] objectForKey:@"targetUrl"];
    NSURL *targetUrl = nil;
    if (targetUrlStr.length) {
        targetUrl = [NSURL URLWithString:targetUrlStr];
    }else{
        targetUrl = serviceUrl;
    }
    
    if (![UserCenter defaultCenter].isLogined) {
        [self checkLoginWithLoginedBlock:^{
            
            if (targetUrl) {
                [self.webView loadRequest:[NSURLRequest requestWithURL:targetUrl]];
            }else{
                [self.webView loadRequest:_request];
            }
            
        } loginCancelBlock:^{
            
            //do nothing
            if (!_hasPageDisplayed) {
                [self backForePage];
            }
        }];
    }else{
        DLog(@"ERROR: webView still call login when client already logon!");
    }
    
    return NO;
}

- (BOOL)handleBackMethod:(NSURL *)url {
    NSString *urlString = [url absoluteString];
    NSRange range = [urlString rangeOfString:@"objc://nativeWebBackMethod/"];
    if (range.location == NSNotFound) {
        backType = 3;
    }
    else {
        NSString *paramString = [urlString substringFromIndex:range.location + [@"objc://nativeWebBackMethod/" length]];
        backType = [paramString intValue];
    }
    return NO;
}

- (BOOL)mobileGoPay:(NSURL *)url
{
    NSString *paramString = [url query];
    NSDictionary *paramDic = [paramString queryDictionaryUsingEncoding:NSUTF8StringEncoding];
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
                                                        message:L(@"PFOrderPaySuccess")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"check the order")
                                              otherButtonTitles:L(@"AlertGoShopping")];
        
        __weak SNWebViewController *weakSelf = self;
        
        [alert setCancelBlock:^{
            //去订单中心
            [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            [weakSelf jumpToOrderCenterBoard];
        }];
        
        [alert setConfirmBlock:^{
            //去逛逛
            [weakSelf goAroundWithCompleteBlock:^{
                [weakSelf.navigationController popToRootViewControllerAnimated:NO];
            }];
        }];
        
        [alert show];
    }
    
    return YES;
}

- (BOOL)loginWithRedirect:(NSURL *)url
{
    NSArray *componts = [[url absoluteString] componentsSeparatedByString:@"?"];
    NSString *paramString = [componts safeObjectAtIndex:1];
    NSDictionary *paramDic = [paramString queryDictionaryUsingEncoding:NSUTF8StringEncoding];
    NSString *redirectUrlStr = paramDic[@"URL"];
    NSURL *redirectUrl = [NSURL URLWithString:redirectUrlStr];
    
    if (![UserCenter defaultCenter].isLogined) {
        
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
    }
    else
    {
        NSURLRequest *redirectRequest = [NSURLRequest requestWithURL:redirectUrl];
        [self.webView loadRequest:redirectRequest];
    }
    
    return NO;
}

- (BOOL)recharge:(NSURL *)url
{
    //充值中心
    PaymentCenterViewController *paymentCenterViewController = [[PaymentCenterViewController alloc] init];
    paymentCenterViewController.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:paymentCenterViewController animated:YES];
    return NO;
}

//callioswebviewcontroller
- (BOOL)product:(NSURL *)url
{
    NSArray *components = [[url absoluteString] componentsSeparatedByString:@":"];
    NSString *productId = nil;
    NSString *productCode = nil;
    int productType = 0;    // 0 普通商品，1 抢购， 2 单品团
    NSString *purchaseId = nil;
    int chanId = 0;
    NSString *shopCode = nil; //默认最优
    
    productId = [components objectAtIndex:1];
    productCode = [components objectAtIndex:2];
    
    if ([components count] > 3) productType = [[components objectAtIndex:3] intValue];
    if ([components count] > 4) purchaseId = [components objectAtIndex:4];
    if ([components count] > 5) chanId = [[components objectAtIndex:5] intValue];
    if ([components count] > 6) shopCode = [components objectAtIndex:6];
    
    if ([shopCode isEqualToString:@""])
    {
        shopCode = nil;  //为空是最优
    }
    else if ([shopCode isEqualToString:@"0000000000"])
    {
        shopCode = @""; //自营商品
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
                
                DataProductBasic *dataProductBasic = dto.transformToProductDTO;
                
                ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:dataProductBasic];
                productViewController.type = 2;
                productViewController.productType = FromPanicProduct;
                productViewController.panicDTO = dto;
                productViewController.panicChannel = chanId;    //设置抢购渠道
                [self.navigationController pushViewController:productViewController animated:YES];
                
            }
            break;
        }
        case 2:  //单品团b2c
        {
            DJGroupListItemDTO *itemDto = [[DJGroupListItemDTO alloc] init];
            itemDto.grpPurId = purchaseId;
            itemDto.catentryId = productId;
            itemDto.channelID = [NSString stringWithFormat:@"%d",chanId];
            
            DataProductBasic *productDTO = [[DataProductBasic alloc] init];
            productDTO.productId = productId;
//            productDTO.productCode = itemDto.partnumber;
#warning 默认苏宁自营,后期优化
            productDTO.shopCode = @"";
            
            ProductDetailViewController *productViewController = [[ProductDetailViewController alloc] initWithDataBasicDTO:productDTO];
            productViewController.productType = FromGroupProduct;
            productViewController.baseItemDto = itemDto;
            productViewController.actId = purchaseId;
            productViewController.channelId = [NSString stringWithFormat:@"%d",chanId];
            productViewController.hidesBottomBarWhenPushed = YES;
            productViewController.type = 3;
            [self.navigationController pushViewController:productViewController animated:YES];

            break;
        }
        default:
            break;
    }
    
    return YES;
}

- (BOOL)search:(NSURL *)url
{
    NSArray *components = [[url absoluteString] componentsSeparatedByString:@":"];
    [SearchListViewController goToSearchResultWithKeyword:(NSString *)[components safeObjectAtIndex:1]
                                                  fromNav:self.navigationController];
    
    return NO;
}

- (BOOL)eppCallBack:(NSURL *)url
{
    if (self.webType == SNWebViewTypeEppPay || self.webType == SNWebViewTypeEppPayPlane)
    {
        if ([[url absoluteString] rangeOfString:@"epp-m"].location == NSNotFound)
        {
            
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                            message:L(@"PFOrderPaySuccess")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"check the order")
                                                  otherButtonTitles:L(@"AlertGoShopping")];

            
            __weak SNWebViewController *weakSelf = self;
            
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
            
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

- (BOOL)eppCallBack_flight:(NSURL *)url
{
    if (self.webType == SNWebViewTypeEppPayPlane)
    {
        BBAlertView *alertView = [[BBAlertView alloc]
                                  initWithTitle:nil
                                  message:L(@"BTOrderPaySuccess")
                                  delegate:self
                                  cancelButtonTitle:nil
                                  otherButtonTitles:L(@"ok")];
        [alertView setConfirmBlock:^{
            self.appDelegate.tabBarViewController.selectedIndex = kMyEbuyTabIndex;
            [[NSNotificationCenter defaultCenter] postNotificationName:SHOULD_GO_TO_PLANE_ORDERCENTER
                                                                object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }];
        [alertView show];
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)subook_downloadOrRead:(NSURL *)url
{
    NSString *openUrlString = [NSString stringWithFormat:@"%@%@", kURLSchemeSNBook, url];
    NSURL *openUrl  = [NSURL URLWithString:openUrlString];
    
    if ([[UIApplication sharedApplication] canOpenURL:openUrl]) {
        // 如果已经安装苏宁电子书苏客户端，就使用客户端打开链接
        [[UIApplication sharedApplication] openURL:openUrl];
    } else {
        // 否则使用 去下载
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kSNBookItunesLink]];
    }
    
    return NO;
}

- (BOOL)yaoYiYao_copy:(NSURL *)url
{
    NSString *paras = [url query];
    NSArray *arr = [paras componentsSeparatedByString:@"&"];
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    for (NSString *str in arr) {
        NSArray *arr0 = [str componentsSeparatedByString:@"="];
        if (arr0.count >= 1) {
            [paraDic setObject:arr0[1] forKey:arr0[0]];
        }
    }
    
    if ([paras isEqualToString:@"yaoyiyaofuzhi"]
        || [paraDic[@"yaoyiyaofuzhi"] isEqualToString:@"1"]) {
        [self presentSheet:L(@"WC_CopySuccess") posY:self.view.bounds.size.height - 100.0f];
        
        NSString *pasteStr = nil;
        NSString *cot = paraDic[@"content"];
        NSArray *arr1 = [url.absoluteString componentsSeparatedByString:@"?"];
        if (nil != cot && cot.length > 0) {
            pasteStr = [NSString stringWithFormat:@"%@ %@",cot,(arr1.count > 0) ? arr1[0] : @""];
        }else {
            pasteStr = ((arr1.count > 0) ? arr1[0] : @"");
        }
        pasteStr = [pasteStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIPasteboard generalPasteboard] setString:pasteStr];
        
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)itunes:(NSURL *)url
{
    [[UIApplication sharedApplication] openURL:url];
    
    //跳转后回到首页 edited by gjf
    [self.navigationController popViewControllerAnimated:YES];

    return NO;
}

- (BOOL)itunes_ebuy:(NSURL *)url
{
    //提示当前已下载使用 gjf
    [self presentSheet:L(@"WC_DowloadedEbuySuccess")];

    //ebuy自己的下载链接，因为已经在使用，固不跳转
    return NO;
}

//一般的http(s)请求
- (BOOL)httpUrls:(NSURL *)url
{
    if (self.webType == SNWebViewTypeAppStore)
    {
        //苏宁应用商店中特有逻辑
        
        NSString *paramString = [url query];
        NSDictionary *paramDic = [paramString queryDictionaryUsingEncoding:NSUTF8StringEncoding];
        NSString *reload = EncodeStringFromDic(paramDic, @"reload");
        NSString *page_title = EncodeStringFromDic(paramDic, @"page_title");
        NSString *appstore = EncodeStringFromDic(paramDic, @"appstore");
        if (appstore.length)
        {
            [[UIApplication sharedApplication] openURL:url];
            return NO;
        }
        
        //进入一个新页面
        if ([reload isEqualToString:@"1"])
        {
            NSMutableDictionary *dic = [paramDic mutableCopy];
            [dic removeObjectForKey:@"reload"];
            
            NSString *urlString = [url absoluteString];
            NSRange queryRange = [urlString rangeOfString:@"?"];
            NSString *rUrl = [[urlString substringToIndex:queryRange.location] urlByAppendingDict:dic];
            
            SNWebViewController *h = [[SNWebViewController alloc] initWithType:self.webType attributes:@{@"url": rUrl}];
            h.pageTitle = page_title;
            [self.navigationController pushViewController:h animated:YES];
            return NO;
        }
        else
        {
            return YES;
        }
        
        
    }
    else
    {
        return YES;
    }
}

- (BOOL)urlScheme_ebuy:(NSURL *)url
{
    @weakify(self);
    [SNRouter handleOpenUrl:url
                 onChecking:^(SNRouterObject *obj) {
                     @strongify(self);
                     [self displayOverFlowActivityView];
                 } shouldRoute:^BOOL(SNRouterObject *obj) {
                     @strongify(self);
                     [self removeOverFlowActivityView];
                     if (obj.errorMsg) {
                         [self presentSheet:obj.errorMsg];
                         return NO;
                     }else{
                         obj.navController = self.navigationController;
                         return YES;
                     }
                 } didRoute:NULL];
    
    return NO;
}

- (BOOL)otherUrlSchemes:(NSURL *)url
{
    //其他url scheme,
    return YES;
}

- (BOOL)abouts:(NSURL *)url
{
    return YES;
}

- (BOOL)back:(NSURL *)url
{
    sourcePageTitle = nil;
    daoPageTitle = nil;
    erWeiMaPageTitle = nil;
    remotePageTitle = nil;
    [self.navigationController popViewControllerAnimated:YES];
    return NO;
}

- (BOOL)back2:(NSURL *)url
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    return NO;
}

- (BOOL)showNavBar:(NSURL *)url
{
    if (!self.hasNav) {
        self.hasNav = YES;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        UIBarButtonItem *tempItem = self.navigationItem.rightBarButtonItem;
        //右侧添加一个空的item使标题能够居中
        if (self.webType == SNWebViewTypeCShop) {
            self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"" withName:@"" target:nil action:nil];
        }
    }
    return NO;
}

- (BOOL)eppTrustLoginOk:(NSURL *)url
{
    [UserCenter defaultCenter].hasTrustLoginToEpp = YES;
    [self loadRequest];
    return NO;
}

- (void)passportTrustLoginToEpp
{
    NSString *eppTrustLoginUrl = [NSString stringWithFormat:@"%@?sysCode=%@&targetUrl=%@&mode=restrict",kPassportTrustLoginUrl, @"epp", [kEppTrustOkUrl URLEncoding]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:eppTrustLoginUrl]];
    [self.webView loadRequest:request];
}


- (void)newPassportTrustLoginToEpp
{
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
                        cookies];
    NSString *str = nil;
    for (NSHTTPCookie *cookie in cookies)
    {
        NSString *name = [cookie name];
        
        if ([name isEqualToString:@"TGC"])
        {
            str = [cookie value];
            break;
        }
    }
    
//    NSString *eppTrustLoginUrl = [NSString stringWithFormat:@"%@=%@&snuid=%@&ticket=%@&istgc=true",trustofepp,[kEppTrustOkUrl URLEncoding],[UserCenter defaultCenter].userInfoDTO.custNum, str];

    NSString *urlString = [NSString stringWithFormat:@"%@",kPayPassportForHttps];
    
    
    if (self.webType == SNWebViewTypeEfubao) {
        NSString *string =[NSString stringWithFormat:@"sysCode=suning&targetUrl=%@&snuid=%@&ticket=%@&istgc=true",[kMyEppTrustUrl URLEncoding],[UserCenter defaultCenter].userInfoDTO.custNum, str];
        NSString *eppTrustLoginUrl = [NSString stringWithFormat:@"%@?%@",urlString, string];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:eppTrustLoginUrl]];
        [self.webView loadRequest:request];
        
    }
    else{
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        
        [request setURL:[NSURL URLWithString:urlString]];
        
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *postBody = [NSMutableData data];

        [postBody appendData:[[NSString stringWithFormat:@"sysCode=suning&targetUrl=%@&snuid=%@&ticket=%@&istgc=true",[kEppTrustOkUrl URLEncoding],[UserCenter defaultCenter].userInfoDTO.custNum, str] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:postBody];
        [self.webView loadRequest:request];


    }
    
    
//    NSString *eppTrustLoginUrl = [NSString stringWithFormat:@"%@?sysCode=%@&targetUrl=%@&mode=restrict",kPassportTrustLoginUrl, @"epp", [kEppTrustOkUrl URLEncoding]];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:eppTrustLoginUrl]];
    
}

#pragma mark - 分享

- (SNShareKit *)shareKit
{
    if (!_shareKit) {
        _shareKit = [[SNShareKit alloc] initWithNavigationController:self.navigationController];
    }
    return _shareKit;
}

- (BOOL)wapActivityShare:(NSURL *)url
{
    NSString *paramString = [url query];
    NSDictionary *paramDic = [paramString queryDictionaryUsingEncoding:NSUTF8StringEncoding];
    NSString *title = [paramDic objectForKey:@"title"];
    NSString *content = [paramDic objectForKey:@"content"];
    NSString *targetUrl = [paramDic objectForKey:@"targeturl"];
    NSString *iconPath = [paramDic objectForKey:@"iconpath"];
    
    [self nativeShareWithTitle:title content:content targetUrl:targetUrl iconUrl:iconPath shareWays:@[SNShareToWeiXin, SNShareToWeiXinFriend]];
    
    return NO;
}

- (void)nativeShareWithTitle:(NSString *)title content:(NSString *)content targetUrl:(NSString *)targetUrl iconUrl:(NSString *)iconUrl shareWays:(NSArray *)shareWays
{
    self.shareKit.shareTitle = title;
    self.shareKit.shareContent = content;
    self.shareKit.shareUrl = targetUrl;
    
    NSURL *_webShareImageURL = [NSURL URLWithString:iconUrl];
    
    self.shareKit.shareImage = nil; //避免多次分享图片重复
    
    self.chooseShareWayView = [[ChooseShareWayView alloc] initWithShareTypes:shareWays];
    self.chooseShareWayView.delegate = self;
    
    if (_webShareImageURL)
    {
        @weakify(self);
        SNImageLoadImage(_webShareImageURL, ^(UIImage *image) {
            
            @strongify(self);
            self.shareKit.shareImage = image;
            [self.chooseShareWayView showChooseShareWayView];
            
        });
    }
    else
    {
        [self.chooseShareWayView showChooseShareWayView];
    }
}

- (void)chooseShareWay:(SNShareType)shareWay
{
    [self.shareKit didChooseShareWay:shareWay];
}

- (void)checkCanGoBack
{
    if (self.webType == SNWebViewTypeCShop && !self.hasNav)
    {
        NSString *jsscript =
        @"var hrefs = document.getElementsByTagName('a');"
         "var findback = false;"
         "for (var i = 0; i < hrefs.length; i++) {"
         "    var ele = hrefs[i];"
         "    var url = ele.getAttribute('href');"
         "    if ( url.indexOf(\"history.go(-1)\") >= 0 || url.indexOf(\"history.back\") >= 0 ) {"
         "        ele.setAttribute('href', \"javascript:void(window.location='ebuyweb://SNIOSWebViewBack');\");"
         "        findback = true;"
         "        break;"
         "    }"
         "}"
         "if ( !findback ) {"
         "    var arrowleft = document.getElementsByClassName('arrow-left');"
         "    if ( arrowleft.length > 0) {"
         "        findback = true;"
         "    }"
         "}"
         "if ( !findback ) {"
         "    var scripts = document.getElementsByTagName('script');"
         "    for (var i = 0; i < scripts.length; i++) {"
         "        var content = scripts[i].textContent;"
         "        if ( content.indexOf('redirect:back') >= 0 || content.indexOf('backtoclient') >= 0) {"
         "            findback = true;"
         "            break;"
         "        }"
         "    }"
         "}"
         "if ( !findback ) {"
         "    window.location='ebuyweb://SNIOSWebViewShowNavBar';"
         "}";
        [self.webView stringByEvaluatingJavaScriptFromString:jsscript];
    }
}

- (UINavigationController *)navigationController
{
    if (super.navigationController) {
        return super.navigationController;
    } else if (self.parentViewController) {
        return self.parentViewController.navigationController;
    } else {
        return nil;
    }
}

@end
