//
//  LotteryOrderDto.h
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryOrderDto : NSObject

@property(nonatomic,copy) NSString      *gid;           //游戏编号
@property(nonatomic,copy) NSString      *buyDate;       //购买日期
@property(nonatomic,copy) NSString      *pid;           //购买期次
@property(nonatomic,copy) NSString      *bnum;          //认购份数  
@property(nonatomic,copy) NSString      *money;         //认购金额
@property(nonatomic,copy) NSString      *cancel;        //是否撤销（0未撤销 1本人撤销 2系统撤销）
@property(nonatomic,copy) NSString      *award;         //计奖标志（0未计奖 2已计奖）
@property(nonatomic,copy) NSString      *isReturn;      //是否派奖（0未派奖 1派奖中 2已派奖）
@property(nonatomic,copy) NSString      *amoney;        //派奖金额
@property(nonatomic,copy) NSString      *rmoney;        //认购派奖金额
@property(nonatomic,copy) NSString      *retdate;       //派奖时间
@property(nonatomic,copy) NSString      *pay;           //是否支付成功（－1支付失败 0未支付成功 1支付成功 2退款中 3已退款）
@property(nonatomic,copy) NSString      *projid;        //方案编号（即订单号）


-(void)encodeFromDictionary:(NSDictionary *)dic;
@end
