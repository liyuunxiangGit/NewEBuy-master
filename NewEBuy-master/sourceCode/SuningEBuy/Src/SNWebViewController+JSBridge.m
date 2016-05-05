//
//  SNWebViewController+JSBridge.m
//  SuningEBuy
//
//  Created by liukun on 14-8-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNWebViewController+JSBridge.h"
#import "WebViewJavascriptBridge.h"
#import "ChooseShareWayView.h"
#import "ProductDetailViewController.h"
#import "KCOpenUDID.h"
#import "SearchListViewController.h"
#import "ShopCartV2ViewController.h"
#import "BoundPhoneViewController.h"
#import "ActiveEfubaoViewController.h"
#import "NewInviteFriendViewController.h"
#import "EfubaoUnBoundEmailViewController.h"
const char SNWebRightButtonKey;

@implementation SNWebViewController (JSBridge)

- (void)jsBridgeEngineStart
{
    self.jsBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView webViewDelegate:self handler:NULL];
    
    //注册handlers
    
    //复制文本
    [self.jsBridge registerHandler:@"copyToClipboard" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *text = EncodeStringFromDic(data, @"text");
        if (text.length) {
            [[UIPasteboard generalPasteboard] setString:text];
            if (responseCallback) responseCallback(@{@"isSuccess": @YES});
        } else {
            if (responseCallback) responseCallback(@{@"isSuccess": @NO, @"error": @"empty str to copy"});
        }
    }];
    
    @weakify(self);
    [self.jsBridge registerHandler:@"callNativeShare" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSString *title = EncodeStringFromDic(data, @"title");
        NSString *content = EncodeStringFromDic(data, @"content");
        NSString *targetUrl = EncodeStringFromDic(data, @"targetUrl");
        NSString *iconUrl = EncodeStringFromDic(data, @"iconUrl");
        NSString *shareWaysStr = EncodeStringFromDic(data, @"shareWays");
        
        //解析shareWay
        NSArray *shareWayIndexArr = [shareWaysStr componentsSeparatedByString:@","];
        NSArray *shareWayArray = @[SNShareToSinaWeibo,SNShareToSMS,SNShareToTCWeiBo,SNShareToWeiXin,SNShareToWeiXinFriend];
        NSMutableArray *shareWays = [NSMutableArray array];
        for (NSString *num in shareWayIndexArr) {
            NSInteger index = num.intValue - 1;
            NSString *way = [shareWayArray safeObjectAtIndex:index];
            if (way) {
                [shareWays addObject:way];
            }
        }
        
        if ([shareWays count])
        {
            [self nativeShareWithTitle:title content:content targetUrl:targetUrl iconUrl:iconUrl shareWays:shareWays];
            if (responseCallback) responseCallback(@{@"isSuccess": @YES});
        }
        else
        {
            if (responseCallback) responseCallback(@{@"isSuccess": @NO, @"error": @"ShareWay error"});
        }

    }];
    
    //去商品详情
    [self.jsBridge registerHandler:@"goToProductDetail" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSString *productCode = EncodeStringFromDic(data, @"productCode");
        NSString *shopCode = EncodeStringFromDic(data, @"shopCode");
        NSString *promotionType = EncodeStringFromDic(data, @"promotionType");
        NSString *rushPurId = EncodeStringFromDic(data, @"rushPurId");
        NSString *rushPurChannel = EncodeStringFromDic(data, @"rushPurChannel");

        NSString *grpPurId = EncodeStringFromDic(data, @"groupPurId");

        if (!shopCode.length) {
            shopCode = nil;
        }
        else if ([shopCode isEqualToString:@"0000000000"]) {
            shopCode = @"";
        }
        
        
        DataProductBasic *product = [[DataProductBasic alloc] init];
        product.productCode = productCode;
        product.shopCode = shopCode;

        ProductDetailViewController *vc = [[ProductDetailViewController alloc] initWithDataBasicDTO:product];
        if ([promotionType isEqualToString:@"1"]) {
            vc.productType = FromPanicProduct;
            vc.panicDTO = [[PanicPurchaseDTO alloc] init];
            vc.panicDTO.rushPurId = rushPurId;
            vc.panicChannel = [rushPurChannel isEqualToString:@"1"]?PanicChannelB2C:PanicChannelMobile;
        } else if ([promotionType isEqualToString:@"2"]) {
            vc.productType = FromGroupProduct;
            vc.actId = grpPurId;
        } else if ([promotionType isEqualToString:@"3"]) {
            vc.productType = FromBigSaleProduct;
        }
        vc.productType = [promotionType intValue];
        [self.navigationController pushViewController:vc animated:YES];
        
        if (responseCallback) responseCallback(@{@"isSuccess": @YES});
    }];
    
    //获取基本信息
    [self.jsBridge registerHandler:@"getClientInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSInteger shopCartQuantity = [[[ShopCartV2ViewController sharedShopCart] logic] allProductQuantity];
        NSString *cityCode = [Config currentConfig].defaultCity;
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        NSString *cityName = [dao getCityNameByCityCode:cityCode];
        if (responseCallback) responseCallback(@{@"version": [SystemInfo appVersion],
                                                 @"identifier": [KCOpenUDID value],
                                                 @"cityCode": cityCode?cityCode:@"9173",
                                                 @"cityName": cityName?cityName:@"",
                                                 @"shopCartQuantity": @(shopCartQuantity)});
    }];
    
    //切换城市
    [self.jsBridge registerHandler:@"changeCity" handler:^(id data, WVJBResponseCallback responseCallback) {
       
       [Config currentConfig].defaultCity = EncodeStringFromDic(data, @"cityId");
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        NSString *province= [dao setProvinceCode:[Config currentConfig].defaultCity];
        [Config currentConfig].defaultProvince = province?province:@"";
        [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION object:nil];
        if (responseCallback) responseCallback(@{@"isSuccess": @YES});

    }];
    
    //在线客服
    [self.jsBridge registerHandler:@"gotoCustom" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *shopCode = EncodeStringFromDic(data, @"shopCode");
        NSString *shopName = EncodeStringFromDic(data, @"shopName");
        if (shopCode && shopCode.length < 10) {
            int count = 10 - shopCode.length;
            NSString *prefixCode = @"";
            for (int i = 0; i<count; i++) {
                prefixCode = [NSString stringWithFormat:@"%@0",prefixCode];
            }
            shopCode = [NSString stringWithFormat:@"%@%@",prefixCode,shopCode];
        }
        [self checkLoginWithLoginedBlock:^{
            OSChatViewController *vc = [[OSChatViewController alloc] initAsCShop:shopCode ProductName:shopName ProductCode:nil OrderNo:nil];
            vc.vendorName = shopName;
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        } loginCancelBlock:nil];
        
    }];
 
    
    //去搜索结果
    [self.jsBridge registerHandler:@"goToSearchResultWithKeyword" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSString *keyword = EncodeStringFromDic(data, @"keyword");
        [SearchListViewController goToSearchResultWithKeyword:keyword fromNav:self.navigationController];
        if (responseCallback) responseCallback(@{@"isSuccess": @YES});
    }];
    
    //去下一级页面
    [self.jsBridge registerHandler:@"pushToNextPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSString *url = EncodeStringFromDic(data, @"url");
        SNWebViewController *vc = [[SNWebViewController alloc] initWithRequestUrl:url];
        [self.navigationController pushViewController:vc animated:YES];
        if (responseCallback) responseCallback(@{@"isSuccess": @YES});
    }];
    
    //提示弹出框
    [self.jsBridge registerHandler:@"showAlert" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *message = EncodeStringFromDic(data, @"message");
        NSArray *buttons = EncodeArrayFromDic(data, @"buttons");
        
        BBAlertView *alert = [[BBAlertView alloc]
                              initWithTitle:nil
                              message:message
                              delegate:nil
                              cancelButtonTitle:[buttons safeObjectAtIndex:0]
                              otherButtonTitles:[buttons safeObjectAtIndex:1]];
        [alert setConfirmBlock:^{
            if (responseCallback) responseCallback(@{@"clickIndex": @1});
        }];
        
        [alert setCancelBlock:^{
            if (responseCallback) responseCallback(@{@"clickIndex": @0});
        }];
        [alert show];
        
    }];
    
    //提示文本
    [self.jsBridge registerHandler:@"showTip" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSString *message = EncodeStringFromDic(data, @"message");
        if (message.length) {
            [self presentSheet:message];
        }
        if (responseCallback) responseCallback(@{@"isSuccess": message.length?@YES:@NO});
        
    }];
    
    //设置右上角的button
    [self.jsBridge registerHandler:@"showRightButtons" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSArray *buttons = EncodeArrayFromDic(data, @"buttons");
        NSString *navButtonId = EncodeStringFromDic(data, @"id");
        if (navButtonId) {
            objc_setAssociatedObject(self, &SNWebRightButtonKey, navButtonId, OBJC_ASSOCIATION_RETAIN);
        }
        
        NSMutableArray *itemArray = [NSMutableArray array];
        NSInteger i = 0;
        for (NSString *title in buttons) {
            
            //最多三个按钮
            if (i == 3) {
                break;
            }
            NSString *imageUrl = [title hasPrefix:@"http"] ? title : nil;
            
            if ([imageUrl length]) {
                EGOImageButton *btn = [EGOImageButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(0, 0, 44, 44);
                btn.imageURL = [NSURL URLWithString:imageUrl];
                [btn addTarget:self action:@selector(navBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = i;
                UIBarButtonItem *item = [[SNUIBarButtonItem alloc] initWithCustomView:btn];
                item.tag = i;
                [itemArray addObject:item];
            } else if (title.length) {
                UIBarButtonItem *item = [SNUIBarButtonItem itemWithTitle:title Style:SNNavItemStyleDone target:self action:@selector(navBtnTapped:)];
                item.tag = i;
                [itemArray addObject:item];
            }
            i++;
        }
        self.navigationItem.rightBarButtonItems = itemArray;
        
    }];
    
    //碎屏险跳转cpa gjf
    [self.jsBridge registerHandler:@"gotoCPA" handler:^(id data,WVJBResponseCallback responseCallbace){
        @strongify(self);
        NewInviteFriendViewController *invite = [[NewInviteFriendViewController alloc] init];
        [self.navigationController pushViewController:invite animated:YES];
    }];
    
    //易付宝未激活激活页面跳转 gjf
    [self.jsBridge registerHandler:@"gotoActive" handler:^(id data,WVJBResponseCallback responseCallbace){
        @strongify(self);
        
        switch ([UserCenter defaultCenter].efubaoStatus) {//defaultCenter.efubaoStatus
            case eLoginByPhoneUnBound:{
                BoundPhoneViewController *controller = [[BoundPhoneViewController alloc] init];
                controller.isEfubaoBound = YES;
                [self.navigationController pushViewController:controller animated:YES];
                break;
            }
            case eLoginByEmailPhoneUnBound:
            case eLoginByPhoneUnActive:
            case eLoginByEmailUnActive:
            {
                NSString *logonName = [UserCenter defaultCenter].userInfoDTO.logonId;
                
                NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
                
                NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
                
                if ([emailTest evaluateWithObject:logonName]) {
                    [self presentSheet:L(@"EmailAccountToNetworkActivate")];
                    
                    return;
                }
                ActiveEfubaoViewController *controller = [[ActiveEfubaoViewController alloc] init];
                
                [self.navigationController pushViewController:controller animated:YES];
                break;
            }
            case eLoginByEmailUnBound:
            {
                EfubaoUnBoundEmailViewController *efubaoController = [[EfubaoUnBoundEmailViewController alloc] init];
                
                [self.navigationController pushViewController:efubaoController animated:YES];
                break;
            }

                break;
            default:{
                
            }
                break;
        }
    }];
    
    //加商品到购物车
    [self.jsBridge registerHandler:@"addProductToShopCart" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *productId = EncodeStringFromDic(data, @"productId");
        NSString *shopCode = EncodeStringFromDic(data, @"shopCode");
        if ([shopCode isEqualToString:@"0000000000"]) {
            shopCode = @"";
        }
        NSNumber *quantity = EncodeNumberFromDic(data, @"quantity");
        NSString *cityCode = EncodeStringFromDic(data, @"cityCode");
        if (!cityCode.length) {
            cityCode = [Config currentConfig].defaultCity;
        }
        DataProductBasic *product = [[DataProductBasic alloc] init];
        product.productId = productId;
        product.shopCode = shopCode;
        product.quantity = [quantity intValue];
        product.cityCode = cityCode;
        
        [[ShopCartV2ViewController sharedShopCart] addProductToShoppingCart:product completionBlock:^(BOOL isSuccess, NSString *errorMsg) {
            
            NSDictionary *responseData = @{@"isSuccess": @(isSuccess),
                                           @"errorMsg": errorMsg?errorMsg:@""};
            responseCallback(responseData);
        }];
    }];
    
    //设置标题栏颜色
    [self.jsBridge registerHandler:@"setBarColor" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSString *colorString = EncodeStringFromDic(data, @"color");
        UIColor *color = [UIColor colorWithHexString:colorString];
        
        self.webTitleColor = color;
        [self setNavBarColor:self.webTitleColor];
    }];
    
    //页面路由的逻辑
    [self.jsBridge registerHandler:@"routeToClientPage" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        @strongify(self);
        NSString *adTypeCode = EncodeStringFromDic(data, @"adTypeCode");
        NSString *adId = EncodeStringFromDic(data, @"adId");
        [SNRouter handleAdTypeCode:adTypeCode adId:adId chanId:nil qiangId:nil
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
                            
                        } didRoute:^(SNRouterObject *obj) {
                            
                            
                        } source:SNRouteSourceSomeCode];
    }];
    
    //在safari中打开链接
    [self.jsBridge registerHandler:@"openLinkInSafari" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSString *url = EncodeStringFromDic(data, @"url");
        
        NSURL *requestUrl = [NSURL URLWithString:url];
        
        [[UIApplication sharedApplication] openURL:requestUrl];
        
    }];
    
    //跳首页
    [self.jsBridge registerHandler:@"gotoHomePage" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        TabBarController *tabBarVC = [AppDelegate currentAppDelegate].tabBarViewController;
        
        if ([tabBarVC presentedViewController])
        {
            [tabBarVC dismissViewControllerAnimated:NO completion:NULL];
        }
        
        [tabBarVC setSelectedIndex:0];
        
        UINavigationController *navController = [[tabBarVC viewControllers] safeObjectAtIndex:0];
        
        [navController popToRootViewControllerAnimated:NO];
        
    }];
}

