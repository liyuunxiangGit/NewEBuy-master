//
//  NewOrderSnxpressViewController.h
//  SuningEBuy
//
//  Created by xmy on 2/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ServiceDetailService.h"
#import "AllOrderDetailCommonViewController.h"
#import "LogisticCompanyDetailCell.h"
typedef enum{
    
    eOrderCenterDeliveryNew,    //订单中心的送货安装查询
    eHomeDeliveryNew,           //首页的送货安装查询
    eCShopDeliveryNew           //C店送货安装查询
    
} DeliveryInfoStatusNew;

@interface NewOrderSnxpressViewController : AllOrderDetailCommonViewController<ServiceDetailServiceDelegate>
{
    DeliveryInfoStatusNew __statusNew;
    BOOL                  isDetailInfoLoaded;
//    BOOL                  isOrderDetailLogisticsQuery;
}

@property (nonatomic,strong) ServiceDetailService  *serviceDetailServiceNew;

@property (nonatomic,copy) NSString               *salNum;
@property (nonatomic,copy) NSString               *orderId;
@property (nonatomic,copy) NSString               *orderItemId;
@property (nonatomic,copy) NSString               *cShopCode;
@property (nonatomic,strong) NSMutableArray              *deliveryInforArray;
@property (nonatomic, strong) NSString            *showParcel;
@property (nonatomic,assign) BOOL                 isOrderDetailLogisticsQuery;
- (id)initWithStatus:(DeliveryInfoStatusNew)status;


@end
