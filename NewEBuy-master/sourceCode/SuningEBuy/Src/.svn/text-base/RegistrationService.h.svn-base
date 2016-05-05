//
//  RegistrationService.h
//  SuningEBuy
//
//  Created by 王家兴 on 13-7-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RegistrationDetailDTO.h"
#import "RegistrationPrepareDTO.h"
#import "StoresRegistrationDTO.h"
#import "RegistrationBaseDTO.h"
#import "CheckInDTO.h"

@protocol RegistrationServiceDelegate;

@interface RegistrationService : DataService
{
    HttpMessage *registrationPrepareMsg;
    HttpMessage *registrationDetailMsg;
    HttpMessage *storesRegistrationMsg;
}
@property (nonatomic, strong) RegistrationPrepareDTO *registPrepareDto;
@property (nonatomic, strong) RegistrationDetailDTO *registDetailDto;
@property (nonatomic, strong) StoresRegistrationDTO *storeRegistDto;
@property (nonatomic, strong) CheckInDTO *checkInDto;


@property (nonatomic, weak) id<RegistrationServiceDelegate> delegate;

/*!
 @abstract      请求签到信息准备
 @param         userId  用户名
 @discussion    用户名
 */
- (void)beginSendRegistrationPrepareRequest:(NSString *)userId;

/*!
 @abstract      请求签到信息
 @param         dto  包含请求参数的dto
 @discussion    参数dto中需要包含三个基本参数useId，checkType，distance，latitudeAndLongitude，storeId
 */
- (void)beginSendRegistrationDetailRequest:(RegistrationDetailBaseDTO *)dto;

/*!
 @abstract      请求判断门店签到
 @param         dto  包含请求参数的dto
 @discussion    参数dto中需要包含三个基本参数useId，distance，latitudeAndLongitude，storeId
 */
- (void)beginSendStoresRegistrationRequest:(StoresRegistrationBaseDTO *)dto;
@end

@protocol RegistrationServiceDelegate <NSObject>

@optional

- (void)didSendRegistrationPrepareRequestComplete:(RegistrationService *)service  Result:(BOOL)isSuccess;

- (void)didSendRegistrationDetailRequestComplete:(RegistrationService *)service  Result:(BOOL)isSuccess;

- (void)didSendStoresRegistrationRequestComplete:(RegistrationService *)service  Result:(BOOL)isSuccess;

@end