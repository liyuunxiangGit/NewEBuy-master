//
//  ScanSearchViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 13-8-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ScanSearchView.h"

@interface ScanSearchViewController : CommonViewController

@property (nonatomic, strong) ScanSearchView *scanSearchView;

@property (nonatomic, strong) NSMutableArray *historyList; //浏览历史

- (void)reloadScanHistoryTableViewData;

@end
