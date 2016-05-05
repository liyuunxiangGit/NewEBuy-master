//
//  ShopSnxpressService.h
//  SuningEBuy
//
//  Created by xmy on 26/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"

@class ShopOrderListService;

@protocol ShopSnxpressServiceDelegate <NSObject>

- (void)getShopSnxpress:(BOOL)isSuccess errorMsg:(NSString *)errorMsg;

@end


@interface ShopSnxpressService : DataService

{
    HttpMessage *_ShopSnxpressMsg;
}

@property (nonatomic, strong)id<ShopSnxpressServiceDelegate>delegate;

@property (nonatomic,strong)  NSMutableArray *deliveryInforArray;

@property (nonatomic,strong)  NSMutableArray *installInforArray;


- (void)sendShopSnxpressRequest:(NSString*)saleNum WithCatalogId:(NSString*)catalogId;


@end
