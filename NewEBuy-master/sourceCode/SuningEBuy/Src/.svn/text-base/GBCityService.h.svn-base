//
//  GBCityService.h
//  SuningEBuy
//
//  Created by shasha on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBBaseService.h"

typedef enum{
    
    eALLCityType,
    eHotCityType,
    eAllAndHotCityType
    
}CityListType;

@protocol GBCityServiceDelegate ;

@interface GBCityService : GBBaseService{

    HttpMessage    *__allCityListMsg;
    HttpMessage    *__hotCityListMsg;
    HttpMessage    *__allAndHotCityListMsg;

}

@property (nonatomic, strong) NSArray *hotCityList;
@property (nonatomic, strong) NSArray *allCityList;
@property (nonatomic, strong) NSArray *letterList;
@property (nonatomic, strong) id<GBCityServiceDelegate>  delegate;

- (void)beginSendAllCityListHttpRequest;
- (void)beginSendHotCityListHttpRequest;
- (void)beginSendAllAndHotCityListHttpRequest;

@end


@protocol GBCityServiceDelegate <NSObject>

@optional
- (void)didSendAllCityListFinished:(GBCityService *)service isSuccess:(BOOL)isSuccess;
- (void)didSendHotCityListFinished:(GBCityService *)service isSuccess:(BOOL)isSuccess;
- (void)didSendAllAndHotCityListFinished:(GBCityService *)service isSuccess:(BOOL)isSuccess;

@end
