//
//  PasswordToggleView.m
//  SuningEBuy
//
//  Created by liukun on 14-2-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PasswordToggleView.h"

@interface PasswordToggleView()

@property (nonatomic, strong) UIView *contentView;

@end

/*********************************************************************/

@implementation PasswordToggleView

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"isShowWords"];
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.clipsToBounds = YES;
        self.frame = CGRectMake(0, 0, 50, 20);
        [self addObserver:self
               forKeyPath:@"isShowWords"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:NULL];
        
        UIImageView *bgImageView = [[UIImageView alloc] init];
        bgImageView.image = [UIImage streImageNamed:@"login_toggle_bg"];
        bgImageView.frame = self.bounds;
        [self addSubview:bgImageView];
        
        [self addTarget:self action:@selector(touched:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.contentView];
        
        [self layoutToggleAnimated:NO];
    }
    return self;
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.userInteractionEnabled = NO;
        _contentView.backgroundColor  = [UIColor clearColor];
        _contentView.frame = CGRectMake(-30, 0, 80, 20);
        
        UIImageView *dian = [[UIImageView alloc] init];
        dian.frame = CGRectMake(0, 0, 30, 20);
        dian.contentMode = UIViewContentModeCenter;
        dian.image = [UIImage imageNamed:@"login_toggle_dian.png"];
        [_contentView addSubview:dian];
        
        UIImageView *cycle = [[UIImageView alloc] init];
        cycle.frame = CGRectMake(30.5, 0, 20, 20);
        cycle.image = [UIImage imageNamed:@"login_toggle_cycle.png"];
        [_contentView addSubview:cycle];
        
        UIImageView *abc = [[UIImageView alloc] init];
        abc.frame = CGRectMake(50, 0, 30, 20);
        abc.contentMode = UIViewContentModeCenter;
        abc.image = [UIImage imageNamed:@"login_toggle_abc.png"];
        [_contentView addSubview:abc];
    }
    return _contentView;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"isShowWords"])
    {
        BOOL _oldValue = [[change objectForKey:NSKeyValueChangeOldKey] boolValue];
        BOOL _newValue = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        
        if (_newValue != _oldValue)
        {
            [self sendActionsForControlEvents:UIControlEventValueChanged];
        }
    }
}

- (void)touched:(id)sender
{
    self.isShowWords = !self.isShowWords;
    
    [self layoutToggleAnimated:YES];
}

- (void)layoutToggleAnimated:(BOOL)animated
{
    void(^layout_M)(void) = ^{
        
        if (self.isShowWords)
        {
            self.contentView.left = -30.;
        }
        else
        {
            self.contentView.left = 0;
        }
    };
    
    if (animated)
    {
        [UIView animateWithDuration:0.2
                              delay:0.
                            options:UIViewAnimationCurveEaseInOut
                         animations:^{
                             layout_M();
                         } completion:NULL];
    }
    else
    {
        layout_M();
    }
}

@end
