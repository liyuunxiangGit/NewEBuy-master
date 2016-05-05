//
//  ChooseShareWayView.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-11-30.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>


extern NSString *const SNShareToSinaWeibo;
extern NSString *const SNShareToSMS;
extern NSString *const SNShareToTCWeiBo;
extern NSString *const SNShareToWeiXin;
extern NSString *const SNShareToWeiXinFriend;
extern NSString *const SNShareToSNWeibo;
extern NSString *const SNShareToSNCloud;
extern NSString *const SNShareToSinaWeiboForGift;       //分享有礼

@protocol ChooseShareWayViewDelegate <NSObject>

- (void)chooseShareWay:(SNShareType)shareWay;

@end

@interface ChooseShareWayView : UIControl

@property (nonatomic, assign) id<ChooseShareWayViewDelegate> delegate;

@property (nonatomic, strong) UIButton      *closeBtn;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIImageView   *sperateLineImageView;
/** contentView */
@property (nonatomic, strong, readonly) UIView *contentView;
/*
 // property : bRemoved
 // Description : ***
 // Date : 2014-04-03 11:00:00
 // Author : XZoscar
 */
@property (nonatomic,assign,readonly,getter = isRemoved) BOOL bRemoved;

/**
 @abstract  初始化方法
 @param  types 是类型组成的数组，如： @[SNShareToSinaWeibo, SNShareToSMS]
 */
- (instancetype)initWithShareTypes:(NSArray *)types;
- (instancetype)init;

- (void)showChooseShareWayView;

- (void)hideChooseShareWayView;

@end
