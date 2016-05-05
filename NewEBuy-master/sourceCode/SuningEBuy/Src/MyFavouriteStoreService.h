//
//  MyFavouriteStoreService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class MyFavouriteStoreService;

@protocol  MyFavouriteStoreServiceDelegate <NSObject>

- (void)getMyFavouriteStoreList:(MyFavouriteStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end

//我的苏宁接口
@interface MyFavouriteStoreService : DataService
{
    
    HttpMessage *storeListHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *favouriteStoreListArr;

@property (nonatomic, strong) NSMutableArray *goodStoreListArr;

@property (nonatomic, strong) NSMutableArray *allStoreListArr;

@property (nonatomic, weak) id<MyFavouriteStoreServiceDelegate> serviceDelegate;

- (void)getMyFavouriteStoreListWithUserId:(NSString *)userId
                                   cityId:(NSString *)cityId
                                longitude:(NSString *)longitude
                                 latitude:(NSString *)latitude;

@end
