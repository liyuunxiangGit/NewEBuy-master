//
//  ShopCartSyncTask.h
//  SuningEBuy
//
//  Created by liukun on 14-6-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataTask.h"

@interface ShopCartSyncTask : DataTask

/** isMerge */
@property (nonatomic, assign, readonly) BOOL isMerge;

/** result */
@property (strong) NSMutableArray *shopCartItemList;
@property (nonatomic, strong) NSNumber *productAllPrice; //总价格
@property (nonatomic, strong) NSNumber *userPayAllPrice; //应付总金额
@property (nonatomic, strong) NSNumber *sunpgkPrice; //阳光包金额
@property (nonatomic, strong) NSNumber *totalDiscount; //折扣价格
@property (nonatomic, strong) NSString *promotionDesc;
@property (nonatomic, assign) BOOL inSameCity; //是否在同一个城市

- (instancetype)initWithCartList:(NSArray *)cartList
                         isMerge:(BOOL)isMerge
                      isInSettle:(BOOL)isInSettle
                        delegate:(id<BBTaskDelegate>)delegate;

@end
