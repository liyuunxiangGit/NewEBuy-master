//
//  GBFirstCategoryViewController.h
//  SuningEBuy
//
//  Created by shasha on 13-2-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBListPrametersDTO.h"

@protocol GBFirstCategoryDelegate;

@interface GBFirstCategoryViewController : CommonViewController

@property (nonatomic, strong) GBListPrametersDTO *paramDTO;
@property (nonatomic, weak) id<GBFirstCategoryDelegate> delegate;

- (void)setFirstCategoryList:(NSMutableArray *)firstCateList;

@end


@protocol GBFirstCategoryDelegate <NSObject>

- (void)categoryChangedWithCityName:(NSString *)cityName;

@end