//
//  SearchListTopView.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  包含常用分类，品牌旗舰店，SearchSegmentView 的视图

#import <UIKit/UIKit.h>
#import "BrandShopDTO.h"
#import "SugDirDTO.h"
#import "SearchSegmentView.h"
@class  SearchListViewController;

typedef enum
{
    NOVIEW,          //什么都没，减词时候用
    SEGMENTVIEW = 1, //只有一个分段控件
    CATALOG_SEGMENTVIEW = 2,   //分类，分段
    BRAND_SEGMENTVIEW = 3,         //品牌，分段
    BRAND_CATALOG_SEGMENTVIEW = 4  //品牌，分类，分段
}TOPVIEWSTATE;

@protocol SearchListTopViewDelegate <NSObject>
//- (void)searchSegmentDidChangeSortType:(SortType)sort;
- (void)usualCatalogTapped:(NSString *)ci;
- (void)brandShopTapped:(NSString *)url;
@end

@interface SearchListTopView : UIView<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) id<SearchListTopViewDelegate> delegate;
@property (nonatomic, assign) int  State;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *catalogArray;//热销品牌借用了常用分类的数组和dto，没有单独做数据结构，因为两者不会同时存在

@property (nonatomic, strong) BrandShopDTO *brandShopDto;
@property (nonatomic, strong) SearchSegmentView *searchSegmentView;
@property (nonatomic, copy)  NSString *strSelected;
@end
