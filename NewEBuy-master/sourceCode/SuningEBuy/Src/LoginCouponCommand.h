//
//  LoginCouponCommand.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-3-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ActivitySwitchService.h"
#import "Command.h"

@interface LoginCouponCommand : Command<ActivitySwitchServiceDelegate>
{
@private
    NSString *_userId;
}

- (id)initWithUserId:(NSString *)userId;

//注册送券
- (void)execute;

@end
