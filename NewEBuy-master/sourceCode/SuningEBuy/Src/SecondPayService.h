//
//  SecondPayService.h
//  SuningEBuy
//
//  Created by  liukun on 12-11-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SecondPayService.h
 @abstract    二次支付
 @author       liukun
 @version     v1.0  12-11-29
 */


#import "DataService.h"
#import "payFlowDTO.h"

@protocol SecondPayServiceDelegate <NSObject>

@optional
- (void)secondPayCheckCompletionWithResult:(BOOL)isSuccess
                                  errorMsg:(NSString *)errorMsg
                                    payDto:(payFlowDTO *)payDTO;

@end

//----------------------------------------------------------

@interface SecondPayService : DataService
{
    HttpMessage     *secondPayHttpMsg;
}

@property (nonatomic, weak) id<SecondPayServiceDelegate> delegate;


- (void)beginSecondPayOrderCheckWithOrderId:(NSString *)orderId;

@end
