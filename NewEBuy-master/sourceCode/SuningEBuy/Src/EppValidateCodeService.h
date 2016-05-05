//
//  EppValidateCodeService.h
//  SuningEBuy
//
//  Created by  liukun on 13-2-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
/*!
 @header      EppValidateCodeService.h
 @abstract    获取易付宝验证码
 @author       liukun
 @version     v1.0  13-2-19
 */


#import "DataService.h"
#import "Calculagraph.h"

@protocol EppValidateCodeServiceDelegate <NSObject>

@optional
//获取验证码完成
- (void)requestValidateCodeComplete:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

//时间改变
- (void)eppRemainTimeToRetry:(NSInteger)seconds;

@end

//----------------------------------------------------------

@interface EppValidateCodeService : DataService
{
    HttpMessage *eppValidateHttpMsg;
}

@property (nonatomic, weak) id<EppValidateCodeServiceDelegate> delegate;


- (void)requestValidateCode;
- (void)stopPayCalculagraph;

- (BOOL)available;
+ (BOOL)checkVerifyCode:(NSString *)code error:(NSString **)errorMsg;

@end
