//
//  FlightOrderService.h
//  SuningEBuy
//
//  Created by admin on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "FlightInfoDTO.h"
#import "InsuranceDTO.h"

typedef enum{
    eOrderFail = 0,//订单提交失败
    eOrderFail_DataCheckFail = 1, //数据校验失败
    eOrderSucc_InsuranceSucc = 2,//订单提交成功，核保成功
    eOrderSucc_InsuranceFail = 3,//订单成功，核保失败
    eOrderSucc_PriceChange_InsuranceSucc = 4,//订单提交成功，订单价价格变化，核保成功
    eOrderSucc_PriceChange_InsuranceFail= 5,//订单提交成功，订单价价格变化，核保失败
    eOrderFail_SaleOut = 6,//订单机票售完
    eOrderFail_CheckFail = 7,//验签失败
    eOrderFail_ReSubmit = 8,//该订单中有顾客已经选择了此航班
} FlightOrderStatus;

@class FlightOrderService;

@protocol FlightOrderDelegate <NSObject>

@optional

/*!
 @method
 @abstract 机票订单提交的回调方法
 */
- (void)didSendFlightOrderSubmitComplete:(FlightOrderService *)service 
                                  Result:(BOOL)isSuccess 
                                ErrorMsg:(NSString *)errorMsg
                               ErrorCode:(NSString *)errorCode;


- (void)paymentByEppCompletionWithResult:(BOOL)isSuccess
                                errorMsg:(NSString *)errorMsg
                                  status:(int)status;


- (void)paymentByHftxCompletionWithResult:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg
                                   payUrl:(NSString *)url
                                   status:(int)status;
-(void)paymentbyOnBankComPletionWithResult:(BOOL)isSuccess
                                  errorMsg:(NSString *)errorMsg
                                 errorCode:(NSString *)errorCode
                                       xml:(NSString *)xml;
                                            
@end


@interface FlightOrderService : DataService
{
    HttpMessage *flghtOrderSubmitMsg;

    HttpMessage *payByEppHttpMsg;
    HttpMessage *payByHftxHttpMsg;
    HttpMessage *payOnBankHttpMsg;
}

@property (nonatomic,weak) id<FlightOrderDelegate> delegate;

/*!
 @abstract   机票订单id
 @discussion 机票订单提交接口返回数据
 */
@property (nonatomic, strong) NSString  *orderId;
@property (nonatomic, strong) NSString  *shouldPay;

/*!
  @abstract  订单状态
 @discussion 机票订单提交接口返回数据处理结果
 */
@property (nonatomic, assign) FlightOrderStatus   orderStatus;


/*!
 @method
 @abstract               提交机票订单请求
 @discussion             提交机票订单请求
 @param customerCount    登机人数量
 @param boardingList     登机人列表
 @param addressInfoDTO   送票地址
 @param name             预订人姓名
 @param mobile           预订人手机号码
 @param goFlightInfoDTO    单程：机票信息
                           往返：去程机票信息
 @param backFlightInfoDTO  单程：为空
                           往返：返程机票信息

 */
- (void)beginSendOrderSubmitRequest:(int)customerCount
                       BoardingList:(NSMutableArray *)boardingList
                        AddressInfo:(AddressInfoDTO*)addressInfoDTO
                        AddressType:(NSString *)addressType
                     BookPersonName:(NSString *)name
                   BookPersonMobile:(NSString *)mobile
                       GoFlightInfo:(FlightInfoDTO *)goFlightInfoDTO
                     BackFlightInfo:(FlightInfoDTO *)backFlightInfoDTO
                      insuranceInfo:(InsuranceDTO *)selectInsurance;

//- (void)sendEfubaoHttpRequest:(NSMutableDictionary *)postDataDic;
//
//- (void)sendPaymentHttpRequest:(NSMutableDictionary *)postDataDic andWhich:(int)row;


- (void)beginPaymentByEppWithOrderId:(NSString *)orderId
                              userId:(NSString *)userId
                         epayAccount:(NSString *)epayAccount
                            password:(NSString *)password;

- (void)beginPaymentByHftxWithOrderId:(NSString *)orderId
                               userId:(NSString *)userId
                          epayAccount:(NSString *)epayAccount;
- (void)beginsendPayonBankwithOrderId:(NSString *)orderId
                               userId:(NSString *)userId
                             memberId:(NSString *)memeberId
                             payAmout:(NSString *)payAmout;
@end
