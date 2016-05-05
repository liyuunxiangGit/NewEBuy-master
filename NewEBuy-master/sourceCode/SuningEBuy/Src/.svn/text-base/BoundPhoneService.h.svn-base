//
//  BoundPhoneService.h
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      BoundPhoneService
 @abstract    绑定手机service
 @author      shasha
 @version     v1.0  12-9-11
 */

@protocol BoundPhoneServiceDelegate;

#import "DataService.h"
@interface BoundPhoneService : DataService{

    HttpMessage     *boundWhenLogonByPhoneHttpMsg;
    
    HttpMessage     *boundWhenLogonByEmailHttpMsg;

}

@property (nonatomic, weak) id  <BoundPhoneServiceDelegate>delegate;

/*!
 @abstract   绑定手机号码 （使用注册的手机号码进行绑定）
 @discussion 当登录时候用手机号码登录
 @param phoneNum  手机号码
 @param codeNum   验证码
 */
- (void)beginBoundPhoneWhenLogonByPhone:(NSString *)phoneNum CodeNum:(NSString *)codeNum;


/*!
 @abstract   绑定手机号码 （使用填写的手机号码进行绑定）
 @discussion 当登录时候用邮箱等非手机号码登录时，使用此接口进行绑定手机号码
 @param phoneNum  手机号码
 @param codeNum   验证码
 */
- (void)beginBoundPhoneWhenLogonByEmail:(NSString *)phoneNum CodeNum:(NSString *)codeNum;


@end


@protocol BoundPhoneServiceDelegate <NSObject>

//bindPhone_5015:未登录； “bindPhone_9005”：“与易付宝系统通信异常”；
//bindPhone_9020：验证码错误；  "bindPhone_2032"：“绑定手机号码失败”；  
//1001：请求参数不全；  1005：手机号码格式不对；  2031：手机号码已经被绑定；
//9010：验证码错误；  1002：手机绑定过程中出错；
- (void)didBoundPhoneWhenLogonByPhoneComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc;

- (void)didBoundPhoneWhenLogonByEmailComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc;

@end
