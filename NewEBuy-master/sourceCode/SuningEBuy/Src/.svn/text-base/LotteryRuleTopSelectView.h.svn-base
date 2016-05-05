//
//  LotteryRuleTopSelectView.h
//  SuningLottery
//
//  Created by jian  zhang on 12-9-30.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LotteryRuleTopSelectViewDelegate;


@interface LotteryRuleTopSelectView : UIView

{
    
}

@property (nonatomic, weak) id<LotteryRuleTopSelectViewDelegate>   delegate;

@property (nonatomic, strong) NSArray                                *titleArr;

- (void)setButtonTitle;

@end

@protocol LotteryRuleTopSelectViewDelegate <NSObject>

- (void)didSelectedOKWithIndex:(int)index;

@end
