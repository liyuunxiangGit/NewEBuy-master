//
//  AccountCheckCodeService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "Calculagraph.h"
#import "MemeberMergeService.h"

typedef enum{
    eValidateMemberCardContactCellphoneSendCellphoneCode,//验证门店会员卡联系手机发送短信验证码。
    eMailAccountValidateOwnerSendMailCode,//邮箱账号验证邮箱发送邮箱验证码。
    eMailAccountValidateOwnerVerifyMailCode,//邮箱账号验证邮箱校验邮箱验证码。
    eMailAccountBindCellphoneSendCellphoneCode,//邮箱账号绑定手机发送短信验证码。
    eMailAccountBindCellphoneVerifyCellphoneCode,//邮箱账号绑定手机校验短信验证码。
    eMergeMbrCardSendCellphoneCode,//登录状态合并会员卡验证易购绑定手机号发送短信验证码。
    eMergeMemberCardVerifyCellphoneCode,//登录状态合并会员卡验证易购绑定手机号校验短信验证码。
    eMergeAccountCode,//选择合并的易购手机号
    
    eEmailAccountBindCellSendMailCode,//登录转邮箱账号绑定手机发送邮箱验证码
    eEmailAccountBindCellVerifyMailCode,//登录状态邮箱账号绑定手机验证邮箱验证码
    eEmailAccountBindCellSendCellCode,//登录状态邮箱账号绑定手机发送手机验证码
    eEmailAccountBindCellVerifyCellCode//登录状态邮箱账号绑定手机验证手机验证码
    
}AccountCheckCodeState ;

@protocol AccountCheckCodeServiceDelegate;

@interface AccountCheckCodeService : DataService{
    
    HttpMessage     *checkCodeHttpMsg;
    HttpMessage     *emailCodeHttpMsg;
}

@property (nonatomic, weak) id  <AccountCheckCodeServiceDelegate>delegate;
@property (nonatomic, assign) BOOL userCal;
@property (nonatomic, assign) CGFloat limitTime;
@property (nonatomic, strong) MemberInfoDto  *memberInfoDto;

/*!
 @method
 @abstract   获取对应手机号码的验证码
 @discussion
 @param phoneNum  手机号码
 */
- (void)beginGetCheckCode:(NSString *)phoneNum email:(NSString *)email checkCodeState:(AccountCheckCodeState)checkCodeState validateCode:(NSString *)validateCode;


- (void)beginGetEmailCheckCode:(NSString *)phoneNum checkCodeState:(AccountCheckCodeState)checkCodeState validateCode:(NSString *)validateCode;

@end

@protocol AccountCheckCodeServiceDelegate <NSObject>

- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc;

@end