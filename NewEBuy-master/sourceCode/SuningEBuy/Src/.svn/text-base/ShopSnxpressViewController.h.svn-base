//
//  ShopSnxpressViewController.h
//  SuningEBuy
//
//  Created by xmy on 26/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ShopSnxpressService.h"
#import "ServiceDetailService.h"

#import "AllOrderDetailCommonViewController.h"



@interface ShopSnxpressViewController : AllOrderDetailCommonViewController<ShopSnxpressServiceDelegate,ServiceDetailServiceDelegate>
{
    NSString              *_salNum;
    NSString              *_orderId;
    NSString              *_orderItemId;
    
    NSMutableArray        *_deliveryInfoArray;
    NSMutableArray        *_installInforArray;
    
    ShopSnxpressService  *_snxpressService;
    
    BOOL                  isDetailInfoLoaded;
}
@property (nonatomic,strong) ServiceDetailService  *serviceDetailService;

@property (nonatomic,strong) UIView               *backgroundView;

@property (nonatomic,copy) NSString               *salNum;

@property (nonatomic,copy) NSString               *orderId;

@property (nonatomic,copy) NSString               *orderItemId;

@property (nonatomic,strong) NSMutableArray       *deliveryInfoArray;

@property (nonatomic,strong) NSMutableArray       *installInforArray;

@property (nonatomic,strong) ShopSnxpressService  *snxpressService;
@property (nonatomic, strong) ProductListDTO *orderProductListDTO;


@end
