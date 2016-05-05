//
//  SNUIImageView.m
//  SNFramework
//
//  Created by  liukun on 14-1-14.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import "SNUIImageView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "EGOPlaceholder.h"

void SNImageCacheConfig(void)
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        //设置图片缓存最大内存
        [[SDImageCache sharedImageCache] setMaxMemoryCost:1024*1024*10];
        [[SDImageCache sharedImageCache] setMaxCacheAge:3600*24*7];
    });
}

void SNImageCacheClearWithCompletion(dispatch_block_t completion)
{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:completion];
    [[SDImageCache sharedImageCache] clearMemory];
}

void SNImageCachePreloadImages(NSArray *urls)
{
    [urls enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        
        if (![[SDWebImageManager sharedManager] cachedImageExistsForURL:obj]) {
            
            [[SDWebImageManager sharedManager] downloadImageWithURL:obj
                                                            options:SDWebImageRetryFailed|SDWebImageContinueInBackground
                                                           progress:NULL
                                                          completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                                               
                                                              SNLogInfo(@"Preload %@ OK!", imageURL);
                                                           }];
        }
    }];
}

id<SNImageLoadOperation> SNImageLoadImage(NSURL *url, void(^completion)(UIImage *))
{
    id operation = [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageRetryFailed|SDWebImageContinueInBackground progress:NULL completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        
        completion(image);
    }];
    return operation;
}

void SNImageCacheClearMemory(void)
{
    [[SDImageCache sharedImageCache] clearMemory];
}

@implementation SNUIImageView

+ (instancetype)captchaView
{
    SNUIImageView *view = [[self alloc] init];
    view.cacheOptions = (SDWebImageRetryFailed|SDWebImageRefreshCached|SDWebImageContinueInBackground|SDWebImageHandleCookies|SDWebImageHighPriority);
    return view;
}

- (void)dealloc
{
    [self sd_cancelCurrentImageLoad];
}

- (void)setUp
{
    self.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder"];
    self.shouldShowIndicator = YES;
    self.cacheOptions = (SDWebImageRetryFailed|SDWebImageContinueInBackground);
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];
    }
    return self;
}


- (UIImageView *)topLineImage {
    if (!_topLineImage) {
        _topLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
        _topLineImage.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:_topLineImage];
    }
    return _topLineImage;
}


- (UIImageView *)rightLineImage {
    if (!_rightLineImage) {
        _rightLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
        _rightLineImage.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
        [self addSubview:_rightLineImage];
    }
    return _rightLineImage;
}


- (UIImageView *)bottomLineImage {
    if (!_bottomLineImage) {
        _bottomLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
        _bottomLineImage.image = [UIImage streImageNamed:@"line.png"];
        [self addSubview:_bottomLineImage];
    }
    return _bottomLineImage;
}


- (UIImageView *)leftLineImage {
    if (!_leftLineImage) {
        _leftLineImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.frame.size.height)];
        _leftLineImage.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
        [self addSubview:_leftLineImage];
    }
    return _leftLineImage;
}

- (void)setTouchEndBlock:(void (^)(SNUIImageView *))touchEndBlock
{
    _touchEndBlock = [touchEndBlock copy];
    if (_touchEndBlock) {
        self.userInteractionEnabled = YES;
    }
}

