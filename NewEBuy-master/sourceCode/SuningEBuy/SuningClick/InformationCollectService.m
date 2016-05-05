//
//  InformationTransmitHttp.m
//  SuningEBuy
//
//  Created by wangrui on 12/28/11.
//  Copyright (c) 2011 suning. All rights reserved.
//

#import "InformationCollectDAO.h"
#import "InformetionCollectDTO.h"
#import "InformationCollectService.h"

#define kSystemInfoParamType   @"sysdata"
#define kUserInfoParamType     @"typedata"
#define kSeparatorFieldSymbol  @"#@#";

@implementation InformationCollectService
@synthesize appStartInfoDic = _appStartInfoDic;
@synthesize systemInfoStr = _systemInfoStr;
@synthesize collectDataDic = _collectDataDic;

- (void)dealloc
{

    TT_RELEASE_SAFELY(_informationDao);
    
    TT_RELEASE_SAFELY(_appStartInfoDic);
    
    TT_RELEASE_SAFELY(_systemInfoStr);
    
    TT_RELEASE_SAFELY(_collectDataDic);
    
}

- (id)init
{
    if (self = [super init])
    {
        _informationDao = [[InformationCollectDAO alloc] init];
    }
    
    return self;
}

- (void)main
{
    @autoreleasepool {
         [self sendDataHttpRequest];
    }
}

#pragma mark -
#pragma mark Data Query
/**
  *采集的数据包括如下：
  *---用户使用，商品搜索，页面访问，崩溃信息---
 */
- (NSMutableDictionary *)appStartInfoDic
{
    if (!_appStartInfoDic) 
    {
        
        NSArray *collectDataTypes = [NSArray arrayWithObjects:[NSNumber numberWithInteger:IphoneUsingStat],
                                     [NSNumber numberWithInteger:ProductSearchStat],
                                     [NSNumber numberWithInteger:PageAccessingStat],
                                     [NSNumber numberWithInteger:SystemCrashDownStat],
                                     nil];
        
        _appStartInfoDic = [[NSMutableDictionary alloc] initWithCapacity:[collectDataTypes count]];
        
        // 遍历数据表
        for (NSNumber *dataType in collectDataTypes)
        {
            // 所有记录
            NSArray *subDataArray = [self informationFromTableType:dataType.integerValue];
            
            if ([subDataArray count] == 0)
            {
                continue;
            }
            
            NSString *keyName = nil;
            
            NSMutableString *collectInformations = [NSMutableString stringWithString:@""];
            
            for (InformetionCollectDTO *dto in subDataArray)
            {
                NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:dataType,kInfoDataType, dto, kInfoDataValue, nil];
                
                NSString *dataInfo = [self generateAppsDataWithDic:dataDic];
                
                NSString *fieldSeparatorSymbol = [collectInformations isEqualToString:@""] ? collectInformations : kSeparatorFieldSymbol;
                
                if (dataType.integerValue == IphoneUsingStat) {
                    
                    [collectInformations appendFormat:@"%@%@", fieldSeparatorSymbol, dataInfo];

                    break;
                }
                else
                {
                    [collectInformations appendFormat:@"%@%@", fieldSeparatorSymbol, dataInfo];
                }
                
            }
            
            switch (dataType.integerValue)
            {
                case IphoneUsingStat:
                    
                    keyName = IphoneUseTbl;
                    
                    break;
                case ProductSearchStat:
                    
                    keyName = ProductSearchTbl;
                    
                    break;
                case PageAccessingStat:
                    
                    keyName = PageAccessingTbl;
                    
                    break;
                case SystemCrashDownStat:
                    
                    keyName = SystemCrashDownTbl;
                    
                    break;
                default:
                    break;
            }
           
            [_appStartInfoDic setObject:collectInformations forKey:keyName];

            
        }
        
    }
    
    return _appStartInfoDic;
}

/**
 系统信息
 */
