//
//  OrderCenterService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

/*!
 @header     OrderCenterService
 @abstract   获取各类订单数量以及热销商品信息列表
 @author     wangman
 @version    v1.1 12-09-13 
 */

#import "DataService.h"

#import "OrderStatInfo.h"

/*!
 @protocol     OrderCenterServiceDelegate 
 @abstract     OrderCenterService的一个代理 
 @discussion   获取各类订单数量回调、获取热销商品信息列表回调
 */

@protocol OrderCenterServiceDelegate <NSObject>

@optional

/*!
 @method      orderCenterHttpRequestCompletedWithResult:  isSucccess: errorCode:
 @abstract    获得各类订单数量回调 
 @param       orderStatInfo 订单数量实体 
 @param       isSucess 获取是否成功
 @param       errorCode 错误信息
 */

- (void)orderCenterHttpRequestCompletedWithResult:(OrderStatInfo *)orderStatInfo isSucccess:(BOOL)isSucess errorCode:(NSString *)errorCode;

/*!
 @method      topBannerHttpRequestCompletedWithResult: isSucccess: errorCode:
 @abstract    获得热销商品信息列表后回调
 @param       productList 热销商品信息列表
 @param       isSuccess  获取是否成功 
 @param       errorCode 错误信息
 */
- (void)topBannerHttpRequestCompletedWithResult:(NSArray *)productList isSucccess:(BOOL)isSuccess errorCode:(NSString *)errorCode;

@end

/*!
 @class     OrderCenterService 
 @abstract  各类订单数量、热销商品信息 
 */

@interface OrderCenterService : DataService
{
    HttpMessage                                               *_orderHttpMsg;
    
    id<OrderCenterServiceDelegate>                            __weak _delegate;
    
    OrderStatInfo                                             *_orderStatInfo;
}

@property (nonatomic, weak)id<OrderCenterServiceDelegate>    delegate;

@property (nonatomic, strong)OrderStatInfo                     *orderStatInfo;


/*!
 @method       beginSendOrderHttpRequest
 @abstract     发送订单数量请求   
 */

- (void)beginSendOrderHttpRequest;


@end
