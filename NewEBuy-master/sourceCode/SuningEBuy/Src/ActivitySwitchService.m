//
//  ActivitySwitchService.m
//  SuningEBuy
//
//  Created by  on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ActivitySwitchService.h"

static BOOL isLoadingSwitchList = NO;

@interface ActivitySwitchService()

- (void)parseSwitchListData:(NSDictionary *)items;

@end

/*********************************************************************/

@implementation ActivitySwitchService

@synthesize delegate = _delegate;

+ (BOOL)isLoadingSwitchList
{
    return isLoadingSwitchList;
}

- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(getSwitchListHttpMsg);
    HTTPMSG_RELEASE_SAFELY(activityActionHttpMsg);
}

#pragma mark -
#pragma mark service life  cycle

- (void)beginGetSwitchList
{
    //兼容外界便捷调用
    
    isLoadingSwitchList = YES;
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue, kHttpRequestHomeStoreKey, nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",
                     kHostAddressForHttp, kHttpRequestSwitchListView];
    
    HTTPMSG_RELEASE_SAFELY(getSwitchListHttpMsg);
    
    getSwitchListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:url
                                                     postDataDic:postDataDic
                                                         cmdCode:CC_GetSwitchList];
    TT_RELEASE_SAFELY(postDataDic);
    getSwitchListHttpMsg.requestMethod=RequestMethodGet;
    getSwitchListHttpMsg.canMultipleConcurrent = YES;
    [self.httpMsgCtrl sendHttpMsg:getSwitchListHttpMsg];
}

/**
 *  获取开关数据
 *
 *  @param version 开关数据版本号
 */
- (void)beginGetSwitchListWithVersion:(NSString *)version {
    isLoadingSwitchList = YES;
    
    //add by zhagnbeibei:20141016 
//    NSDictionary *postDataDic = [[NSDictionary alloc] init];
    
//    NSString *url = [NSString stringWithFormat:@"%@?v=%@",
//                     , version];

    
    HTTPMSG_RELEASE_SAFELY(getSwitchListHttpMsg);
    
    getSwitchListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                      requestUrl:kNewSwitchURL
                                                     postDataDic:@{@"v":version}
                                                         cmdCode:CC_GetSwitchList];
    getSwitchListHttpMsg.requestMethod = RequestMethodGet;
//    TT_RELEASE_SAFELY(postDataDic);
    getSwitchListHttpMsg.canMultipleConcurrent = YES;
    [self.httpMsgCtrl sendHttpMsg:getSwitchListHttpMsg];

}

- (void)beginActivityWithActionName:(NSString *)actionName userId:(NSString *)userId
{
    
    NSDictionary *postDataDic = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 kHttpRequestHomeStoreValue, kHttpRequestHomeStoreKey, 
                                 userId?userId:@"", @"userId",
                                 actionName?actionName:@"", @"actionName",
                                 nil];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostAddressForHttps, [kHttpRequestIssueCouponForActivity passport]];
    
    HTTPMSG_RELEASE_SAFELY(activityActionHttpMsg);
    
    activityActionHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                       requestUrl:url
                                                      postDataDic:postDataDic
                                                          cmdCode:CC_ActivityAction];
    activityActionHttpMsg.canMultipleConcurrent = YES;
    [self.httpMsgCtrl sendHttpMsg:activityActionHttpMsg];
    TT_RELEASE_SAFELY(postDataDic);
}

#pragma mark -
#pragma mark final

- (void)getSwithListFinish:(BOOL)isSuccess map:(NSDictionary *)map
{
    if (_delegate && [_delegate respondsToSelector:@selector(getSwitchListCompletionWithResult:map:)]) {
        [_delegate getSwitchListCompletionWithResult:isSuccess map:map];
    }
    isLoadingSwitchList = NO;
}

- (void)activityActionFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(service:sendActivityActionComplete:)])
    {
        [_delegate service:self sendActivityActionComplete:isSuccess];
    }
    
}

#pragma mark -
#pragma mark http message

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_GetSwitchList) {
        [self getSwithListFinish:NO map:nil];
    }else{
        [self activityActionFinish:NO];
    }
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    if (receiveMsg.cmdCode == CC_GetSwitchList) {
        
        if (receiveMsg.jasonItems) {
            
            [self parseSwitchListData:receiveMsg.jasonItems];
        }else{
            [self getSwithListFinish:NO map:nil];
        }
        
    }else{
        
        if (receiveMsg.jasonItems) {
            NSString *isSuccess = [receiveMsg.jasonItems objectForKey:@"isSuccess"];
            if (NotNilAndNull(isSuccess) && [isSuccess isEqualToString:@"1"]) {
                [self activityActionFinish:YES];
            }else{
                self.errorMsg = L(@"Failed");
                [self activityActionFinish:NO];
            }
        }else{
            self.errorMsg = kHttpResponseJSONValueFailError;
            [self activityActionFinish:NO];
        }
    }
}

