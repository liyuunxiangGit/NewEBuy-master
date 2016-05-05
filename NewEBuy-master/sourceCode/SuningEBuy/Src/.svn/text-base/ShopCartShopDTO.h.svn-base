//
//  ShopCartShopDTO.h
//  SuningEBuy
//
//  Created by  liukun on 13-10-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import "ShopCartV2DTO.h"

@interface ShopCartShopDTO : BaseHttpDTO <NSCopying, NSCoding>

@property (nonatomic, copy) NSString *shopCode;
@property (nonatomic, copy) NSString *shopName;
@property (nonatomic, strong) NSNumber *shipPrice;          //购物车二所用运费
@property (nonatomic, strong) NSNumber *totalShipPrice;     //购物车一所用运费
@property (nonatomic, strong) NSNumber *limitedAmount;      //自营限制额数，如：满39元免运费中的39
@property (nonatomic, strong) NSMutableArray *itemList; //item of ShopCartShopDTO


- (BOOL)isSuning;   //是否是苏宁自营

+ (instancetype)suningShop;
+ (instancetype)cShopWithShopCode:(NSString *)shopCode
                         shopName:(NSString *)shopName;

//是否已经全选
- (BOOL)isAllSelect;
//是否编辑状态下的商品都已全选
- (BOOL)isEditAllSelect;
//设置为全不选
- (void)unSelectAll;
- (void)unSelectAllWithChangedItems:(NSArray **)items;
//全选
- (void)selectAllWithChangedItems:(NSArray **)items;

//编辑状态下的全选跟全不选
- (void)unSelectEditAllWithChangedItems;
- (void)selectEditAllWithChangedItems;

- (void)encodeForExceptionListFromDic:(NSDictionary *)dic;


- (BOOL)isEditing;
- (void)setEditing:(BOOL)editing;

- (NSArray *)identifierArray;
@end
