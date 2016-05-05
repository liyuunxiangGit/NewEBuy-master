//
//  GBOrderListService.h
//  SuningEBuy
//
//  Created by xingxuewei on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "GBOrderInfoDTO.h"
#import "GBBaseService.h"

@protocol GBOrderListServiceDelegate;

@interface GBOrderListService : GBBaseService
{
    HttpMessage *_GBOrderListMsg;
    
    NSMutableArray   *page;
    
    NSMutableArray  *orderList;
    
}

@property (nonatomic, strong)   id<GBOrderListServiceDelegate>  delegate;

- (void)beginGetGBOrderList:(NSInteger )orderState
             withSearchTime:(NSString *)searchTime withCurrentPage:(NSInteger)currentPage;


- (void)parseItems:(NSDictionary *)items;

- (void)parseOrderList:(NSDictionary *)orderListData;

- (void)getGBOrderListFinished:(BOOL)isSuccess;


@end



@protocol GBOrderListServiceDelegate <NSObject>

@optional

- (void)getGBOrderListCompleted:(BOOL)isSuccess orderList:(NSMutableArray *)list page:(NSMutableArray*)page errorMsg:(NSString *)errorMsg;



@end
