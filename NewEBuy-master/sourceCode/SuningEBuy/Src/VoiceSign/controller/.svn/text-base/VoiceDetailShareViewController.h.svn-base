//
//  VoiceDetailShareViewController.h
//  SuningEBuy
//
//  Created by xmy on 18/4/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "SNShareKit.h"
#import "ChooseShareWayView.h"

@interface VoiceDetailShareViewController : CommonViewController<ChooseShareWayViewDelegate>

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic, strong) SNShareKit              *shareKit;
@property (nonatomic, strong) ChooseShareWayView    *chooseShareWayView; //分享方式
@property (nonatomic, strong)NSString *shareContent;

- (id)init:(NSString *)urlString WithShareContentStr:(NSString *)content;

@end
