//
//  GBCityListViewController.h
//  SuningEBuy
//
//  Created by shasha on 13-3-4.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBCityService.h"
#import "GBCityDTO.h"

@protocol  GBCityListDelegate;

@interface GBCityListViewController : CommonViewController<GBCityServiceDelegate>

@property (nonatomic, weak) id<GBCityListDelegate>  delegate;

@end

@protocol GBCityListDelegate <NSObject>

- (void)selectCity:(GBCityDTO *)cityDTO;

@end