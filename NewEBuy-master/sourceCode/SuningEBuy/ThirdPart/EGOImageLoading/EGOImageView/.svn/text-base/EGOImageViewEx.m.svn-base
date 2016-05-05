//
//  EGOImageViewEx.m
//  WingletterIOS
//
//  Created by Hubert Ryan on 11-5-24.
//  Copyright 2011 suning. All rights reserved.
//

#import "EGOImageViewEx.h"


@implementation EGOImageViewEx

@synthesize exDelegate = exDelegate_;

@synthesize activityView = _activityView;


- (void)dealloc {
    TT_RELEASE_SAFELY(_activityView);
    [super dealloc];
}

- (id)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event{
	
	
}
//捕获手指拖拽消息
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
	
}

//捕获手指拿开消息
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event{
	
    //停留位置在view中才响应事件
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
    if ([exDelegate_ conformsToProtocol:@protocol(EGOImageViewExDelegate)])
    {
		if ([exDelegate_ respondsToSelector:@selector(imageExViewDidOk:)])
        {
			[exDelegate_ imageExViewDidOk:self];
		}
	}
}

- (void)setImageURL:(NSURL *)aURL
{
    if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
	
	if(!aURL) {
		self.image = self.placeholderImage;
		return;
	} else {
		imageURL = [aURL retain];
	}
    
    [self.activityView startAnimating];
    
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	NSData* imageData = [[EGOImageLoader sharedImageLoader] dataForURL:aURL shouldLoadWithObserver:self];
	
	if(imageData)
    {
        self.imageFileData = imageData;
        
        [self.activityView stopAnimating];
		// trigger the delegate callback if the image was found in the cache
		if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
			[self.delegate imageViewLoadedImage:self];
		}
	} else {
		self.image = self.placeholderImage;
	}
}


- (void)imageLoaderDidLoad:(NSNotification *)notification
{
    [self.activityView stopAnimating];
    
    [super imageLoaderDidLoad:notification];
}

- (void)imageLoaderDidFailToLoad:(NSNotification *)notification
{
    [self.activityView stopAnimating];
    
    [super imageLoaderDidFailToLoad:notification];
}

- (UIActivityIndicatorView *)activityView
{
    if (!_activityView)
    {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        
        _activityView.hidesWhenStopped = YES;
        
        _activityView.frame = CGRectMake(self.width/2-10, self.height/2-10, 20, 20);
        
        [self addSubview:_activityView];
    }
    return _activityView;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.activityView.frame = CGRectMake(frame.size.width/2-10, frame.size.height/2-10, 20, 20);
}



@end
