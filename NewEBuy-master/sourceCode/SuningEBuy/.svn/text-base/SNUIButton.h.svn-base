//
//  SNUIButton.h
//  SNFramework
//
//  Created by  liukun on 14-1-3.
//  Copyright (c) 2014年 liukun. All rights reserved.
//

#import <UIKit/UIKit.h>

#define EGOImageButton SNUIButton

@protocol EGOImageButtonDelegate;
@interface SNUIButton : UIButton
{
    NSURL       *_imageURL;
    UIImage     *_placeholder;
    UIImage     *_adjustedPlaceholder;
}

/** imageURL */
@property (nonatomic, strong) NSURL *imageURL;
/** placeholder */
@property (nonatomic, strong) UIImage *placeholderImage;
/** ImageOptions */
@property (nonatomic, assign) NSUInteger cacheOptions;
/** Loading框 */
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
/** 是否展示加载中 */
@property (nonatomic, assign) BOOL shouldShowIndicator;
/** 设置为YES时，cache由NSURLCache管理*/
@property (nonatomic, assign) BOOL refreshCached;

/**
 *  为验证码图片定制的view
 */
+ (instancetype)captchaView;

/**
 *  为图片的底边添加一条线，右侧离button的右边距离5
 */
- (void)addBottomLineRightOffset;

/**
 *  为图片的底边和右边添加一条线，底边左离button的左边距离5
 */
- (void)addRightBottomLineLeftOffset;

/**
 *  为图片的左边添加一条线
 */
- (void)addLeftLine;

/**
 *  为图片的顶边添加一条线
 */
- (void)addTopLine;

/**
 *  为图片的底边添加一条线
 */
- (void)addBottomLine;

/**
 *  为图片的右边和底边添加一条线
 */
- (void)addRightBottomLine;

/**
 *  为图片的顶部、右边、底边添加一条线
 */
- (void)addTopRightBottomLine;

/**
 *  4个边都添加线
 */
- (void)addFullLine;

@property(nonatomic, weak) id<EGOImageButtonDelegate> delegate;

@end

@protocol EGOImageButtonDelegate<NSObject>
@optional
- (void)imageButtonLoadedImage:(EGOImageButton*)imageButton;
- (void)imageButtonFailedToLoadImage:(EGOImageButton*)imageButton error:(NSError*)error;
@end
