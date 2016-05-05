//
//  MobilePayOrderListService.h
//  SuningEBuy
//
//  Created by shasha on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"
#import "MobileQueryDTO.h"
@protocol  MobilePayOrderListServiceDelegate;

@interface MobilePayOrderListService : DataService{
    HttpMessage     *mobilePayOrderListHttpMsg;
}
@property (nonatomic, weak) id  <MobilePayOrderListServiceDelegate>delegate;
@property (nonatomic, strong) NSMutableArray  *orderList;

/*!
 @method
 @abstract        手机充值，手机充值订单记录查询
 @discussion      所有的订单
 */
- (void)beginGetMobilePayOrderListHttpRequest;

@end

@protocol  MobilePayOrderListServiceDelegate<NSObject>

@optional
/*!
 @method
 @abstract        手机充值，手机充值订单记录查询回调方法
 @discussion      所有的订单 
 */
- (void)didGetMobilePayOrderListCompleted:(BOOL)isSuccess 
errorMsg:(NSString *)errorMsg;
@end

