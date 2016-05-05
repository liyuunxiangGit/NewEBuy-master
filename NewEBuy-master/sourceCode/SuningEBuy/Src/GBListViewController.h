//
//  GBListViewController.h
//  SuningEBuy
//
//  Created by shasha on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PPRevealSideViewController.h"
#import "GBFirstCategoryViewController.h"
#import "GBCityListViewController.h"
#import "PageRefreshTableViewController.h"
#import "GBListService.h"
#import "GBSearchFilterDTO.h"
#import "GBHeadNodeDTO.h"

typedef enum{
    eBigMode,
    eSmallMode
} ViewMode;

@interface GBListViewController : PageRefreshTableViewController<GBListServiceDelegate,GBFirstCategoryDelegate,GBCityListDelegate,UISearchBarDelegate>

//进入时调用，询问是否设置了默认城市
- (void)firstCallQueryCity:(NSString *)tuanGouType snProId:(NSString *)snProId;

@end
