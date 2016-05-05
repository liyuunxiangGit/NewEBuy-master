//
//  ChooseShareWayViewController.h
//  SuningEBuy
//
//  Created by  on 12-9-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
/*!
 @header      ChooseShareWayViewController
 @abstract    选择分享方式页面
 @author      刘坤
 @version     v1.0.001  12-9-21
 */

#import "SNPopoverCommonViewController.h"


@protocol ChooseShareWayDelegate <NSObject>

- (void)didChooseShareWay:(SNShareType)shareWay;

@end



@interface ChooseShareWayViewController : SNPopoverCommonViewController

@property (nonatomic, weak) id<ChooseShareWayDelegate> delegate;
@property (nonatomic, assign) SNShareType allType;


@end
