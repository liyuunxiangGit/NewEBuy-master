//
//  ReceiveInfoViewController.h
//  SuningEBuy
//
//  Created by  on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "PayFlowService.h"//service
#import "GiftCouponService.h"
#import "AddressInfoListViewController.h"//地址
#import "StoreMentionViewController.h"
#import "ShopCartV2DTO.h"
#import "ShopCartShopDTO.h"
#import "PickerButton.h"
#import "AddressEditViewController.h"
#import "StoreMentionViewController.h"//自提

#import "ProductDetailSubmitService.h"
#import "CheckCodeService.h"


#import "SNReaderViewController.h"
#import "PaymentChooseViewController.h"
#import "keyboardNumberPadReturnTextField.h"

#import "ReceiveInfoProductCell.h"
#import "ReceiveInfoShopRemarkCell.h"
#import "InsendTimeDTO.h"
#import "ReceiveInsendTimeCell.h"

@class ShopCartLogic;

@interface ReceiveInfoViewController : CommonViewController<PayFlowServiceDelegate,
AddressChangeDelegate, GiftCouponServiceDelegate,
PickerButtonDelegate, UITextFieldDelegate, StoreMentionDelegate,ProductDetailSubmitServiceDelegate,CheckCodeServiceDelegate,SNReaderDelegate,PaymentChooseDelegate,ReceiveInfoShopRemarkCellDelegate,ReceiveInsendTimeCellDelegate>
{
    BOOL    isCouponListLoaded;
    BOOL    isLastShipInfoLoaded;
    
    BOOL    isUpfold;
    BOOL    isUpNum;
    
    NSInteger requestAddressTimes;
    NSInteger requestAddressSuccessTimes;
    
    NSInteger invoiceType; // 发票类型:0-普通发票 ； 2-电子发票 ； 5-不开发票
}
//需要传入的字段
@property (nonatomic, copy) NSString *powerFlag;            //节能补贴标识
@property (nonatomic, copy) NSString *deliveryCityCode;     //送货城市id
@property (nonatomic, copy) NSString *deliveryCityName;     //送货城市Name
@property (nonatomic, strong) NSArray *productList;         //购物车商品列表
@property (nonatomic, strong) NSString *totalPriceStr;       //商品总价格的格式化字符串
@property (nonatomic, strong) NSString *shouldPayPrice;       //应该支付的价格
@property (nonatomic, strong) NSString *totalDiscount;        //优惠金额

@property (nonatomic, assign) BOOL      isCOrder;             //C店订单
@property (nonatomic, assign) BOOL      isAllCOrder;             //C店订单

@property (nonatomic, assign) BOOL      canUseEleInvoice;       //是否能使用电子发票
@property (nonatomic, assign) BOOL      eleInvoiceIsDefault;    //电子发票是否可默认

@property (nonatomic, strong) NSString *totalFareStr;       //总运费

@property (nonatomic, strong) NSString *cloudDiamQty;    //云钻数量
@property (nonatomic, strong) NSString *cloudDiamAmt;    //云钻抵现后金额

@property (nonatomic, strong) NSString *invoiceStr;
//service
@property (nonatomic, strong) PayFlowService *payFlowService;
//@property (nonatomic, strong) GiftCouponService *giftCouponService;
//@property (nonatomic, strong) CheckCodeService  *checkCodeService;

//数据源
@property (nonatomic, assign) ShipMode shipMode;
@property (nonatomic, strong) AddressInfoDTO *addressInfo;
@property (nonatomic, strong) StoreInfoDto *storeInfo;
//@property (nonatomic, strong) GiftCouponListView   *giftListView;
//@property (nonatomic, strong) RecommendListView    *recommendView;

//存放地址信息的容器
@property (nonatomic, strong) AddressInfoDTO *addressIterimDto;
@property (nonatomic, strong) StoreInfoDto *storeIterimDto;

//立即结算相关
@property (nonatomic, assign) BOOL  isFromBuyNow;
@property (nonatomic, strong) ShopCartLogic *buyNowLogic;

@property (nonatomic, strong) NSArray *shopCartLogic;

//去结算button
@property (nonatomic, strong) UIButton    *submitBtn;

@property (nonatomic, strong) payFlowDTO    *savePayFlowDto;

@property (nonatomic) BOOL isSubmitOrders;

//订单备注
@property (nonatomic, strong) NSMutableDictionary   *orderRemarkDic;
@property (nonatomic, strong) NSString              *orderRemarkStr;

//送货时间
@property (nonatomic, strong) NSMutableDictionary   *insendTimeDic;

//修改地址后判断是否与刚刚展示地址为同城，若不是，则清除已选券及云钻
@property (nonatomic, strong) NSString *currentCityCode;

//刷新tableView
- (void)reloadTableView;

- (void)calculateProduct:(NSArray *)array;

- (void)chooseInvoiceType:(NSUInteger)type with:(NSString *)invoiceStr;

- (void)selectSendTimeFinished:(InsendTimeType)type withDictionary:(NSMutableDictionary *)dic;

//地址列表选择后调的方法
- (void)saveAddressResult:(BOOL)isSuccess service:(PayFlowService *)service payDTO:(payFlowDTO *)dto errorCode:(NSString *)errorCode;
@end
