//
//  DJGroupDetailIntroduceView.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

@protocol IntroduceViewDelegate;

@interface DJGroupDetailIntroduceView : UIView <UIWebViewDelegate>
{
    UIWebView   *_introduceWebView;
    DataProductBasic *_dataProductBasic;
    BOOL _isNeedData;
    NSURL *_requestURL;
    NSString *_productName;
}

@property  (nonatomic,strong) UIWebView *introduceWebView;
@property (nonatomic,strong) DataProductBasic *dataProductBasic;
@property (nonatomic) BOOL isNeedData;
@property (nonatomic,strong) NSURL *requestURL;
@property (nonatomic,strong) NSString *productName;

@property (nonatomic,weak) id<IntroduceViewDelegate> delegate;

- (void)initWebView;
- (void)loadData;

@end

@protocol IntroduceViewDelegate <NSObject>

- (void)webViewDidStartLoad:(UIWebView *)webView;
- (void)webViewDidFinishLoad:(UIWebView *)webView;
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;

@end
