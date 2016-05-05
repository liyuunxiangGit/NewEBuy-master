//
//  SNHttpConfig.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-16.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DDLog.h>

typedef NS_ENUM(NSInteger, SNHttpServer) {
    SNHttpServerSit,
    SNHttpServerPre,
    SNHttpServerPrd
};

static int ddLogLevel;

static NSString *commerceHost;
static NSString *commerceSSLHost;
static NSString *htmlHost;      //伪静态

static inline void SNHttpBaseUrlInits(SNHttpServer serverType);
static inline void SNHttpBaseUrlInits(SNHttpServer serverType)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        if (serverType == SNHttpServerSit)
        {
            commerceHost = @"http://b2csit.cnsuning.com/webapp/wcs/stores/servlet";
            commerceSSLHost = @"https://b2csit.cnsuning.com/webapp/wcs/stores/servlet";
            htmlHost = @"http://b2csit.cnsuning.com/emall";
        }
        else if (serverType == SNHttpServerPre)
        {
            commerceHost = @"http://b2cpre.cnsuning.com/webapp/wcs/stores/servlet";
            commerceSSLHost = @"https://b2cpre.cnsuning.com/webapp/wcs/stores/servlet";
            htmlHost = @"http://b2cpre.cnsuning.com/emall";
        }
        else if (serverType == SNHttpServerPrd)
        {
            commerceHost = @"http://www.suning.com/webapp/wcs/stores/servlet";
            commerceSSLHost = @"https://www.suning.com/webapp/wcs/stores/servlet";
            htmlHost = @"http://www.suning.com/emall";
        }
    });
}

static inline void SNHttpClientLogSwith(BOOL isOn)
{
    if (isOn) {
        ddLogLevel = LOG_LEVEL_VERBOSE;
    }else{
        ddLogLevel = LOG_LEVEL_ERROR;
    }
}

#pragma mark ----------------------------- constant

#define kSuningStoreKey             @"storeId"
#define kSuningStoreValue           @"10052"
