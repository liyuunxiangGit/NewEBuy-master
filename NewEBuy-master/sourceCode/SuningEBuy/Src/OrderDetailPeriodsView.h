//
//  OrderDetailPeriodsView.h
//  SuningLottery
//
//  Created by yangbo on 4/12/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryOrderDetailService.h"

//追号列表视图 显示追号列表
@interface OrderDetailPeriodsView : UIView <UITableViewDelegate, UITableViewDataSource>
{
    UITableView     *_tableView;
    
    NSArray         *_periodsArray;         //期次订单信息
    
    NSInteger       _openIndex;             //打开的期次在_periodsArray的index， 未打开为-1

    LotteryOrderDetailService *_service;
}

- (id)initWithService:(LotteryOrderDetailService *)service;
@end
