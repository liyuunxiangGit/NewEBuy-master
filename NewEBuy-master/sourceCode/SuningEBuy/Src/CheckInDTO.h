//
//  CheckInDTO.h
//  SuningEBuy
//
//  Created by  liukun on 13-9-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import "CIDate.h"

typedef NS_ENUM(NSInteger, CICheckState) {
    
    CICheckStateUnCheck = 0,        //未签到
    CICheckStateTodayUncheck,       //今天未签到
    CICheckStateNormalCheck,        //常规已签到
    CICheckStateActivityCheck,      //活动已签到
    CICheckStateOnCheck,            //等待签到
    CICheckStateOnBlank             //空白
};

@interface CheckInDTO : BaseHttpDTO

@property (nonatomic, copy) NSString *errCode;             // xzoscar 2014-06-04 add

@property (nonatomic, copy) NSString  *checkType;          //签到类型  00001常规签到， 其他为活动签到
@property (nonatomic, copy) NSString  *checkTitle;         //活动签到的title
@property (nonatomic, copy) NSString  *isCheck;            //是否能签到   0即可以签到
@property (nonatomic, copy) NSString  *checkRuleDesc;      //签到规则说明
@property (nonatomic, copy) NSString  *checkCount;         //连续签到天数
@property (nonatomic, copy) NSString  *largessType;        //赠送优惠券云钻type  0 云钻 1 优惠券 2 云钻+优惠券
@property (nonatomic, copy) NSString  *dayNum;             //活动天数
@property (nonatomic, copy) NSString  *residueDay;         //剩余活动天数

@property (nonatomic, strong) NSArray  *checkInfoList;      //历史签到记录（List）
@property (nonatomic, strong) NSArray  *prePointsList;      //赠送云钻活动规则（List后台签到标准 上个月的规则
@property (nonatomic, strong) NSArray  *curPointsList;      //赠送云钻活动规则（List后台签到标准 上个月的规则
@property (nonatomic, strong) NSArray  *nextPointsList;     //赠送云钻活动规则（List后台签到标准 上个月的规则
@property (nonatomic, strong) NSArray  *preCouponList;      //赠送优惠券的活动规则 上个月优惠券的值（维护值）
@property (nonatomic, strong) NSArray  *curCouponList;      //赠送优惠券的活动规则 上个月优惠券的值（维护值）
@property (nonatomic, strong) NSArray  *nextCouponList;     //赠送优惠券的活动规则 上个月优惠券的值（维护值）

@property (nonatomic, copy) NSString *currentDateStr;        //当前时间     yyyyMMdd
@property (nonatomic, strong) CIDate *currentDate;
@property (nonatomic, copy) NSString *activeStartDateStr;    //当前活动开始时间  yyyyMMdd
@property (nonatomic, strong) CIDate *activeStartDate;

@property (nonatomic, strong) NSArray *currMonthCheckList;
@property (nonatomic, strong) NSArray *preMonthCheckList;

- (void)encodeFromDictionary:(NSDictionary *)dic;


- (NSString *)pointInDate:(CIDate *)date;
- (NSString *)couponInDate:(CIDate *)date;
- (CICheckState)checkStateInDate:(CIDate *)date;

- (BOOL)setStateCheckedToToday; //把今天设置为已签到

@end
