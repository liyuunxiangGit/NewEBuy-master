//
//  ScanHistoryViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommonViewController.h"

@interface ScanHistoryViewController : CommonViewController

@property (nonatomic, strong) NSMutableArray *historyList;
@property (nonatomic, copy)   SNBasicBlock backBlock;

@end
