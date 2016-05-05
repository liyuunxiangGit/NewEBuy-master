//
//  NProDetailIntroduceView.h
//  SuningEBuy
//
//  Created by xmy on 20/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

@interface NProDetailIntroduceView : CommonViewController<UIWebViewDelegate>

@property (nonatomic, strong) UIWebView            *introduceWebView;

@property (nonatomic, strong)DataProductBasic *webDto;

- (void)setNProDetailIntroduceView:(DataProductBasic*)dto;

@end
