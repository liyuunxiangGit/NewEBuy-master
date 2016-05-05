//
//  SearchParamDTO.h
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/**
 @header      SearchParamDTO
 @abstract    新搜索接口传参dto
 @author      liukun
 @version     12-10-16 
 @discussion   
 */

#import <Foundation/Foundation.h>
#import "SNSwitch.h"
/**
 @enum      SearchType
 @abstract  搜索的类型，改类型决定了调用什么接口
 */
typedef enum 
{
    SearchTypeKeyword,     //关键词搜索
    SearchTypeCategory_2,  //类目二级搜索
    SearchTypeCategory_3,  //三级类目搜索
    SearchTypeBrand,       //品牌、出版社搜索，2.5级类目搜索
}SearchType;

/**
 @enum      SortType
 @abstract  搜索的排序方式
 */
typedef enum {
    SortTypeDefault = 0,       //默认
//    SortTypeEvaluDown = 0,
//    SortTypeEvaluUp = 1,
    
    SortTypeSalevolume = 2,    //销量
    
    SortTypePriceUp = 4,       //价格
    SortTypePriceDown = 5,      //价格降序
    
    SortTypeEvaluate = 6      //评价 降序
}SortType;

/*!
 @enum      SearchSet
 @abstract  搜索的类型，不同场景类型不同
 */

typedef enum 
{
    SearchSetMix    = 5,  //手机混排搜索
    SearchSetElec   = 6,  //手机电器搜索
    SearchSetBook   = 7,  //手机图书搜索
}SearchSet;

typedef enum : NSUInteger {
    ALL_PRODUCT = 1,              //城市
    ALL_PROMOTION = 1 << 1,     //自营
    QIANG = 1 << 2,  //抢购
    TUAN = 1 << 3, //团购
    QUAN = 1 << 4,          //返券
    JIANG = 1 << 5,          //直降
} SALESPROMOTIONFLAG;

@interface SearchParamDTO : NSObject
{
    SearchType      _searchType;    //搜索类型
    SearchSet       _set;           //requaired
    NSString        *_inventory;    //是否有货， 默认-1全部，0无货， 1有货
    NSString        *_keyword;      //关键词
    NSString        *_cityId;       //城市id
    NSString        *_categoryId;   //类目id
    NSString        *_currentPage;  //当前页，从第0页开始，可用户控制
    NSString        *_pageSize;     //每页返回结果个数，默认20， 可调整
    SortType        _sortType;      //排序方式
    NSMutableDictionary  *_checkedFilters;//当前筛选项
    NSString        *_brand;        //对应品牌， 电器传名称，图书传出版社id
    NSString        *_shopNum  ;         //商家筛选项 -1是全部，1或不传表示苏宁自营
    
}

@property (nonatomic, assign) SearchType searchType;    //required
@property (nonatomic, assign) SearchSet set;            //required
@property (nonatomic, copy)   NSString *inventory;
@property (nonatomic, copy)   NSString *keyword;
@property (nonatomic, copy)   NSString *cityId;
@property (nonatomic, copy)   NSString *categoryId;
@property (nonatomic, copy)   NSString *categoryName;   //三级类目名称，埋点用
@property (nonatomic, copy)   NSString *currentPage;
@property (nonatomic, copy)   NSString *pageSize;
@property (nonatomic, assign) SortType sortType;
@property (nonatomic, strong) NSMutableDictionary *checkedFilters;
@property (nonatomic, copy)   NSString *brand;

@property (nonatomic, copy)   NSString *title;  //可用于搜索结果页面展示的title
@property (nonatomic, copy)   NSString *shopNum;     //商家筛选

@property (nonatomic, copy)   NSString *priceString; //价格区间
@property (nonatomic, copy)   NSString *salesPromotion; //促销活动
@property (nonatomic, assign) SALESPROMOTIONFLAG salesPromotionFlag;

@property (nonatomic, copy)  NSString *brandRecommended; //热销品牌cf
//判断是否进行过自营，有货，分类，筛选等操作
- (BOOL)isCleanSearch;


//同isCleanSearch方法，去掉有货的条件
- (BOOL)isCleanSearchWithoutInventory;

/**
 @abstract      初始化方法
 @param         type  请求类型：关键字、类目二级、类目三级、品牌
 @param         set   搜索类型： 混排、图书
 @result        SolrParamDTO
 */
- (id)initWithSearchType:(SearchType)type set:(SearchSet)set;


/**
 @abstract      初始化方法
 @param         type  请求类型：关键字、类目二级、类目三级、品牌
 @param         set   搜索类型： 混排、图书
 @result        SolrParamDTO
 */
- (void)resetWithSearchType:(SearchType)type set:(SearchSet)set;

/**
 @abstract      打包成postDataDic，便于发送请求
 @result        发送请求需要的参数集
 */
- (NSDictionary *)postDataDictionary;

/**
 @abstract  手动设置cf通过该方法
 @param     cf的值
 */
- (void)setCF:(NSString *)cf;

@end