- (UIActivityIndicatorView *)indicatorView
{
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (void)setRefreshCached:(BOOL)refreshCached
{
    _refreshCached = refreshCached;
    if (_refreshCached) {
        self.cacheOptions |= SDWebImageRefreshCached;
    } else {
        self.cacheOptions &= (0xffff ^ SDWebImageRefreshCached);
    }
}

- (void)setImageURL:(NSURL *)imageURL
{
    if (_imageURL != imageURL) {
        _imageURL = imageURL;
        
        if (self.shouldShowIndicator) [self.indicatorView startAnimating];
        
        @weakify(self);
        [self sd_setImageWithURL:_imageURL placeholderImage:self.placeholderImage options:self.cacheOptions progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            @strongify(self);
            if (self.shouldShowIndicator) [self.indicatorView stopAnimating];
            
            if (image)
            {                
                if ([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
                    [self.delegate imageViewLoadedImage:self];
                }
            }
            else
            {
                SNLogError(@"ImageLoadError: %@", error);
                if ([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
                    [self.delegate imageViewFailedToLoadImage:self error:error];
                }
            }
        }];
        
    } else if (imageURL == nil) {
        
        self.image = self.placeholderImage;
    }
}

- (void)setFrame:(CGRect)frame
{
    if (!CGSizeEqualToSize(self.frame.size, frame.size))
    {
        _adjustedPlaceholder = nil;
    }
    [super setFrame:frame];
}

- (void)setImage:(UIImage *)image
{
    if (image == self.placeholderImage)
    {
        if (!_adjustedPlaceholder) {
            _adjustedPlaceholder = [EGOPlaceholder adjustPlaceholderImage:image size:self.frame.size];
        }
        image = _adjustedPlaceholder;
    }
    [super setImage:image];
}

- (void)addRightBottomLine {
    
    self.rightLineImage.frame = CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height);
    self.bottomLineImage.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    
    /*
    //bottom
    UIImageView *horizonImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    horizonImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:horizonImageView];
    TT_RELEASE_SAFELY(horizonImageView);
    
    //right
    UIImageView *verticalImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    verticalImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:verticalImageView];
    TT_RELEASE_SAFELY(verticalImageView);
     */
}


- (void)addTopRightBottonLine {
    
    self.topLineImage.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    self.rightLineImage.frame = CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height);
    self.bottomLineImage.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    /*
    //top
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    topImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:topImageView];
    TT_RELEASE_SAFELY(topImageView);
    
    //right
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    rightImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:rightImageView];
    TT_RELEASE_SAFELY(rightImageView);
    
    //bottom
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    bottomImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
     */
}

- (void)addFullLine {
    
    self.topLineImage.frame = CGRectMake(0, 0, self.frame.size.width, 0.5);
    self.rightLineImage.frame = CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height);
    self.bottomLineImage.frame = CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5);
    self.leftLineImage.frame = CGRectMake(0, 0, 0.5, self.frame.size.height);
    
    /*
    //top
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 0.5)];
    topImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:topImageView];
    TT_RELEASE_SAFELY(topImageView);
    
    //right
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-0.5, 0, 0.5, self.frame.size.height)];
    rightImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:rightImageView];
    TT_RELEASE_SAFELY(rightImageView);
    
    //bottom
    UIImageView *bottomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, self.frame.size.width, 0.5)];
    bottomImageView.image = [UIImage streImageNamed:@"line.png"];
    [self addSubview:bottomImageView];
    TT_RELEASE_SAFELY(bottomImageView);
    
    //left
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.frame.size.height)];
    leftImageView.image = [UIImage streImageNamed:@"segment_vertical_line.png"];
    [self addSubview:leftImageView];
    TT_RELEASE_SAFELY(leftImageView);
     */
}

#pragma mark ----------------------------- touches

//捕获手指拿开消息
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
    
    if (touch)
    {
        CGPoint location = [touch locationInView:self];
        if (location.x < self.width && location.x > 0 &&
            location.y < self.height && location.y > 0)
        {
            [self callEvent];
        }
    }
}


- (void)callEvent
{
    if (_touchEndBlock) {
        _touchEndBlock(self);
    }
}

@end

#pragma mark - EGOImageViewEx

@implementation EGOImageViewEx

- (void)setUp
{
    [super setUp];
    
    @weakify(self);
    [self setTouchEndBlock:^(SNUIImageView *imageView) {
        
        @strongify(self);
        if ([self.exDelegate respondsToSelector:@selector(imageExViewDidOk:)]) {
            [self.exDelegate imageExViewDidOk:self];
        }
    }];
}

@end
