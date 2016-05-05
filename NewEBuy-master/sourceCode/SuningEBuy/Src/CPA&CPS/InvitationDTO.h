//
//  InvitationDTO.h
//  SuningEBuy
//
//  Created by leo on 14-3-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitationDTO : NSObject

@property (nonatomic,copy) NSString *actTitle;                          //活动标题

@property (nonatomic,copy) NSString *actContent;                        //活动内容

@property (nonatomic,copy) NSString *actRuleURL;                        //活动说明url

@property (nonatomic,copy) NSString *smsContent;                        //分享内容

@property (nonatomic,copy) NSString *cipher;                            //暗号

@property (nonatomic,copy) NSString *qrCodeUrl;                         //二维码url

@property (nonatomic,copy) NSString *rewardRule;                        //规则

@property (nonatomic,copy) NSString *errorMsg;                          //错误信息

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end

@interface QueryRewardDTO : NSObject

@property (nonatomic,copy) NSString *totalReward;                       //总计获得

@property (nonatomic,copy) NSString *cpaReward;                         //三个月cpa获得

@property (nonatomic,copy) NSString *cpsReward;                         //三个月cps获得

@property (nonatomic,strong) NSString *bfrLastCpaReward;                //上上月cpa奖励总计

@property (nonatomic,strong) NSString *bfrLastCpsReward;                //上上月cps奖励总计

@property (nonatomic,strong) NSString *lastCpaReward;                //上月cps奖励总计

@property (nonatomic,strong) NSString *lastCpsReward;                //上月cps奖励总计

@property (nonatomic,strong) NSString *currCpaReward;                //当月cps奖励总计

@property (nonatomic,strong) NSString *currCpsReward;                //当月cps奖励总计

@property (nonatomic,copy) NSString *shareTitle;                          //活动标题

@property (nonatomic,copy) NSString *shareContent;                        //活动内容

@property (nonatomic,copy) NSString *errorMsg;                          //错误信息

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end


@interface GetRedPackEntryDTO : NSObject

@property (nonatomic,copy) NSString *canGetRedPack;                     //是否可获得红包，1可以，0否

@property (nonatomic,copy) NSString *ticketRuleUrl;                       //ticketRuleUrl:券使用规则地址

@property (nonatomic,copy) NSString *redPackRule;                       //红包规则

@property (nonatomic,copy) NSString *errorMsg;                          //错误信息

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end