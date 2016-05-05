//
//  ConfirmAcceptService.h
//  SuningEBuy
//
//  Created by xmy on 4/5/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"

@class ConfirmAcceptService;
@protocol ConfirmAcceptServiceDelegate <NSObject>

- (void)ConfirmAcceptServiceComplete:(ConfirmAcceptService*)service WithIsSuccess:(BOOL)isSuccess;

@end

@interface ConfirmAcceptService : DataService
{
    HttpMessage *confirmHttpMsg;
}


@property (nonatomic,strong)id<ConfirmAcceptServiceDelegate>delegate;

@property (nonatomic, strong)NSString *resultStr;
@property (nonatomic, strong)NSString *msgStr;

- (void)sendConfirmAcceptServiceRequest:(NSString*)orderId WithItemId:(NSString*)orderitemIds WithShopCode:(NSString*)cshopVendorCode;

@end
