//
//  OWBAuthorizeWebViewController.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
// 刘坤修改于 2012-12-19  添加iPhone5页面兼容

#import <UIKit/UIKit.h>
#import "OWBAuthorizeWebView.h"
#import "WBRequest.h"
#import "CommonViewController.h"

#define kWBAuthorizeURL     @"https://api.weibo.com/oauth2/authorize"
#define kWBAccessTokenURL   @"https://api.weibo.com/oauth2/access_token"
#define kWBShowURL          @"https://api.weibo.com/2/users/show.json"

@protocol OWBAuthorizeWebViewControllerDelegate;



@interface OWBAuthorizeWebViewController : CommonViewController<OWBAuthorizeWebViewDelegate>{

    id<OWBAuthorizeWebViewControllerDelegate> __weak delegate;
}

@property(nonatomic,strong) OWBAuthorizeWebView *authorizeView;
@property(nonatomic,copy) NSString           *appKey;
@property(nonatomic,copy) NSString           *redirectURI;
@property(nonatomic,weak) id<OWBAuthorizeWebViewControllerDelegate> delegate;

-(void)pressReturn:(id)sender;

@end


@protocol OWBAuthorizeWebViewControllerDelegate <NSObject>

- (void)authorizeWebView:(OWBAuthorizeWebView *)webView didReceiveAuthorizeCode:(NSString *)code;

@end
