//
//  CheckUpdateCommand.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CheckUpdateCommand.h"
#import "SNSwitch.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

static BOOL autoChecked = NO;

@interface CheckUpdateCommand()
- (void)checkVersionUpdateWithSwithMap:(NSDictionary *)map;
@end

/*********************************************************************/

@implementation CheckUpdateCommand

+ (BOOL)autoChecked
{
    return autoChecked;
}

- (id)initWithCheckUpdateMode:(CheckUpdateMode)mode
{
    self = [super init];
    if (self) {
        _mode = mode;
    }
    return self;
}

- (void)execute
{
    
    //自动检查
    if (_mode == AutoCheck)
    {
        //如果已经检查过了，直接结束
        if (autoChecked)
        {
            [self done];
        }
        else
        {
            //如果开关接口获取完成了
            if ([SNSwitch isLoadOk])
            {
                NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
                [self checkVersionUpdateWithSwithMap:dic];
            }
            else
            {
                //add by zhangbeibei:20141016
//                [SNSwitch updateWithCallBack:^{
//                    
//                    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
//                    [self checkVersionUpdateWithSwithMap:dic];
//                }];
                NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
                [self checkVersionUpdateWithSwithMap:dic];
            }
        }
    }
    else //手动检查
    {
        self.needUpdate = YES;
        [SNSwitch updateWithCallBack:^{
            
            NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
            [self checkVersionUpdateWithSwithMap:dic];
        }];
    }
}

//判断是否需要更新的算法
- (BOOL)checkVersionIsNeedUpdateClientV:(NSString *)clientVer
                                serverV:(NSString *)serverVer
{
    if (IsNilOrNull(clientVer) ||
        [clientVer isEmptyOrWhitespace] ||
        IsNilOrNull(serverVer) ||
        [serverVer isEmptyOrWhitespace])
    {
        return NO;
    }
    
    NSArray *clientArray = [clientVer componentsSeparatedByString:@"."];
    NSArray *serverArray = [serverVer componentsSeparatedByString:@"."];
    NSInteger count =
    ([clientArray count] > [serverArray count]) ? [clientArray count] : [serverArray count];
    
    for (int i = 0; i < count; i++) {
        NSString *clientString = i < [clientArray count] ? [clientArray objectAtIndex:i] : @"0";
        NSString *serverString = i < [serverArray count] ? [serverArray objectAtIndex:i] : @"0";
        if ([clientString intValue] < [serverString intValue]) {
            return YES;
        }else if ([clientString intValue] > [serverString intValue]){
            return NO;
        }
    }
    return NO;
}

- (BOOL)isNeedForceUpdate:(NSDictionary *)map
{
    NSString *forceUpdateVersions = [map objectForKey:kForceUpdateSwithKey];
    
    NSArray *versions = [forceUpdateVersions componentsSeparatedByString:@","];
    
    if (versions && [versions count] > 0) {
        NSString *clientVersion =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        for (NSString *ver in versions)
        {
            if ([ver isEqualToString:clientVersion]) {
                return YES;
            }
        }
    }
    return NO;
}
-(BOOL)grayForeUpDate:(NSString*)aStr
{
    NSArray *versions = [aStr componentsSeparatedByString:@","];
    if (versions && [versions count] > 0) {
        NSString *clientVersion =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        for (NSString *ver in versions)
        {
            if ([ver isEqualToString:clientVersion]) {
                return YES;
            }
        }
    }
    return NO;
}

