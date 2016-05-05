//
//  HistoryLotteryCodeViewController.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-12.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryHallDto.h"
#import "HistoryCodeRequestService.h"
#import "PageRefreshTableViewController.h"

@interface HistoryLotteryCodeViewController : PageRefreshTableViewController<HistoryCodeRequestServiceDelegate>
{
    HistoryCodeRequestService           *_historyCodeRequestService;
}

@property (nonatomic, strong)  UIImageView     *centerNoneDataView;
@property (nonatomic, strong)  LotteryHallDto *lotteryDto;
@property (nonatomic, strong)  NSMutableArray *historyCodeArray;

@end
