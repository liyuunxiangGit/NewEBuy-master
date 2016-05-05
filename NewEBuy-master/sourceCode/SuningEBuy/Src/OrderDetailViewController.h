//
//  OrderDetailViewController.h
//  SuningEBuy
//
//  Created by xmy .
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AllOrderDetailCommonViewController.h"

#import "MemberOrderDetailsDTO.h"

#import "OrderDetailService.h"

//#import "OrderListService.h"

#import "DataProductBasic.h"
#import "ProductDetailSubmitService.h"
#import "SecondPayService.h"

#import "NewOrderStatusCell.h"
#import "NewOrderProInfoCell.h"
//#import "NewDetailDisplayDTO.h"

#import "NOrderListService.h"
#import "ReturnGoodsApplicationService.h"

#import "NewEvalutionService.h"
//#import "EvalutionDetailDTO.h"
#import "EvalutionDTO.h"

#import "OrderAmountCell.h"
//#import "ReturnGoodsApplicationService.h"
//#import "CShopReturnApplicationService.h"
//#import "TESTViewController.h"
@interface OrderDetailViewController : AllOrderDetailCommonViewController
<OrderDetailServiceDelegate,ProductDetailSubmitServiceDelegate,SecondPayServiceDelegate,NewOrderStatusCellDelegate,NewEvalutionServiceDelegate,ReturnGoodsApplicationServiceDelegate,EGOImageViewExDelegate>
{
    
    OrderDetailService       *_service;
    
    NSString                 *_orderId;
    
    UITableView              *_orderDetailTableView;
    
    BOOL                     _isOrderDetailLoaded;
    
    NSArray                  *_orderDetailDisplayLists;
    
    MemberOrderNamesDTO      *_orderNamesDTO;
    
    OrderListType            _listType;
    
    MemberOrderDetailsDTO    *_memberOrderDetailsDTO;
    
    DataProductBasic         *_dataProductBasic;
    
    BOOL                     _isSubmitDisOrder;
    
    NSString                 *_orderItemsId;
    
    NSString                 *_prepayTrueAmount;
    
    BOOL                      _isGetOnlineStatusOk;
    int                       _onlineStatus;
    
    UIWebView                 *_callWebView;
    
    BOOL                      isEvalutionAndShowPhoto;
}

@property(nonatomic, strong) OrderDetailService       *service;

@property(nonatomic, strong) NSString                 *orderId;

@property(nonatomic, strong) UITableView              *orderDetailTableView;

@property(nonatomic, assign) BOOL                     isOrderDetailLoaded;

@property(nonatomic, strong) NSArray                  *orderDetailDisplayLists;

@property(nonatomic, strong) MemberOrderNamesDTO      *orderNamesDTO;

@property(nonatomic, assign) OrderListType            listType;

@property(nonatomic, strong) MemberOrderDetailsDTO    *memberOrderDetailsDTO;

@property(nonatomic, strong) MemberOrderDetailsDTO    *shaiDanDetailsDTO;//晒单


@property(nonatomic, strong) DataProductBasic         *dataProductBasic;

@property(nonatomic, assign) BOOL                     isSubmitDisOrder;

@property(nonatomic, strong) NSString                 *orderItemsId;

@property(nonatomic, strong) NSString                 *prepayTrueAmount;

@property(nonatomic, strong) ProductDetailSubmitService *displayorderService;

@property(nonatomic, strong) SecondPayService         *secondPayService;


//xmy
@property(nonatomic, strong) NSString          *supplierCode;//是否是c店商品 有则为C店商品，反正为自营
@property(nonatomic, strong) NSString          *supplierName;//是否是c店商品 有则为C店商品，反正为自营

@property(nonatomic, strong) NSMutableArray            *CSLists;
@property (nonatomic, strong) NSArray           *CShopLists;
@property(nonatomic, strong) NSString          *orderSt;//列表订单状态
@property(nonatomic, strong) NSArray            *detailHeadLists;//详情head
@property(nonatomic, strong) NewOrderItemListDTO      *itemDTO;
@property(nonatomic, assign) BOOL                     isCShopProduct;

@property (nonatomic)BOOL isReturn;//是否是货到付款商品
@property (nonatomic,strong)MemberOrderDetailsDTO *secondDto;

//2013-11-26
@property (nonatomic, strong) NewEvalutionService       *evalutionService;
@property (nonatomic,strong)EvalutionDetailDTO *evaDetailDto;
@property (nonatomic,strong)EvalutionDTO *dto;

@property (nonatomic,assign)BOOL isFinishAccept;
@property (nonatomic,assign)BOOL isDelivery;
@property (nonatomic, strong) NSMutableArray *orderItemIdArr;
@property (nonatomic,strong) NSMutableDictionary *orderItemIdDic;
//申请退货
//@property (nonatomic, strong) ReturnGoodsApplicationService *applianceService;
//@property (nonatomic, strong) CShopReturnApplicationService *cShopApplianceService;
//@property  (nonatomic, strong) ReturnGoodsPrepareDTO      *prepareDto;
@property  (nonatomic, strong) NSArray                    *reasonList;
@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, strong) NSString *orderRemark;

@property (nonatomic, strong) NSMutableArray              *LogisticsBtnShowArr;

@property (nonatomic, strong) NSMutableDictionary         *LogisticsShowDic;

// 从订单列表 进入详情
@property (nonatomic,assign) BOOL isFromOrderListEntry;

- (id)initWithDTO:(MemberOrderNamesDTO *)dto ;

- (void)secondPay;
- (void)cancelOrder;

@end
