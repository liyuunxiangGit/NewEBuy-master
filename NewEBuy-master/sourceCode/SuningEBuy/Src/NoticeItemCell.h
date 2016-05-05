//
//  NoticeItemCell.h
//  SuningEBuy
//
//  Created by david david on 12-6-28.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryHallDto.h"
#import "OHAttributedLabel.h"

@interface NoticeItemCell : SNUITableViewCell

@property(nonatomic,strong) UIImageView *backgroundImageView;   //背景图片
@property(nonatomic,strong) UIImageView *lotteryImageView;      //彩种logo
@property(nonatomic,strong) UIImageView *shadowImageView;      //彩种logo下的阴影
@property(nonatomic,strong) UILabel *lotteryNameLbl;            //彩种名称
@property(nonatomic,strong) OHAttributedLabel *desLbl;                    //第**期开奖号码
@property(nonatomic,strong) UILabel *redLbl;                    //红球
@property(nonatomic,strong) UILabel *blueLbl;                   //篮球

@property(nonatomic,strong) LotteryHallDto *hallDto;

@property(nonatomic,strong) UIImageView *goHistoryCodeImageView;

-(void)setItem:(LotteryHallDto *)dto;

-(BOOL)isNullOrEmpty:(NSString *)string;

-(CGFloat)width:(NSString *)string;

@end
