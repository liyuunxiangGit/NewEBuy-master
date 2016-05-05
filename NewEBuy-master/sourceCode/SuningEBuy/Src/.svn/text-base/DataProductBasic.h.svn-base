//
//  DataProductBasic.h
//  SuningEMall
//
//  Created by zhang xinyan on 11-1-14.
//  Copyright 2011 suning. All rights reserved.
//
/*!
 @header      DataProductBasic
 @abstract    商品信息的dto
 @author      老版EBuy移植过来
 @version     v2.0  12-9-10
 @discussion  1、刘坤12-9-10添加了NSCodeing代理方法中的字段，修复内存泄露
 */

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "SNSwitch.h"

@class SearchMtsPromotionDataService;
typedef enum {
    PackageTypeNormal,
    PackageTypeAccessory,
    PackageTypeSmall,
    PackageTypeXn,
}PackageType;

typedef enum {
    DAJUHUI = 1 << 0,
    Qiang = 1 << 1,
    Tuan  = 1 << 2,
    Quan  = 1 << 3,
    Jiang = 1 << 4,
    YU    = 1 << 5
} SearchPromotionFlag;

@interface DataProductBasic : BaseHttpDTO {
	NSString	*_productCode;
	NSString	*_productId;
	NSString	*_productName;

	NSString	*_cityCode;
    NSString    *_xsection;//added by shasha:12-11 商品四级，送货时间获取精确到区
	NSString    *_imageNum;
	NSString    *_hasStorage;
	NSString    *_canTake;
	NSString    *_isOldToNew;
	NSString    *_hasAnnex;
	NSNumber    *_marketPrice;
	NSNumber    *_suningPrice;
    NSNumber    *_promotionPrice;
    NSNumber    *_itemPrice;
    BOOL        _isOnlyNetPrice;
    
	NSString    *_productFeature;
	NSString    *_packageList;
	NSURL		*_productImageURL;
	NSString	*_shipOffset;
    NSString    *_shipOffSetText;
	
	NSString	*_evaluation;
	
	BOOL		_isLoadMore;
	NSString    *_userId;
	NSNumber	*_price;
	
	NSString    *_collectTime;      //收藏时间
	
	NSString	*_special;

	BOOL		_isSupportCash;
    
    NSInteger    _ProductNum;  //wangjiangbo, 08-15, add apple icon image
    BOOL            _isService;               //是否为阳光包
	NSString        *_serviceProductCode;     //来自阳光包的商品编码
	NSString		*_serviceProductId;

	NSInteger		_sendType;
	NSString		*_invoice;
	
	BOOL			_isProducerSent;
    
    BOOL            _isABook;

    //begin by liukun
    NSString        *colorCurr_;
    NSArray         *colorItemList_;
    NSString        *versionCurr_;
    NSString        *versionDesc_;
    NSArray         *versionItemList_;
    NSArray         *colorVersionMap_;
    /*end by liukun*/
    
    NSString        *_powerFlgOrAmt;//节能补贴金额或者标识，当为false时，非节能补贴，当不为false时，返回节能补贴金额
    
    NSNumber        *_qianggouPrice;//抢购价格 刘坤， 12-9-17
    
    NSString        *_promIcon;
    
    //begin by shangjiafeng
    NSString        *_supplierNum;         //商家数目
    
    NSNumber        *_bestPrice;           //最优价格
    
    NSString        *_inventory;            //苏宁库存  0无货 1有货
    
    NSString        *_allInventory;         //所有库存  0无货 1有货
    //end by shangjiafeng
    
}

@property (nonatomic, copy)     NSString    *partnumber; //商品通码 chupeng 2014-5-9
@property (nonatomic, assign)   BOOL        isTongmaProduct; //是否是通码商品，不是的话图片按老逻辑，是的话按通码逻辑 chupeng
@property (nonatomic, copy)     NSString	*productCode;
@property (nonatomic, copy)     NSString	*productId;
@property (nonatomic, copy)     NSString	*productName;
@property (nonatomic, copy)     NSString	*cityCode;
@property (nonatomic, copy)     NSString    *xsection;
@property (nonatomic, copy)     NSString    *imageNum;
@property (nonatomic, copy)     NSString    *hasStorage;//商品状态,Y：有货,N：无货,Z:暂不销售
@property (nonatomic, copy)     NSString    *canTake;
@property (nonatomic, copy)     NSString    *isOldToNew;
@property (nonatomic, copy)     NSString    *hasAnnex;
@property (nonatomic, strong)   NSNumber    *marketPrice;
@property (nonatomic, strong)   NSNumber    *suningPrice;
@property (nonatomic, strong)   NSNumber    *promotionPrice;//新自营商品价格
@property (nonatomic, strong)   NSNumber    *itemPrice;//新自营图书价格
@property (nonatomic, strong)   NSNumber    *netPrice;
@property (nonatomic, assign)   BOOL        isOnlyNetPrice;
@property (nonatomic, copy)     NSString    *productFeature;
@property (nonatomic, copy)     NSString    *packageList;
@property (nonatomic, copy)     NSString	*shipOffset;
@property (nonatomic, copy)     NSString    *shipOffSetText;//送达时间
@property (nonatomic, strong)   NSURL		*productImageURL;
@property (nonatomic, copy)     NSString	*evaluation;
@property (nonatomic, copy)     NSString    *userId;

