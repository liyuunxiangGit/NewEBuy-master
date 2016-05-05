//
//  ShopCartV2Service.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
/*!
 @header      ShopCartV2Service.h
 @abstract    购物车service
 @author       liukun
 @version     v1.0  13-5-6
 */


#import "DataService.h"
#import "ShopCartV2DTO.h"
#import "ShopCartShopDTO.h"

@class ShopCartV2Service;

@protocol ShopCartV2ServiceDelegate <NSObject>

@optional
- (void)service:(ShopCartV2Service *)service syncShopCartComplete:(BOOL)isSuccess;
- (void)service:(ShopCartV2Service *)service orderCheckOutComplete:(BOOL)isSuccess;

@end

@interface ShopCartV2Service : DataService
{
    HttpMessage *syncShopCartHttpMsg;
    HttpMessage *orderCheckHttpMsg;
    HttpMessage *buyNowOrderHttpMsg;
}

@property (nonatomic, weak) id <ShopCartV2ServiceDelegate> delegate;

@property (strong) NSMutableArray *shopCartItemList;
@property (nonatomic, strong) NSNumber *productAllPrice; //总价格
@property (nonatomic, strong) NSNumber *userPayAllPrice; //应付总金额
@property (nonatomic, strong) NSNumber *sunpgkPrice; //阳光包金额
@property (nonatomic, strong) NSNumber *totalDiscount; //折扣价格
@property (nonatomic, strong) NSString *promotionDesc;
@property (nonatomic, assign) BOOL inSameCity; //是否在同一个城市

@property (nonatomic, assign) BOOL      canUseEleInvoice;       //是否能使用电子发票
@property (nonatomic, assign) BOOL      eleInvoiceIsDefault;    //电子发票是否可默认

//异常商品列表
@property (nonatomic, strong) NSArray  *exceptionList;
@property (nonatomic, copy)   NSString *powerFlag;
@property (nonatomic, strong) NSArray *cShopExceptionList; //c店的异常商品列表
@property (nonatomic, strong) NSNumber *totalShipPrice; //总运费
@property (nonatomic, assign) BOOL  isCOrder;   //是否是C店订单
@property (nonatomic, assign) BOOL  isallCorder;    //是否全c订单

//异常商品
@property (nonatomic, strong) ShopCartV2DTO *errorItem;
@property (nonatomic, strong) NSArray       *errorItemList;

//同步购物车
- (void)requestSyncShopCart:(NSArray *)cartList isMerge:(BOOL)isMerge;

//同步的检查商品是否能够加入购物车
- (BOOL)checkProductCanAddToShopCartSync:(DataProductBasic *)product
                                quantity:(int)quantity
                                   error:(NSString **)error DEPRECATED_ATTRIBUTE;
//立即购买
- (void)requestBuyNowOrder:(NSArray *)cartList;

//去结算
- (void)requestOrderCheckOut:(NSArray *)cartList;
//新去结算
- (void)requestOrderCheckOutV3:(NSArray *)cartList;

//持久化保存购物车
//- (void)saveShopCartListToCache:(NSArray *)shopCartItemList;
//- (NSArray *)shopCartListFromCache;
//- (NSArray *)unloginShopCartListFromCache;
//- (void)removeUnloginShopCart;//在登录后，合并完成后，清除未登录的购物车。

- (ShopCartV2DTO *)errorItemFromExceptionList:(NSArray *)exceptionList;
- (NSArray *)errorItemsFromExceptionList:(NSArray *)exceptionList;
@end
