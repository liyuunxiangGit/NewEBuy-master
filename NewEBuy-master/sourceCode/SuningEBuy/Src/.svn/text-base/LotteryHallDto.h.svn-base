//
//  LotteryHallDto.h
//  SuningEBuy
//
//  Created by david david on 12-6-27.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpDTO.h"

@interface LotteryHallDto : BaseHttpDTO

@property(nonatomic,copy) NSString *date;//服务器当前时间
@property(nonatomic,copy) NSString *gid;//游戏编号
@property(nonatomic,copy) NSString *pid; //开奖期数
@property(nonatomic,copy) NSString *gname;//游戏名称
@property(nonatomic,copy) NSString *code;//开奖号码
@property(nonatomic,copy) NSString *awardtime;//开奖时间
@property(nonatomic,copy) NSString *ginfo;//单注奖金信息
@property(nonatomic,copy) NSString *ninfo;//中奖注数信息
@property(nonatomic,copy) NSString *etime;
@property(nonatomic,copy) NSString *sales;//本期销量
@property(nonatomic,copy) NSString *pools;//奖池滚存
@property(nonatomic,copy) NSString *nowpid;//当前期数
@property(nonatomic,copy) NSString *nowendtime;//当前截至时间
@property(nonatomic,copy) NSString *nowfendtime;//当前复式截至时间
@property(nonatomic,copy) NSString *isale;//是否销售


- (void)encodeWithCoder:(NSCoder *)coder;

- (id)initWithCoder:(NSCoder *)coder;

- (void)encodeFromDictionary:(NSDictionary *)dic andExDic:(NSDictionary *)dicEx;

@end
