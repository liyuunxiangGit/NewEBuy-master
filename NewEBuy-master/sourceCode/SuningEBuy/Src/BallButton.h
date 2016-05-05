//
//  BallButton.h
//  SuningLottery
//
//  Created by wangrui on 13-4-19.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallSelectConstant.h"

@interface BallButton : UIButton

- (id)initWithType:(LotteryBallType)ballType ballNumber:(NSString *)ballNumber andDelegate:(id)delegate;

@end


@interface HighlightedBallView : UIImageView

@property (nonatomic, strong) UILabel *bigNumberLbl;
@property (nonatomic, strong) UILabel *smallNumberLbl;

- (id)initWithFrame:(CGRect)frame andNumber:(NSString *)ballNumber;

@end
