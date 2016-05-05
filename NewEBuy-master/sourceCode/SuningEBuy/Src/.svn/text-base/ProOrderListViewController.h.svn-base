//
//  ProOrderListViewController.h
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"

#import "AllOrderDownSelectViewController.h"
#import "NOrderListService.h"
#import "DataProductBasic.h"
#import "SecondPayService.h"
#import "OrderDetailService.h"
#import "ServiceDetailService.h"
#import "PaymentModeViewController.h"

#import "AllOrderListPageFreshViewController.h"
#import "NewEvalutionService.h"
#import "EvalutionDTO.h"
#import "ProductDetailSubmitService.h"
#import "EvaluationAndDisplayProductPictureViewController.h"
@interface ProOrderListViewController : AllOrderListPageFreshViewController<AllOrderDownSelectViewControllerDelegate,NOrderListServiceDelegate,SecondPayServiceDelegate,ServiceDetailServiceDelegate,OrderDetailServiceDelegate,NewEvalutionServiceDelegate,ProductDetailSubmitServiceDelegate>
{
    BOOL isReturnStatus;
    BOOL isEvalutionAndShowPhoto;//
    
}
/*商品订单*/
@property (nonatomic, strong) NOrderListService *orderListservice;

@property (nonatomic,strong) UILabel *alertLbl;
@property (nonatomic,strong) UIImageView *alertImageV;

@property(nonatomic,strong) NSMutableArray  *orderList;

@property(nonatomic) OrderSelectDownType selectType;

@property(nonatomic,strong) NSIndexPath                  *selectIndexPath;

@property(nonatomic, strong) SecondPayService      *secondPayService;

@property(nonatomic, strong) OrderDetailService    *detailService;

@property (nonatomic,strong) ServiceDetailService  *serviceDetailService;

@property (nonatomic, strong) NSString             *orderItemId;//选中商品行id
@property (nonatomic, strong) NSString             *orderId;//选中商品id
@property (nonatomic,strong) NSString              *supplierCode;
@property(nonatomic) BOOL        isCancelorderDetail;//点击的是否是取消订单
@property(nonatomic) BOOL        isSecondPayDetail;//点击的是否是支付按钮
@property(nonatomic) BOOL        isGetDetailData;
@property(nonatomic, strong) NSMutableArray         *CSLists;
@property(nonatomic, strong) NSArray         *detailHeadLists;//详情head
@property(nonatomic, strong) NSArray         *orderDetailDisplayLists;
@property (nonatomic,strong)MemberOrderDetailsDTO    *secondDto;
@property (nonatomic, strong) NSString *orderStatus;

@property (nonatomic) BOOL clickConfirm;//点击的是否时确认收货按钮
@property (nonatomic) NSInteger selectSection;
@property (nonatomic) NSInteger selectRow;

@property (nonatomic) BOOL      isLoadOrderListData;
@property (nonatomic) NSMutableArray *orderItemIdArr;
@property (nonatomic, strong) NSMutableArray *keyArr;
@property (nonatomic, strong) NSMutableDictionary *orderItemIdDic;
@property (nonatomic, strong) NSString *orderDetailStatus;
@property (nonatomic,assign) NSInteger currentRow;
@property (nonatomic, assign) NSInteger currentSection;

//评价
@property (nonatomic, strong) NewEvalutionService       *evalutionService;
@property (nonatomic,strong)EvalutionDetailDTO *evaDetailDto;
@property (nonatomic,strong)EvalutionDTO *dto;

//晒单
@property(nonatomic, strong) ProductListDTO    *shaiDanDetailsDTO;
@property(nonatomic, strong) ProductDetailSubmitService *displayorderService;
@property(nonatomic, assign) BOOL                     isSubmitDisOrder;
@property (nonatomic,strong)MemberOrderDetailsDTO    *displayorderMemMemberOrderDetailsDTO;

- (id)initWithOrderStatus:(NSString*)str;

@end
