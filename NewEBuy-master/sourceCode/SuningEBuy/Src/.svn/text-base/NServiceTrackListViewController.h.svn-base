//
//  NServiceTrackListViewController.h
//  SuningEBuy
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageRefreshTableViewController.h"
#import "NOrderListService.h"

@interface NServiceTrackListViewController : PageRefreshTableViewController<NOrderListServiceDelegate>{
    
    BOOL isLoadOk;
}

@property(nonatomic, strong) NSMutableArray              *orderList;
@property(nonatomic, strong) UIView                      *loadMoreView;
@property(nonatomic, strong) UIView                      *backgroundView;
@property(nonatomic, copy)   NSString                    *timeRange;
@property(nonatomic, copy)   NSString                    *orderStatus;
@property(nonatomic, strong) NOrderListService           *service;

@end
