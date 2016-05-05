//
//  MobileRechargeNewService.h
//  SuningEBuy
//
//  Created by 家兴 王 on 12-9-20.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@class MobileRechargeNewService;

@protocol MobileRechargeNewServiceDelegate <NSObject>

@optional
- (void)getCheckPreferentialHttpRequestCompletedWithService:(MobileRechargeNewService *)service
                                                   isSucess:(BOOL)isSucess
                                                  errorCode:(NSString *)errorCode;
- (void)getCheckMobileNumberHttpRequestCompletedWithService:(MobileRechargeNewService *)service 
                                                   isSucess:(BOOL)isSucess 
                                                  errorCode:(NSString *)errorCode;

@end

@interface MobileRechargeNewService : DataService
{
    BOOL             isLoadingCheckPreferential;
    BOOL             isLoadingCheckMobileNumber;
    HttpMessage      *checkPreferentialMsg;
    HttpMessage      *checkMobileNumberMsg;
    
    NSString         *preferentPrice;
    NSString         *providerNO;
    NSString         *backError;
    
    NSString         *numberInfo;
    NSString         *ispCode;
    NSString         *ispName;
    NSString         *ispType;
    NSString         *provinceId;
    NSString         *provinceName;
    
}

@property(nonatomic,weak)id<MobileRechargeNewServiceDelegate> delegate;

@property(nonatomic,strong) NSString *preferentPrice;

@property(nonatomic,strong) NSString *providerNO;

@property(nonatomic,strong) NSString *backError;

@property(nonatomic,strong) NSString *numberInfo;

@property(nonatomic,strong) NSString *ispCode;

@property(nonatomic,strong) NSString *ispName;

@property(nonatomic,strong) NSString *ispType;

@property(nonatomic,strong) NSString *provinceId;

@property(nonatomic,strong) NSString *provinceName;

- (void)beginGetCheckPreferential:(NSString *)phoneNum money:(NSString *)money;
- (void)beginGetCheckMobileNumber:(NSString *)mobileNumber;

- (void)sendCheckPreferentialHttpRequest:(NSDictionary *)parametersDic;
- (void)getCheckPreferentialFinish:(BOOL)isSuccess;

- (void)sendCheckMobileNumberHttpRequest:(NSString *)mobileNumber;
- (void)getCheckMobileNumberFinish:(BOOL)isSuccess;
@end

