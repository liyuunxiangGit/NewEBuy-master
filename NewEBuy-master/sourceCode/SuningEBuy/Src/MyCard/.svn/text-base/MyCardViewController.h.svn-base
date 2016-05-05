//
//  MyCardViewController.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MemeberMergeService.h"

@interface MyCardViewController : CommonViewController<EGOImageViewDelegate,EGOImageViewExDelegate,MemeberMergeServiceDelegate>
//卡片背景
@property (nonatomic, strong) UIImageView           *cardBack;
//电子会员卡号
@property (nonatomic, strong) UILabel               *cardLabel;
//条码
@property (nonatomic, strong) EGOImageViewEx        *zbarView;
//手机号码
@property (nonatomic, strong) UILabel               *mobileLabel;
//云钻
@property (nonatomic, strong) UILabel               *integralLabel;
//门店会员卡
@property (nonatomic, strong) UILabel               *shopCardLabel;

//绑定btn
@property (nonatomic, strong) UIButton              *activeBtn;

//提示
@property (nonatomic, strong) UIImageView           *tipView;
@property (nonatomic, strong) UILabel               *tipLabel;

@property (nonatomic, strong) MemeberMergeService   *memberMergeService;

@end
