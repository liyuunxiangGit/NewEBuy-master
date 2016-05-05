//
//  ScreenShotView.m
//  TestSample
//
//  Created by chupeng on 13-12-5.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "ScreenShotView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "SNGraphics.h"

@implementation ScreenShotView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.arrayImage = [NSMutableArray array];
        self.backgroundColor = [UIColor blackColor];
        self.imgView = [[UIImageView alloc] initWithFrame:self.bounds];
                
        self.maskView = [[UIView alloc] initWithFrame:self.bounds];
        _maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.4];
        [self addSubview:_imgView];
        [self addSubview:_maskView];
    }
    return self;
}

- (void)layoutSubviews
{

    [super layoutSubviews];
}

- (void)showEffectChange:(CGPoint)pt
{
    if (pt.x > 0)
    {
        _maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:-pt.x / 320.0 * 0.4 + 0.4];
        _imgView.transform = CGAffineTransformMakeScale(0.95 + (pt.x / 320.0 * 0.05), 0.95 + (pt.x / 320.0 * 0.05));
    }
}

- (void)restore
{
    if (_maskView && _imgView)
    {
        _maskView.backgroundColor = [UIColor colorWithHue:0 saturation:0 brightness:0 alpha:0.4];
        _imgView.transform = CGAffineTransformMakeScale(0.95, 0.95);
    }
}

- (void)screenShot
{
//    AppDelegate *appdelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height), YES, 0);
//    [appdelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    CGImageRef imageRef = viewImage.CGImage;
//    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRef];
//    self.imgView.image = sendImage;
//    self.imgView.transform = CGAffineTransformMakeScale(0.95, 0.95);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
