//
//  SearchMtsPromotionDataService.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  促销mts一拖二接口,搜索列表所有可见行进行单行调用

#import "DataService.h"
#import "DataProductBasic.h"

@class SearchMtsPromotionDataService;

@protocol SearchMtsPromotionDataServiceDelegate <NSObject>
- (void)getMtsPromotionCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg service:(SearchMtsPromotionDataService *)service;
@end

@interface SearchMtsPromotionDataService : DataService
{
    HttpMessage *mtsPromotionHttpMsg;
}
@property (nonatomic, weak) DataProductBasic *parentDto;

@property (nonatomic, copy) NSString *productCode; //商品编码

//chupeng 2014-6-27 促销标签
@property (nonatomic, strong)  NSMutableArray *activityInfoArray; //促销活动数组

@property (nonatomic, copy)    NSString        *minPriceOfPromotion; //促销活动最低价,比较得出

@property (nonatomic, assign)  unsigned char            flagOfPromotionImgView; //标识哪几个促销图片需要展示

@property (nonatomic, assign)  BOOL            iSdaJuHui;

//大聚惠
//- (void)beginGetMtsPromotionInfoWithProductID:productid productCode:(NSString *)productCode bigPoloyActivityID:(NSString*)bigActivityID bigPoloyVendor:(NSString *)bigVendor;

//预约
/*
 
预约商品：http://search.suning.com/%E9%AD%85%E6%97%8Fmx4/cityId=9173&sc=0&ci=20002&st=0&il=0&iy=-1
 
预约信息请求链接：http://m.suning.com/mts-web/spfs/querySalesShow_{productId}_{productNum}_{channelId}_{cityId}_{endDeviceId}_{activityId}_{jchannelId}_{jvendor}.htm?orderInfo=  (http://m.suning.com/mts-web/spfs/querySalesShow_{productId}_{productNum}_{channelId}_{cityId}_{endDeviceId}_{activityId}_{jchannelId}_{jvendor}.htm?orderInfo=%C2%A0)
*/
- (void)beginGetMtsPromotionInfoWithProductID:productid productCode:(NSString *)productCode bigPoloyActivityID:(NSString*)bigActivityID bigPoloyVendor:(NSString *)bigVendor orderInfo:(NSString *)orderinfo;


- (void)cancelRequest;
@end
