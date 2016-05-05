//
//  AttachedPictureView.m
//  iweibo
//
//  Created by Minwen Yi on 1/4/12.
//  Copyright 2012 Beyondsoft. All rights reserved.
//

#import "AttachedPictureView.h"


@implementation AttachedPictureView
@synthesize myAttachedPictureViewDelegate;



-(void)setAttachedImage:(UIImage *)attachedImage {
	UIImageView *frameImage = (UIImageView *)[self viewWithTag:AttachedImageTag];
	if (frameImage) {
		[frameImage removeFromSuperview];
	}
	UIImageView *iv = [[UIImageView alloc] initWithImage:attachedImage];
	iv.frame = CGRectMake(16, 5.0f, 24, 24);
	iv.tag = AttachedImageTag;
	[iv setUserInteractionEnabled:YES];
	[self addSubview:iv];
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTaped:)];
	[iv addGestureRecognizer:tapGesture];
	
	UIButton *frameBtn2 = (UIButton *)[self viewWithTag:FrameImageTag];
	if (frameBtn2) {
		[frameBtn2 removeFromSuperview];
	}
	UIButton *frameBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	frameBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
	frameBtn.tag = FrameImageTag;
    [frameBtn setImage:[UIImage imageNamed:@"composeImageFrame.png"] forState:UIControlStateNormal];
	[frameBtn setImage:[UIImage imageNamed:@"composeImageFrame.png"] forState:UIControlStateHighlighted];
	[frameBtn addTarget:self action:@selector(BtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:frameBtn];
}

- (void)BtnClicked {
	
	if ([self.myAttachedPictureViewDelegate respondsToSelector:@selector(AttachedPictureViewClicked)]) {
		[self.myAttachedPictureViewDelegate AttachedPictureViewClicked];
	}
}

-(void)imageTaped:(UITapGestureRecognizer *)recognizer {
	[self BtnClicked];
}
@end
