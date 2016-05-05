//
//  RegistrationPrepareDTO.h
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegistrationPrepareDTO : NSObject

@property (nonatomic, strong) NSString *errCode;          // xzoscar add 2014-06-04

@property (nonatomic, copy) NSString  *checkType;          //签到类型  00001常规签到， 其他为活动签到
@property (nonatomic, copy) NSString  *checkTitle;         //活动签到的title
@property (nonatomic, copy) NSString  *isCheck;            //是否能签到   0即可以签到
@property (nonatomic, copy) NSString  *checkRuleDesc;      //签到规则说明
@property (nonatomic, copy) NSString  *checkCount;         //连续签到天数
@property (nonatomic, copy) NSString  *largessType;        //赠送优惠券云钻type  0 云钻 1 优惠券 2 云钻+优惠券
@property (nonatomic, copy) NSString  *dayNum;             //活动天数
@property (nonatomic, copy) NSString  *residueDay;         //剩余活动天数

@property (nonatomic, copy) NSArray  *checkInfoList;      //历史签到记录（List）
@property (nonatomic, copy) NSArray  *prePointsList;      //赠送云钻活动规则（List后台签到标准 上个月的规则
@property (nonatomic, copy) NSArray  *curPointsList;      //赠送云钻活动规则（List后台签到标准 上个月的规则
@property (nonatomic, copy) NSArray  *nextPointsList;     //赠送云钻活动规则（List后台签到标准 上个月的规则
@property (nonatomic, copy) NSArray  *preCouponList;      //赠送优惠券的活动规则 上个月优惠券的值（维护值）
@property (nonatomic, copy) NSArray  *curCouponList;      //赠送优惠券的活动规则 上个月优惠券的值（维护值）
@property (nonatomic, copy) NSArray  *nextCouponList;     //赠送优惠券的活动规则 上个月优惠券的值（维护值）

@property (nonatomic, copy) NSString *currentDate;        //当前时间     yyyyMMdd
@property (nonatomic, copy) NSString *activeStartDate;    //当前活动开始时间  yyyyMMdd

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
