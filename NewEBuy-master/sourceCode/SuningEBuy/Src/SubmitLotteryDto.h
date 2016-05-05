//
//  SubmitLotteryDto.h
//  SuningEBuy
//
//  Created by david on 12-6-30.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubmitLotteryDto : NSObject

@property(nonatomic,strong) NSString        *gid;           //彩票id  代购追号公用
@property(nonatomic,strong) NSString        *productName;   //彩票名称 代购追号公用
@property(nonatomic,strong) NSString        *productTimes;  //彩票期数  追号无
@property(nonatomic,strong) NSString        *saleType;      //代购  or  追号 直接用汉字区别

@property(nonatomic,strong) NSString        *productMoney;  //购买彩票的总金额 代购追号公用
@property(nonatomic,strong) NSString        *buyCodes;      //购买彩票的号码 代购追号公用

@property(nonatomic,strong) NSString        *multiNo;       //投注倍数 代购追号公用
@property(nonatomic,strong) NSString        *endTime;       //截至时间 追号好像没用

@property(nonatomic,strong) NSString        *periods;       //追号期数  追号独用
@property(nonatomic,assign) BOOL            stopWhenWin;    //中奖追号是否停止

//用券新增参数--------------start---------------------------
//origin	投注来源标识
//commPayedMoney	券使用金额，券支付必填
//coupons	券号，多个券号用逗号隔开
//eppPayedMoney	易付宝支付金额，券支付必填
@property(nonatomic,strong)NSString *origin;
@property(nonatomic,strong)NSString *commPayedMoney;
@property(nonatomic,strong)NSString *coupons;
@property(nonatomic,strong)NSString *eppPayedMoney;
@property(nonatomic)BOOL            needCoupon;
//用券新增参数--------------end-----------------------------
@end