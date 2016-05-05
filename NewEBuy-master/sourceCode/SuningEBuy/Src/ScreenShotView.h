//
//  ScreenShotView.h
//  TestSample
//
//  Created by chupeng on 13-12-5.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScreenShotView : UIView
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) NSMutableArray *arrayImage;

- (void)showEffectChange:(CGPoint)pt;
- (void)restore;
- (void)screenShot;
@end
