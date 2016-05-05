//
//  ConfirmBetInfoModel.h
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

@interface ConfirmBetInfoModel : BaseHttpDTO

@property (nonatomic,copy) NSString *payAmountMoney ;        //应付金额
@property (nonatomic,copy) NSString *amountMoney    ;        //总额
@property (nonatomic,copy) NSString *coupon         ;        //劵额

@property (nonatomic,copy) NSString *userName       ;        //真实姓名
@property (nonatomic,copy) NSString *IDNumber       ;        //身份证号
@property (nonatomic,copy) NSString *phoneNum       ;        //大奖通知电话

- (void)setAttributes:(NSDictionary *)dataDic;
@end
