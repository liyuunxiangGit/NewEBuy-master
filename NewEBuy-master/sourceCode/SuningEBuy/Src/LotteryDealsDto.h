//
//  LotteryDealsDto.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-17.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryDealsDto : NSObject
@property(nonatomic,copy) NSString      *gid;           //游戏编号
@property(nonatomic,copy) NSString      *pid;           //购买期次

@property(nonatomic,copy) NSString      *projid;        //方案编号（即订单号）
@property(nonatomic,copy) NSString      *bnum;          //认购份数
@property(nonatomic,copy) NSString      *money;         //认购金额
@property(nonatomic,copy) NSString      *buyDate;       //购买日期
@property(nonatomic,copy) NSString      *cancel;        //是否撤销（0未撤销 1本人撤销 2系统撤销）
@property(nonatomic,copy) NSString      *award;         //计奖标志（0未计奖 2已计奖）
@property(nonatomic,copy) NSString      *isReturn;      //是否派奖（0未派奖 1派奖中 2已派奖）
@property(nonatomic,copy) NSString      *amoney;        //派奖金额
@property(nonatomic,copy) NSString      *rmoney;        //认购派奖金额
@property(nonatomic,copy) NSString      *retdate;       //派奖时间
@property(nonatomic,copy) NSString      *pay;           //是否支付成功（－1支付失败 0未支付成功 1支付成功 2退款中 3已退款）
@property(nonatomic,copy) NSString      *icast;         //是否出票 0 未出票 1可以出票 2已拆票 3已出票
@property(nonatomic,copy) NSString      *istate;        //状态 -1未支付 0禁止认购 1认购中 2已满员 3过期未满撤销 4主动撤销 5出票失败撤销

@property(nonatomic,copy) NSString      *cendtime;         //方案结束时间
@property(nonatomic,copy) NSString      *localState;   //0出票中 1出票失败 2 等待开奖 3 未中奖 4 已中奖
@property(nonatomic,copy) NSString      *buyid;         //认购编码
@property(nonatomic,copy)NSString       *coupon;        //是否使用用券
@property(nonatomic)BOOL           isExpired;        //是否过期

-(void)encodeFromDictionary:(NSDictionary *)dic;

@end