- (NSString *)systemInfoStr
{
    if (!_systemInfoStr)
    {
        NSArray *systemInfoArr = [self informationFromTableType:SystemInfoStat];
        
        if ([systemInfoArr count] > 0)
        {
            
            NSDictionary *dataDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInteger:SystemInfoStat],kInfoDataType, [systemInfoArr lastObject], kInfoDataValue, nil];
            
            _systemInfoStr = [self generateAppsDataWithDic:dataDic];
            
        }
    }
    
    return _systemInfoStr;
}

/**
 使用情况
 */
- (NSString *)userInfoStrWithDic:(NSDictionary *)dataDic
{
    
    NSString *userInfoStr = nil;
    
    ClientInfoMark infoType = [[dataDic objectForKey:kInfoDataType] integerValue];
    
    if (infoType == AppStartSendDataStat)
    {
        userInfoStr = [self.appStartInfoDic JSONRepresentation];
        
        return userInfoStr;
    }
    
    userInfoStr = [self generateAppsDataWithDic:dataDic];
    
    return userInfoStr;
}

- (NSURL *)remoteInterfaceWithType:(ClientInfoMark)infoType
{
    NSURL *remoteUrl = nil;
    
    switch (infoType) 
    {
        case UserRegisterStat:
            
            remoteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kInfoCollectAddressForHttp, kUserRegisterInfo]];
            
            break;
        case UserOrderNumStat:
            
            remoteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kInfoCollectAddressForHttp, kUserOrderNumInfo]];
            
            break;
        default:
            
            remoteUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@", kInfoCollectAddressForHttp, kClientUseInfo]];
            
            break;
    }
    
    return remoteUrl;
}
 
/**
  根据搜集类型获取数据
 */
- (NSArray *)informationFromTableType:(ClientInfoMark)infoType
{
    
    NSArray *infoArray = nil;
    
    infoArray = [_informationDao clientInformationsWithType:infoType];
    
    return infoArray;
}

#pragma mark -
#pragma mark Data Save
- (void)saveCollectedDataWithDic:(NSDictionary *)dataDic
{
    
#if DEBUG_COLLECT_DATA
    
    @autoreleasepool 
    {
        ClientInfoMark infoType = [(NSNumber *)[dataDic objectForKey:kInfoDataType] integerValue];
        
        InformetionCollectDTO *dto = (InformetionCollectDTO *)[dataDic objectForKey:kInfoDataValue];
        
        [_informationDao insertCollectedInfoWithType:infoType infoData:dto];

    }

    
#else
    
    return;
    
#endif
    
}

#pragma mark -
#pragma mark Data Transfer
- (void)sendDataHttpRequest
{
    
#if DEBUG_COLLECT_DATA
    
    
        NSURL *remoteUrl = nil;
        
        NSString *userInfoStr = nil;
        
        NSString *systemInfoStr = nil;
        
        ClientInfoMark infoType = [[self.collectDataDic objectForKey:kInfoDataType] integerValue];
        
        remoteUrl = [self remoteInterfaceWithType:infoType];
        
        userInfoStr = [self userInfoStrWithDic:self.collectDataDic];
        
        systemInfoStr = self.systemInfoStr;
        
        if (!systemInfoStr || [systemInfoStr isEmptyOrWhitespace]) 
        {
            if (infoType == AppStartSendDataStat) 
            {
                
                [_informationDao clearCollectedInformationData];                    
            }
            
            return;
        }
        
       // DLog(@"The system info is %@ , %@", systemInfoStr,userInfoStr);
        
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:remoteUrl];
        
        request.defaultResponseEncoding = NSUTF8StringEncoding;
        
        [request setPostValue:systemInfoStr forKey:kSystemInfoParamType];
        
        [request setPostValue:userInfoStr forKey:kUserInfoParamType];
        
        [request startSynchronous];
        
        if (infoType == AppStartSendDataStat) 
        {
            
            [_informationDao clearCollectedInformationData];                    
        }
        
