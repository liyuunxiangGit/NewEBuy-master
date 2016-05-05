//
//  ShopSearchSegmentView.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ShopSearchSegmentViewDelegate <NSObject>

/*!
 @abstract      排序方式改变
 @discussion    回调方法
 @param         sort  排序方式
 */
- (void)searchSegmentDidChangeSortType:(int)sort;

@end


@interface ShopSearchSegmentView : UIView

//0 -- 默认 1 -- 销量降序 2 -- 评价降序
@property (nonatomic, assign) int selectedSort;
@property (nonatomic, weak) id<ShopSearchSegmentViewDelegate> delegate;
@property (nonatomic, strong) UIButton *button1;
@property (nonatomic, strong) UIButton *button2;
@property (nonatomic, strong) UIButton *button3;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) UIImageView *arrawImageView;
@end
