//
//  SweepstakesRuleInfoViewController.h
//  SuningEBuy
//
//  Created by robin on 1/28/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "CommonViewController.h"



@interface SweepstakesRuleInfoViewController : CommonViewController<UIWebViewDelegate, EGOImageViewDelegate>
{

}

@property (nonatomic, strong) UIWebView *ruleWebView;

@property (nonatomic, copy) NSString *ruleInfoString;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIImageView  *topBarBackgroundImage;

@property (nonatomic, strong) EGOImageView  *sweepViewImage;

@end
