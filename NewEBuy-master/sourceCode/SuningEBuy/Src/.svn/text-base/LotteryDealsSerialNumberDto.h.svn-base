//
//  LotteryDealsSerialNumberDto.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-17.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryDealsSerialNumberDto : NSObject

@property(nonatomic,copy) NSString      *zhid;          //追号id
@property(nonatomic,copy) NSString      *gid;           //游戏编号
@property(nonatomic,copy) NSString      *pid;           //购买期次

@property(nonatomic,copy) NSString      *pnums;         //追号总期数
@property(nonatomic,copy) NSString      *zhflag;        //中奖是否停止 0不停止 1停止 2盈利停止
@property(nonatomic,copy) NSString      *finish;        //是否完成 0完成 1未完成

@property(nonatomic,copy) NSString      *success;       //追号成功期数
@property(nonatomic,copy) NSString      *failure;       //追号失败期数

@property(nonatomic,copy) NSString      *adddate;       //购买日期
@property(nonatomic,copy) NSString      *tmoney;         //总金额
@property(nonatomic,copy) NSString      *reason;         //追号停止原因 0未完成 1已投注完成 2中奖停止 用户手动停止
@property(nonatomic,copy) NSString      *bonus;         //总中奖金额
@property(nonatomic,copy) NSString      *casts;         //实际投注金额
@property(nonatomic,copy) NSString      *pay;           //是否支付成功 -1支付失败 0未支付成功 1支付成功 2退款中 3已退款

@property(nonatomic,copy) NSString      *localState;    //本地显示用状态

-(void)encodeFromDictionary:(NSDictionary *)dic;
@end
