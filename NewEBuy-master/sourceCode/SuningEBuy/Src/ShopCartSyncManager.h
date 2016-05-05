//
//  ShopCartSyncManager.h
//  SuningEBuy
//
//  Created by liukun on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShopCartV2DTO.h"
#import "ShopCartLogic.h"

typedef NS_ENUM(NSInteger, ShopCartItemUpdateType) {
    ShopCartItemJustQuery = 0,      //购物车查询
    ShopCartItemUpdateQuantity = 1, //购物车行更新数量
    ShopCartItemUpdateSpecial,      //购物车行更新special
    ShopCartItemUpdateFlag,         //购物车行更新勾选状态
    ShopCartItemDeleteItem,         //删除购物车行
};

/**
 *  购物车同步助手，未登录时使用老逻辑，每次都是全量同步，覆盖服务端。登录后使用新逻辑，采用增量更新，更新任务串行。
 *  @author liukun
 *  @since 2.4.2
 */
@interface ShopCartSyncManager : NSObject

- (instancetype)initWithController:(ShopCartV2ViewController *)object;
/**
 *  加入商品到购物车的同步逻辑
 *
 *  @param product  即将加入购物车的商品dto
 *  @param callBack 加入购物车检查完成后的回调
 *  @param canAdd   是否可以加入购物车
 *  @param errorMsg 不能加入购物车时的报错信息
 */
- (void)addProduct:(DataProductBasic *)product callBack:(void(^)(BOOL canAdd, NSString *errorMsg))callBack;

/**
 *  更改购物车城市后与服务端进行同步
 *
 *  @param cityCode 更改后的城市编码
 */
- (void)modifyCity:(NSString *)cityCode;

/**
 *  更改购物车行项目的勾选状态
 *
 *  @param items 更改了勾选状态的行项目list, 元素均为：ShopCartV2DTO
 */
- (void)modifyCheck:(NSArray *)items;
- (void)modifyCount:(NSArray *)items;
- (void)modifySpecial:(NSArray *)items;
- (void)deleteItems:(NSArray *)items;
- (void)query;
- (void)merge;
- (void)mergeWithLoginWinFlag:(BOOL)isInSettle; //是否是去结算前的合并流程
- (void)cancelSync;

- (id)addRefreshBlock:(void(^)(ShopCartLogic *logic))block;
- (void)removeRefreshObserver:(id)observerBlock;

- (id)addMissedItemEvent:(void(^)(NSString *missItemId))eventBlock;
- (void)removeMissedItemEventObserver:(id)observer;

- (BOOL)isIdle;
- (void)addEventWhenIdle:(dispatch_block_t)event;


- (void)pause;
- (void)resume;

@end
