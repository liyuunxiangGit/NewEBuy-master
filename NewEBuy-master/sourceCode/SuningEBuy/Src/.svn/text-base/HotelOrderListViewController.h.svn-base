//
//  HotelOrderListViewController.h
//  SuningEBuy
//
//  Created by Qin on 14-2-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageRefreshTableViewController.h"
@interface HotelOrderListViewController : PageRefreshTableViewController
{
    ASIFormDataRequest                  *sendCommendASIHTTPRequest;
    
    UITableView         *tableView_;
    
    BOOL            isLoaderOK;
    BOOL            isFromAllOrderCenter;
}
@property (nonatomic,assign)BOOL            isFromAllOrderCenter;
@property (nonatomic,strong) UILabel *alertLbl;
@property (nonatomic,strong) UIImageView *alertImageV;

@property (nonatomic, strong) NSMutableArray *itemListArr;


- (void)sendListHttpRequest;
@end
