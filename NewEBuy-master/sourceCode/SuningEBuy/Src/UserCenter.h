//
//  UserCenter.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      UserCenter
 @abstract    用户信息中心，取缔了以前放在appdelegate里面造成appDelegate冗余
 @author      刘坤
 @version     v1.0.003  12-8-29
 */

#import <Foundation/Foundation.h>
#import "UserInfoDTO.h"
#import "IPInfoDTO.h"
#import "UserDiscountInfoDTO.h"
#import "UserLoginService.h"

#undef CURRENT_USER
#define CURRENT_USER ([UserCenter defaultCenter].userInfoDTO)

/*!
 @enum
 @abstract 会员易付宝状态的enum
 */

typedef enum {
    
    eUserUnLogin,         //用户未登录
    eLoginByPhoneUnBound, //手机登录、手机未绑定、易付宝未激活
    eLoginByEmailUnBound, //邮箱登录、邮箱未激活、手机位激活、易付宝未激活
    eLoginByEmailPhoneUnBound, //邮箱登录、邮箱已激活、手机未激活、易付宝未激活
    eLoginByPhoneUnActive,//手机登录、手机已绑定、易付宝未激活
    eLoginByEmailUnActive,//邮箱登录、邮箱已激活、手机已激活、易付宝未绑定
    eLoginByPhoneActive,  //手机登录、手机已绑定、易付宝已激活
    eLoginByEmailActive   //邮箱登录、邮箱已绑定、易付宝已激活
    
}eEfubaoStatus;


@interface UserCenter : NSObject
{
@private
    BOOL                 _isLogined;
    UserInfoDTO          *_userInfoDTO;
    UserDiscountInfoDTO  *_userDiscountInfoDTO;
    BOOL                  _isGetRedPack;
    NSString             *_lastUserId; //用于记录上次登录的用户id,如果和本次登录的用户id不同，则所有页面跳到首页
}

/*!
 @property  isLogined
 @abstract  标识位，标识是否有用户登录
 */
@property (nonatomic, readonly) BOOL isLogined;

/*!
 @abstract    易付宝状态
 @discussion  初始值为eUserUnLogin，用户登录、注销的时候都需要刷新此状态
 */
@property (nonatomic, assign)   eEfubaoStatus  efubaoStatus;

/*!
 @property      userInfoDTO
 @abstract      保存用户信息的DTO
 */
@property (nonatomic, strong) UserInfoDTO *userInfoDTO;

/*!
 @property      lastUserId
 @abstract      当在session失效的时候记录，用户再次登录后会设置为nil
 */
@property (nonatomic, copy) NSString *lastUserId;

/*!
 @abstract      用户优惠信息的DTO，
 @discussion    包括易付宝余额、易购券、云钻等。
 用户登出的时候设为nil。登录成功的时候，重新请求数据，刷新数据。
 */
@property (nonatomic, strong) UserDiscountInfoDTO  *userDiscountInfoDTO;

/*!
 @abstract    是否提醒过用户即将要到期的易购券；
 @discussion  没个用户回话只进行一次提醒
 
 */
@property (nonatomic, assign) BOOL                 isNoticeOutDateCoupon;


@property (nonatomic, strong) IPInfoDTO             *cabInfo;
@property (nonatomic, strong) IPInfoDTO             *impInfo;
@property (nonatomic, strong) IPInfoDTO             *ofsInfo;
@property (nonatomic, strong) NSString              *token;
@property (nonatomic, strong) NSString              *userType;



@property (nonatomic, strong) NSString              *suningUsername;
@property (nonatomic, strong) NSString              *suningPassword;
@property (nonatomic, strong) NSString              *bindPhoneNum;

//add by gjf 暗号
@property (nonatomic, strong) NSString              *cipher;

@property (nonatomic,assign) BOOL                    isGetRedPack;

@property (nonatomic, strong) NSString              *deviceno;
@property (nonatomic, strong) NSString              *cipher1;
@property (nonatomic, strong) NSString              *actverule;

//add by gjf
@property (nonatomic, strong) NSString              *ticketRuleUrl;

@property (nonatomic, assign)  BOOL                 hasTrustLoginToEpp; //是否信任登录到epp过

+ (UserCenter *)defaultCenter;

/*!
 @abstract      获取默认的地址信息
 @result        默认保存的地址信息
 */
- (AddressInfoDTO *)defaultAddressInfo;

/*!
 @abstract      根据cityCode获取地址信息
 @result        获取改城市的地址信息
 */
- (AddressInfoDTO *)getAddressInfoByCity:(NSString *)cityCode;

- (void)clearUserInfo;
- (void)markAsLogout;

/**
 * 记录需要注册送券的账号
 */
- (void)sendCouponAfterRegistForUser:(NSString *)userId;

@end
