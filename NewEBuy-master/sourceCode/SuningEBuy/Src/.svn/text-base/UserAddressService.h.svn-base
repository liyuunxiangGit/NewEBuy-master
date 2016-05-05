//
//  UserAddressService.h
//  SuningEBuy
//
//  Created by  on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      UserAddressService
 @abstract    获取用户地址信息Service
 @author      刘坤
 @version     v1.0.001  12-9-25
 */

#import "DataService.h"
#import "AddressInfoDTO.h"

@protocol UserAddressServiceDelegate <NSObject>

@optional
- (void)getAddressListCompletionWithResult:(BOOL)isSuccess 
                                  errorMsg:(NSString *)errorMsg 
                               addressList:(NSArray *)list;


- (void)addAddressCompletionWithResult:(BOOL)isSuccess 
                              errorMsg:(NSString *)errorMsg 
                               address:(AddressInfoDTO *)dto;


- (void)editAddressCompletionWithResult:(BOOL)isSuccess 
                               errorMsg:(NSString *)errorMsg 
                                address:(AddressInfoDTO *)dto;


- (void)deleteAddressCompletionWithResult:(BOOL)isSuccess 
                                 errorMsg:(NSString *)errorMsg;

@end



@interface UserAddressService : DataService
{
    HttpMessage     *getAddressListHttpMsg;
    HttpMessage     *addAddressHttpMsg;
    HttpMessage     *editAddressHttpMsg;
    HttpMessage     *deleteAddressHttpMsg;
}

@property (nonatomic, weak) id<UserAddressServiceDelegate> delegate;

/*!
 @abstract      获取用户地址列表
 */
- (void)beginGetAddressListRequest;


/*!
 @abstract      新增用户地址
 @param         address  地址dto
 */
- (void)beginAddAddressRequest:(AddressInfoDTO *)address;


/*!
 @abstract      编辑用户地址
 @param         address  地址dto
 */
- (void)beginEditAddressRequest:(AddressInfoDTO *)address;


/*!
 @abstract      删除用户地址
 @param         addressNo  地址id
 */
- (void)beginDeleteAddressRequest:(NSString *)addressNo;

@end
