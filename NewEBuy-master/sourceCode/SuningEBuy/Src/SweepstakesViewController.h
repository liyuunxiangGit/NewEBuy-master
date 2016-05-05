//
//  SweepstakesViewController.h
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "SweepstakesRootView.h"

#import "JPService.h"

#import "SNPopoverController.h"

@interface SweepstakesViewController : CommonViewController<JPServiceDelegate>
{
    @private
        SweepstakesRootView *_homeView;
}

@property (nonatomic, strong) JPService           *service;

@property (nonatomic, strong) NSTimer              *animateTimer;


-(void)showRuleInfoView;

-(BOOL)sendSweepActiveHttp;

@end
