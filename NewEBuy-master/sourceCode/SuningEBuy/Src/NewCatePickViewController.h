//
//  NewCatePickViewController.h
//  SuningEBuy
//
//  Created by chupeng on 13-12-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFilterDelegate.h"
#import "SearchParamDTO.h"
#import "SearchCateDTO.h"

@class FilterPopupViewController;


@interface SectionState : NSObject
@property (nonatomic, assign) BOOL bSelected; // no未选中，yes被选中
@property (nonatomic, assign) BOOL bFolding;  // yes-折叠， no展开
@end


@interface NewCatePickViewController : CommonViewController
{
    NSInteger   selectedIndex;
    id<SearchFilterDelegate> __weak _delegate;
}

@property (nonatomic, weak) id<SearchFilterDelegate> delegate;
@property (nonatomic, assign) FilterPopupViewController *filterPopupViewController;
@property (nonatomic, strong) UIImageView *checkMarkView;
@property (nonatomic, strong) NSArray   *categoryList;
@property (nonatomic, copy)   NSString  *selectCateId;
@property (nonatomic, assign) NSInteger selectedIndex;    //当前选中的section
@property (nonatomic, assign) NSInteger sectionNeedChangeState;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, strong) NSMutableArray *sectionStateArray;
@property (nonatomic, assign) BOOL      bSearchingCategory; //是否是类别搜索结果，是的话分类界面不显示数量，因为数量都是0
@property (nonatomic, strong) UILabel *titleLabel;
- (id)initWithCateList:(NSArray *)list;
@end
