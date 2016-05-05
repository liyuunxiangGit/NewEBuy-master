//
//  NOrderListService.h
//  SuningEBuy
//
//  Created by david on 13-11-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"

//typedef enum{
//	OrderPayed = 0,     //已支付订单
//	OrderWaitPay,       //等待支付订单
//	OrderCanceled,      //已取消订单
//    OrderReturned,      //已退货订单
//    OrderShippped,      //卖家已发货
//    OrderReceipt        //收货完成
//} OrderListType;

//已支付订单／待支付订单／发货处理中订单/已取消订单／退货成功订单／已发货订单／收货完成订单/全部订单
typedef enum{
    OrderAll = 0,               //全部订单
	OrderPayed ,     //已支付订单
	OrderWaitPay,       //待支付订单
    OrderDelivery,      //发货处理中订单
	OrderCanceled,      //已取消订单
    OrderReturned,      //退货成功订单
    OrderShippped,      //已发货订单
    OrderReceipt        //收货完成
} OrderListType;

typedef enum{
	OrderOneWeek = 0,     //近一周
	OrderOneMonth,       //近六月
    OrderTimeAll             //全部
} OrderListTime;

@protocol NOrderListServiceDelegate;


@interface NOrderListService : DataService{
    
    HttpMessage         *_orderListMsg;
}

@property(nonatomic,assign) OrderListType   *orderListType;
@property(nonatomic,assign) BOOL            isLastPage;
@property(nonatomic,assign) id<NOrderListServiceDelegate>delegate;
@property(nonatomic,strong) NSMutableArray  *orderList;

//获取订单列表
-(void)beginGetOrderListHttpRequest:(NSString*)userId
                        currentPage:(NSString*)currentPage
                        orderStatus:(NSString*)orderStatus
                         selectTime:(NSString*)time;

@end

@protocol NOrderListServiceDelegate <NSObject>

-(void)orderListService:(NOrderListService *)service
              isSuccess:(BOOL)isSuccess;

@end
