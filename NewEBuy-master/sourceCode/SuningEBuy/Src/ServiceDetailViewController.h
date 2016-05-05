//
//  ServiceDetailViewController.h
//  SuningEMall
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceDetailService.h"
#import "LogisticsQueryDTO.h"

#import "AllOrderDetailCommonViewController.h"

typedef enum{

    eOrderCenterDelivery,//订单中心的送货安装查询，通过订单号查询
    eHomeDelivery,//首页的送货安装查询， 通过销售单号查询
    eShopOrderDelivery//门店的送货安装查询（2013-04-01之后与首页同一接口），通过oms订单号查询

} DeliveryInfoStatus;

@interface ServiceDetailViewController : AllOrderDetailCommonViewController <ServiceDetailServiceDelegate>
{
    NSString              *_salNum;
    NSString              *_orderId;
    NSString              *_orderItemId;

    NSMutableArray        *_deliveryInfoArray;
    NSMutableArray        *_installInforArray;
    
    ServiceDetailService  *_serviceDetailService;
    
    BOOL                  isDetailInfoLoaded;
}
@property (nonatomic,strong) UIView               *backgroundView;

@property (nonatomic,copy) NSString               *salNum;
@property (nonatomic,copy) NSString               *verificationCode;//校验码

@property (nonatomic,copy) NSString               *orderId;

@property (nonatomic,copy) NSString               *orderItemId;

@property (nonatomic,strong) NSMutableArray       *deliveryInfoArray;

@property (nonatomic,strong) NSMutableArray       *installInforArray;

@property (nonatomic,strong) ServiceDetailService  *serviceDetailService;

@property (nonatomic,strong) OrderItemDTO *dtoServiceDetail;

@property (nonatomic, strong) NSMutableArray *orderList;

@property (nonatomic, strong) NewOrderListDTO *orderListDTO;

@property (nonatomic, strong) ProductListDTO *orderProductListDTO;


- (id)initWithStatus:(DeliveryInfoStatus)status;

@end
