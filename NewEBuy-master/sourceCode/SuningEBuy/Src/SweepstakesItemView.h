//
//  SweepstakesItemView.h
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SweepstakesItemDelegate;

@interface SweepstakesItemView : UIView
{
    BOOL isAnimition;
}

@property (nonatomic, assign) BOOL isVisible;

@property (nonatomic, assign) BOOL isWinning;

@property (nonatomic, strong) UIImageView *frontView;

@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, weak) id <SweepstakesItemDelegate> exDelegate;

- (void)flipViews;

- (BOOL)flipFromBackToFront;
- (BOOL)flipFromFrontToBack;
@end

@protocol SweepstakesItemDelegate <NSObject>
@optional


- (void)sweepstakesItemDidOk:(SweepstakesItemView *)itemView;
@end
