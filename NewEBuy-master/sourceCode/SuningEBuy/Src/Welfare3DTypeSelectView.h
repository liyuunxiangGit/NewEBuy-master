//
//  Welfare3DTypeSelectView.h
//  SuningLottery
//
//  Created by jian  zhang on 12-9-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallSelectConstant.h"


@protocol Welfare3DTypeSelectViewDelegate;


@interface Welfare3DTypeSelectView : UIView


@property (nonatomic, strong)  UIButton                                 *button1;
@property (nonatomic, strong)  UIButton                                 *button2;
@property (nonatomic, strong)  UIButton                                 *button3;
@property (nonatomic, strong)  UIButton                                 *button4;
@property (nonatomic, strong)  UIButton                                 *button5;
@property (nonatomic, strong)  UIButton                                 *button6;

@property (nonatomic, weak)  id<Welfare3DTypeSelectViewDelegate>      delegate;

- (void)changeBallType:(int)indexType;

@end

@protocol Welfare3DTypeSelectViewDelegate <NSObject>

- (void)didSelectWelfare3DTypeOK:(int)selectType;

@end
