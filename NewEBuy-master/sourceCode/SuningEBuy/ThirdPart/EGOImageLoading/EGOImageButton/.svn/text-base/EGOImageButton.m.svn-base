//
//  EGOImageButton.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/30/09.
//  Copyright (c) 2009-2010 enormego
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import "EGOImageButton.h"
#import "EGOImageLoader.h"
#import "ImageManipulator.h"

@implementation EGOImageButton
@synthesize imageURL, placeholderImage, delegate,shouldAdjustPlaceholder,isRoundCorner;
@synthesize activityView = _activityView;



- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageButtonDelegate>)aDelegate {
	if((self = [super initWithFrame:CGRectZero])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
        self.shouldAdjustPlaceholder = YES;
		[self setImage:self.placeholderImage forState:UIControlStateNormal];
	}
	
	return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        self.shouldAdjustPlaceholder = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        self.shouldAdjustPlaceholder = YES;
    }
    return self;
}


- (void)setImageURL:(NSURL *)aURL {
	if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
	
	if(!aURL) {
		[self setImage:self.placeholderImage forState:UIControlStateNormal];
		imageURL = nil;
		return;
	} else {
		imageURL = [aURL retain];
	}
    
    [self.activityView startAnimating];
    
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	NSData* imageData = [[EGOImageLoader sharedImageLoader] dataForURL:aURL shouldLoadWithObserver:self];
	
	if(imageData)
    {
        [self.activityView stopAnimating];
        UIImage *anImage = [UIImage imageWithData:imageData];
        [self setImage:anImage forState:UIControlStateNormal];
        
	} else {
        [self setImage:self.placeholderImage forState:UIControlStateNormal];
	}
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    if (image == self.placeholderImage && self.shouldAdjustPlaceholder)
    {
        image = [self adjustPlaceholderImage:self.placeholderImage];
    }
    
    if (isRoundCorner_) {
        UIImage *roundImage = [ImageManipulator makeRoundCornerImage:image :imageCornerRadius_ :imageCornerRadius_];
        [super setImage:roundImage forState:state];
    }else{
        [super setImage:image forState:state];
    }
    
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
    [self.activityView stopAnimating];
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
    NSData* imageData = [[notification userInfo] objectForKey:@"data"];
    UIImage* anImage = [UIImage imageWithData:imageData];
	[self setImage:anImage forState:UIControlStateNormal];
	[self setNeedsDisplay];
	
	if([self.delegate respondsToSelector:@selector(imageButtonLoadedImage:)]) {
		[self.delegate imageButtonLoadedImage:self];
	}
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
    [self.activityView stopAnimating];
    
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
	if([self.delegate respondsToSelector:@selector(imageButtonFailedToLoadImage:error:)]) {
		[self.delegate imageButtonFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}

#pragma mark -
- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	
	self.imageURL = nil;
    TT_RELEASE_SAFELY(imageURL);
    
	self.placeholderImage = nil;
    
    TT_RELEASE_SAFELY(_activityView);
    
    [super dealloc];
}


- (UIImage *)adjustPlaceholderImage:(UIImage *)image
{
    if (!image) {
        return nil;
    }
    CGFloat width = self.bounds.size.width*2;
    CGFloat height = self.bounds.size.height*2;
    
    CGSize size = CGSizeMake(width, height);
    CGRect bounds = CGRectMake(0, 0, width, height);
    UIGraphicsBeginImageContext(size);
    
    CGRect imageRect = CGRectZero;
    if (width > height) {
        imageRect = CGRectMake((width-height)/2, 0, height, height);
    }else{
        imageRect = CGRectMake(0, (height-width)/2, width, width);
    }
    
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, RGBCOLOR(250, 246, 237).CGColor);
	CGContextFillRect(context, bounds);
    
    [image drawInRect:imageRect blendMode:kCGBlendModeNormal alpha:1.0];
	
	UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return testImg;
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
