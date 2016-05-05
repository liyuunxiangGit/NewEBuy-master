//
//  RegistHandselCouponCommand
//  SuningEBuy
//
//  Created by  liukun on 12-11-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
//  注册送券

#import <Foundation/Foundation.h>
#import "ActivitySwitchService.h"
#import "Command.h"

@interface RegistHandselCouponCommand : Command<ActivitySwitchServiceDelegate>
{
    @private
    NSString *_userId;
}

- (id)initWithUserId:(NSString *)userId;

//注册送券
- (void)execute;

@end
