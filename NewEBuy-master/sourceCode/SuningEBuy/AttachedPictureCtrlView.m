//
//  AttachedPictureCtrlView.m
//  iweibo
//
//  Created by Minwen Yi on 1/5/12.
//  Copyright 2012 Beyondsoft. All rights reserved.
//

#import "AttachedPictureCtrlView.h"
#import <QuartzCore/QuartzCore.h>

@implementation AttachedPictureCtrlView
@synthesize baseView;
@synthesize myAttachedPictureCtrlViewDelegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
		// 添加删除按钮
		// 添加背景
		baseView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
		[baseView setUserInteractionEnabled:YES];
		[self addSubview:self.baseView];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/


- (void)attachImage:(UIImage *)imageRef {
	UIImageView *imageViewBefore = (UIImageView *)[self viewWithTag:CtrlViewImageTag];
	if (imageViewBefore) {
		[imageViewBefore removeFromSuperview];
	}
	// 图片进行横向纵向变形(默认先用180*180)
	CGSize size = imageRef.size;
	NSInteger frameWidth = ImageMaxWidth;
	NSInteger frameHeight = ImageMaxHeight;
	// 变形逻辑：按原图比例缩放，最大宽度或者高度为180
	if (size.height < ImageMaxHeight - 0.01f && size.width < ImageMaxWidth - 0.01f) {
		// 保持原始尺寸不变
		frameWidth = imageRef.size.width;
		frameHeight = imageRef.size.height;
	}
	else {
		CGFloat h = (ImageMaxHeight / size.height);
		CGFloat w = (ImageMaxWidth / size.width);
		if (h > w) {
			frameWidth = ImageMaxWidth;
			frameHeight = size.height * w;		// 变窄高度
		}
		else {
			frameWidth = size.width * h;
			frameHeight = ImageMaxHeight;			// 变窄宽度
		}
	}

	baseView.frame = CGRectMake((ImageMaxWidth - frameWidth)/2.0f, (ImageMaxHeight - frameHeight)/2.0f, frameWidth, frameHeight);
	baseView.image = [UIImage imageNamed:@"composepic_biankuang.png"];
	UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(3.0f, 3.0f, frameWidth - 6.0f, frameHeight - 6.0f)];
	[imageView setUserInteractionEnabled:YES];
	imageView.layer.masksToBounds = YES;
	imageView.layer.cornerRadius = 3.0f;
	imageView.image = imageRef;
	imageView.tag = CtrlViewImageTag;
	[baseView addSubview:imageView];
	
	UIButton *DelBtnBefore = (UIButton *)[self viewWithTag:CtrlViewDeleteBtnTag];
	if (DelBtnBefore) {
		[DelBtnBefore removeFromSuperview];
	}
	UIButton *DelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	DelBtn.frame = CGRectMake((ImageMaxWidth - frameWidth)/2.0f - 8.0f, (ImageMaxHeight - frameHeight)/2.0f - 8.0f, 20, 20);
	DelBtn.tag = CtrlViewDeleteBtnTag;
	[DelBtn setImage:[UIImage imageNamed:@"composeImageDel.png"] forState:UIControlStateNormal];
	[DelBtn setImage:[UIImage imageNamed:@"composeImageDel.png"] forState:UIControlStateHighlighted];
	[DelBtn addTarget:self action:@selector(BtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:DelBtn];
	
	// 扩大点击范围
	UIButton *DelBtnBeforeBase = (UIButton *)[self viewWithTag:CtrlViewDeleteBtnTag + 3];
	if (DelBtnBeforeBase) {
		[DelBtnBeforeBase removeFromSuperview];
	}
	UIButton *DelBtnBase = [UIButton buttonWithType:UIButtonTypeCustom];
	DelBtnBase.frame = CGRectMake((ImageMaxWidth - frameWidth)/2.0f - 10.0f, (ImageMaxHeight - frameHeight)/2.0f - 10.0f, 58, 58);
	DelBtnBase.tag = CtrlViewDeleteBtnTag + 3;
	[DelBtnBase addTarget:self action:@selector(BtnClicked) forControlEvents:UIControlEventTouchUpInside];
	[self addSubview:DelBtnBase];
}

- (void)BtnClicked {
	if ([self.myAttachedPictureCtrlViewDelegate respondsToSelector:@selector(picCtrlViewDelBtnClicked)]) {
		[self.myAttachedPictureCtrlViewDelegate picCtrlViewDelBtnClicked];
	}
}

@end
