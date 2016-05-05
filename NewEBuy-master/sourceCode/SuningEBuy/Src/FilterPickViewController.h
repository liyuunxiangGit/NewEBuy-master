//
//  FilterPickViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "PickCommonViewController.h"

@interface FilterPickViewController : PickCommonViewController
{

}

@property (nonatomic, strong) NSArray *filterList;
@property (nonatomic, strong) NSMutableDictionary *selectFilterMap;
@property (nonatomic, strong) SearchParamDTO *searchCondition;

- (id)initWithFitlerList:(NSArray *)filList;


@end
