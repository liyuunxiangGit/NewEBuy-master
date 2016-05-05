//
//  SweepstakesListView.h
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SweepstakesItemView.h"
#import "JPInfoDTO.h"

@class SweepstakesRootView;

@interface SweepstakesListView : UIView<SweepstakesItemDelegate>
{
    BOOL  isRotateEnd;
    
    NSInteger   selectItemTag;
    
    NSInteger    loopIdex;
}

@property (nonatomic, strong) SweepstakesItemView *sweepstakesOne;

@property (nonatomic, strong) SweepstakesItemView *sweepstakesTwo;

@property (nonatomic, strong) SweepstakesItemView *sweepstakesThree;

@property (nonatomic, strong) SweepstakesItemView *sweepstakesFour;

@property (nonatomic, strong) NSTimer              *animateTimer;

@property (nonatomic, weak) id  owner;

@property (nonatomic, weak) SweepstakesRootView *rootView;

@property (nonatomic, strong) NSArray *sweepDtoArr;

@property (nonatomic, strong) JPInfoDTO *zjInfo;

-(void)startCenterMoveAnimate;

-(void)setWinningView:(JPInfoDTO *)zjInfo;

-(void)setItemIsTouchEnable:(BOOL)isEnble;

-(void)resetItem;
@end
