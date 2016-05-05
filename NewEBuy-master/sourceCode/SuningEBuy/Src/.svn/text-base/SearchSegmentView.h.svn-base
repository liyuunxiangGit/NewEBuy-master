//
//  SearchSegmentView.h
//  SuningEBuy
//
//  Created by chupeng on 13-12-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  新的搜索结果页面使用的segment视图

#import <UIKit/UIKit.h>
#import "SearchParamDTO.h"

@protocol SearchSegmentDelegate <NSObject>

/*!
 @abstract      排序方式改变
 @discussion    回调方法
 @param         sort  排序方式
 */
- (void)searchSegmentDidChangeSortType:(SortType)sort;

@end

@interface SearchSegmentView : UIView
{
@private
    SortType  _selectedSort;
}
@property (nonatomic, assign) SortType selectedSort;
@property (nonatomic, weak) id<SearchSegmentDelegate> delegate;

@end
