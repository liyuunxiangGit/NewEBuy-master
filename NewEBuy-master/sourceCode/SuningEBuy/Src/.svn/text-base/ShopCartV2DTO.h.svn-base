//
//  ShopCartV2DTO.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-6.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"
#import "DataProductBasic.h"

typedef NS_ENUM(NSInteger, ShopCartSpecial) {
    ShopCartSpecialNone = 0,
    ShopCartSpecialRush = 1, //抢购
    ShopCartSpecialSimpleGroup = 5, //单价团
    ShopCartSpecialMarket = 7, //大聚会
    ShopCartSpecialMarketEnd = 8,   //大聚惠结束
    ShopCartSpecialZhiJiang = 9,    //直降
};

@interface ShopCartV2DTO : BaseHttpDTO <NSCoding, NSCopying>


@property (nonatomic, copy)   NSString *orderItemId;//订单行项目id
@property (nonatomic, copy)   NSString *catentryId;//商品id
@property (nonatomic, copy)   NSString *partNumber;//商品编码
@property (nonatomic, copy)   NSString *productName;//商品名称
@property (nonatomic, strong) NSNumber *itemPrice;//订单行价格
@property (nonatomic, strong) NSString *quantity;//数量
@property (nonatomic, strong) NSString *editQuantity;//编辑中的数量
@property (nonatomic, assign) PackageType packageType;//套餐类型
@property (nonatomic, copy)   NSString *cityCode;//城市id
@property (nonatomic, copy)   NSString *cityName;//城市名称
@property (nonatomic, assign) BOOL     canTake;//是否支持自提
@property (nonatomic, assign) ShopCartSpecial     special;//是否是抢购商品
@property (nonatomic, assign) BOOL     powerFlag;//是否是节能补贴商品
@property (nonatomic, copy)   NSString *errorDesc;//异常描述
@property (nonatomic, copy)   NSString *saleOrg;//销售组织
@property (nonatomic, strong) NSString *massocceceId;//配件关系ID
@property (nonatomic, assign) BOOL     isChecked;//是否被勾选

@property (strong) NSMutableArray *accessoryPackageList; //配件套餐列表
@property (strong) NSMutableArray *smallPackageList;//小套餐列表
@property (strong) NSMutableArray *xnPackageList;//x元n件

//add by kb
@property (nonatomic, assign) BOOL      isCanntCheck;           //是否可勾选
@property (nonatomic, assign) BOOL      isDeleteItemCheck;      //失效商品列表是否勾选

@property (nonatomic, strong) NSString  *juhuiActiveId;         //大聚惠活动Id
@property (nonatomic, strong) NSString  *limitCount;            //大聚惠限购数量
@property (nonatomic, copy)   NSString  *groupCheckMsg;         //

//是否是主商品内部的商品（配件或小套餐）
@property (nonatomic, assign) BOOL  isInnerProduct;

#pragma mark ----------------------------- C店添加字段
@property (nonatomic, copy) NSString *supplierCode; //供应商编码

#pragma mark ----------------------------- 是否在编辑
@property (nonatomic, assign) BOOL  editing;

/** deleteFlag */
@property (nonatomic, assign) BOOL  deleteFlag;

//从dataProductBasic转换为shopCartDTO
+ (ShopCartV2DTO *)shopCartV2DTOFromProduct:(DataProductBasic *)product;

//是否与另一个购物车行相等
- (BOOL)isEqualToItem:(ShopCartV2DTO *)item;

//与商品详情DTO比较
- (BOOL)isEqualToProduct:(DataProductBasic *)product;

//增加整体数量，用于加入购物车，或删除后合并
- (void)increaseQuantity:(int)count;

//使用product覆盖数量
- (void)cover:(DataProductBasic *)product;

//如果item相等，合并
- (void)mergeFrom:(ShopCartV2DTO *)item;

//总数量
- (NSInteger)totalQuantity;

//总价格
- (double)totalPrice;

//是否是C店
- (BOOL)isCShop;

//改变城市
- (void)changeCity:(NSString *)cityCode cityName:(NSString *)cityName;

//是否全部在编辑状态
- (void)setAllInEditing:(BOOL)editing;
- (BOOL)isAllInEditing;
- (BOOL)hasInEditing;

//是否可以更改数量
- (BOOL)canModifyQuantity;

//更改勾选状态
- (BOOL)modifyCheck:(NSString **)errorMsg;

//是否有错误商品
- (NSString *)recursiveErrorDesc;

- (NSArray *)identifierArray;
@end
