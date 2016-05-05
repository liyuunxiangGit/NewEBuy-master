//
//  Preferences.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-6.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import "Preferences.h"
#import "UIDeviceHardware.h"
#import "IPAddress.h"

@implementation Preferences


//获取系统当前时间
+ (NSString *)systemTimeInfo{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyyMMddHHmmssSSS"];
    
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    TT_RELEASE_SAFELY(dateFormatter);
    
    return [currentDateString trim];

}

+ (NSString *)yearMonthDay{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    TT_RELEASE_SAFELY(dateFormatter);
    
    return currentDateString;
    
}

+ (NSString *)currentSystemTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    
    TT_RELEASE_SAFELY(dateFormatter);
    
    return currentDateString;
}

+ (NSString *)platform
{
    UIDeviceHardware *currentHardware = [[UIDeviceHardware alloc] init];
    
    NSString *platf = [currentHardware platformString];
    
    TT_RELEASE_SAFELY(currentHardware);
    
    return platf;
}

+ (NSString *)deviceIPAddressLocal
{
    InitAddresses();
    
    GetIPAddresses();
    
    GetHWAddresses();
    
    return [NSString stringWithFormat:@"%s", ip_names[1]];
}
//获取外网ip地址，博客原文http://blog.csdn.net/favormm/article/details/6858330
+ (NSString *)deviceIPAddressPublic
{
    NSURL *url = [NSURL URLWithString:@"http://automation.whatismyip.com/n09230945.asp"];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    
    NSString *response = nil;
    
    if (!error)
    {
        response = [request responseString];
    }
    return response;
}


@end
