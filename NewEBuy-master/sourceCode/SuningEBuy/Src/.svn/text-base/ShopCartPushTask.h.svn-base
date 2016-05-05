//
//  ShopCartPushTask.h
//  SuningEBuy
//
//  Created by liukun on 14-6-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataTask.h"
#import "ShopCartV2DTO.h"
#import "ShopCartShopDTO.h"
#import "ShopCartPushItem.h"

@interface ShopCartPushTask : DataTask

/** result */
@property (strong) NSMutableArray *shopCartItemList;
@property (nonatomic, strong) NSNumber *productAllPrice; //总价格
@property (nonatomic, strong) NSNumber *userPayAllPrice; //应付总金额
@property (nonatomic, strong) NSNumber *sunpgkPrice; //阳光包金额
@property (nonatomic, strong) NSNumber *totalDiscount; //折扣价格
@property (nonatomic, strong) NSString *promotionDesc;
@property (nonatomic, assign) BOOL inSameCity; //是否在同一个城市

@property (nonatomic, strong) NSString *missItemId; //服务器暂存表中不存在的商品itemId,多个以,分割
/**
 *  初始化方法
 *
 *  @param items    ShopCartPushItem的对象
 *  @param delegate 回调的代理
 *
 *  @return 类的实例
 *
 *  @since 2.4.2
 */
- (instancetype)initWithItems:(NSArray *)items
                     delegate:(id<BBTaskDelegate>)delegate;

@end