@property (nonatomic, assign)   BOOL		isLoadMore;

@property (nonatomic, strong)   NSNumber	*price;

@property (nonatomic, copy)     NSString  *collectTime;

@property (nonatomic, copy)     NSString	*special;

@property (nonatomic, assign)   BOOL		isSupportCash;
//robin
@property (nonatomic, assign)   NSInteger       ProductNum;

@property (nonatomic,assign)    BOOL		isService;
@property (nonatomic,strong)    NSString	*serviceProductCode;
@property (nonatomic,strong)    NSString	*serviceProductId;
@property (nonatomic,assign)    NSInteger	sendType;
@property (nonatomic,strong)    NSString	*invoice;

@property (nonatomic, assign)   BOOL		isProducerSent;

@property (nonatomic, assign)   BOOL      isABook;

@property (nonatomic, copy)     NSString *colorCurr;
@property (nonatomic, strong)   NSArray *colorItemList;
@property (nonatomic, copy)     NSString *versionCurr;
@property (nonatomic, copy)     NSString *versionDesc;
@property (nonatomic, strong)   NSArray *versionItemList;
@property (nonatomic, strong)   NSArray *colorVersionMap;

@property (nonatomic, copy)     NSString *commentCount; //评价
@property (nonatomic, copy)     NSString *advisoryCount;//咨询
@property (nonatomic, copy)     NSString *showOrdeCount;//晒单
@property (nonatomic, strong)   NSString *zixunCount;//咨询总数

@property (nonatomic, copy)     NSString *goodevaluate;
@property (nonatomic, copy)     NSString *midEvaluate;
@property (nonatomic, copy)     NSString *badEvaluate;

@property (nonatomic, copy)     NSString *powerFlgOrAmt;
@property (nonatomic, strong)   NSNumber *qianggouPrice;
@property (nonatomic, strong)   NSNumber *tuangouPrice;

@property (nonatomic, copy)     NSString *quickbuyId;
@property (nonatomic, strong)   NSString *rushProcessId;    //抢购过程ID

@property (nonatomic, copy)     NSString *danjiaGroupId; //xiewei

//刘坤 13/5/6
@property (nonatomic, copy)     NSString *productService;//商品服务
@property (nonatomic, copy)     NSString *saleOrg;//销售组织
@property (nonatomic, assign)   PackageType packageType; //套餐类型
@property (nonatomic, strong)   NSArray *accessoryPackageList;//配件套餐
@property (nonatomic, strong)   NSArray *smallPackageList;//小套餐  DataProductBasic
@property (nonatomic, strong)   NSArray *allAccessoryProductList; //因iPhone版只显示一个列表，故整合配件套餐为一个list;

//lxk 商品数量
@property (nonatomic)           NSUInteger quantity;   // 默认1
//配件套餐中套餐商品的属性
@property (nonatomic, copy)     NSNumber *accessoryPackagePrice;//配件套餐价
@property (nonatomic, copy)     NSString *masocceceId;//配件关系id
@property (nonatomic, assign)   BOOL  isAccessorySelect;//是否选中了配件套餐

//小套餐虚拟商品的属性
@property (nonatomic, copy)     NSNumber *primaryPrice;//小套餐原价
@property (nonatomic, copy)     NSNumber *savePrice;//小套餐为你节省
@property (nonatomic, copy)     NSNumber *smallPackagePrice;//小套餐优惠价

@property (nonatomic, copy)     NSString    *qianggouFlag;//抢购标识  1抢购中   空不处于抢购中
@property (nonatomic, copy)     NSString    *qianggouActId;//抢购活动ID
@property (nonatomic, copy)     NSString    *rushPurChan;   //抢购渠道,1主站，2客户端

@property (nonatomic, copy)     NSString    *bookmarkFlag;
@property (nonatomic, copy)     NSString    *tuangouFlag;
@property (nonatomic, copy)     NSString    *tuangouActId;

@property (nonatomic, copy)     NSString    *promIcon;

@property (nonatomic, copy)     NSString    *favourDesc;

@property (nonatomic, strong)   NSString    *returnCate;    //退货提示语

#pragma mark ----------------------------- C店相关

