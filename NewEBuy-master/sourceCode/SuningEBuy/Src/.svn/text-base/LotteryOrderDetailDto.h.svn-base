//
//  LotteryOrderDetailDto.h
//  SuningEBuy
//
//  Created by huangtf on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LotteryOrderDetailDto : NSObject


@property(nonatomic,copy) NSString   *projid;           //订单编号
@property(nonatomic,copy) NSString   *gameName;         //商品名称
@property(nonatomic,copy) NSString   *gameId;           //彩种id
@property(nonatomic,copy) NSString   *pid;              //期次
@property(nonatomic,copy) NSString   *saleType;         //代购

@property(nonatomic,copy) NSString   *buyDate;          //投注时间
@property(nonatomic,copy) NSString   *buyMoney;         //投注金额
@property(nonatomic,copy) NSString   *winLottery;       //中奖金额
@property(nonatomic,copy) NSString   *cancel;           //是否撤销（0未撤销 1本人撤销 2系统撤销）
@property(nonatomic,copy) NSString   *ireturn;          //是否派奖（0未派奖 1派奖中 2已派奖）
@property(nonatomic,copy) NSString   *rmoney;           //认购派奖金额
@property(nonatomic,copy) NSString   *pay;              //是否支付成功（－1支付失败 0未支付成功 1支付成功 2退款中 3已退款）
@property(nonatomic,copy) NSString   *mulity;           //投注倍数
@property(nonatomic,copy) NSString   *ccodes;           //投注倍数
@property(nonatomic,copy) NSString   *awardcode;        //开奖号码






-(void)encodeFromDictionary:(NSDictionary *)dic1 andAnotherDic:(NSDictionary *)dic2;

@end
