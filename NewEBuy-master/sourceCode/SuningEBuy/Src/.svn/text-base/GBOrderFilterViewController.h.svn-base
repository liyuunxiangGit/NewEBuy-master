//
//  GBOrderFilterViewController.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PickCommonViewController.h"

@protocol OrderStatusFilterDlegate <NSObject>

@optional

- (void)filterSelectOk:(NSInteger)selectIndex;

- (void)initRightBarButton;

@end


@interface GBOrderFilterViewController : SNPopoverCommonViewController{
     NSInteger   selectedIndex;
}

@property (nonatomic, strong) NSArray *orderStatusList;
@property (nonatomic,copy) NSString *selectedStatusId;
@property (nonatomic, weak)id <OrderStatusFilterDlegate> delegate;

- (id)initWithStatusList:(NSArray *)list;

@end
