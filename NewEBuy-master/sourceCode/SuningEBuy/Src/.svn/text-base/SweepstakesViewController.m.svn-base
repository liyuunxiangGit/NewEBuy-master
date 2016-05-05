//
//  SweepstakesViewController.m
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "SweepstakesViewController.h"

#import "SweepstakesRuleInfoViewController.h"
#import "MyEbuyViewController.h"


@implementation SweepstakesViewController

@synthesize animateTimer = _animateTimer;

@synthesize service = _service;


- (void)dealloc {
    
    TT_INVALIDATE_TIMER(_animateTimer);

    _homeView.owner = nil;
    TT_RELEASE_SAFELY(_homeView);
    
    SERVICE_RELEASE_SAFELY(_service);
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init {
    self = [super init];
    if (self) {
        
        self.title = L(@"happySweepstakes");
        
        self.hidesBottomBarWhenPushed = YES;
        self.hasNav = NO;
  
    }
    return self;
}

#pragma mark -
#pragma mark view life cycle

- (void)loadView
{    
    _homeView = [[SweepstakesRootView alloc] initWithOwner:self];
    self.view = _homeView;
   // self.tableView = _homeView.tableView;
    
//    NSURL *imageUrl = [NSURL URLWithString:kSweepstakesInfoImageURL];
//    
//    [[EGOImageLoader sharedImageLoader] clearCacheForURL:imageUrl];
//    
//    [[EGOImageLoader sharedImageLoader] dataForURL:imageUrl shouldLoadWithObserver:nil];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self startTimer];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self endTimer];
    [_homeView.sweepstakeBodyView.animateTimer invalidate];
    _homeView.sweepstakeBodyView.animateTimer = nil;
}

#pragma mark -
#pragma mark 定时器

- (void)startTimer
{
    if (!_animateTimer || ![_animateTimer isValid])
    {
        
        self.animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.6f
                                                             target:self
                                                           selector:@selector(startAnimating)
                                                           userInfo:nil
                                                            repeats:NO];
    }
}

- (void)endTimer
{
    TT_INVALIDATE_TIMER(_animateTimer);
}

-(void)startAnimating
{
    [_homeView.sweepstakeBodyView startCenterMoveAnimate];
}

- (JPService *)service
{
    if (!_service)
    {
        _service = [[JPService alloc] init];
        
        _service.delegate = self;
    }
    return _service;
}

-(BOOL)sendSweepActiveHttp
{
    if (![UserCenter defaultCenter].isLogined)
    {
        [self login];
        return NO;
    }
    
    [self displayOverFlowActivityView];
    
    [self.service beginChouJiang];
    
    return YES;
}

- (void)alertErrorMsg:(NSString *)errorMsg
{
    BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-info")
                                                    message:errorMsg
                                                   delegate:nil
                                          cancelButtonTitle:L(@"Sweepstakes_HangAround")
                                          otherButtonTitles:L(@"Cancel")];
    [alert setConfirmBlock:^{
        [_homeView.sweepstakeBodyView resetItem];
    }];
    [alert setCancelBlock:^{
        [self.navigationController popToRootViewControllerAnimated:YES];

    }];
    [alert show];
}

- (void)chouJiangCompleteWithResult:(BOOL)isSuccess
                          errorCode:(NSString *)errorCode
                           errorMsg:(NSString *)errorMsg
                             JPList:(NSArray *)list
                             ZJInfo:(JPInfoDTO *)zjInfo
{
    DLog(@"chouJiangCompleteWithResult");
    
    [self removeOverFlowActivityView];
    
    if (isSuccess ==YES) {
        
      // [_homeView.sweepstakeBodyView rotationBegin];
        
        if (zjInfo !=nil)
        {
            [_homeView.sweepstakeBodyView setWinningView:zjInfo];
        }
        else
        {
            [self alertErrorMsg:L(@"Sweepstakes_SystemBusy")];

        }
        
        
    }else{
        
        if ([errorCode isEqualToString:@"001"])
        {
            [self alertErrorMsg:L(@"Sweepstakes_SystemBusy")];
        }
        else if ([errorCode isEqualToString:@"002"])
        {
            [self alertErrorMsg:L(@"Sweepstakes_IncorrectTime")];
        }
        else if ([errorCode isEqualToString:@"003"])
        {
            [self login];
            [_homeView.sweepstakeBodyView resetItem];
        }
        else if ([errorCode isEqualToString:@"006"])
        {
            //激活易付宝
            [self jumpToActivityEfubao];
            [self.navigationController popToRootViewControllerAnimated:NO];
        }
        else if ([errorCode isEqualToString:@"010"])
        {
            [self alertErrorMsg:L(@"Sweepstakes_LotteryNumsOut")];
        }
        else
        {
            [self alertErrorMsg:errorMsg?errorMsg:L(@"Sorry loading failed")];
        }
        

    }

}

-(void)showRuleInfoView
{
    SweepstakesRuleInfoViewController *exchangeController = [[SweepstakesRuleInfoViewController alloc]init];
    
    exchangeController.ruleInfoString = @"";
    
    [self.navigationController pushViewController: exchangeController animated:YES];
    

}
@end
