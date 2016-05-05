//
//  NewOrderListDTO.h
//  SuningEBuy
//
//  Created by xmy on 31/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
//订单信息
@interface NewOrderListDTO : BaseHttpDTO

@property (nonatomic,copy)  NSString     *orderId;          //订单id
@property (nonatomic,copy)  NSString     *prepayAmount;     //订单价格
@property (nonatomic,copy)  NSString     *totalShipPrice;   //订单总运费
@property (nonatomic,copy)  NSString     *lastUpdate;       //下单时间
@property (nonatomic,copy)  NSString     *oiStatus;         //订单状态 ！！！
@property (nonatomic,copy)  NSString     *ormOrder;         //支付类型id

@property (nonatomic,assign)BOOL         canConfirmAccept;  //是否支持确认收货
@property (nonatomic,assign)BOOL         canCheckLogistics; //是否支持查看物流
@property (nonatomic,assign)BOOL         canTwiceBuy;       //是否能够二次购
@property (nonatomic,assign)BOOL         canMerchantOrder;  //是否能取消订单

@property (nonatomic,strong)NSMutableArray *supplierList;   //供应商列表

@property (nonatomic,strong)NSMutableArray *productList;    //商品列表

//因同一订单中自营商品与c店商品可同时存在，则此处的supplierCode与cShopName不能判断是否为c店订单
@property (nonatomic,copy)  NSString        *supplierCode;      //供应商编码
@property (nonatomic,copy)  NSString        *cShopName;         //供应商名称

@property (nonatomic)  BOOL        isCshop;         //是否为C店

@property (nonatomic,assign) BOOL delivetyOK;//是否为已发货订单
@property (nonatomic,assign) BOOL wOrder;//是否为发货处理中订单

@property (nonatomic,copy) NSString *omsStatus;//OMS订单状态
@property (nonatomic,assign) BOOL finishAccept;//收货完成标识
@property (nonatomic,strong) NSString *supplierOrderStatus;//按商家来显示订单状态 ！！！
-(BOOL)canCancelOrderList;
//- (BOOL)canSecondPay;

- (BOOL)isDelivityOK:(NSString*)omsStatusStr;

- (BOOL)isFinishAcceptOK:(BOOL)finish;

@end

//供应商列表信息
@interface OrderSupplierListDTO : BaseHttpDTO

@property (nonatomic,copy)  NSString        *supplierCode;      //供应商编码
@property (nonatomic,copy)  NSString        *cShopName;         //供应商名称
@property (nonatomic,strong)NSMutableArray  *productList;      //商品列表
@property (nonatomic,copy) NSString *omsStatus;//OMS订单状态
@property (nonatomic,assign) BOOL finishAccept;//收货完成标识
@property (nonatomic,assign) BOOL canConfirmAcceptNew;//确认收货标识
@property (nonatomic,strong) NSString *supplierOrderStatus;//商家订单状态


@end

//商品信息
@interface ProductListDTO : BaseHttpDTO

@property (nonatomic,copy) NSString *orderItemId;//订单行id
@property (nonatomic,copy) NSString *productCode;//商品编码
@property (nonatomic,copy) NSString *productId;//商品id
@property (nonatomic,copy) NSString *productName;//商品名称
@property (nonatomic,copy) NSString *quantity;//商品数量
@property (nonatomic,copy) NSString *itemPrice;//商品价格
@property (nonatomic,copy) NSString *supplierCode;//所属供应商
@property (nonatomic,copy) NSString *supplierName;//所属供应商名

@property (nonatomic,copy) NSString *omsStatus;//OMS订单状态
@property (nonatomic,assign) BOOL finishAccept;//收货完成标识
@property (nonatomic,assign) BOOL canConfirmAcceptPro;//确认收货标识
@property (nonatomic,assign) BOOL isShowShopName;//是否显示门店名称 (自添加)
@property (nonatomic,strong) NSString *supplierOrderStatus;//商家订单状态

@property (nonatomic, strong) NSString *isCanComment;//评价
@property (nonatomic, strong) NSString *isCanShow;//晒单
//自行添加字段,在订单列表中条评价晒单页面使用
@property (nonatomic, strong) NSString *lastUpdate;//更新时间
@property (nonatomic, strong) NSString *orderID;//订单ID
@end
