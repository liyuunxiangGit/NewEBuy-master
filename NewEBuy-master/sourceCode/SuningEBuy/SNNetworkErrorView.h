//
//  SNNetworkErrorView.h
//  SuningEBuy
//
//  Created by  liukun on 14-1-4.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kNetworkErrorTag        0x11e


@interface SNNetworkErrorView : SNUIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy)   SNBasicBlock refreshBlock;

@end


@interface UIView (SNNetworkError)

- (void)showNetworkErrorViewWithRefreshBlock:(SNBasicBlock)block;
- (void)hideNetworkErrorView;
- (BOOL)isShowingNetworkErrorView;

@end