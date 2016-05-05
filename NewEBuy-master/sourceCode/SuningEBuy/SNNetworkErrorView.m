//
//  SNNetworkErrorView.m
//  SuningEBuy
//
//  Created by  liukun on 14-1-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNNetworkErrorView.h"

@implementation SNNetworkErrorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor uiviewBackGroundColor];
    }
    return self;
}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sn_network_error.png"]];
        _imageView.backgroundColor = [UIColor clearColor];
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _imageView;
}

- (UIButton *)button
{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 143, 38);
        _button.backgroundColor = [UIColor clearColor];
        [_button setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"]
                           forState:UIControlStateNormal];
        [_button setTitle:L(@"Common_ClickToRetry") forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor light_Black_Color] forState:UIControlStateNormal];
        _button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [_button addTarget:self
                    action:@selector(buttonTapped:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat contentHeight = self.imageView.height+10+self.button.height;
    
    CGFloat topMargin = (self.bounds.size.height-contentHeight)/2 - 10;
    
    self.imageView.frame = CGRectMake((self.bounds.size.width-self.imageView.frame.size.width)/2, topMargin, self.imageView.frame.size.width, self.imageView.frame.size.height);
    self.button.frame = CGRectMake((self.bounds.size.width-self.button.frame.size.width)/2, self.imageView.bottom+10, self.button.frame.size.width, self.button.frame.size.height);
    [self addSubview:self.imageView];
    [self addSubview:self.button];
}

- (void)buttonTapped:(id)sender
{
    if (_refreshBlock) {
        _refreshBlock();
    }
}

@end

@implementation UIView (SNNetworkError)

- (SNNetworkErrorView *)getNetworkErrorViewAtCenter
{
    UIView *view = [self viewWithTagNotDeepCounting:kNetworkErrorTag];
	
    if (view && [view isKindOfClass:[SNNetworkErrorView class]]){
		
        return (SNNetworkErrorView *)view;
    }
    else
    {
        return nil;
    }
}

- (BOOL)isShowingNetworkErrorView
{
    return [self getNetworkErrorViewAtCenter]?YES:NO;
}

- (void)showNetworkErrorViewWithRefreshBlock:(SNBasicBlock)block
{
    SNNetworkErrorView *view = [self getNetworkErrorViewAtCenter];
    
    if (!view) {
        view = [[SNNetworkErrorView alloc] initWithFrame:self.bounds];
        view.tag = kNetworkErrorTag;
        view.refreshBlock = block;
        [self addSubview:view];
    }
}

- (void)hideNetworkErrorView
{
    SNNetworkErrorView *view = [self getNetworkErrorViewAtCenter];

    if (view) {
        [view removeFromSuperview];
    }
}

@end
