//
//  SuningStoreInfoService.h
//  SuningEBuy
//
//  Created by xingxianping on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "StoreDetailInfoDTO.h"
#import "StoreListDTO.h"
#import "NearbySuningDTO.h"
@protocol  SuningStoreInfoServiceDelegate;

@interface SuningStoreInfoService : DataService
{
    HttpMessage *storeListHttpMsg;
    
    HttpMessage *storeInfoHttpMsg;
    
}
@property (nonatomic, strong) NSMutableArray *storeListArr;

@property (nonatomic, strong) NSMutableArray *floorInfoArr;

@property (nonatomic, strong) NSMutableArray *storeServiceArr;

@property (nonatomic, weak) id<SuningStoreInfoServiceDelegate> serviceDelegate;

@property (nonatomic, strong) StoreDetailInfoDTO *storeInfoDTO;

//云信接口，token不用管，直接传空
- (void)getNearBySuningStoreListWithToken:(NSString *)token
                                longitude:(NSString *)longitude
                                 latitude:(NSString *)latitude
                                 cityName:(NSString *)city;


- (void)getSuningStoreDetailInfoWithStoreId:(NSString *)storeId;


//add by gjf 声波活动请求接口
-(void)getVoiceCodeActivity:(NSString *)voicecode;
@end

@protocol SuningStoreInfoServiceDelegate <NSObject>
@optional
- (void)getNearBySuningStoreList:(SuningStoreInfoService *)service
                       isSuccess:(BOOL)isSuccess
                        errorMsg:(NSString *)errorMsg;

- (void)getNearBySuningStoreDetailInfo:(SuningStoreInfoService *)service
                             isSuccess:(BOOL)isSuccess
                              errorMsg:(NSString *)errorMsg;

-(void)getVoiceCodeActivity:(VoiceActiveDTO *)dto;
@end