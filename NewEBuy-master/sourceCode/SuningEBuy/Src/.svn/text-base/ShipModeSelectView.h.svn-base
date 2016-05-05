//
//  ShipModeSelectView.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PayFlowService.h"
@protocol ShipModeSelectViewDelegate;

@interface ShipModeSelectView : UIView

@property (nonatomic, weak) id<ShipModeSelectViewDelegate>  delegate;

@property (nonatomic, assign) ShipMode  shipMode;

//展示
- (void)showInSuperView:(UIView *)superView withShipMode:(ShipMode)shipMode;
//隐藏
- (void)hide;

@end

@protocol ShipModeSelectViewDelegate <NSObject>

- (void)shipModeSelectAction:(ShipMode)shipMode;

@end
