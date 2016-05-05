//
//  UserFeedBackController.h
//  SuningEBuy
//
//  Created by li xiaokai on 14-1-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "UserFeedBackNewViewController.h"
#import "UserFeedBackPreViewController.h"
@interface UserFeedBackController : CommonViewController


@property(nonatomic,strong)UserFeedBackNewViewController *tuCaoVC;

@property(nonatomic,strong)UserFeedBackPreViewController *questionVC;


@property(nonatomic,strong)UIButton *tuCaoBtn;

@property(nonatomic,strong)UIButton *questionBtn;
@end
