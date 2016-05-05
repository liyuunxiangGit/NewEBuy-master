//
//  StoreInfoService.h
//  SuningEBuy
//
//  Created by  on 12-10-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "StoreInfoDto.h"

@protocol StoreInfoServiceDelegate <NSObject>

@optional
- (void)getShopListCompletionWithResult:(BOOL)isSuccess
                               errorMsg:(NSString *)errorMsg 
                               shopList:(NSArray *)list;

@end


@interface StoreInfoService : DataService
{
    HttpMessage     *getShopsHttpMsg;
}

@property (nonatomic, weak) id<StoreInfoServiceDelegate> delegate;


- (void)beginGetShopListRequest:(NSString *)cityId 
                       distrist:(NSString *)districtId;

@end
