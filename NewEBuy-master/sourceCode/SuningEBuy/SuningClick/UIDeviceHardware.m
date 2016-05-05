//
//  UIDeviceHardware.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-6.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import "UIDeviceHardware.h"
#include <sys/types.h>
#include <sys/sysctl.h>

@implementation UIDeviceHardware

- (NSString *)platform
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    
    char *machine = malloc(size);
    
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
    free(machine);
    
    return platform;
}

- (NSString *)platformString
{
    NSString *platform = [self platform];
        
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone1G GSM";
    
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone3G GSM";
    
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone3GS GSM";
    
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone4 GSM";
    
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone4 CDMA";
    
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone4S";
    
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone5";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1 WiFi";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2 WiFi";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2 GSM";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2 CDMAV";

    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2 CDMAS";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini WiFi";

    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3 WiFi";

    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3 GSM";

    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3 CDMA";

    
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])   return @"iPhone Simulator";
    
    return platform;
    
}

@end
