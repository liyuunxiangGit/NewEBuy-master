//
//  EGOImageView.h
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
//  v1.0.001  12-8-28 刘坤

#import <UIKit/UIKit.h>
#import "EGOImageLoader.h"
#import "AnimatedImageView.h"

typedef enum
{
    ImageAnimationNone = 0,
    ImageAnimationSmallToBig,
    ImageAnimationFlip,
    ImageAnimation3DMakeRotate
}GOEForAnimation;

@protocol EGOImageViewDelegate;
@interface EGOImageView : AnimatedImageView<EGOImageLoaderObserver> {
//@private
	NSURL* imageURL;
	UIImage* placeholderImage;
	id<EGOImageViewDelegate> delegate;
    BOOL _hasBorder;
    
    //刘坤，2012-6-8， 添加是否将图片显示圆角
    BOOL isRoundCorner_;
    NSInteger imageCornerRadius_;
}

- (id)initWithPlaceholderImage:(UIImage*)anImage; // delegate:nil
- (id)initWithPlaceholderImage:(UIImage*)anImage delegate:(id<EGOImageViewDelegate>)aDelegate;

- (void)cancelImageLoad;

@property(nonatomic,retain) NSURL* imageURL;
@property(nonatomic,retain) UIImage* placeholderImage;
@property(nonatomic,assign) id<EGOImageViewDelegate> delegate;
@property(nonatomic,assign) BOOL hasBorder;
@property(nonatomic,assign) BOOL isDataIntegrated;

@property(nonatomic,assign) GOEForAnimation hasAnimateType;
@property(nonatomic,assign) BOOL isRoundCorner;
@property(nonatomic,assign) NSInteger imageCornerRadis;
@property(nonatomic,assign) BOOL shouldAdjustPlaceholder;   //是否自适应placeholder, 默认yes

- (void)setHasBorder:(BOOL)aHasBorder;

@end

@protocol EGOImageViewDelegate<NSObject>
@optional
- (void)imageViewLoadedImage:(EGOImageView*)imageView;
- (void)imageViewFailedToLoadImage:(EGOImageView*)imageView error:(NSError*)error;
@end