//
//  FilterPickForSalesPromotion.h
//  SuningEBuy
//
//  Created by chupeng on 14-5-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  促销商品的选择页面，给本地的促销商品筛选使用


#import <UIKit/UIKit.h>
#import "PickCommonViewController.h"
#import "SearchParamDTO.h"

@interface SalesFilterDto : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *value;
@end

@interface FilterPickForSalesPromotion : PickCommonViewController
@property (nonatomic, strong) SearchParamDTO  *searchCondition;
@property (nonatomic, copy)   SNBasicBlock    selectFilterBlock;
@property (nonatomic, strong) NSMutableArray *arraySelected;
@property (nonatomic, strong) NSMutableArray *arrayItems;


@end
