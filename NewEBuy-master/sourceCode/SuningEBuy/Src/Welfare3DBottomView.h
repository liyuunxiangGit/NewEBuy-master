//
//  Welfare3DBottomView.h
//  SuningLottery
//
//  Created by jian  zhang on 12-9-25.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "BallSelectConstant.h"
#import "OHAttributedLabel.h"

@protocol Welfare3DBottomViewDelegate;

@interface Welfare3DBottomView : UIView

@property(nonatomic,weak)   id<Welfare3DBottomViewDelegate>       bottomDelegate;
@property(nonatomic,assign)   int                                   ballType;
@property(nonatomic,copy)     NSString                              *resultStr;
@property(nonatomic,strong)   UILabel                               *selectedNumsLabel;


-(void)setResultChoice:(NSMutableArray *)wel3DArr LottertType:(int)lotteryType multiNo:(NSString *)mutiNo period:(NSString *) period;

@end

@protocol Welfare3DBottomViewDelegate <NSObject>

@optional

- (void)submit:(NSString *)resultStr;

- (void)reChoose;

@end