//
//  ShopCartLogic.h
//  SuningEBuy
//
//  Created by  liukun on 13-10-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartShopDTO.h"
#import "ShopCartV2DTO.h"

@interface ShopCartLogic : NSObject <NSCopying, NSCoding>

@property (nonatomic, strong) NSMutableArray *shopCartList; //items of ShopCartShopDTO
@property (nonatomic, strong) NSNumber *productAllPrice; //总价格
@property (nonatomic, strong) NSNumber *userPayAllPrice; //应付总金额
@property (nonatomic, strong) NSNumber *sunpgkPrice; //阳光包金额
@property (nonatomic, strong) NSNumber *totalDiscount; //折扣价格
@property (nonatomic, strong) NSString *promotionDesc;//促销信息
@property (nonatomic, assign) BOOL inSameCity; //是否在同一个城市

@property (nonatomic, strong) NSString *cityCode;
@property (nonatomic, strong) NSString *cityName;

#pragma mark ----------------------------- init

- (id)initWithCartList:(NSMutableArray *)cartList
       productAllPrice:(NSNumber *)productAllPrice
       userPayAllPrice:(NSNumber *)userPayAllPrice
           sunpgkPrice:(NSNumber *)sunpgkPrice
         totalDiscount:(NSNumber *)totalDiscount
         promotionDesc:(NSString *)promotionDesc
            inSameCity:(BOOL)inSameCity;

#pragma mark ----------------------------- property methods

//是否为空
- (BOOL)isEmpty;

//是否有效的商品列表为空
- (BOOL)isValidItemEmpty;

//所有订单行的合并列表
- (NSArray *)allItemList;

//第一个商品
- (ShopCartV2DTO *)firstItem;

//当前默认送货城市id
- (NSString *)currentDeliveryCity;

//当前默认送货城市
- (void)getDeliveryCityCode:(NSString **)cityCode cityName:(NSString **)cityName;

//已勾选的购物车商品列表
- (NSArray *)checkedCartItemList;

//已勾选的购物车商品数量
- (NSInteger)checkedCartItemCount;

//编辑状态下已勾选的购物车商品数量
- (NSInteger)checkedEditCartItemCount;

//已勾选的购物车列表
- (NSArray *)checkedShopList;

//购物车中店家的订单列表, shopCode为nil或@""，返回苏宁自营列表
- (NSArray *)itemListInShopCartOfShop:(NSString *)shopCode;

//失效的商品
- (NSArray *)invalidItemList;

//购物车中店家DTO, shopCode为nil或@""，返回苏宁自营列表
- (ShopCartShopDTO *)shopDTOInShopCartOfShop:(NSString *)shopCode;

//购物车中店家DTO, 
- (ShopCartShopDTO *)shopDTOInShopCartAtIndex:(NSInteger)index;

//购物车中 商品所对应的 ShopCartV2DTO
- (ShopCartV2DTO *)cartItemInShopCartOfProduct:(DataProductBasic *)product;

//当前购物车商品个数
- (NSInteger)allProductQuantity;

//购物车中已有的商品的商品数量
- (NSInteger)quantityOfProduct:(DataProductBasic *)product;

//所有订单行的数量
- (NSInteger)allCartItemQuantity;

//某一dto占订单行数
- (NSInteger)cartItemQuantityOfDTO:(ShopCartV2DTO *)dto;

//本地计算购物车的商品总价格 (暂时未用，使用接口返回）
- (double)calculateTotalPrice;

//是否有苏宁自营的商品
- (BOOL)hasSuningShop;

//本地检查是否城市相同
- (BOOL)localCheckIsInSameCity;

//是否选中的有苏宁自营的商品
- (BOOL)isSuningChecked;

//是否选中的有C店的商品
- (BOOL)isCShopChecked;

#pragma mark ----------------------------- utils

//判断列表是否是C店订单
+ (BOOL)isCShopOrder:(NSArray *)cartList;

//判断0自营1C店2自营C店同时结算
+ (NSString *)submitType:(NSArray *)cartList;

//枚举商户
- (void)enumerateShopsUsingBlock:(void (^)(ShopCartShopDTO *shop, BOOL *stop))block;

//枚举订单行
- (void)enumerateCartItemsUsingBlock:(void (^)(ShopCartV2DTO *dto, BOOL *stop))block;

#pragma mark ----------------------------- event

//添加一个商品
- (void)addProductToLocalShopCart:(DataProductBasic *)product;

//添加一个商品,是否合并到已有商品
- (void)addProductToLocalShopCart:(DataProductBasic *)product isMerge:(BOOL)isMerge;

//清除已选中的商品
- (void)cleanCheckedCartItems:(NSArray **)cleanedItems;

//清除编辑状态下以选中的商品
- (void)cleanEditCheckedCartItems:(NSArray **)cleanedItems;

//改变抢购商品或单价团商品为普通商品
- (void)changeSpecialItemToNormal:(ShopCartV2DTO *)rushItem changedItem:(ShopCartV2DTO **)item;

//设置为全不选
- (void)unSelectAll;

- (void)unSelectAllWithChangedItems:(NSArray **)items;

//全选
- (void)selectAllWithChangedItems:(NSArray **)items;

//编辑状态下的全选与全部选
- (void)unSelectEditAllWithChangedItems;
- (void)selectEditAllWithChangedItems;

//当前是否全部选择
- (BOOL)isAllSelected;

//是否编辑状态下的商品都已全选
- (BOOL)isEditAllSelect;

//统一城市, 2014/2/11, 未勾选的城市也会更改
- (void)changeAllItemsCity:(NSString *)cityCode cityName:(NSString *)cityName;

//删除某一商品
- (void)deleteItem:(ShopCartV2DTO *)item;

//删除所选无效商品
- (NSArray *)cleanItemsWillDelete;

#pragma mark ----------------------------- cached data

+ (instancetype)cachedLogic;
+ (instancetype)emptyLogic;
+ (void)removeCache;
- (void)saveToCache;

#pragma mark - equalment

- (BOOL)isMatchedIn:(ShopCartLogic *)antherLogic;

@end
