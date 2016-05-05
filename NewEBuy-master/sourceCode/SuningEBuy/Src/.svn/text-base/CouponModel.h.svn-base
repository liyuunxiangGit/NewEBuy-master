//
//  CouponModel.h
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface CouponModel : BaseHttpDTO

@property (nonatomic,copy) NSString *couponName;              //用券名称

@property (nonatomic,assign) BOOL      remarked;              //是否选中标记

@property (nonatomic,copy) NSString *couponNo;                //劵号
@property (nonatomic,copy) NSString *expiryDate;              //有效期
@property (nonatomic,copy) NSString *remainMoney;             //可用金额
@property (nonatomic,copy) NSString *isExclusion;             //是否互斥标记
@property (nonatomic,copy) NSString *isControl;               //是否控制使用标识
@property (nonatomic,copy) NSString *totalMoney;              //面值

- (void)setAttributes:(NSDictionary *)dataDic;

@end
