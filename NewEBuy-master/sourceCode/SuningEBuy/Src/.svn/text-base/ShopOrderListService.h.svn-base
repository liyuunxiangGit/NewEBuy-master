//
//  ShopOrderListService.h
//  SuningEBuy
//
//  Created by xmy on 24/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"

@class ShopOrderListService;

@protocol ShopOrderListServiceDelegate <NSObject>

- (void)getShopOrderList:(BOOL)isSuccess
               errorCode:(NSString *)errorCode
             WithService:(ShopOrderListService *)service;

@end


//typedef enum{
//    ShopOrderAll = 0,       //全部订单
//	ShopOrderPayed ,        //已支付订单
//    ShopOrderDelivery,      //发货处理中订单
//	ShopOrderCanceled,      //已取消订单
//    ShopOrderReturned      //退货成功订单
//} ShopOrderListType;
//

typedef enum{
    ShopOrderAll = 0       //全部订单
} ShopOrderListType;


typedef enum{
	ShopOrderHalfYear = 0,       //近六月
    ShopOrderTimeAll             //全部
} ShopOrderListTime;


@interface ShopOrderListService : DataService
{
    HttpMessage *_ShopOrderListMsg;
    
    NSMutableArray      *_page;
    
    NSMutableArray *_shopOrderList;
    
    SNPageInfo     _pageInfo;

}

@property (nonatomic,retain) NSMutableArray *shopOrderList;
@property (nonatomic,assign) id<ShopOrderListServiceDelegate>delegate;
@property(nonatomic, assign) SNPageInfo pageInfo;
@property(nonatomic,assign) BOOL            isLastPage;


- (void)sendShoporderListRequest:(NSString*)currentPage
                        WithTime:(NSString*)time
                       WithCustNum:(NSString*)token
                     orderStatus:(NSString*)orderStatus;

@end
