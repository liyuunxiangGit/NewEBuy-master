//
//  ShopCartV2ViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ShopCartV2Service.h"
#import "ShopCartItemCell.h"
#import "ShopCartLogic.h"
#import "MyFavoriteService.h"
#import "ProductDetailService.h"
#import "RightSideToolView.h"
#import "InvalidProductViewController.h"
#import "ShopCartSyncManager.h"

@interface ShopCartV2ViewController : CommonViewController
<ShopCartV2ServiceDelegate, ShopCartItemCellDelegate, UINavigationControllerDelegate>

//失效商品数组
@property (nonatomic, strong) NSArray               *invalidItemList;

//包含了数据和一些逻辑属性
@property (nonatomic, strong) ShopCartLogic         *logic;

@property (nonatomic, strong) ShopCartV2Service     *cartService;
@property (nonatomic, strong) MyFavoriteService     *myFavorateService;
@property (nonatomic, strong) ProductDetailService  *pDetailService;
//@property (nonatomic, strong)

/** sync manager */
@property (nonatomic, strong, readonly) ShopCartSyncManager *syncManager;

+ (ShopCartV2ViewController *)sharedShopCart;  //获取当前的购物车

//预检查商品是否能够加入购物车(抢购或单价团用到)
- (BOOL)checkProductCanAddToShopCart:(DataProductBasic *)product errorMsg:(NSString **)errorMsg;

//加入商品到购物车
- (void)addProductToShoppingCart:(DataProductBasic *)product
                 completionBlock:(SNOperationCallBackBlock)block;

//刷新购物车
- (void)refreshShopCartView;

//设置购物车是否可点击
- (void)setSubmitButtonEnable:(BOOL)isEnable;

//去商品详情
- (void)goToProductWithItem:(ShopCartV2DTO *)item;

//更换城市并重新结算
- (void)reOrderCheckOutWithCity:(NSString *)cityCode
                       cityName:(NSString *)cityName
                          logic:(ShopCartLogic *)logic
                       complete:(void(^)(BOOL isSuccess, ShopCartV2Service *service, ShopCartLogic *logic))block;

- (void)removeObserverForOrderCheckOut;

//以后购买
- (void)addItemToFavorite:(ShopCartV2DTO *)item;

@end
