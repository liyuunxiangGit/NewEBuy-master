//
//  PayServicePaymentService.h
//  SuningEBuy
//
//  Created by 谢 伟 on 12-10-11.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "PayServiceDTO.h"

@protocol PayServicePaymentServiceDelegate;

@interface PayServicePaymentService : DataService
{
    HttpMessage                            *efubaoHttpMsg;
    HttpMessage                            *paymentApplyHttpMsg;
    HttpMessage                            *payOnBankHttpMsg;
    PayServiceDTO                          *_payDataSource;
    
    NSString                               *_wwwUrl;
    NSString                               *_desc;
    BOOL                                   _isNotSuccess;
    
    id<PayServicePaymentServiceDelegate>    __weak _delegate;
}

@property (nonatomic, strong) PayServiceDTO  *payDataSource;
@property (nonatomic, strong) NSString  *wwwUrl;
@property (nonatomic, strong) NSString  *desc;
@property (nonatomic, assign) BOOL  isNotSuccess;
@property (nonatomic, weak) id<PayServicePaymentServiceDelegate>    delegate;

- (void)beginGetPaymentApplyWith:(PayServiceDTO *)payServiceDTO
                         PayMode:(NSInteger)selectedPayMode
                     PayPassword:(NSString *)payPassword;
- (void)beginsendPayOnBankHttpRequest:(PayServiceDTO *)orderDTO;
- (void)beginsendPayOnSdkBankHttpRequest:(PayServiceDTO *)orderDTO;
- (void)didSendPayOnBankHttpRequestFinished:(BOOL)isSuccess
                                        url:(NSURL *)url
                                        xml:(NSString *)xml;
@end


@protocol PayServicePaymentServiceDelegate <NSObject>

@optional

- (void)getPaymentApplyCompleteWithService:(PayServicePaymentService *)service
                                    Result:(BOOL)isSuccess
                                  errorMsg:(NSString *)errorMsg;
- (void)didSendPaySdkOnBankCompleted:(BOOL)isSuccess xml:(NSString *)xml code:(NSString*)code;
- (void)didSendPayOnBankCompleted:(BOOL)isSuccess
                         errorMsg:(NSString *)errorMsg
                      punchoutUrl:url
                     punchoutForm:xml
;
@end
