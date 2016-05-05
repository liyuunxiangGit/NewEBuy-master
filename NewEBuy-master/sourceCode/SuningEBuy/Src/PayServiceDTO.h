//
//  PayServiceDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-21.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

@interface PayServiceDTO : BaseHttpDTO
{
    NSString     *_typeCode;
    
    //region Info
    NSString     *_areaCode;
    NSString     *_areaName;
    
    //company Info
    NSString     *_companyCode;
    NSString     *_companyId;
    NSString     *_companyName;
    
    NSString     *_modeCode;
    
    NSString     *_chargeAccount;
    
    //account Info
    NSString     *_model;
    NSString     *_customerName;
    NSString     *_balance;
    NSString     *_payAmount;
    NSString     *_contractNo;
    NSString     *_beginDate;
    NSString     *_endDate;
    NSString     *_accountTerm;
    
    NSString     *_accountNo;
    NSString     *_efubaoBalance;
    
    NSString     *_payInfo;
}
@property (nonatomic, copy) NSString *typeCode;

@property (nonatomic, copy) NSString *areaCode;
@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, copy) NSString *companyCode;
@property (nonatomic, copy) NSString *companyId;
@property (nonatomic, copy) NSString *companyName;

@property (nonatomic, copy) NSString *modeCode;
@property (nonatomic, copy) NSString *chargeAccount;

@property (nonatomic, copy) NSString *model;
@property (nonatomic, copy) NSString *customerName;
@property (nonatomic, copy) NSString *balance;
@property (nonatomic, copy) NSString *payAmount;
@property (nonatomic, copy) NSString *contractNo;
@property (nonatomic, copy) NSString *beginDate;
@property (nonatomic, copy) NSString *endDate;
@property (nonatomic, copy) NSString *accountTerm;

@property (nonatomic, copy) NSString *accountNo;
@property (nonatomic, copy) NSString *efubaoBalance;

@property (nonatomic, copy) NSString *payInfo;

@property (nonatomic, copy) NSString *isChargeTime;//是否在缴费时间段内
@property (nonatomic, copy) NSString *chargeTimeMessage;//非缴费时间段提示信息

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