- (void)setNavBarColor:(UIColor *)color
{
    if (IOS7_OR_LATER)
    {
        self.navigationController.navigationBar.barTintColor = color;
    }
    else
    {
        UIImage *image = [UIImage imageWithColor:color size:self.navigationController.navigationBar.size];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)jsBridge_viewWillAppear
{
    if (self.webTitleColor) {
        [self setNavBarColor:self.webTitleColor];
    }
}

- (void)jsBridge_ViewWillDisappear
{
    if (self.webTitleColor) {
        [self setNavBarColor:RGBACOLOR(247, 247, 248, 0.8)];
    }
}

- (void)navBtnTapped:(UIButton *)sender
{
    NSInteger index = [sender tag];
    NSString *navButtonId = objc_getAssociatedObject(self, &SNWebRightButtonKey);
    NSDictionary *responseDic = @{@"buttonIndex": @(index), @"id": navButtonId};
    [self.jsBridge callHandler:@"navRightButtonClicked" data:responseDic];
}

- (BOOL)jsBridgeBackForePage
{
    if ([self.jsBridge isBindToHander:@"backButtonClicked"]) {
        
        @weakify(self);
        NSDictionary *dataDic = @{@"canGoBack": @([self.webView canGoBack])};
        [self.jsBridge callHandler:@"backButtonClicked" data:dataDic responseCallback:^(id responseData) {
            
            @strongify(self);
            if ([self.webView canGoBack]) {
                NSDictionary *responseDic = responseData;
                if ([responseDic[@"backType"] intValue] == 1) {
                    [self.navigationController popViewControllerAnimated:YES];
                } else if ([responseDic[@"backType"] intValue] == 2) {
                    [self loadRequest];
                } else if ([responseDic[@"backType"] intValue] == 3) {
                    [self.webView goBack];
                }
            } else { //保证可以退出
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        return YES;
    }
    else
    {
        return NO;
    }
}


@end