- (void)parseSwitchListData:(NSDictionary *)items
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            NSArray *list = [items objectForKey:kHttpResponseSwitchSwitchList];
            
            NSMutableDictionary *retDic = nil;
            if (NotNilAndNull(list) && [list count] > 0) {
                retDic = [[NSMutableDictionary alloc] initWithCapacity:[list count]];
                for (NSDictionary *dic in list){
                    
                    NSString *__switchName = EncodeStringFromDic(dic, kHttpResponseSwitchSwitchName);
                    NSString *__switchValue = EncodeStringFromDic(dic, kHttpResponseSwitchSwitchValue);
                    NSString *__switchDetail = EncodeStringFromDic(dic, @"switchDetail");
                    
                    if (__switchName.length > 0)
                    {
                        /*liukun modify at 12-11-16*/
                        /*添加更新内容提示*/
                        /*lixiaokai modify at 13-05-06*/
                        /*添加开机广告到指定页面*/
                        if ([__switchName isEqualToString:@"iPhone"]
                            || [__switchName isEqualToString:@"iPhone_cuxiaotu"]
                            || [__switchName isEqualToString:@"iPhone5_cuxiaotu"]
                            || [__switchName isEqualToString:@"isOpenEppWap"]
                            || [__switchName isEqualToString:@"ON_Coupon"]
                            || [__switchName isEqualToString:@"sharePromote_ios"]
                            || [__switchName isEqualToString:@"wdyglqxs"]
                            || [__switchName isEqualToString:@"lqxrhbtk"]
                            || [__switchName isEqualToString:@"wdygyqxs"]
                            // 244 cpa&cps 新开关老开关弃用
                            || [__switchName isEqualToString:@"shouyexinrenios"]
                            || [__switchName isEqualToString:@"yaoqinghaoyouios"]
                            || [__switchName isEqualToString:@"lingquhongbaoios"]
                            
                            || [__switchName isEqualToString:@"HomeBtIOSList236"]
                            // HomeBtIOSList237,qdtyao 2014-04-15 add ,XZoscar
                            || [__switchName isEqualToString:@"HomeBtIOSList237"]
                            || [__switchName isEqualToString:@"qdtyao"]
                            ||[__switchName isEqualToString:@"payment_i"]
                            ||[__switchName isEqualToString:@"soundsdkIOS"]
                            // 242 声波后台逻辑 add by gjf
                            ||[__switchName isEqualToString:@"storeSoundIOS"]
                            ||[__switchName isEqualToString:@"InternetAccount"]
                            ||[__switchName isEqualToString:@"precash"]
                            ||[__switchName isEqualToString:@"reserve"]
                            ||[__switchName isEqualToString:@"sscxkg"]
                            ||[__switchName isEqualToString:@"isneedcustom"]
                            ||[__switchName isEqualToString:@"isneedcuxiao"]
                            // 2.4.1 M2大聚会 2014年07月10日09:35:45 Joe
                            ||[__switchName isEqualToString:@"isneedM2I"]
                            ||[__switchName isEqualToString:@"isneedjuhui"]
                            ||[__switchName isEqualToString:@"Gray_Ios"]
                            ||[__switchName isEqualToString:@"app_monitor_i"]
                            ||[__switchName isEqualToString:@"VirtualPayment_i"])
                            
                        {
                            
                            [retDic setObject:dic forKey:__switchName];
                            
                        }
                        //支付方式的值放在switchContent里面
                        else if ([__switchName isEqualToString:@"OnlinePayment"] &&
                                 __switchDetail.length)
                        {
                            [retDic setObject:__switchDetail forKey:__switchName];
                        }
                        else if ([__switchName isEqualToString:@"OnlinePayment_i"] &&
                                 __switchDetail.length)
                        {
                            [retDic setObject:__switchDetail forKey:__switchName];
                        }

                        else if (__switchValue.length)
                        {
                            [retDic setObject:__switchValue forKey:__switchName];

                        }
                        
                    }
                }
            }
            
            /*test*/
            /*
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                                 @"iPhone", @"switchName",
                                 @"2.1.7", @"switchValue",
                                 @"版本更新", @"switchTitle",
                                 @"更新说明", @"switchContent",
                                 @"1、大量sdk几个老师死定了空间<br />2、大陆上看见个哦isdlkg<br />3、都拉开始监管力度<br />4、大力考生及管理科文件为李光洁了深刻咖喱看色戒<br />5、大量开始交给几位数来看能够诶我", @"switchDetail",
                                  nil];
            [retDic setObject:dic forKey:@"iPhone"];
            */
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getSwithListFinish:YES map:retDic];
            });

            
        }
    });
}

@end