//        NSError *error = [request error];
//        
//        if (!error) 
//        {
//            NSString *response = [request responseString];
//            
//            if ([response isEqualToString:@"true"]) 
//            {
//                DLog(@"The response is ok, and the server url is %@", remoteUrl);
//                
//                if (infoType == AppStartSendDataStat) 
//                {
//                    
//                    [_informationDao clearCollectedInformationData];                    
//                }
//
//            }
//        }

    
    
    
#else
    
    return;
    
#endif
    
}

- (NSString *)generateAppsDataWithDic:(NSDictionary *)dataDic
{
    ClientInfoMark infoType = [[dataDic objectForKey:kInfoDataType] integerValue];
    
    InformetionCollectDTO *dto = (InformetionCollectDTO *)[dataDic objectForKey:kInfoDataValue];
    
    NSMutableString *userInfoStr = [NSMutableString stringWithString:@""];
    
    switch (infoType) 
    {
        case SystemInfoStat:
        {
            [userInfoStr appendFormat:@"%@", dto.appVersion?dto.appVersion:@""];
            
            [userInfoStr appendFormat:@"|%@", dto.sysKind?dto.sysKind:@""];
            
            [userInfoStr appendFormat:@"|%@", dto.osVersion?dto.osVersion:@""];
            
            [userInfoStr appendFormat:@"|%@", dto.platform?dto.platform:@""];
            
            [userInfoStr appendFormat:@"|%@", dto.uniqueId?dto.uniqueId:@""];
            
            [userInfoStr appendFormat:@"|%@", dto.appDownWay?dto.appDownWay:@""];
            
            [userInfoStr appendFormat:@"|%@", dto.userIP?dto.userIP:@""];

            [userInfoStr appendFormat:@"|%@", dto.sessionId?dto.sessionId:@""];
            
            [userInfoStr appendFormat:@"|%@", !IsStrEmpty([Config currentConfig].locationCity)?[Config currentConfig].locationCity:L(@"NanjingCity")];

            [userInfoStr appendFormat:@"|%@", L(@"Others")];
            
            break;
        }
        case IphoneUsingStat:
        {
            [userInfoStr appendFormat:@"%@",dto.isLogin?dto.isLogin:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.loginName?dto.loginName:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.appStartTime?dto.appStartTime:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.appStopTime?dto.appStopTime:@""];
            
            break;
        }
        case UserRegisterStat:
        {
            [userInfoStr appendFormat:@"%@",dto.isLogin?dto.isLogin:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.loginName?dto.loginName:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.registerName?dto.registerName:@""];
            
            break;
        }
        case UserOrderNumStat:
        {
            [userInfoStr appendFormat:@"%@",dto.isLogin?dto.isLogin:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.loginName?dto.loginName:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.orderNum?dto.orderNum:@""];
            
            break;
        }
        case ProductSearchStat:
        {
            [userInfoStr appendFormat:@"%@",dto.isLogin?dto.isLogin:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.loginName?dto.loginName:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.searchKey?dto.searchKey:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.searchResult?dto.searchResult:@""];
            
            break;
        }
        case PageAccessingStat:
        {
            [userInfoStr appendFormat:@"%@",dto.isLogin?dto.isLogin:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.loginName?dto.loginName:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.pageName?dto.pageName:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.pageInTime?dto.pageInTime:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.pageOutTime?dto.pageOutTime:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.pageKey?dto.pageKey:@""];
            
            break;
        }
        case SystemCrashDownStat:
        {
            [userInfoStr appendFormat:@"%@",dto.isLogin?dto.isLogin:@""];
            
            [userInfoStr appendFormat:@"|%@",dto.loginName?dto.loginName:@""];

            NSMutableString *crashLog = nil;
            
            if (!dto.crashInfo) 
            {
                crashLog = [NSMutableString stringWithString:@""];
            }
            else
            {
                crashLog = [NSMutableString stringWithString:dto.crashInfo];
                
                [crashLog replaceOccurrencesOfString:@"|" withString:@"-" options:NSCaseInsensitiveSearch range:NSMakeRange(0, crashLog.length)];
            }
            
            [userInfoStr appendFormat:@"|%@",crashLog];
            
            break;
        }
        default:
            break;
    }
    
    return userInfoStr;
}

@end