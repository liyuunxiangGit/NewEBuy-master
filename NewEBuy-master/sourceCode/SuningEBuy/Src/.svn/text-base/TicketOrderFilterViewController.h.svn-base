//
//  TicketOrderFilterViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNPopoverCommonViewController.h"

@protocol TicketFilterDelegate;

@interface TicketOrderFilterViewController : SNPopoverCommonViewController

@property (nonatomic, weak) id<TicketFilterDelegate> delegate;

- (id)initWithFilterIndex:(NSInteger)index;


@end


@protocol TicketFilterDelegate <NSObject>

- (void)didSelectOrderStatus:(NSInteger)status;

@end