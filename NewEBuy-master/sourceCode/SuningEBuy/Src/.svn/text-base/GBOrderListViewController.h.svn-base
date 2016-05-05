//
//  GBOrderListViewController.h
//  SuningEBuy
//
//  Created by xingxuewei on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "GBOrderFilterViewController.h"
#import "GBOrderInfoDTO.h"
#import "GBOrderListService.h"
#import "PageRefreshTableViewController.h"
#import "GBOrderDetailViewController.h"

#import "AllOrderListPageFreshViewController.h"

@interface GBOrderListViewController : AllOrderListPageFreshViewController<GBOrderListServiceDelegate,OrderStatusFilterDlegate>
{
    NSInteger _orderState;
    
    NSMutableArray *_orderList;
    
    NSMutableArray *orderStatusArray;
    
    BOOL isLoaded;
    
    GBOrderListService *service;
    
    NSString *searchTime;
    
    NSInteger currentStatus;
    
}

@property (nonatomic,strong)GBOrderInfoDTO *infoDto;

@property (nonatomic,strong) NSMutableArray *orderList;

@property(nonatomic,assign) NSInteger orderState;
@property (nonatomic, strong) SNPopoverController *filterPopoverController;
@property (nonatomic,strong)GBOrderFilterViewController *orderFilterViewController;

- (void)updateTable;

@end
