//
//  GBOrderDetailViewController.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "GBOrderInfoDTO.h"
#import "GBOrderDetailInfoService.h"
#import "GBOrderDetailInfoCell.h"
#import "GBOrderDetailDelegate.h"
#import "GBOrderMoreInfoCell.h"
#import "GBGoodsInfoViewController.h"
#import "GBCancelOrderService.h"

#import "AllOrderDetailCommonViewController.h"
#import "GBRefundViewController.h"

@interface GBOrderDetailViewController : AllOrderDetailCommonViewController<OrderDetailInfoServiceDelegate,GBOrderDetailDelegate,GBCancelOrderDelegate>
{
    GBOrderDetailInfoService *service;
    
    GBOrderInfoDTO   *_orderInfo;
    
    GBOrderInfoDTO  *_orderDetailInfo;
    
    GBType   tuanGouType;
    
    GBOrderStatus orderStatus;
    
    BOOL isLoaded;
}
@property (nonatomic,strong) GBOrderDetailInfoService *service;
@property (nonatomic,strong) GBOrderInfoDTO   *orderInfo;
@property (nonatomic,strong) GBOrderInfoDTO   *orderDetailInfo;

@property (nonatomic,strong) UIView *tipsView;
@property (nonatomic,strong) UILabel *tipsLabel;

@property (nonatomic,assign) BOOL     isFormPayPage;

@property (nonatomic,strong) GBCancelOrderService *cancelService;

-(id)initWithOrderInfo:(GBOrderInfoDTO *)dto;

-(void)gotoGroupDetail;
@end
