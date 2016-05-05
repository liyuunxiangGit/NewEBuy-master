//
//  AppHelperViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-4-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommonViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kDefaultAppHelperPageCount      4

@interface AppHelperViewController : CommonViewController<UIScrollViewDelegate>{

    UIScrollView       *helperScrollView_;
    SNBasicBlock       dismissBlock;
}

@property(nonatomic,strong)UIScrollView       *helperScrollView;

//add by gjf 引导页面windowleavel = uilaertviewleavel
@property(nonatomic,strong)UIWindow           *yinDWindow;
- (void)addHelperImages;

- (void)setDismissBlock:(SNBasicBlock)block;
- (void)showOnWindow:(UIWindow *)window;

@end
