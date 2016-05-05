//
//  SellerInfoService.h
//  SuningEBuy
//
//  Created by xmy on 14/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DataService.h"
#import "SellerListDTO.h"

@class SellerInfoService;
@protocol SellerInfoServiceDelegate <NSObject>

@optional
- (void)service:(SellerInfoService *)service didGetSellerInfoComplete:(BOOL)isSuccess;

@end

@interface SellerInfoService : DataService
{
    HttpMessage     *sellerHttpMessage;
}

@property (nonatomic, weak) id<SellerInfoServiceDelegate> delegate;
@property (nonatomic, strong) NSArray *shopList;
@property (nonatomic, strong)SellerListDTO *sellerDto;


- (void)requestSellerInfoWithProductId:(NSString *)productId
                           productCode:(NSString *)productCode
                              cityCode:(NSString *)cityCode;


@end
