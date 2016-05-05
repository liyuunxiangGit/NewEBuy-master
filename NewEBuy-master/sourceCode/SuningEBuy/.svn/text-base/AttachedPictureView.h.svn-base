//
//  AttachedPictureView.h
//  iweibo
//
//  Created by Minwen Yi on 1/4/12.
//  Copyright 2012 Beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FrameImageTag				600
#define AttachedImageTag			(FrameImageTag + 1)

@protocol AttachedPictureViewDelegate;

@interface AttachedPictureView : UIView {
	id<AttachedPictureViewDelegate>		__weak myAttachedPictureViewDelegate;
}

@property (nonatomic, weak) id<AttachedPictureViewDelegate> myAttachedPictureViewDelegate;

// 设置图片
-(void)setAttachedImage:(UIImage *)attachedImage;
@end

@protocol AttachedPictureViewDelegate<NSObject>
- (void)AttachedPictureViewClicked;
@end