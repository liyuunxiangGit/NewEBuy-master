//
//  UserDiscountInfoDTO.h
//  SuningEBuy
//
//  Created by shasha on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDiscountInfoDTO : NSObject

//云钻值(achive)
@property (nonatomic,copy)   NSString *achievement;
//易购券金额 = 礼品券+电子券(snTeck)
@property (nonatomic,copy)   NSString *coupon;
//易付宝余额advance
@property (nonatomic,copy)   NSString *advance;
//礼品卡余额(advCard)
@property (nonatomic,copy)   NSString *advCard;

//未读短消息(unReadMessage)
@property (nonatomic,copy)   NSString *unReadMessage;

//是否显示云钻查询失败信息标识，为1时显示(achiveFlg)

@property (nonatomic,copy)   NSString *achiveFlg;

//是否显示电子券查询失败信息标识，为1时显示(electFlg)
@property (nonatomic,copy)   NSString *electFlg;

//是否显示易付宝查询失败信息标识，为1时显示(advanceFlg)
@property (nonatomic,copy)   NSString *advanceFlg;

//是否显示礼品卡查询失败信息标识，为1时显示(advCardFlg)
@property (nonatomic,copy)   NSString *advCardFlg;


- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
