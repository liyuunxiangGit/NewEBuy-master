//
//  ShopSearchListService.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "LoadMore.h"
#import "ShopSearchListDTO.h"

@class ShopSearchListService;
@protocol ShopSearchListServiceDelegate <NSObject>

- (void)getShopListCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg service:(ShopSearchListService *)service;

@end

@interface ShopSearchListParamDTO : NSObject
@property (nonatomic, copy) NSString *keyWord; //关键词
@property (nonatomic, copy) NSString *cn;    //城市
@property (nonatomic, copy) NSString *st; //排序方式 默认-0, 销量降序－1，评价降序－2
@property (nonatomic, copy) NSString *cp; //当前页index
@property (nonatomic, copy) NSString *ps; //每页记录数,为空默认为20

@end

@interface ShopSearchListService : DataService <LoadMore>
{
    HttpMessage *shopSearchListHttpMsg;
}

@property (nonatomic, weak) id<ShopSearchListServiceDelegate> delegate;
@property (nonatomic, strong) NSMutableArray *shopList;
@property (nonatomic, strong) ShopSearchListParamDTO *shopSearchParam;
@property (nonatomic, copy)   NSString *resultNumber;           //搜索商品总个数
/*!
 @abstract      开始进行搜索
 @param         shopSearchCondition  封装了搜索需要的所有参数的DTO
 @param         page 请求的页数
 */
- (void)beginGetShopSearchListWithSearchCondition:(ShopSearchListParamDTO *)shopSearchCondition page:(NSInteger)page;

/*!
 @abstract      刷新数据
 @discussion    将service的数据直接作为viewController的数据源时，可以调用该方法进行刷新请求
 @param         shopSearchCondition  封装了搜索需要的所有参数的DTO
 */
- (void)refreshData:(ShopSearchListParamDTO *)shopSearchCondition;

/*!
 @abstract      加载下一页的数据
 @discussion    将service的数据直接作为viewController的数据源时，可以调用该方法进行加载下一页
 @param         searchCondition  封装了搜索需要的所有参数的DTO
 */
- (void)loadMoreData:(ShopSearchListParamDTO *)shopSearchCondition;

@end
