//
//  AdModelService.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "HomeTopScrollAdDTO.h"

#define kModel1       1
#define kModel2       2
#define kModel3       3
#define kModel4       4
#define kModel5       5
#define kModel6       6

@protocol AdModelServiceDelegate;

@interface AdModelService : DataService 
{
    HttpMessage                      *adModelASIHttpRequest;
    id<AdModelServiceDelegate>       __weak _delegate;
}

@property (nonatomic, weak)   id<AdModelServiceDelegate> delegate;
@property (nonatomic, strong)   NSArray *innerAdvertiseList;
@property (nonatomic, strong)   NSArray *innerProductList;
@property (nonatomic, strong)   NSArray *innerProductBaseList;
//@property (nonatomic, retain)   NSArray *innerFloorList;//楼层

@property (nonatomic, strong)   HomeTopScrollAdDTO *dto;
- (void)requestModelListWithAdId:(NSString *)adID;

@end


@protocol AdModelServiceDelegate <NSObject>

@optional
- (void)service:(AdModelService *)service getAdModelListComplete:(BOOL)isSuccess;

@end
