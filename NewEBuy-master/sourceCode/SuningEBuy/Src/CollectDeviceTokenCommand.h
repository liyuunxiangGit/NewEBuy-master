//
//  CollectDeviceTokenCommand.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "Command.h"

//本地缓存key
#define kCCDeviceTokenCacheKey              @"sn.remoteNotification.deviceToken"
#define kCCDeviceTokenSendCacheKey          @"sn.remoteNotification.deviceToken.sended"

//#define kCCCityCacheKey                     @"sn.remoteNotification.city"
#define kCCCitySendCacheKey                 @"sn.remoteNotification.city.sended"

#define kCCUserIdCacheKey                   @"sn.remoteNotification.custNum"
#define kCCUserIdSendCacheKey               @"sn.remoteNotification.custNum.sended"

#define kCCSoftVersionSendCacheKey          @"sn.remoteNotification.softVersion.sended"

#define kCCAcceptTypeSendCacheKey          @"sn.remoteNotification.acceptType.sended"

//参数加密盐
#define kCollectTokenParamEncodeSalt        @"sn201209"
//参数加密的key
#define kCollectTokenParamEncodeKey         @"SNPushService"


typedef enum {
    SNRNSuningEBuy      = 1,
    SNRNSuningRedbaby,
    SNRNSuningReader,
    SNRNSuningAppStore,
    SNRNSuningBusiness,
    SNRNSuningLottery,
    SNRNSuningEfubao,
    SNRNSuningSafe,
    SNRNSuningWeather,
    
}SNRNAppId;

@interface CollectDeviceTokenCommand : Command

@property (nonatomic, strong) NSData *deviceToken;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, assign) SNRNAppId appId; //默认suningebuy

- (void)execute;

@end
