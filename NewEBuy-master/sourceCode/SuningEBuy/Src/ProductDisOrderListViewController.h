//
//  ProductDisOrderViewController.h
//  SuningEBuy
//
//  Created by caowei on 12-2-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDisOrderCell.h"
#import "DataProductBasic.h"
#import "productToolClass.h"
#import "GetAllSysInfo.h"
#import "LoadMoreDisOrderCell.h"
#import "PageRefreshTableViewController.h"

#import "DisProductDetailsDTO.h"
#import "productHttpDataSource.h"
#import "ProductDisOrderDetailsViewController.h"
#import "ProductDisorderListService.h"

@interface ProductDisOrderListViewController : PageRefreshTableViewController
<ProductDisorderListDelegate>
{
        
    BOOL                     isLoadingOK;
    
    UITableView             *orderTableView_;
    
    DisProductDetailsDTO        *_selectDisOrderDTO;
    
    
}
@property (nonatomic, strong) DataProductBasic *dataProductBasic;

@property (nonatomic, strong) NSMutableArray *orderList;

@property (nonatomic, strong) DisProductDetailsDTO *selectDisOrderDTO;

@property (nonatomic, strong) ProductDisorderListService *service;


@end