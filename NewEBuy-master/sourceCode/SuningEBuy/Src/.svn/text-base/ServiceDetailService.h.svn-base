//
//  ServiceDetailService.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"

@protocol ServiceDetailServiceDelegate;

@interface ServiceDetailService : DataService
{
    
    HttpMessage                          *serviceDetailHttpMsg;
    
    id<ServiceDetailServiceDelegate>     __weak _delegate;
    
    NSMutableArray                       *_deliveryInforArray;
    NSMutableArray                       *_installInforArray;
}

@property (nonatomic, weak) id<ServiceDetailServiceDelegate> delegate;

@property (nonatomic,strong)  NSMutableArray *deliveryInforArray;

@property (nonatomic,strong)  NSMutableArray *installInforArray;

- (void)beginGetServiceDetailWithSaleNum:(NSString *)saleNum;
- (void)beginGetServiceDetailWithOrderId:(NSString *)orderId 
                             OrderItemId: (NSString *)orderItemId;
- (void)beginGetCShopServiceDetail:(NSString *)orderId
                         cShopCode: (NSString *)cShopCode;
- (void)beginGetShopOrderServiceDetailWithOrderId:(NSString *)orderId
                                      OrderItemId: (NSString *)orderItemId;


@end


@protocol ServiceDetailServiceDelegate <NSObject>

@optional

- (void)getServiceDetailCompleteWithService:(ServiceDetailService *)service
                                     Result:(BOOL)isSuccess
                                   errorMsg:(NSString *)errorMsg;
@end
