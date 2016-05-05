//
//  ShopOrderDetailService.h
//  SuningEBuy
//
//  Created by xmy on 2/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class ShopOrderDetailService;

@protocol ShopOrderDetailServiceDelegate <NSObject>

- (void)getShopOrderDetail:(ShopOrderDetailService*)service success:(BOOL)isSuccess WithErrorMsg:(NSString*)errorMsg;

@end

@interface ShopOrderDetailService : DataService
{
    HttpMessage *_ShopOrderDetailMsg;

}

@property (nonatomic,assign) id<ShopOrderDetailServiceDelegate>delegate;

@property(nonatomic, strong) NSMutableArray *detailList;


- (void)sendShopOrderDetailRequestWithOmsOrderId:(NSString *)omsOrderId
                              WithOmsOrderItemId:(NSString*)omsOrderItemId
                           WithorderSourceSystem:(NSString*)orderSourceSystem
                                       WithCustNum:(NSString *)custNum;
@end
