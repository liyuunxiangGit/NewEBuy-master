//
//  PerformanceStatistics.h
//  SuningEBuy
//
//  Created by zl on 14-9-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
//CFAbsoluteTimeGetCurrent()
#define kAppMonitorISwithKey     @"app_monitor_i"
#define kVirtualPaymentKey        @"VirtualPayment_i"
#define kSwitchDetailKey       @"switchDetail"
@interface PerformanceStatisticsData : NSObject
@property(nonatomic,strong)NSDate* startTime;//开始时间
@property(nonatomic,strong)NSDate* endTime;//结束时间
@property(nonatomic,strong)NSString   *distanceTime;//结束时间
@property(nonatomic,assign)BOOL           isSearch;//是否是搜索
@property(nonatomic,copy)NSString        *functionId;//功能模块
@property(nonatomic,copy)NSString        *taskId;//任务
@property(nonatomic,copy)NSString        *interfaceId;//接口
@property(nonatomic,copy)NSString        *startTimeStr;//开始时间
@property(nonatomic,assign)NSUInteger     count;//计数
@end
@interface PerformanceStatisticsHttp : NSObject
@property(nonatomic,strong)NSDate* startTime;//开始时间
@property(nonatomic,copy)NSString* functionId;//功能模块
@property(nonatomic,copy)NSString* interfaceId;//接口
@property(nonatomic,copy)NSString* errorType;//错误
@property(nonatomic,copy)NSString* errorCode;
@property(nonatomic,copy)NSString* url;
@end

@interface PerformanceStatistics : NSObject
@property(nonatomic,strong)NSMutableArray* arrayData;
@property(nonatomic,strong)NSArray * arraySdk;
@property(nonatomic,strong)NSDateFormatter* formatter;
@property(nonatomic,strong)NSDate* startTimeStatus;//开始时间
@property(nonatomic,assign)NSUInteger     countStatus;//计数
+(PerformanceStatistics*)sharePerformanceStatistics;
-(void)sendCustomData:(PerformanceStatisticsData*)aData;
-(void)sendCustomNetData:(PerformanceStatisticsHttp*)aData;
-(void)sendCustomErrorData:(PerformanceStatisticsHttp*)aData;
-(NSString*)getTimer:(NSDate*)aStart end:(NSDate*)aEnd;
-(NSString*)getStartTimer:(NSDate*)aStart;
-(NSArray*)sortArray;
-(void)sendData:(PerformanceStatisticsData*)aData;
-(BOOL)isCountStatus;
-(BOOL)isPaySDK;
-(BOOL)isVirtualPayment;
@end