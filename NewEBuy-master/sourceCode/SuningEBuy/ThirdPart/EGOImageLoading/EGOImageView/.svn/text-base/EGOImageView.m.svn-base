//
//  EGOImageView.m
//  EGOImageLoading
//
//  Created by Shaun Harrison on 9/15/09.
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

#import "EGOImageView.h"
#import "EGOImageLoader.h"
#import "ImageManipulator.h"

#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)


@implementation EGOImageView
@synthesize imageURL, placeholderImage, delegate;
@synthesize hasBorder =_hasBorder;
@synthesize isDataIntegrated = _isDataIntegrated;
@synthesize hasAnimateType;
@synthesize isRoundCorner = isRoundCorner_;
@synthesize imageCornerRadis = imageCornerRadius_;
@synthesize shouldAdjustPlaceholder = _shouldAdjustPlaceholder;

- (id)initWithPlaceholderImage:(UIImage*)anImage {
	return [self initWithPlaceholderImage:anImage delegate:nil];	
}

- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate {
	if((self = [super initWithImage:anImage])) {
		self.placeholderImage = anImage;
		self.delegate = aDelegate;
        self.shouldAdjustPlaceholder = YES;
	}
	
	return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        self.hasAnimateType = ImageAnimationNone;
        self.shouldAdjustPlaceholder = YES;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholderImage = [UIImage imageNamed:@"ebuy_default_image_placeholder.png"];
        self.hasAnimateType = ImageAnimationNone;
        self.shouldAdjustPlaceholder = YES;
    }
    return self;
}

- (void)setHasBorder:(BOOL)aHasBorder{
    if(aHasBorder!=_hasBorder && !_hasBorder){
        [self.layer setMasksToBounds:YES];
        //Set the corner radius
        [self.layer setCornerRadius:5.0];
        //Set the border color
        
        //UIColor *color =[UIColor colorWithRed:50/255.0 green:205/255.0 blue:50/255.0 alpha:1.0];
        UIColor *color =[UIColor whiteColor];
        [self.layer setBorderColor:[color CGColor]];
        //Set the image border
        [self.layer setBorderWidth:1];
        
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setImageURL:(NSURL *)aURL {
	if(imageURL) {
		[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:imageURL];
		[imageURL release];
		imageURL = nil;
	}
	
	if(!aURL) {
		self.image = self.placeholderImage;
		imageURL = nil;
		return;
	} else {
		imageURL = [aURL retain];
	}

	[[EGOImageLoader sharedImageLoader] removeObserver:self];
	NSData* imageData = [[EGOImageLoader sharedImageLoader] dataForURL:aURL shouldLoadWithObserver:self];
	
	if(imageData)
    {
        self.imageFileData = imageData;
        
        self.isDataIntegrated = YES;

		// trigger the delegate callback if the image was found in the cache
        if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) 
        {
            [self.delegate imageViewLoadedImage:self];
        }
	} else {
		self.image = self.placeholderImage;
	}
}

//liukun 2012-6-8
- (void)setImage:(UIImage *)image
{
    if (image == self.placeholderImage && self.shouldAdjustPlaceholder)
    {
        image = [self adjustPlaceholderImage:self.placeholderImage];
    }
    
    if (isRoundCorner_) {
        UIImage *roundImage = [ImageManipulator makeRoundCornerImage:image :imageCornerRadius_ :imageCornerRadius_];
        [super setImage:roundImage];
    }else{
        [super setImage:image];
    }
    
}

#pragma mark -
#pragma mark Image loading

- (void)cancelImageLoad {
	[[EGOImageLoader sharedImageLoader] cancelLoadForURL:self.imageURL];
	[[EGOImageLoader sharedImageLoader] removeObserver:self forURL:self.imageURL];
}

- (void)imageLoaderDidLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;

	NSData* imageData = [[notification userInfo] objectForKey:@"data"];
    
    self.imageFileData = imageData;
    
    BOOL isDataIntegrated = [[[notification userInfo] objectForKey:@"dataIntegrated"] boolValue];
    
    self.isDataIntegrated = isDataIntegrated;
    
	[self setNeedsDisplay];
    
    //animation
    switch (self.hasAnimateType) {
        case ImageAnimationSmallToBig:
        {    
            CGRect firstFrame = self.frame;
            CGRect frame = self.frame;
            frame.origin.x = firstFrame.size.width/2;
            frame.origin.y = firstFrame.size.height/2;
            frame.size.width = 1;
            frame.size.height = 1;
            self.frame = frame;
            [self.layer setAnchorPoint:CGPointMake(0.5, 0.5)];
            
            [UIView beginAnimations:@"show" context:NULL];
            //[UIView setAnimationCurve:UIViewAnimationCurveLinear];
            //  [UIView setAnimationDelegate:self];
            [UIView setAnimationDuration:0.4f];
            [UIView setAnimationDidStopSelector:@selector(animationFinished: finished: context:)];
            
            self.frame = firstFrame;
            
            [UIView commitAnimations];
            
            break;
        }  
            
        case ImageAnimationFlip:
        {    
            
            [UIView beginAnimations:@"animationID" context:nil];
            [UIView setAnimationDuration:0.4f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationRepeatAutoreverses:NO];
            //UIButton *theButton = (UIButton *)sender;
            
            [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.superview cache:NO];
            
            [self.superview exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            [UIView commitAnimations];
            
            break;
        }  
            
        case ImageAnimation3DMakeRotate:
        {
            self.hasBorder = YES;
            CABasicAnimation *origeScaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            origeScaleAnimation.fromValue = [NSNumber numberWithDouble:0.3];
            origeScaleAnimation.toValue = [NSNumber numberWithDouble:1.0];
            origeScaleAnimation.duration = 0.4f;
            //    origeScaleAnimation.autoreverses			= NO;
            origeScaleAnimation.repeatCount			= 1;  //"forever"
            origeScaleAnimation.removedOnCompletion	= YES;
            
            CABasicAnimation *transformAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
            transformAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
            transformAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(DEGREES_TO_RADIANS(150), 0.7, 0.3, 0.4)];
            transformAnimation.duration = 0.4;
            transformAnimation.autoreverses = NO;
            transformAnimation.repeatCount = 1;
            transformAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
            
            CAAnimationGroup *animGroup = [CAAnimationGroup animation];
            animGroup.animations = [NSArray arrayWithObjects:
                                    transformAnimation,
                                    origeScaleAnimation,
                                    nil];
            animGroup.duration = 0.4;
            // animGroup.delegate = self;
            //    animGroup.autoreverses = NO;
            //  animGroup.removedOnCompletion = YES;
            animGroup.repeatCount = 1;
            
            [self.layer addAnimation:animGroup forKey:@"ANimiad"];
        }    
            
        default:
            break;
    }

	
	if([self.delegate respondsToSelector:@selector(imageViewLoadedImage:)]) {
		[self.delegate imageViewLoadedImage:self];
	}	
}

- (void)imageLoaderDidFailToLoad:(NSNotification*)notification {
	if(![[[notification userInfo] objectForKey:@"imageURL"] isEqual:self.imageURL]) return;
	
	if([self.delegate respondsToSelector:@selector(imageViewFailedToLoadImage:error:)]) {
		[self.delegate imageViewFailedToLoadImage:self error:[[notification userInfo] objectForKey:@"error"]];
	}
}

#pragma mark -
- (void)dealloc {
	[[EGOImageLoader sharedImageLoader] removeObserver:self];
    
	self.imageURL = nil;
    
    TT_RELEASE_SAFELY(imageURL);
    
	self.placeholderImage = nil;    
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

@end
