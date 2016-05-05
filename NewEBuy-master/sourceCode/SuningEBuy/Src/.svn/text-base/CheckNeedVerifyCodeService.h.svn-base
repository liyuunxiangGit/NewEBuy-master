//
//  CheckNeedVerifyCodeService.h
//  SuningEBuy
//
//  Created by chupeng on 14-1-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "UserInfoDTO.h"
#define KUserName @"username"

@protocol CheckNeedVerifyCodeServiceDelegate <NSObject>
- (void)CheckNeedVerifyCodeCompletedWithResult:(BOOL)needVerify;
@end

@interface CheckNeedVerifyCodeService : DataService
{
    HttpMessage    *checkHttpMsg;
}

@property (nonatomic, weak) id<CheckNeedVerifyCodeServiceDelegate> delegate;
@property (nonatomic, copy) NSString *userName;

- (void)beginCheckNeedVerifyCode:(NSString *)userName;
@end
