//
//  PerformanceStatistics.m
//  SuningEBuy
//
//  Created by zl on 14-9-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PerformanceStatistics.h"
#import "CommonViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define KSNmobile     @"SNmobile1"
#define KSNmobileOne  @"SNmobile2"
#define KSNmobileTwo  @"SNmobile3"
#define KSWitchTitle  @"switchTitle"
#define KSWitchValue  @"switchValue"
#define KCreateTime   @"Create_time"
#define KFunctionID   @"Function_ID"
#define KTaskID       @"Task_ID"
#define KInterfaceID  @"Interface_ID"
#define KTaskTime     @"Task_time"
#define KErrorType    @"Error_type"
#define KErrorCode    @"Error_code"
#define KUrl          @"URL"

@implementation PerformanceStatisticsData

@end
@implementation PerformanceStatisticsHttp

@end
@implementation PerformanceStatistics

+(PerformanceStatistics*)sharePerformanceStatistics
{
    static  PerformanceStatistics* performanceStatistics;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        performanceStatistics = [self new];
        
    });

    return performanceStatistics;
}
-(BOOL)isPaySDK
{
    if ([[self.arraySdk safeObjectAtIndex:2] isEqualToString:@"1"])
    {
        return YES;
    }
    else
    {
        return NO;
    }

}
-(BOOL)isVirtualPayment
{
    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if(dic)
    {
        NSDictionary *infoDic = [dic objectForKey:kVirtualPaymentKey];
        if (!infoDic)
        {
            return NO;
        }
        NSString* str = [infoDic objectForKey:kSwitchDetailKey];
        
        if ([str length])
        {
            if (![str hasPrefix:@"EppSdk"])
            {
                return NO;
            }

            NSArray *compents = [str componentsSeparatedByString:@"|"];
            self.arraySdk = compents;
            if ([[self.arraySdk safeObjectAtIndex:1] isEqualToString:@"1"])
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
        else
        {
            return NO;
        }
    }
    return YES;
}

-(BOOL)isCountStatus
{
    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if(dic)
    {
        NSDictionary *infoDic = [dic objectForKey:kAppMonitorISwithKey];
        if (!infoDic)
        {
            return NO;
        }
        NSString* str = [infoDic objectForKey:KSWitchValue];
        if (![str length])
        {
            return NO;
        }
        NSUInteger valueNumber = [str integerValue];
        if (!valueNumber)
        {
            return YES;
        }
    }
    return NO;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        _arrayData = [NSMutableArray new];
        _formatter = [[NSDateFormatter alloc ] init];
        [_formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    }
    return self;
}

-(NSString*)getStartTimer:(NSDate*)aStart
{
    return [[PerformanceStatistics sharePerformanceStatistics].formatter stringFromDate:aStart];
}

-(NSString*)getTimer:(NSDate*)aStart end:(NSDate*)aEnd
{
    NSTimeInterval start = [aStart timeIntervalSince1970];
    NSTimeInterval end = [aEnd timeIntervalSince1970];
    NSTimeInterval cha = end-start;
    NSString* result = [NSString stringWithFormat:@"%.3f",cha];
    return result;
}

-(NSArray*)sortArray
{
    if (![PerformanceStatistics sharePerformanceStatistics].arrayData.count)
    {
        return nil;
    }
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"_distanceTime"
                                                  ascending:YES];
    NSArray *sortedArray = [[PerformanceStatistics sharePerformanceStatistics].arrayData sortedArrayUsingDescriptors:@[sortDescriptor]];
    return sortedArray;
}

-(BOOL)lessAndEqual
{
    NSDictionary *dic = [GlobalDataCenter defaultCenter].activitySwitchMap;
    if(dic)
    {
        NSDictionary *infoDic = [dic objectForKey:kAppMonitorISwithKey];
        if (!infoDic)
        {
            return NO;
        }
        
        NSString* str = [infoDic objectForKey:KSWitchTitle];
        if (![str length])
        {
            return NO;
        }
        
        NSUInteger titleNumber = [str integerValue];
        NSUInteger randNumber = arc4random()%100 + 1;
        if(randNumber < titleNumber)
        {
            return YES;
        }
    }
    return NO;
}

-(void)sendData:(PerformanceStatisticsData*)aData
{
    if (!aData.functionId||!aData.interfaceId||!aData.taskId)
    {
        return;
    }
    aData.startTimeStr = [[PerformanceStatistics sharePerformanceStatistics]getStartTimer:[PerformanceStatistics sharePerformanceStatistics].startTimeStatus];
    aData.distanceTime = [[PerformanceStatistics sharePerformanceStatistics]getTimer:[PerformanceStatistics sharePerformanceStatistics].startTimeStatus end:aData.endTime];
    [[PerformanceStatistics sharePerformanceStatistics]sendCustomData:aData];
}

-(void)sendCustomData:(PerformanceStatisticsData*)aData
{
    if (!IOS6_OR_LATER) {
        return;
    }
    if (!aData.startTimeStr||!aData.functionId||!aData.interfaceId||!aData.taskId||!aData.distanceTime)
    {
        return;
    }

    if ([self lessAndEqual])
    {
        int taskTime = aData.distanceTime.floatValue*1000;
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:aData.startTimeStr,KCreateTime,aData.functionId,KFunctionID,aData.taskId,KTaskID,aData.interfaceId,KInterfaceID,[NSNumber numberWithInt:taskTime],KTaskTime,nil];
        [SSAIOSSNDataCollection Sa_Pf_CustomInfo_Upload:K_BIZ key:KSNmobile value:dic];
    }
}

-(void)sendCustomNetData:(PerformanceStatisticsHttp*)aData
{
    if (!IOS6_OR_LATER) {
        return;
    }
    if (!aData.startTime||!aData.functionId||!aData.interfaceId||!aData.errorType||!aData.errorCode)
    {
        return;
    }

    if ([self lessAndEqual])
    {
        NSString* strTime = [[PerformanceStatistics sharePerformanceStatistics]getStartTimer:aData.startTime];
        if (![strTime  length])
        {
            return;
        }
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:strTime,KCreateTime,aData.functionId,KFunctionID,aData.interfaceId,KInterfaceID,aData.errorType,KErrorType,aData.errorCode,KErrorCode,nil];
        [SSAIOSSNDataCollection Sa_Pf_CustomInfo_Upload:K_BIZ key:KSNmobileOne value:dic];
    }

}

-(void)sendCustomErrorData:(PerformanceStatisticsHttp*)aData
{
    if (!IOS6_OR_LATER) {
        return;
    }
    if (!aData.startTime||!aData.errorCode||!aData.url)
    {
        return;
    }
    if ([self lessAndEqual])
    {
        NSString* strTime = [[PerformanceStatistics sharePerformanceStatistics]getStartTimer:aData.startTime];
        if (![strTime  length])
        {
            return;
        }
        NSDictionary* dic = [NSDictionary dictionaryWithObjectsAndKeys:strTime,KCreateTime,aData.url,KUrl,aData.errorCode,KErrorCode,nil];
        [SSAIOSSNDataCollection Sa_Pf_CustomInfo_Upload:K_BIZ key:KSNmobileTwo value:dic];
    }
}
@end