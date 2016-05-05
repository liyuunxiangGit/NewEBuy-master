//
//  SweepstakesRootView.h
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "CommonView.h"

#import "SweepstakesListView.h"

@interface SweepstakesRootView : CommonView
{

}


@property (nonatomic, strong) UILabel *ruleInfoLbl;

@property (nonatomic, strong) UIButton *ruleInfoBtn;

@property (nonatomic, strong) SweepstakesListView *sweepstakeBodyView;

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIImageView  *topBarBackgroundImage;

@end