//尚加锋  use by search
@property (nonatomic, strong)   NSString        *supplierNum;         //商家数目=C店商家总数 + 苏宁
@property (nonatomic, strong)   NSNumber        *bestPrice;           //最优价格
@property (nonatomic, strong)   NSString        *inventory;            //苏宁库存
@property (nonatomic, strong)   NSString        *allInventory;         //所有库存  0无货 1有货

//use by product detail
@property (nonatomic, copy) NSString *shopName;   //商家名称
@property (nonatomic, copy) NSString *shopCode;   //供应商编码 苏宁自营为空，C店为10位
@property (nonatomic, copy) NSString *companyName;   //公司名称;为空时不能进入店铺，反之可以

@property (nonatomic, copy) NSString *shopSize;   //在售商家数量
@property (nonatomic, copy) NSString *shopGrade;  //商家满意度
@property (nonatomic, copy) NSString *serviceSatisfy; //服务满意度
@property (nonatomic, copy) NSString *deliverSpeed;  //物流满意度
@property (nonatomic, copy) NSString *sellerSpeed;   //发货及时性
@property (nonatomic, copy) NSString *fare;          //运费 苏宁自营为“免运费” C店为具体数字
@property (nonatomic, assign) BOOL isCShop;       //是否是C店 0 苏宁自营  1 C店

//xmy 2013-10-17
@property (nonatomic, assign) BOOL factorySendFlag;       //0  非厂送   1 厂送 苏宁自营
@property (nonatomic, assign) BOOL isPublished;       //是否上下架   false 下架  true 上架

@property (nonatomic, strong) NSString *thirdCategoryId;    //三级销售目录id
@property (nonatomic, strong) NSString *catentryIds;        //商品组id
@property (nonatomic, strong) NSString *vendorCode;         //A类供应商编码
@property (nonatomic, strong) NSString *vendorName;         //A类供应商名称

//chupeng 2014-5-28
@property (nonatomic, copy) NSString *countOfarticle; //评价数量

//chupeng 2014-6-27 促销标签
@property (nonatomic, strong)  NSMutableArray *activityInfoArray; //促销活动数组
@property (nonatomic, copy)    NSString        *minPriceOfPromotion; //促销活动最低价,比较得出
@property (nonatomic, assign)  unsigned char            flagOfPromotionImgView; //标识哪几个促销图片需要展示
@property (nonatomic, assign)    BOOL       iSdaJuHui;         //是否有大聚惠活动

//chupeng 2014-7-24 mts一拖2接口
@property (nonatomic, strong)  SearchMtsPromotionDataService *promotionService;

//大聚惠活动信息
@property (nonatomic, copy) NSString *activityId;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, copy) NSString *vendor;

@property (nonatomic, assign) BOOL      isJuhui;        //该商品是否为大聚惠商品
@property (nonatomic, strong) NSNumber  *juhuiPrice;    //大聚惠商品价格

//预约相关
@property (nonatomic, strong) NSNumber  *appointPrice;  //预约促销价格
@property (nonatomic, strong) NSString  *appointActivityId; //预约活动id
@property (nonatomic, copy) NSString *yuyueOrderInfo;   //预约orderInfo

//s码相关
@property (nonatomic, strong) NSString  *scScodeActivetyId;

@property (nonatomic, assign) BOOL  isRtnNoReason;      //是否支持15天无理由退换货 1：支持；0：不支持

@property (nonatomic, strong) NSString *limitBuyNum;    //每人限购数量

- (void)initData;

//搜索无结果返回数据的解析
- (void)encodeSearchNoResSugProductFromDic:(NSDictionary *)dic;

//搜索结果解析
- (void)encodeSearchResultProductFromDic:(NSDictionary *)dic;

- (void)assembleImageUrl;

//是否有商品簇
- (BOOL)hasClustor;

//是否是套餐商品
- (BOOL)hasPackageList;

//是否有晒单
- (BOOL)hasSunOrder;

//是否正在抢购
- (BOOL)hasQianGouing;

- (int)selectAccessoryProductCount; //选中的套餐商品的数量
- (double)accessoryDiscount;        //套餐商品节省了钱数

- (double)totalPrice;

- (NSArray *)selectedAccessoryList;

//使用mts一拖2接口发送促销请求
- (void)beginGetPromotionInfo;
- (void)cancelPromotionRequest;
@end

/*********************************************************************/

@interface AccessoryPackageDTO : BaseHttpDTO <NSCoding>
{
    
}

@property (nonatomic, copy) NSString *cityCode;
@property (nonatomic, copy) NSString *groupName;
@property (nonatomic, copy) NSString *size;
@property (nonatomic, strong) NSArray *packageList;


@end

@interface SearchPromotionActivityDto : NSObject
@property (nonatomic, copy) NSString *activityTypeId;
@property (nonatomic, copy) NSString *salesPrice;

@end

