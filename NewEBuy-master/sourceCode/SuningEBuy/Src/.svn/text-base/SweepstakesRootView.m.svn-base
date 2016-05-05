//
//  SweepstakesRootView.m
//  SuningEBuy
//
//  Created by robin on 1/24/13.
//  Copyright (c) 2013 Suning. All rights reserved.
//

#import "SweepstakesRootView.h"

#import "SweepstakesViewController.h"

@implementation SweepstakesRootView

@synthesize ruleInfoLbl = _ruleInfoLbl;

@synthesize sweepstakeBodyView = _sweepstakeBodyView;

@synthesize topBarBackgroundImage = _topBarBackgroundImage;

@synthesize ruleInfoBtn = _ruleInfoBtn;

@synthesize backBtn = _backBtn;

- (void)dealloc {
    
    
    TT_RELEASE_SAFELY(_ruleInfoLbl);
    
    _sweepstakeBodyView.owner = nil;
    _sweepstakeBodyView.rootView = self;
    TT_RELEASE_SAFELY(_sweepstakeBodyView);
    
    TT_RELEASE_SAFELY(_topBarBackgroundImage);
    
    TT_RELEASE_SAFELY(_ruleInfoBtn);
    
    TT_RELEASE_SAFELY(_backBtn);

    
}

- (id)initWithOwner:(id)owner {
    self = [super initWithOwner:owner];
    if (self) {
        CGRect frame = [[UIScreen mainScreen] bounds];
        self.frame = frame;

        [self addSubview: self.topBarBackgroundImage];
        
        [self addSubview: self.backBtn];
        
        [self addSubview: self.sweepstakeBodyView];
        
        [self addSubview: self.ruleInfoBtn];
        
    }
    return self;
}

-(void)showRuleInfoButton
{
    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.ruleInfoBtn.top -= 80;
                     }
                     completion:^(BOOL finished) {
                         
                        [self.sweepstakeBodyView setItemIsTouchEnable:YES];
                     }];
}

- (UIButton *)ruleInfoBtn
{
    if (!_ruleInfoBtn)
    {
        _ruleInfoBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _ruleInfoBtn.frame = CGRectMake(40, self.height, 65, 28);
        
       // _ruleInfoBtn.backgroundColor = [UIColor clearColor];
        
        [_ruleInfoBtn setBackgroundImage:[UIImage imageNamed:@"lottery_method.png"] forState:UIControlStateNormal];
        
        [_ruleInfoBtn addTarget:self action:@selector(clickRuleInfoBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [self performSelector:@selector(showRuleInfoButton) withObject:nil afterDelay:2.3f];
    }
    
    return _ruleInfoBtn;
}

-(UIButton *)backBtn{
    if (_backBtn == nil) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(10, 0, 46, 44);
        //[_backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[_backBtn setTitle:L(@"AddPersonInfoBtn") forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"lottery_back.png"];
        [_backBtn setImage:image forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIImageView *)topBarBackgroundImage
{
    if (!_topBarBackgroundImage)
    {
        
        _topBarBackgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lottery_titlebar.png"]];
        
        _topBarBackgroundImage.frame = CGRectMake(0, 0, _topBarBackgroundImage.width, _topBarBackgroundImage.height);
        
        NSString *backImageName = (isIPhone5==NO)?@"lottery_bg.png":@"lottery_bg-5.png";
        
        UIImage *backImage = [UIImage newImageFromResource: backImageName];
        
        UIImageView *bakcImageView =  [[UIImageView alloc]  initWithFrame:CGRectMake(0, _topBarBackgroundImage.bottom, self.width, backImage.size.height)];
        
        bakcImageView.image = backImage;
        
        bakcImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview: bakcImageView];
        
        
        
    }
    return _topBarBackgroundImage;
}

- (SweepstakesListView *)sweepstakeBodyView{
    
    if (!_sweepstakeBodyView) {
        
        _sweepstakeBodyView = [[SweepstakesListView alloc] initWithFrame:CGRectMake(0, self.topBarBackgroundImage.size.height, 320, self.size.height-80)];
        
        _sweepstakeBodyView.backgroundColor = [UIColor clearColor];
        
        _sweepstakeBodyView.owner = self.owner;
        
        _sweepstakeBodyView.rootView = self;
    }
    
    return _sweepstakeBodyView;
}

-(void)clickRuleInfoBtn
{
    SweepstakesViewController *rootNC = (SweepstakesViewController *)self.owner;
    
    if ([rootNC isKindOfClass: [SweepstakesViewController class]]) {
        
        [rootNC showRuleInfoView];
        
    }
}

-(void)backEvent
{
    SweepstakesViewController *rootNC = (SweepstakesViewController *)self.owner;
    
    if ([rootNC isKindOfClass: [SweepstakesViewController class]]) {
        
        [rootNC.navigationController popViewControllerAnimated:YES];
        
    }
}


@end
