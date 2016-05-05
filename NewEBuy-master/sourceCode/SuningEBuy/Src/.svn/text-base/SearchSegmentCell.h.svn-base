//
//  SearchSegmentCell.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      SearchSegmentCell
 @abstract    搜索排序行专用cell
 @author      刘坤
 @version     v1.0.001  12-8-31
 */
#import <UIKit/UIKit.h>
#import "SearchParamDTO.h"

/*!
 @protocol       SearchSegmentDelegate
 @abstract       SearchSegmentCell的一个代理
 @discussion     代理模式
 */
@protocol SearchSegmentCellDelegate <NSObject>

/*!
 @abstract      排序方式改变
 @discussion    回调方法
 @param         sort  排序方式
 */
- (void)searchSegmentDidChangeSortType:(SortType)sort;

@end




@interface SearchSegmentCell : UITableViewCell
{
    @private
    SortType  _selectedSort;
}

@property (nonatomic, assign) SortType selectedSort;
@property (nonatomic, weak) id<SearchSegmentCellDelegate> delegate;


@end
