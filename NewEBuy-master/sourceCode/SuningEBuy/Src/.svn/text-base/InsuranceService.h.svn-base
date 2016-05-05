//
//  InsuranceService.h
//  SuningEBuy
//
//  Created by  liukun on 12-11-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      InsuranceService.h
 @abstract    获取险种的接口
 @author      liukun
 @version     v1.0  12-11-20
 */


#import "DataService.h"
#import "InsuranceDTO.h"

@protocol InsuranceServiceDelegate <NSObject>

@optional
- (void)getInsuranceListCompletionWithResult:(BOOL)isSuccess
                                    errorMsg:(NSString *)errorMsg
                               insuranceList:(NSArray *)insurances;

@end

//----------------------------------------------------------

@interface InsuranceService : DataService
{
    HttpMessage     *queryInsuranceHttpMsg;
}

@property (nonatomic, weak) id<InsuranceServiceDelegate> delegate;


- (void)beginGetInsuranceListRequest;

@end
