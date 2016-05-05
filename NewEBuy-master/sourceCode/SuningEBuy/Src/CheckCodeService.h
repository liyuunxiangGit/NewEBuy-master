//
//  CheckCodeService.h
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      CheckCodeService
 @abstract    获取验证码的服务
 @author      shasha
 @version     12-9-3  Create
 */

#import "DataService.h"
#import "Calculagraph.h"

typedef enum{
    eEfubaoCheckCode,//邮箱登陆，易付宝激活，手机绑定
    eIntegralCheckCode,//邮箱登陆，云钻激活，手机绑定
    ePhoneCheckCode,//手机登陆，手机绑定
    eUserCashCardBind//使用礼品卡时获取验证码
}CheckCodeState ;

@protocol CheckCodeServiceDelegate;

@interface CheckCodeService : DataService{
    
    HttpMessage     *checkCodeHttpMsg;
    
}

@property (nonatomic, weak) id  <CheckCodeServiceDelegate>delegate;
@property (nonatomic, assign) BOOL userCal;
@property (nonatomic, assign) CGFloat limitTime;

/*!
 @method
 @abstract   获取对应手机号码的验证码
 @discussion 
 @param phoneNum  手机号码
 */
- (void)beginGetCheckCode:(NSString *)phoneNum checkCodeState:(CheckCodeState)checkCodeState;

//是否会请求
- (BOOL)available;

+ (void)stopCalculagraph;
- (void)stopCalculagraph;


@end

@protocol CheckCodeServiceDelegate <NSObject>

- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc;

@optional
//剩余时间重试,在userCal为yes时执行
- (void)eppGetCodeRemainTimeToRetry:(NSInteger)seconds checkCodeState:(CheckCodeState)status;

@end