-(NSString*)grayUpDate
{
    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if (dic)
    {
        NSDictionary *updateInfoDic = [dic objectForKey:kGrayUpdateSwithKey];
        if (NotNilAndNull(updateInfoDic) && [updateInfoDic isKindOfClass:[NSDictionary class]])
        {
            NSString *clientVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
            NSString *versions = [updateInfoDic objectForKey:kUpdateVersionKey];
            NSString *detail = [updateInfoDic objectForKey:kUpdateDetailKey];
            if ([self grayForeUpDate:versions]||([clientVersion compare:versions options:NSCaseInsensitiveSearch] == NSOrderedSame))
            {
                return detail;
            }
        }
    }
    
    return @"-1";
}
//更新提示信息：
- (void)showVersionUpdateDialog:(NSString *)title
                        content:(NSString *)content
{
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(title)?L(@"UpdateVersionTip"):title
                                                        message:IsStrEmpty(content)?L(@"versionUpdate"):content
                                                       delegate:nil
                                              cancelButtonTitle:L(@"LaterUpdate")
                                              otherButtonTitles:L(@"NowUpdate")];
    alertView.contentAlignment = UITextAlignmentLeft;
    NSString *grayUpdate = [self grayUpDate];
    [alertView setConfirmBlock:^{
        
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1120012"], nil]];
        
    
        NSURL *iTunesUrl = [NSURL URLWithString:kItunesAppLink];
        if (grayUpdate.length && ![grayUpdate isEqualToString:@"-1"])
        {
            iTunesUrl = [NSURL URLWithString:grayUpdate];
        }

        [[UIApplication sharedApplication] openURL:iTunesUrl];
        
        if (_mode == AutoCheck)
        {
            [self done];
        }
    }];
    
    [alertView setCancelBlock:^{
        
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1120011"], nil]];
        if (_mode == AutoCheck)
        {
            [self done];
        }
    }];
    
    [alertView show];
    
}

//强制更新提示信息：
- (void)showMustVersionUpdateDialog:(NSString *)title content:(NSString *)content
{
    
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:IsStrEmpty(title)?L(@"UpdateVersionTip"):title
                                                        message:IsStrEmpty(content)?L(@"versionUpdate"):content
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:L(@"Ok")];
    alertView.contentAlignment = UITextAlignmentLeft;
    
    alertView.shouldDismissAfterConfirm = NO;
    NSString *grayUpdate = [self grayUpDate];
    [alertView setConfirmBlock:^{
        
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1120014"], nil]];
        
        NSURL *iTunesUrl = [NSURL URLWithString:kItunesAppLink];
        if (grayUpdate.length && ![grayUpdate isEqualToString:@"-1"])
        {
            iTunesUrl = [NSURL URLWithString:grayUpdate];
        }
        [[UIApplication sharedApplication] openURL:iTunesUrl];
        
    }];
    
    [alertView show];
}

- (void)showNoneUpdateDialog
{
    self.needUpdate = NO;
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil
                                                        message:L(@"MostUpdateVersion")
                                                       delegate:nil
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
    
    [alertView show];
    
}


- (void)checkVersionUpdateWithSwithMap:(NSDictionary *)map
{
    if (map == nil || [map count] == 0) {
        
        [self done];
        return;
    }
    
    NSDictionary *updateInfoDic = [map objectForKey:kSystemVersionKey];
    if (NotNilAndNull(updateInfoDic) && [updateInfoDic isKindOfClass:[NSDictionary class]]) {
        
        NSString *serverVersion = [updateInfoDic objectForKey:kUpdateVersionKey];
        NSString *clientVersion =
        [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
        
        //需要更新
        if (NotNilAndNull(serverVersion) &&
            [self checkVersionIsNeedUpdateClientV:clientVersion serverV:serverVersion])
        {
            
            NSString *title = [updateInfoDic objectForKey:kUpdateTitleKey];
            NSString *content = [updateInfoDic objectForKey:kUpdateContentKey];
            NSString *detail = [updateInfoDic objectForKey:kUpdateDetailKey];
            
            NSString *showContent = nil;
            if (!IsStrEmpty(content) && !IsStrEmpty(detail)) {
                detail = [detail stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
                showContent = [NSString stringWithFormat:@"%@\n%@", content, detail];
            }
            
            if (_mode == ManualCleck)
            {
                [self done];
            }
            
            //是否需要强制更新
            if ([self isNeedForceUpdate:map])
            {
                 [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121701"], nil]];
                [self showMustVersionUpdateDialog:NotNilAndNull(title)?title:nil
                                          content:showContent];
            }
            else
            {
                [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121701"], nil]];
                [self showVersionUpdateDialog:NotNilAndNull(title)?title:nil
                                      content:showContent];
            }
        }
        else //不需要更新
        { 
            if (_mode == ManualCleck)
            {   //手动更新
                [self showNoneUpdateDialog];
            }
            [self done];

        }
        
        autoChecked = YES;
    }
    else
    {
        if (_mode == ManualCleck)
        {   //手动更新
            [self showNoneUpdateDialog];
        }
        
        [self done];
    }
    
    
}


@end
