//
//  FilterRootViewController.h
//  SuningEBuy
//
//  Created by chupeng on 13-12-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFilterDelegate.h"
#import "SearchParamDTO.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"
#import "CustomKeyboardNumberPadReturnTextField.h"
#import "FilterPickForSalesPromotion.h"


@interface UISegmentEffectView : UIView
@property (nonatomic, assign) BOOL bSelected;
@property (nonatomic, strong) UIImageView *grayBackImgView;
@property (nonatomic, strong) UIImageView *orangeBackImgView;
@property (nonatomic, strong) UIImageView *ballImgView;
@end

@interface FilterRootViewController : CommonViewController<UITableViewDataSource, UITableViewDelegate, KeyboardDoneTappedDelegate, UITextFieldDelegate>
{
    id<SearchFilterDelegate> __weak _delegate;
}

#pragma mark - 类别相关
@property (nonatomic, strong) NSArray *categoryList;
@property (nonatomic, copy) NSString  *selectCateId;
@property (nonatomic, copy) NSString  *selectCateName;
//- (id)initWithCateList:(NSArray *)list;

#pragma mark - 高级筛选项相关
@property (nonatomic, weak) id<SearchFilterDelegate> delegate;
@property (nonatomic, strong) NSMutableArray                             *filterList;
@property (nonatomic, strong) NSMutableDictionary                 *selectFilterMap;
@property (nonatomic, strong) SearchParamDTO                      *searchCondition;
@property (nonatomic, assign) NSInteger                           itemNum; //商品数量
@property (nonatomic, strong) OHAttributedLabel                   *titleLabel;
@property (nonatomic, strong) CustomKeyboardNumberPadReturnTextField     *inputPrice1;
@property (nonatomic, strong) CustomKeyboardNumberPadReturnTextField     *inputPrice2;
@property (nonatomic, assign) BOOL                                isKeyWordSearch;

//- (id)initWithFitlerList:(NSArray *)filList;

- (void)resetSwitchBtns;

- (void)resetFilters;
@end
