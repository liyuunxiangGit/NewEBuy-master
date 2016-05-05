//
//  LotteryOrderListCell.h
//  SuningEBuy
//
//  Created by david david on 12-7-3.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryOrderDto.h"

@interface LotteryOrderListCell : UITableViewCell

@property(nonatomic,strong) UIImageView         *lotteryImageView;      //彩种logo

@property(nonatomic,strong) UILabel             *lotteryNameLbl;        //彩种名称

@property(nonatomic,strong) UILabel             *lotteryTimesLbl;       //彩种期次

@property(nonatomic,strong) UILabel             *buyDateLbl;            //购买时间

@property(nonatomic,strong) UILabel             *moneyLbl;              //金额

@property(nonatomic,strong) UILabel             *statusLbl;             //状态

@property(nonatomic,strong) LotteryOrderDto     *orderDto;

@property(nonatomic,strong) UIImageView         *cellSeparatedImageView;//分割线


-(void)setItem:(LotteryOrderDto *)dto;

-(BOOL)isNullOrEmpty:(NSString *)string;

@end
