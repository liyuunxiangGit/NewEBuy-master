//
//  HDZoomingView.h
//  ZoomingView
//
//  Created by sumeng on 12-12-19.
//  Copyright (c) 2012年 sumeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"
#import "MWTapDetectingView.h"
#import "MWTapDetectingImageView.h"

@protocol HDZoomingViewDelegate;

@interface HDZoomingView : UIScrollView <UIScrollViewDelegate, SDWebImageManagerDelegate, MWTapDetectingViewDelegate, MWTapDetectingImageViewDelegate> {
    MWTapDetectingView *_bgView;
    MWTapDetectingImageView *_photoImageView;
    UIActivityIndicatorView *_loadingView;
    UIImage *_photoImage;
    
    CGFloat _xScale;
}

@property (nonatomic, assign) id<HDZoomingViewDelegate>tapDelegate;

- (void)setUrl:(NSURL *)url;
- (void)setImage:(UIImage *)image;
- (void)setFilePath:(NSString *)path;

- (UIImage *)getImage;

@end

@protocol HDZoomingViewDelegate <NSObject>

@optional

- (void)zoomingViewSingleTapDetected:(HDZoomingView *)view;
- (void)zoomingViewDoubleTapDetected:(HDZoomingView *)view;
- (void)zoomingViewLongPressedDetected:(HDZoomingView *)view;

@end