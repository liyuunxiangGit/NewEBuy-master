//
//  FindPasswordDTO.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FindPasswordDTO.h"

@implementation FindPasswordDTO

@synthesize uuid            = _uuid;
@synthesize imageCode       = _imageCode;
@synthesize step            = _step;
@synthesize cellPhone       = _cellPhone;
@synthesize password        = _password;
@synthesize validateCode    = _validateCode;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_imageCode);
    TT_RELEASE_SAFELY(_uuid);
    TT_RELEASE_SAFELY(_step);
    TT_RELEASE_SAFELY(_password);
    TT_RELEASE_SAFELY(_validateCode);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
}

- (void)setStepIndex:(FindPasswordStep)stepIndex
{
    switch (stepIndex) {
        case Check_LoginID_ImageCode:
            self.step = @"CHECK_CELLPHONE_IMAGECODE";
            break;
        case Resend_ValidateCode:
            self.step = @"RESEND_VALIDATECODE";
            break;
        case Check_ValidateCode:
            self.step = @"CHECK_VALIDATECODE";
            break;
        case Reset_Password:
            self.step = @"RESET_PASSWORD";
            break;
        default:
            break;
    }
    _stepIndex = stepIndex;
}

@end
