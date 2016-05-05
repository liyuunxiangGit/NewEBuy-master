//
//  FindPasswordDTO.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

typedef enum  {
    Check_LoginID_ImageCode = 1,
    Resend_ValidateCode = 2,
    Check_ValidateCode = 3,
    Reset_Password = 4
}FindPasswordStep;

@interface FindPasswordDTO : BaseHttpDTO

@property (nonatomic, assign) FindPasswordStep      stepIndex; //步骤
@property (nonatomic, copy) NSString                *uuid;     //唯一标识符
@property (nonatomic, copy) NSString                *imageCode;//图片验证码
@property (nonatomic, copy) NSString                *cellPhone; //手机号码
@property (nonatomic, copy) NSString                *step;      //步骤标识
@property (nonatomic, copy) NSString                *validateCode;//短信验证码
@property (nonatomic, copy) NSString                *password;//密码

@end
