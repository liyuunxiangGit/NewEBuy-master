//
//  NOrderListViewController.h
//  SuningEBuy
//
//  Created by david on 13-11-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "NOrderListService.h"
#import "OrderDetailService.h"
#import "ServiceDetailService.h"
#import "SecondPayService.h"
#import "OrderDetailViewController.h"
#import "PaymentModeViewController.h"
#import "ReturnGoodsApplicationService.h"
#import "MemberOrderNamesDTO.h"
#import "MemberOrderDetailsDTO.h"
#import "OrderSelectDownViewController.h"



@interface NOrderListViewController : PageRefreshTableViewController<NOrderListServiceDelegate,ServiceDetailServiceDelegate,SecondPayServiceDelegate,OrderDetailServiceDelegate,ReturnGoodsApplicationServiceDelegate,OrderSelectDownDelegate>{
    
    BOOL isLoadOk;
    
    UIButton *_btn;
    
//    int proNum ;

}

@property(nonatomic,strong) NSMutableArray  *orderList;
@property(nonatomic,copy)   NSString        *orderStatus;
@property(nonatomic,copy)   NSString        *timeRange;
@property(nonatomic,assign) OrderListType   orderListType;
@property(nonatomic,strong) NOrderListService   *service;

//xmy
@property(nonatomic, assign)OrderListType          listType;

@property(nonatomic, strong) SecondPayService      *secondPayService;

@property(nonatomic, strong) OrderDetailService    *detailService;

@property (nonatomic,strong) ServiceDetailService  *serviceDetailService;

@property (nonatomic, strong) NSString             *orderItemId;//选中商品行id

@property (nonatomic, strong) NSString             *orderId;//选中商品id

@property (nonatomic,strong) NSString              *supplierCode;

@property (nonatomic,strong) NSString              *supplierName;

@property(nonatomic, strong) NSArray               *orderDetailDisplayLists;

//@property (nonatomic ,strong)ReturnGoodsApplicationService *cancelOrderService;//货到付款
@property (nonatomic)BOOL isReturn;//是否是货到付款商品

@property (nonatomic,strong)MemberOrderDetailsDTO        *secondDto;
@property(nonatomic, strong) NSMutableArray                     *CSLists;
@property(nonatomic, strong) NSArray                     *detailHeadLists;//详情head
@property(nonatomic) BOOL                                isGetDetailData;
@property(nonatomic,strong) NSIndexPath                  *selectIndexPath;
@property(nonatomic) BOOL                                isCancelorderDetail;//点击的是否是取消订单
@property(nonatomic) BOOL                                isSecondPayDetail;//点击的是否是支付按钮

// xmy 2013-11-21
@property (nonatomic,strong) UIView                      *headView;//下拉框背景
@property (nonatomic,strong) OrderSelectDownViewController                       *orderSelectDownVC;//下拉弹出界面
@property (nonatomic,strong) UIButton                    *orderStytleBtn;//订单类型下拉按钮
@property (nonatomic,strong) UIButton                    *timeBtn;//时间下拉按钮
@property (nonatomic,strong) UILabel                    *alertLbl;

//- (id)initWithOrderType:(OrderListType)orderListType;


@end
