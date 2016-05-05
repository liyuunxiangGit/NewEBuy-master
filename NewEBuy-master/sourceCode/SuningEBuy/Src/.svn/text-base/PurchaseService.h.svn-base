//
//  PurchaseService.h
//  SuningEBuy
//
//  Created by  on 12-9-17.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      PurchaseService
 @abstract    获取抢购列表和团购列表的service
 @author      刘坤
 @version     v1.0.001  12-9-17
 */

#import "DataService.h"
#import "PurchaseConstant.h"
#import "PanicPurchaseDTO.h"
#import "GroupPurchaseDTO.h"

typedef enum {
    PanicChannelB2C = 1,
    PanicChannelMobile = 2,
    PanicChannelReadBaby = 3,
}PanicChannel;

@protocol PurchaseServiceDelegate <NSObject>

@optional
/*!
 @abstract      获取抢购列表完成之后的回调方法
 @param         isSuccess  是否请求成功
 @param         errorMsg  失败的错误信息
 @param         list  成功时返回的抢购商品列表
 */
- (void)getPanicPurchaseListCompletionWithResult:(BOOL)isSuccess 
                                        errorMsg:(NSString *)errorMsg 
                                       panicList:(NSArray *)list;

/*!
 @abstract      获取团购列表完成之后的回调方法
 @param         isSuccess  是否请求成功
 @param         errorMsg  失败的错误信息
 @param         list  成功时返回的团购商品列表
 */
- (void)getGroupPurchaseListCompletionWithResult:(BOOL)isSuccess 
                                        errorMsg:(NSString *)errorMsg 
                                       groupList:(NSArray *)list;

/*!
 @abstract      获取抢购商品详情完成之后的回调方法
 @param         isSuccess  是否请求成功
 @param         errorMsg  失败的错误信息
 @param         dto  抢购商品详情dto
 */
- (void)getPanicPurchaseDetailCompletionWithResult:(BOOL)isSuccess 
                                          errorMsg:(NSString *)errorMsg 
                               panicPurchaseDetail:(PanicPurchaseDTO *)dto errorCode:(NSString *)errorCode;

/*!
 @abstract      获取抢购资格完成之后的回调方法
 @param         isSuccess  是否请求成功
 @param         errorMsg  失败的错误信息
 @param         flag  标志
 */

- (void)getPanicPurchaseLimitCompletionWithResult:(BOOL)isSuccess errorCode:(NSString *)errorCode  errorMsg:(NSString*)errorMsg flag:(NSString *)flag rushProcessId:(NSString *)rushProcessId;


- (void)getHomeFloorPanicProduct:(BOOL)isSuccess panicPurchaseDetail:(PanicPurchaseDTO *)dto;

@end



@interface PurchaseService : DataService
{
    HttpMessage     *panicHttpMsg;
    HttpMessage     *groupHttpMsg;
    HttpMessage     *panicDetailHttpMsg;
    HttpMessage     *panicLimitHttpMsg;
    HttpMessage     *homeFloorHttpMsg;
}

@property (nonatomic, weak) id<PurchaseServiceDelegate>    delegate;
@property (nonatomic, assign) PanicChannel                              panicChannel;
@property (nonatomic, assign) BOOL                                      isLastPage;


/*!
 @abstract      开始获取抢购列表
 */

- (void)beginGetPanicPurchaseList:(NSString *)cityId actChanId:(NSString *)actChanId pageNumber:(int)pageNumber;

/*!
 @abstract      开始获取抢购商品详情
 */
- (void)beginGetPanicPurchaseDetailList:(NSString *)activityId  cityId:(NSString *)cityId;


/*!
 @abstract      开始获取抢购资格
 */

-(void)beginGetPanicPurchaseLimitList:(NSString *)activityId   userId:(NSString *)userId  cityId:(NSString *)cityId;

/*!
 @abstract      开始获取团购列表
 */
- (void)beginGetGroupPurchaseList;


- (void)beginGetHomeFloorPanicProduct:(NSString *)cityId;

@end
