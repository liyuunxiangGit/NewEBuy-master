//
//  NShopOrderDetailViewController.h
//  SuningEBuy
//
//  Created by xmy on 7/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllOrderDetailCommonViewController.h"
#import "ShopOrderDetailService.h"

@interface NShopOrderDetailViewController : AllOrderDetailCommonViewController<ShopOrderDetailServiceDelegate>

@property (nonatomic, strong) NSMutableArray *shopDetailList;

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) NSString *orderItemId;
@property (nonatomic, strong) NSString *orderSourceSystem;

@property (nonatomic, strong) ShopOrderDetailService *detailService;


- (id)initDetailInfo;

@end
