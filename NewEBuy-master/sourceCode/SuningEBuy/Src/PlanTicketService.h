//
//  PlanTicketService.h
//  SuningEBuy
//
//  Created by admin on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header   PlanTicketService.h
 @abstract 
 @version  2.1.6  2012/9/21 Creation by admin
           2.1.7  2012/11/22 Addition by shasha
 */

#import <UIKit/UIKit.h>
#import "PFOrderBasicDTO.h"
@class PlanTicketService;
@class PFOrderDetailDTO;

/*!
 @protocol
 @abstract   PlanTicketOrderDelegate
 @discussion 包含的操作有：
                （1）机票取消订单的回调方法
                （2）机票订单的获取的回调方法。
                （3）获取机票订单详情的回调方法。
 */
@protocol PlanTicketOrderDelegate <NSObject>
@optional
-(void)getPlanTicketService:(PlanTicketService *)service 
                     Result:(BOOL)isSuccess
                     errorMsg:(NSString *)errorMsg;

-(void)getPlanTicketDetailService:(PlanTicketService *)service Result:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

- (void)endCancelOrderComplete:(PlanTicketService *)service Result:(BOOL)isSucces errorMsg:(NSString *)errorMsg;

@end


@interface PlanTicketService : DataService
{
    HttpMessage     *myPlaneTicketMsg;
    HttpMessage     *cancelPlaneTicketMsg;

//    BOOL                 isDataLoaded;
//    NSMutableArray         *orderList;
//    int                    totalCount;
//    int                   currentPage;
//    BOOL                   isLastPage;
}

@property (nonatomic,weak) id  delegate;
@property (nonatomic,assign) BOOL isDataLoaded;
@property (nonatomic,strong) NSMutableArray *orderList;
@property (nonatomic,assign) int totalCount;
@property (nonatomic,assign) int currentPage;
@property (nonatomic,assign) BOOL isLastPage;
@property (nonatomic,assign) int totalPage;

@property (nonatomic,strong) PFOrderDetailDTO *orderDetailDTO;
@property (nonatomic,strong) NSArray *itemList;
/*!
 @method
 @abstract   取消订单
 @discussion 取消订单接口，2.1.7机票新需求，仅等待支付状态订单调用。
 @param      dto：PFOrderBasicDTO  取消订单的信息DTO
 */
- (void)beginCancelPlanOderRequest:(PFOrderBasicDTO *)dto;
- (void)sendPlanOrderrRequest:(NSString *)orderStatus CurrentPage:(NSString *)currentPage;
- (void)sendPlanOrderDetailRequest:(NSMutableDictionary *)postDataDic;

@end
