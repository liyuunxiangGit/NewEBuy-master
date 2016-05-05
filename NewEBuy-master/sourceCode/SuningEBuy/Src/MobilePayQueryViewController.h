//
//  MobilePayQueryViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-17.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PageRefreshTableViewController.h"
#import "MobileQueryService.h"

#import "AllOrderListPageFreshViewController.h"

@interface MobilePayQueryViewController : AllOrderListPageFreshViewController
<MobileQueryServiceDelegate>
{
    
    BOOL                isOrderLoaded;
}
@property (nonatomic, strong) MobileQueryService  *service;
@property (nonatomic, strong) NSMutableArray *orderList;

@property (nonatomic,strong) UILabel *alertLbl;
@property (nonatomic,strong) UIImageView                 *alertImageV;
@end
