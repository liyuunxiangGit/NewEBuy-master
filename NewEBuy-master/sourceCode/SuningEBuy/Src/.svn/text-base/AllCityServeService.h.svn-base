//
//  AllCityServeService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-8-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class AllCityServeService;

@protocol  AllCityServeServiceDelegate <NSObject>

- (void)getAllCityServiceList:(AllCityServeService *)service
                    isSuccess:(BOOL)isSuccess
                     errorMsg:(NSString *)errorMsg;

@end

//阳光服务接口
@interface AllCityServeService : DataService
{
    
    HttpMessage *serviceListHttpMsg;
    
}

@property (nonatomic, strong) NSMutableArray *serviceListArr;

@property (nonatomic, weak) id<AllCityServeServiceDelegate> serviceDelegate;

- (void)getAllCityServiceListWithCityId:(NSString *)cityId;

@end
