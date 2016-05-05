//
//  DisOrderPhotoView.m
//  SuningEBuy
//
//  Created by caowei on 12-2-29.
//  Copyright (c) 2012年 sn. All rights reserved.
//
#import "DisOrderPhotoView.h"
#define ZOOM_VIEW_TAG 100

@interface DisOrderPhotoView()

/*image view*/
@property (nonatomic, strong) EGOImageView *imageView;

/*activity view: display animation during loading image*/
@property (nonatomic, strong) UIActivityIndicatorView *activityView;


@end

/**********************************************************/

@implementation DisOrderPhotoView

@synthesize imageView = _imageView;
@synthesize activityView = _activityView;
@synthesize ptDelegate = _ptDelegate;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_activityView);
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        
        self.delegate = self;
        
        self.bouncesZoom = YES;     //缩放时可以反弹
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 3.0;
        
        [self addSubview:self.imageView];
        
        [self addSubview:self.activityView];
    }
    return self;
}

- (EGOImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[EGOImageView alloc] initWithFrame:CGRectZero];
        
        _imageView.tag = ZOOM_VIEW_TAG;
        
        _imageView.userInteractionEnabled = YES;
        
        _imageView.delegate = self;
        
        [_imageView setPlaceholderImage:[UIImage imageNamed:kProductImageViewDefultImage]];
        
        changeFrame = _imageView.frame;
        
    }
    return _imageView;
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        
        _activityView.hidesWhenStopped = YES;
        
        _activityView.frame = CGRectMake(150, 230, 20, 20);
    }
    return _activityView;
}

- (void)setImageUrl:(NSURL *)imageUrl
{
    if (!self.imageView.imageURL)
    {
        [self.activityView startAnimating];
        
        self.imageView.imageURL = imageUrl;
    }
}

- (BOOL)isZoomed
{
    return !([self zoomScale] == [self minimumZoomScale]);
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center 
{
    
    CGRect zoomRect;
    
    // the zoom rect is in the content view's coordinates. 
    //    At a zoom scale of 1.0, it would be the size of the imageScrollView's bounds.
    //    As the zoom scale decreases, so more content is visible, the size of the rect grows.
    zoomRect.size.height = [self frame].size.height / scale;
    zoomRect.size.width  = [self frame].size.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    return zoomRect;
}

- (void)zoomToLocation:(CGPoint)location animated:(BOOL)animate
{
    float newScale;
    CGRect zoomRect;
    if ([self isZoomed]) {
        zoomRect = [self bounds];
    } else {
        newScale = [self maximumZoomScale];
        zoomRect = [self zoomRectForScale:newScale withCenter:location];
    }
    
    [self zoomToRect:zoomRect animated:animate];//放大 
}

- (void)turnOffZoom
{
    if ([self isZoomed]) {
        [self zoomToLocation:CGPointZero animated:NO];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
    UITouch *touch = [touches anyObject];
    DLog(@"touchesEnded");
    // if ([touch view] == self) {
    if ([touch tapCount] == 2) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(toggleChromeDisplay) object:nil];
        [self zoomToLocation:[touch locationInView:self] animated:YES];
        
        // self.contentSize = 
        //CGSizeMake(imageView_.frame.size.width, imageView_.frame.size.height);
    }
    // }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    //if ([touch view] == self) {
    if ([touch tapCount] == 1) {
        [self performSelector:@selector(toggleChromeDisplay) withObject:nil afterDelay:0.5];
    }
    //}
}

- (void)toggleChromeDisplay
{
    if ([self.ptDelegate conformsToProtocol:@protocol(PhotoViewDelegate)])
    {
        if ([self.ptDelegate respondsToSelector:@selector(singleTouchTheImageView:)])
        {
            [self.ptDelegate singleTouchTheImageView:self];
        }
    }
}


#pragma mark -
#pragma mark UIScrollView Delegate Methods

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

#pragma mark -
#pragma mark Methods called during rotation to preserve the zoomScale and the visible portion of the image

- (void)setMaxMinZoomScalesForCurrentBounds
{
    CGSize boundsSize = self.bounds.size;
    CGSize imageSize = self.imageView.bounds.size;
    
    // calculate min/max zoomscale
    CGFloat xScale = boundsSize.width / imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / imageSize.height;  // the scale needed to perfectly fit the image height-wise
    CGFloat minScale = MIN(xScale, yScale);                 // use minimum of these to allow the image to become fully visible
    
    // on high resolution screens we have double the pixel density, so we will be seeing every pixel if we limit the
    // maximum zoom scale to 0.5.
    CGFloat maxScale = 1.0 / [[UIScreen mainScreen] scale];
    
    // don't let minScale exceed maxScale. (If the image is smaller than the screen, we don't want to force it to be zoomed.) 
    if (minScale > maxScale) {
        minScale = maxScale;
    }
    
    self.maximumZoomScale = maxScale;
    self.minimumZoomScale = minScale;
}

// returns the center point, in image coordinate space, to try to restore after rotation. 
- (CGPoint)pointToCenterAfterRotation
{
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    return [self convertPoint:boundsCenter toView:self.imageView];
}

// returns the zoom scale to attempt to restore after rotation. 
- (CGFloat)scaleToRestoreAfterRotation
{
    CGFloat contentScale = self.zoomScale;
    
    // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum
    // allowable scale when the scale is restored.
    if (contentScale <= self.minimumZoomScale + FLT_EPSILON)
        contentScale = 0;
    
    return contentScale;
}

