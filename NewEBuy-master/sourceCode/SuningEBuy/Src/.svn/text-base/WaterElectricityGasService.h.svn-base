//
//  WaterElectricityGasService.h
//  SuningEBuy
//
//  Created by 谢 伟 on 12-10-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "PayServiceDTO.h"

@protocol WaterElectricityGasServiceDelegate;

@interface WaterElectricityGasService : DataService
{
    HttpMessage                     *cityListHttpMsg;
    HttpMessage                     *chargeModeHttpMsg;
    HttpMessage                     *regionInfoHttpMsg;
    HttpMessage                     *companyListHttpMsg;
    HttpMessage                     *feeModeHttpMsg;
    HttpMessage                     *accountInfoHttpMsg;
    
    NSMutableArray                  *_regionList;
    NSMutableArray                  *_companyList;
    PayServiceDTO                   *_payServiceDTO;
    NSString                        *_payAccountNum;
    NSString                        *_customerName;
    NSString                        *_payBalance;
    
    BOOL                             _requestFail;
    BOOL                             _isGetAccount;
    
    NSString                        *_errorCode;
    
    id<WaterElectricityGasServiceDelegate> __weak _delegate;
}

@property (nonatomic, strong)   NSMutableDictionary *cityDic;
@property (nonatomic, strong) NSMutableArray  *regionList;
@property (nonatomic, strong) NSMutableArray  *companyList;
@property (nonatomic, strong) PayServiceDTO   *payServiceDTO;
@property (nonatomic, strong) NSString        *payAccountNum;
@property (nonatomic, strong) NSString        *customerName;
@property (nonatomic, strong) NSString        *payBalance;

@property (nonatomic, assign) BOOL  requestFail;
@property (nonatomic, assign) BOOL  isGetAccount;

@property (nonatomic, strong) NSString   *errorCode;
@property (nonatomic, weak) id<WaterElectricityGasServiceDelegate> delegate;

- (void)beginGetChargeCityList:(PayServiceDTO *)payServiceDTO;

- (void)beginGetChargeMode:(PayServiceDTO *)payServiceDTO;

- (void)beginGetRegionInfo:(PayServiceDTO *)payServiceDTO;

- (void)beginGetCompanyList:(PayServiceDTO *)payServiceDTO;

- (void)beginGetFeeMode:(PayServiceDTO *)payServiceDTO;

- (void)beginGetAccountInfo:(PayServiceDTO *)payServiceDTO;

@end


@protocol WaterElectricityGasServiceDelegate <NSObject>

@optional

- (void)getCityListCompleteWithService:(WaterElectricityGasService *)service
                                  Result:(BOOL)isSuccess
                                errorMsg:(NSString *)errorMsg;

- (void)getChargeModeCompleteWithService:(WaterElectricityGasService *)service
                                Result:(BOOL)isSuccess
                              errorMsg:(NSString *)errorMsg;


- (void)getRegionInfoCompleteWithService:(WaterElectricityGasService *)service
                                    Result:(BOOL)isSuccess
                                  errorMsg:(NSString *)errorMsg;

- (void)getCompanyListCompleteWithService:(WaterElectricityGasService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg;

- (void)getFeeModeCompleteWithService:(WaterElectricityGasService *)service
                                   Result:(BOOL)isSuccess
                                 errorMsg:(NSString *)errorMsg;

- (void)getAccountInfoCompleteWithService:(WaterElectricityGasService *)service
                               Result:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg;
@end
