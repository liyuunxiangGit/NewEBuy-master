//
//  HDZoomingView.m
//  ZoomingView
//
//  Created by sumeng on 12-12-19.
//  Copyright (c) 2012年 sumeng. All rights reserved.
//

#import "HDZoomingView.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"

@implementation HDZoomingView

@synthesize tapDelegate = _tapDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _bgView = [[MWTapDetectingView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor clearColor];
        _bgView.tapDelegate = self;
        _bgView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_bgView];
        
        _photoImageView = [[MWTapDetectingImageView alloc] initWithFrame:CGRectZero];
        _photoImageView.tapDelegate = self;
		_photoImageView.contentMode = UIViewContentModeCenter;
		_photoImageView.backgroundColor = [UIColor blackColor];
		[self addSubview:_photoImageView];
        
        _loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _loadingView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
		_loadingView.hidesWhenStopped = YES;
		_loadingView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
		[self addSubview:_loadingView];
        
        self.backgroundColor = [UIColor blackColor];
		self.delegate = self;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
        self.alwaysBounceHorizontal = NO;
        self.alwaysBounceVertical = YES;
		self.decelerationRate = UIScrollViewDecelerationRateFast;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        //[self displayImage];
        UILongPressGestureRecognizer *bgLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_bgView addGestureRecognizer:bgLongPress];
        [bgLongPress release];
        
        UILongPressGestureRecognizer *photoLongPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        [_photoImageView addGestureRecognizer:photoLongPress];
        [photoLongPress release];
    }
    return self;
}

- (void)dealloc
{
    [_bgView release];
    [_photoImageView release];
    [_loadingView release];
    [_photoImage release];
    [super dealloc];
}

- (void)setUrl:(NSURL *)url {
    [_loadingView startAnimating];
    _photoImageView.image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:url.absoluteString];
    //addby snping 自己缓存取不到,就先用EGOCache缓存的小图-_-
    if (!_photoImageView.image) {
        _photoImageView.image =_photoImage;
    }
    [[SDWebImageManager sharedManager] downloadImageWithURL:url
                                                    options:SDWebImageRetryFailed|SDWebImageContinueInBackground
                                                   progress:NULL
                                                  completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                      if (image && !error) {
                                                          [_photoImage release];
                                                          _photoImage = [image retain];
                                                          [self displayImage];
                                                      }
                                                  }];
}

- (void)setImage:(UIImage *)image {
    [_photoImage release];
    _photoImage = [image retain];
    [self displayImage];
}

- (void)setFilePath:(NSString *)path {
    [_photoImage release];
    _photoImage = [[UIImage alloc] initWithContentsOfFile:path];
    [self displayImage];
}

- (UIImage *)getImage {
    return _photoImage;
}

- (void)setMaxMinZoomScalesForCurrentBounds {
	// Reset
	self.maximumZoomScale = 1;
	self.minimumZoomScale = 1;
	self.zoomScale = 1;
	
	// Bail
	if (_photoImageView.image == nil) return;
	
	// Sizes
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = _photoImageView.frame.size;
    
    // Calculate Min
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
	
	// If image is smaller than the screen then ensure we show it at
	// min scale of 1
	if (xScale > 1 && yScale > 1) {
		minScale = 1.0;
	}
    
	// Calculate Max
	CGFloat maxScale = 2.0; // Allow double scale
    // on high resolution screens we have double the pixel density, so we will be seeing every pixel if we limit the
    // maximum zoom scale to 0.5.
	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
		maxScale = maxScale / [[UIScreen mainScreen] scale];
	}
	
	// Set
	self.maximumZoomScale = maxScale;
	self.minimumZoomScale = minScale;
	self.zoomScale = xScale;
    _xScale = xScale;
	
	// Reset position
	_photoImageView.frame = CGRectMake(0, 0, _photoImageView.frame.size.width, _photoImageView.frame.size.height);
	[self setNeedsLayout];
}

- (void)displayImage {
    // Reset
    self.maximumZoomScale = 1;
    self.minimumZoomScale = 1;
    self.zoomScale = 1;
    self.contentSize = CGSizeMake(0, 0);
    
    // Get image from browser as it handles ordering of fetching
    if (_photoImage) {
        // Set image
        _photoImageView.image = _photoImage;
        _photoImageView.hidden = NO;
        
        // Setup photo frame
        CGRect photoImageViewFrame;
        photoImageViewFrame.origin = CGPointZero;
        photoImageViewFrame.size = _photoImage.size;
        _photoImageView.frame = photoImageViewFrame;
        self.contentSize = photoImageViewFrame.size;
        
        // Set zoom to minimum zoom
        [self setMaxMinZoomScalesForCurrentBounds];
	}
    
    [_loadingView stopAnimating];
    
    [self setNeedsLayout];
}

- (void)handleSingleTap {
    if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(zoomingViewSingleTapDetected:)]) {
        [_tapDelegate zoomingViewSingleTapDetected:self];
    }
}

- (void)handleDoubleTap:(CGPoint)touchPoint {
    if (self.zoomScale == self.maximumZoomScale) {
		[self setZoomScale:_xScale animated:YES];
	} else {
		[self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
	}
    
    if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(zoomingViewDoubleTapDetected:)]) {
        [_tapDelegate zoomingViewDoubleTapDetected:self];
    }
}

- (void)longPress:(UILongPressGestureRecognizer*)gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        if (_tapDelegate && [_tapDelegate respondsToSelector:@selector(zoomingViewLongPressedDetected:)]) {
            [_tapDelegate zoomingViewLongPressedDetected:self];
        }
    }
}

#pragma mark - Layout

- (void)layoutSubviews {
	[super layoutSubviews];
	
    _bgView.frame = self.bounds;
    
    // Center the image as it becomes smaller than the size of the screen
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = _photoImageView.frame;
    
    // Horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
	} else {
        frameToCenter.origin.x = 0;
	}
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
	} else {
        frameToCenter.origin.y = 0;
	}
    
	// Center
	if (!CGRectEqualToRect(_photoImageView.frame, frameToCenter))
		_photoImageView.frame = frameToCenter;
	
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return _photoImageView;
}

#pragma mark - SDWebImageManager delegate

- (void)webImageManager:(SDWebImageManager *)imageManager didFinishWithImage:(UIImage *)image {
    [_photoImage release];
    _photoImage = [image retain];
    [self displayImage];
}

- (void)webImageManager:(SDWebImageManager *)imageManager didProgressWithPartialImage:(UIImage *)image forURL:(NSURL *)url {
    [_photoImage release];
    _photoImage = [image retain];
    [self displayImage];
}

#pragma mark - MWTapDetectingView delegate

- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch {
    [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:0.2];
}

- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self handleDoubleTap:[touch locationInView:view]];
}


#pragma mark - MWTapDetectingImageView delegate

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch {
    [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:0.2];
}

- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self handleDoubleTap:[touch locationInView:imageView]];
}

@end
