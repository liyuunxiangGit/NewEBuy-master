//
//  SecondKillRuleViewController.h
//  SuningEBuy
//
//  Created by cui zl on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecondKillRuleViewController : CommonViewController

@property(nonatomic,strong) UISegmentedControl *segCate;
@property(nonatomic,strong)NSArray             *gameRuleArr;

- (CGFloat)getHeiht:(NSInteger)section;

@end
