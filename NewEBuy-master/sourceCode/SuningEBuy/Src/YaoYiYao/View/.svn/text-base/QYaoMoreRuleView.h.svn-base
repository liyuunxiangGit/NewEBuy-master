//
//  QYaoMoreRuleView.h
//  SuningEBuy
//
//  Created by XZoscar on 14-4-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
//  摇易摇－活动规则 页面

#import <UIKit/UIKit.h>

@interface QYaoMoreRuleView : UIView <UIWebViewDelegate>

// ui
@property (nonatomic,strong) IBOutlet UIWebView *webView;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView *loadingView;
@property (nonatomic,strong) IBOutlet UIView    *contentView;

+ (QYaoMoreRuleView *)moreRuleView;

- (IBAction)actionClose;

- (void)setVisible:(BOOL)visiable animate:(BOOL)animated;

- (void)loadDataFromUrl:(NSString *)ruleUrl;

@end
