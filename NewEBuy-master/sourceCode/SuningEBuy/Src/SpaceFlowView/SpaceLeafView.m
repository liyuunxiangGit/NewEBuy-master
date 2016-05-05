//
//  SpaceLeafView.m
//  SpaceFlow
//
//  Created by Kristopher on 14-8-5.
//  Copyright (c) 2014年 Kristopher. All rights reserved.
//

#import <Accelerate/Accelerate.h>
#import <QuartzCore/QuartzCore.h>

#import "SpaceLeafView.h"

@interface SpaceLeafView()<UIGestureRecognizerDelegate>
{
    CGFloat       _width,_height;
    UIImage      *_subContentImage;
    UIImageView  *_blurredImageView;
    UITapGestureRecognizer *_tapGesture;
}

@end

@implementation SpaceLeafView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        _width = frame.size.width;
        
        _height = frame.size.height;
        
        _delegate = nil;
        
        _index = 0;
        
        _radian = 0.0;
        
        _blurredRatio = 1.0;
        
        _subContentView = nil;
        
        _subContentImage = nil;
        
        _blurredImageView = [[UIImageView alloc] initWithFrame:frame];
        _blurredImageView.image = nil;
        _blurredImageView.alpha = 0.0;
        [self addSubview:_blurredImageView];
        
        _tapGesture = nil;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 5;
        
    }
    return self;
}

- (void)tapInHandle:(UITapGestureRecognizer *)tap{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedInSpaceLeafView:)]) {
        [_delegate didSelectedInSpaceLeafView:self];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)setDelegate:(id<SpaceLeafViewDelegate>)delegate{
    _delegate = delegate;
    if (_delegate) {
        if (!_tapGesture) {
            _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapInHandle:)];
            _tapGesture.delegate = self;
            [self addGestureRecognizer:_tapGesture];
        }
    }else{
        if (_tapGesture) {
            _tapGesture.delegate = nil;
            [self removeGestureRecognizer:_tapGesture];
            [_tapGesture removeTarget:self action:@selector(tapInHandle:)];
            _tapGesture = nil;
        }
    }
}

- (void)setRadian:(CGFloat)radian{
    if (radian>=2*M_PI) {
        _radian = radian - (int)(radian/(M_PI))*M_PI;
    }else if (radian<0.0){
        _radian = 2*M_PI + radian - (int)(radian/(M_PI))*M_PI;
    }else{
        _radian = radian;
    }
}


- (void)setBlurredRatio:(CGFloat)blurredRatio{
    if ((blurredRatio>0.0)&&(blurredRatio<1.0)) {
        if (_radian<_leafRadian*0.25||_radian>(2*M_PI-_leafRadian*0.25)) {
            _blurredRatio = 0.99;
            [self refreshBlurringEffect];
        }else{
//            _blurredRatio = powf(blurredRatio, 0.25);
            CGFloat blur = (int)(blurredRatio*10)/10.0;
            blur = powf(blur, 0.25);
            if (blur!=_blurredRatio) {
                _blurredRatio = blur;
                [self refreshBlurringEffect];
            }
        }
    }else{
        _blurredRatio = 1.0;
        [self refreshBlurringEffect];
    }
}

- (void)setSubContentView:(UIView *)subContentView{
    if (_subContentView) {
        [_subContentView removeFromSuperview];
        _subContentView = nil;
        _subContentImage = nil;
        _blurredImageView.image = nil;
        _blurredImageView.alpha = 0.0;
        [self sendSubviewToBack:_blurredImageView];
        self.userInteractionEnabled = YES;
    }
    _subContentView = subContentView;
    if (_subContentView) {
        [self addSubview:subContentView];
        _subContentImage = [self imageConvertedFromView:_subContentView];
    }
}

- (void)refreshSubContentImage{
    _subContentImage = [self imageConvertedFromView:_subContentView];
    [self refreshBlurringEffect];
}

- (UIImage *)imageConvertedFromView:(UIView *)view{
    UIGraphicsBeginImageContext(view.bounds.size);
    CGContextRef currnetContext = UIGraphicsGetCurrentContext();
    [view.layer renderInContext:currnetContext];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (UIImage *)blurredOriginalImage:(UIImage *)originalImage withBlurredRatio:(CGFloat)blurredRatio
{
    uint32_t boxSize1 = (uint32_t)((1.0-blurredRatio)*_height*2.0);
    if (boxSize1%2 == 0) boxSize1++;
    uint32_t boxSize2 = (uint32_t)((1.0-blurredRatio)*_width*2.0);
    if (boxSize2%2 == 0) boxSize2++;
    
    CGImageRef imageRef = originalImage.CGImage;
    vImage_Buffer buffer1, buffer2;
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    size_t bytes = buffer1.rowBytes * buffer1.height;
    buffer1.data = malloc(bytes);
    buffer2.data = malloc(bytes);
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize1, boxSize2,
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    for (NSUInteger i = 0; i < 3; i++)
    {
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize1, boxSize2, NULL, kvImageEdgeExtend);
        void *temp = buffer1.data;
        buffer1.data = buffer2.data;
        buffer2.data = temp;
    }
    free(buffer2.data);
    free(tempBuffer);
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(ctx);
    free(buffer1.data);
    
    return resultImage;
    
}

- (void)refreshBlurringEffect{
    if (_subContentImage&&(_blurredRatio>0.0)&&(_blurredRatio<1.0)) {
        _blurredImageView.image = [self blurredOriginalImage:_subContentImage withBlurredRatio:_blurredRatio];
        _blurredImageView.alpha = 1.0;
        [self bringSubviewToFront:_blurredImageView];
        self.userInteractionEnabled = NO;
    }else{
        _blurredImageView.image = nil;
        _blurredImageView.alpha = 0.0;
        [self sendSubviewToBack:_blurredImageView];
        self.userInteractionEnabled = YES;
    }
}


@end
