//
//  EightBannerADService.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"

@protocol EightBannerADServiceDelegate;

typedef enum{

    eHomeEightBannerType    = 4002,
    eHotSaleAdType          = 4003,
    eNestedAdType           = 4004,
    ePromotionInfoType      = 4005,
    eBookThreeBannerType    = 4006

}EightBannerAdType;

typedef enum {
    BannerAppTypeSuningEBuy = 1,
    BannerAppTypeCaiPiao,
    BannerAppTypeTravel,
    BannerAppTypeYifubao,
    BannerAppTypeRedBaby,
    BannerAppTypeQRCode,        //二维码
}EightBannerAppType;

@interface EightBannerADService : DataService 
{
    HttpMessage                      *topBannerASIHTTPRequest;
    
//    HttpMessage                      *topBannerAdInnerRequest;
    
    id<EightBannerADServiceDelegate> __weak _delegate;
}

@property (nonatomic, weak)   id<EightBannerADServiceDelegate> delegate;

@property (nonatomic, strong)   NSArray *topBannerList;

@property (nonatomic, strong)   NSArray *searchTopAdList;  //add by wangjiaxing
@property (nonatomic, strong)   NSArray *m2DaJuHuiList;  //2.4.1 M2区域大聚会数据

@property (nonatomic, assign)   EightBannerAppType appType; //default is 1

@property (nonatomic, assign)   BOOL isRequestFinished; //default is 1

@property (nonatomic, strong)   NSArray *allAdList; //返回的所有活动，不做筛选

- (void)requestBannerListWithAdType:(EightBannerAdType)type;

//- (void)requestBannerListWithAdId:(NSString *)adId;
@end


@protocol EightBannerADServiceDelegate <NSObject>

@optional
- (void)service:(EightBannerADService *)service requestEightBannerComplete:(BOOL)isSuccess;

//- (void)service:(EightBannerADService *)service requestEightBannerInnerComplete:(BOOL)isSuccess;
@end
