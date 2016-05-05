//
//  SearchListService.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SearchListService
 @abstract    搜索结果列表的service, 提供搜索结果页的数据源
 @author      刘坤
 @version     v2.0  12-10-16
 @discussion  搜索子系统接口重做
 */
#import "DataService.h"
#import "LoadMore.h"
#import "DataProductBasic.h"
#import "SearchFilterDTO.h"
#import "SearchCateDTO.h"
#import "SearchParamDTO.h"
#import "SNSwitch.h"
#import "BrandShopDTO.h"
#import "SugDirDTO.h"

@class SearchListService;

@protocol SearchListServiceDelegate <NSObject>

@optional
/*!
 @abstract      搜索完成的回调方法
 @param         isSuccess  搜索是否成功
 @param         errorMsg 搜索失败时的错误信息
 @param         service  service
 */
- (void)getSearchListCompletionWithResult:(BOOL)isSuccess 
                                 errorMsg:(NSString *)errorMsg 
                                  service:(SearchListService *)service;

/*!
 @abstract      获取搜索无结果推荐商品列表完成的回调方法
 @param         isSuccess  搜索是否成功
 @param         errorMsg 搜索失败时的错误信息
 @param         list    商品列表
 */
- (void)getRecommentHotProductCompletionWithResult:(BOOL)isSuccess 
                                          errorMsg:(NSString *)errorMsg
                                       productList:(NSArray *)list;

/*!
 @abstract      获取搜索无结果推荐商品列表完成的回调方法
 @param         isSuccess  搜索是否成功
 @param         errorMsg 搜索失败时的错误信息
 @param         list    商品列表
 */
- (void)getRecommentHotProductCompletionWithResultForCategoryFilter:(BOOL)isSuccess
                                                           errorMsg:(NSString *)errorMsg
                                                        productList:(NSArray *)list;
@end




@interface SearchListService : DataService <LoadMore>
{
    HttpMessage      *searchListHttpMsg;
    HttpMessage      *noResSugHttpMsg;           // for 关键词搜索无结果场景
    HttpMessage      *noResRecommendMsgForCategory; // for 分类筛选无结果场景
}

@property (nonatomic, weak) id<SearchListServiceDelegate> delegate;

@property (nonatomic, strong) NSMutableArray *productList;      //搜索结果商品列表
@property (nonatomic, strong) NSArray *filterList;              //筛选列表
@property (nonatomic, strong) NSArray *categoryList;            //关键词搜索时，类目列表
@property (nonatomic, copy)   NSString *resultNumber;           //搜索商品总个数
@property (nonatomic, assign) NSInteger showNumber;             //用于展示的商品总个数

@property (nonatomic, assign) BOOL   isJianCi; //当前结果是否是减词结果
@property (nonatomic, copy) NSString *strJianCiKeyWord; //当前结果使用的减词

@property (nonatomic, strong) BrandShopDTO *brandShopDTO;   //品牌旗舰店
@property (nonatomic, strong) NSMutableArray *sugdirsArray;  //常用分类


/*!
 @abstract      开始进行搜索
 @discussion    暂未使用该接口
 @param         searchCondition  封装了搜索需要的所有参数的DTO
 @param         page 请求的页数
 */
- (void)beginGetSearchListWithSearchCondition:(SearchParamDTO *)searchCondition 
                                         page:(NSInteger)page;

/*!
 @abstract      刷新数据
 @discussion    将service的数据直接作为viewController的数据源时，可以调用该方法进行刷新请求
 @param         searchCondition  封装了搜索需要的所有参数的DTO
 */
- (void)refreshData:(SearchParamDTO *)searchCondition;

/*!
 @abstract      加载下一页的数据
 @discussion    将service的数据直接作为viewController的数据源时，可以调用该方法进行加载下一页
 @param         searchCondition  封装了搜索需要的所有参数的DTO
 */
- (void)loadMoreData:(SearchParamDTO *)searchCondition;

/*!
 @abstract      获取推荐商品列表 for 关键词搜索无结果
 */
- (void)beginGetRecommendHotProductListRequest:(NSString*)keyword;

/*!
 @abstract      获取推荐商品列表 for 分类筛选无结果
 @param         categoryID 三级分类id
 */
- (void)beginGetRecommendHotProductListRequestForCategoryFilter:(NSString *)categoryID;

@end
