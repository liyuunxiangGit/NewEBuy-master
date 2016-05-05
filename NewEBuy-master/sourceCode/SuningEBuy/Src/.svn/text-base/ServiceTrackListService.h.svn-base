//
//  ServiceTrackListService.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "LogisticsQueryDTO.h"

#define kMemberCardID    @"memberCardID"
#define kCurrentPage     @"currentPage"

@protocol ServiceTrackListServiceDelegate;

@interface ServiceTrackListService : DataService
{
    BOOL                                isServiceTrackListLoading;
    
    BOOL                                _isLastPage;
    
    int                                 _totalPage;
    int                                 _currentPage;
    
    NSMutableArray                      *_queryResultArray;

    HttpMessage                         *serviceTrackListHttpMsg;
    
    id<ServiceTrackListServiceDelegate> __weak _delegate;
}

@property (nonatomic, assign)  BOOL isLastPage;

@property (nonatomic, assign)  int totalPage;

@property (nonatomic, assign)  int currentPage;

@property (nonatomic, strong)  NSMutableArray *queryResultArray;

@property (nonatomic, weak)  id<ServiceTrackListServiceDelegate> delegate;

- (void)beginGetServiceTrackList:(NSDictionary *)parametersDic __attribute__((deprecated("接口废弃")));

@end


@protocol ServiceTrackListServiceDelegate <NSObject>

@optional

- (void)getServiceTrackListCompleteWithService:(ServiceTrackListService *)service
                                       Result:(BOOL)isSuccess
                                     errorMsg:(NSString *)errorMsg;

@end