- (CGPoint)maximumContentOffset
{
    CGSize contentSize = self.contentSize;
    CGSize boundsSize = self.bounds.size;
    return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)minimumContentOffset
{
    return CGPointZero;
}

// Adjusts content offset and scale to try to preserve the old zoomscale and center.
- (void)restoreCenterPoint:(CGPoint)oldCenter scale:(CGFloat)oldScale
{    
    
    DLog(@"restoreCenterPoint");
    // Step 1: restore zoom scale, first making sure it is within the allowable range.
    self.zoomScale = MIN(self.maximumZoomScale, MAX(self.minimumZoomScale, oldScale));
    
    
    // Step 2: restore center point, first making sure it is within the allowable range.
    
    // 2a: convert our desired center point back to our own coordinate space
    CGPoint boundsCenter = [self convertPoint:oldCenter fromView:self.imageView];
    // 2b: calculate the content offset that would yield that center point
    CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width / 2.0, 
                                 boundsCenter.y - self.bounds.size.height / 2.0);
    // 2c: restore offset, adjusted to be within the allowable range
    CGPoint maxOffset = [self maximumContentOffset];
    CGPoint minOffset = [self minimumContentOffset];
    offset.x = MAX(minOffset.x, MIN(maxOffset.x, offset.x));
    offset.y = MAX(minOffset.y, MIN(maxOffset.y, offset.y));
    self.contentOffset = offset;
}


#pragma mark -
#pragma mark EGOImage View Delegate Methods

- (void)imageViewLoadedImage:(EGOImageView *)imageView
{    
    changeFrame = self.imageView.frame;
    
    if (imageView.image.size.height < 480) {
        
        changeFrame.size.width = 320;
        
        changeFrame.origin.x = 0 ;
        
        changeFrame.size.height = (imageView.image.size.width * 480 /320) >480? 480:(imageView.image.size.width * 480 /320);
         
        changeFrame.origin.y = (480 - changeFrame.size.height) /2;
         
    }else
    {
        changeFrame.size.height = 480;
        changeFrame.size.width =  (imageView.image.size.width * 480)/imageView.image.size.height;
        
        changeFrame.origin.y = 0;
        
        if (changeFrame.size.width < 320) {
            //changeFrame.size.width = imageView.image.size.width;
            changeFrame.origin.x = (320 - changeFrame.size.width) /2 ;
        }else
        {
            changeFrame.size.width = 320;
            changeFrame.size.height =  (imageView.image.size.height * 320)/imageView.image.size.width;
            
            changeFrame.origin.x = 0;//-((imageView.image.size.width - 320) /2) ;
            changeFrame.origin.y = (480 - changeFrame.size.height) /2 ;
            
        }    
        
    }
    [self.activityView stopAnimating];
    
    [self setNeedsLayout];
}





- (void)imageViewFailedToLoadImage:(EGOImageView *)imageView error:(NSError *)error
{    
    changeFrame = self.imageView.frame;
    
    if (imageView.image.size.height < 480) {
        
        changeFrame.size.height = imageView.image.size.height; 
        changeFrame.origin.y = (480 - imageView.image.size.height) /2 ;
        
        if (imageView.image.size.width < 320) {
            changeFrame.size.width = imageView.image.size.width;
            changeFrame.origin.x = (320 - imageView.image.size.width) /2 ;
        }else
        {
            changeFrame.size.width = 320;
            changeFrame.size.height =  (imageView.image.size.height * 320)/imageView.image.size.width;
            
            changeFrame.origin.x = 0;//-((imageView.image.size.width - 320) /2) ;
            changeFrame.origin.y =  (480 - changeFrame.size.height) /2;
        }    
        
    }else
    {
        changeFrame.size.height = 480;
        changeFrame.size.width =  (imageView.image.size.width * 480)/imageView.image.size.height;
        
        changeFrame.origin.y = 0;
        
        if (changeFrame.size.width < 320) {
            //changeFrame.size.width = imageView.image.size.width;
            changeFrame.origin.x = (320 - changeFrame.size.width) /2 ;
        }else
        {
            changeFrame.size.width = 320;
            changeFrame.size.height =  (imageView.image.size.height * 320)/imageView.image.size.width;
            
            changeFrame.origin.x = 0;//-((imageView.image.size.width - 320) /2) ;
            changeFrame.origin.y = (480 - changeFrame.size.height) /2 ;
            
        }    
        
    }
    
    [self.activityView stopAnimating];
    
    [self setNeedsLayout];
    
}


- (void)layoutSubviews 
{
    [super layoutSubviews];
    
    if ([self isZoomed]== NO) {
        
        [self.imageView setFrame: changeFrame];
        
    }else
    {
        
        CGRect Fram = self.imageView.frame;
        
        if (Fram.size.width > 320) {
            Fram.origin.x =0;
        }else{
            Fram.origin.x =  160 - (Fram.size.width / 2.0);;
        }
        
        if (Fram.size.height > 480) {
            Fram.origin.y =0;
        }else{
            Fram.origin.y =  240 - (Fram.size.height / 2.0);;
        }
        
        [self.imageView setFrame: Fram];
        
    }    
}


@end