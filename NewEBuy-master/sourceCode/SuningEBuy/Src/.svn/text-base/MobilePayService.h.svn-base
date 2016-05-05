//
//  MobilePayService.h
//  SuningEBuy
//
//  Created by shasha on 12-9-28.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "payMobileOrderDTO.h"

@protocol  MobilePayServiceDelegate;

@interface MobilePayService : DataService{
    
    HttpMessage     *mobilePayHttpMsg;
    HttpMessage     *mobilePaySdkHttpMsg;
    HttpMessage     *huifuPayHTTpMsg;
    HttpMessage     *payOnBankHttpMsg;
    
}

@property (nonatomic, weak) id  <MobilePayServiceDelegate>delegate;
//易付宝或者汇付天下的订单号
@property (nonatomic, copy) NSString  *orderNumber;

/*!
 @method
 @abstract        手机充值，易付宝支付接口
 @discussion      易付宝支付
 @param           orderDTO  手机充值所需要的参数列表DTO
 @param           password  易付宝密码
 
 */
- (void)beginSendMobilePayHttpRequest:(payMobileOrderDTO *)orderDTO yifubaoPassWord:(NSString *)password validateCode:(NSString *)validateCode ;

/*!
 @method
 @abstract      手机充值，汇付天下支付接口
 @discussion    汇付天下支付
 @param         orderDTO  手机充值所需要的参数列表DTO
 */
- (void)beginSendHuifuMobilePayHttpRequest:(payMobileOrderDTO *)orderDTO;

- (void)beginsendPayOnBankHttpRequest:(payMobileOrderDTO *)orderDTO;
- (void)beginsendPayOnSdkBankHttpRequest:(payMobileOrderDTO *)orderDTO;//调用sdk
@end


@protocol  MobilePayServiceDelegate<NSObject>

@optional
/*!
 @method
 @abstract        手机充值，易付宝支付回调
 @discussion      易付宝支付
 @param           orderDTO  手机充值所需要的参数列表DTO
 @param           password  易付宝密码
 
 */
- (void)didSendMobilePayCompleted:(BOOL)isSuccess
                         errorMsg:(NSString *)errorMsg;
- (void)didSendMobileSdkPayCompleted:(BOOL)isSuccess xml:(NSString *)xml code:(NSString*)code;
/*!
 @method
 @abstract        手机充值 汇付天下支付回调
 @discussion      汇付天下支付
 @param           orderDTO  手机充值所需要的参数列表DTO
 */
- (void)didSendHuifuMobilePayCompleted:(BOOL)isSuccess
                              errorMsg:(NSString *)errorMsg;

- (void)didSendPayOnBankCompleted:(BOOL)isSuccess
                         errorMsg:(NSString *)errorMsg
                      punchoutUrl:url
                     punchoutForm:xml
;

@end
