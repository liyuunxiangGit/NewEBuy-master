//
//  NearStoreService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "SuningStoreDTO.h"

@class NearStoreService;

@protocol  NearStoreServiceDelegate <NSObject>

- (void)getNearestSuningStore:(NearStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end

//身边苏宁首页身边好点service
@interface NearStoreService : DataService
{
    
    HttpMessage *nearStoreHttpMsg;
    
}

@property (nonatomic, strong) SuningStoreDTO *nearStore;

@property (nonatomic, weak) id<NearStoreServiceDelegate> serviceDelegate;

- (void)getNearestSuningStoreWithCityId:(NSString *)cityId longitude:(NSString *)longitude latitude:(NSString *)latitude;

@end
