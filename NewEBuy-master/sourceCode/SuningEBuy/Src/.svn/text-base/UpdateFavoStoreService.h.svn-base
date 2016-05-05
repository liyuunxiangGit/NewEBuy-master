//
//  UpdateFavoStoreService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class UpdateFavoStoreService;

@protocol  UpdateFavoStoreServiceDelegate <NSObject>

- (void)updateFavoStore:(UpdateFavoStoreService *)service isSuccess:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end

//添加取消收藏接口
@interface UpdateFavoStoreService : DataService
{
    
    HttpMessage *updateFavoStoreHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *failureStoreStatusList;

@property (nonatomic, weak) id<UpdateFavoStoreServiceDelegate> serviceDelegate;

- (void)updateFavoStoreWithUserId:(NSString *)userId storeStatus:(NSString *)storeStatus;

@end
