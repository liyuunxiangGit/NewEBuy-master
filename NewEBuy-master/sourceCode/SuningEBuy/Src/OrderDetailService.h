//
//  OrderDetailService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//


/*!
 @header     OrderDetailService
 @abstract   订单商品详细信息的获取
 @author     wangman
 @version    v1.1  12-09-12
 */

#import "DataService.h"

#import "MemberOrderNamesDTO.h"

#import "MemberOrderDetailsDTO.h"



/*!
 @protocol       OrderDetailServiceDelegate
 @abstract       OrderDetailService的一个代理
 @discussion     获取订单商品详细信息的回调、取消订单商品的回调
 */

@protocol OrderDetailServiceDelegate <NSObject>
@optional

- (void)orderDeleteOperationCommplete:(NSError *)error;


/*!
 @method   orderDetailDTOHttpRequestCompletedWith:ordeNamesDto:isSucess: errorCode:
 @abstract 获取订单商品详细信息完成回调
 @param    orderDetailList 订单商品详细信息数组
 @param    ordeNamesDto    订单商品信息
 @param    isSuccess    是否成功获取
 @param    errorCode    错误信息
 */

//- (void)orderDetailDTOHttpRequestCompletedWith:(NSArray *)orderDetailList ordeNamesDto:(MemberOrderNamesDTO *)ordeNamesDto isSucess: (BOOL) isSuccess errorCode: (NSString *)errorCode;
- (void)orderDetailDTOHttpRequestCompletedWith:(NSArray *)orderDetailList ordeNamesDto:(MemberOrderNamesDTO *)ordeNamesDto isSucess: (BOOL) isSuccess errorCode: (NSString *)errorCode WithCSList:(NSArray *)CSList WithHeadList:(NSArray*)headList;


/*!
 @method   orderCancelHttpRequestCompletedWith:  sucess:  errcode:
 @abstract 取消订单商品完成回调
 @param    isSuccess    是否成功取消
 @param    errorCode    错误信息
 */
- (void)orderCancelHttpRequestCompletedWith: (BOOL)isSucess errorMsg:(NSString *)errorMsg;

@end

/*!
 @class     OrderDetailService
 @abstract  订单商品详细信息、取消订单
 */

@interface OrderDetailService : DataService
{
    HttpMessage               *_orderDetailHttpMsg;
    
    HttpMessage               *_cancelOrderHttpMsg;
    
    
    MemberOrderNamesDTO       *_orderNamesDto;
    
    NSArray                   *_orderDetailList;
    
    id <OrderDetailServiceDelegate> __weak _delegate;
    
    NSString                  *_isSucess;
    
    
}

@property(nonatomic ,strong)MemberOrderNamesDTO   *orderNamesDto;

@property(nonatomic ,strong)NSArray   *orderDetailList;

@property(nonatomic, weak) id <OrderDetailServiceDelegate> delegate;

@property(nonatomic, strong)    NSString                  *isSucess;

//xmy
@property(nonatomic ,strong)NSArray   *orderDetailCSList;//C店订单明细
@property(nonatomic ,strong)NSArray   *detailHeadList;//详情Head


/*!
 @method       beginSendOrderDetailDTOHttpRequest
 @abstract     发送订单商品详细信息请求
 @param        orderId 订单编号
 */

//-(void)beginSendOrderDetailDTOHttpRequest:(NSString *)orderId;

-(void)beginSendOrderDetailDTOHttpRequest:(NSString *)orderId WithCode:(NSString*)supplierCode;

-(void)beginSendOldOrderDetailDTOHttpRequest:(NSString *)orderId WithCode:(NSString*)supplierCode;

/*!
 @method    beginSendCancelOrderHttpRequest
 @abstract  发送取消订单请求
 @param     userId 用户账号
 @param     orderId 订单编号
 */

-(void)beginSendCancelOrderHttpRequest:(NSString *)userId orderId:(NSString *)orderId;


// 删除订单 xzoscar 2014/08/21 add
- (void)beginRequestDeleteTheOrderWithOrderId:(NSString *)orderId;

@end
