//
//  GBOrderDetailInfoService.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBBaseService.h"

#import "GBOrderInfoDTO.h"

@protocol OrderDetailInfoServiceDelegate <NSObject>

@optional

- (void)getOrderDetailInfoCopleted:(BOOL ) isSuccess orderDetailInfoDTO:(GBOrderInfoDTO *)dto errorMsg:(NSString *)errorMsg;

@end

@interface GBOrderDetailInfoService : GBBaseService
{
    
    HttpMessage  *orderDetailInfoHttpMsg;
    
    GBOrderInfoDTO *_orderInfoDTO;
}

@property (nonatomic ,strong)GBOrderInfoDTO *orderInfoDTO;
@property (nonatomic ,strong) id <OrderDetailInfoServiceDelegate>delegate;

- (void)sendOrderDetailInfoHttpRequest:(GBOrderInfoDTO *)dto;
- (void)getOrderDetailInfoFinished:(BOOL)isSuccess;

- (void)parseDatas:(NSDictionary *)datas;
@end
