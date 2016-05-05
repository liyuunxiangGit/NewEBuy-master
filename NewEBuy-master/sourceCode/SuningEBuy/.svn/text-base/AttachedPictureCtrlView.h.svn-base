//
//  AttachedPictureCtrlView.h
//  iweibo
// 
//	附件图片操作类
// 
//  Created by Minwen Yi on 1/5/12.
//  Copyright 2012 Beyondsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CtrlViewTagBase						700
#define CtrlViewDeleteBtnTag				(CtrlViewTagBase + 1)
#define	CtrlViewImageTag					(CtrlViewTagBase + 2)

#define ImageMaxHeight						180.0f
#define ImageMaxWidth						180.0f
@protocol AttachedPictureCtrlViewDelegate;

@interface AttachedPictureCtrlView : UIView {
	UIImageView									*baseView;
	id<AttachedPictureCtrlViewDelegate>		__weak myAttachedPictureCtrlViewDelegate;
}
@property (nonatomic) UIImageView		*baseView;
@property (nonatomic, weak) id<AttachedPictureCtrlViewDelegate>	myAttachedPictureCtrlViewDelegate;

- (void)attachImage:(UIImage *)imageRef;
@end

@protocol AttachedPictureCtrlViewDelegate<NSObject> 
// 点击删除按钮
-(void)picCtrlViewDelBtnClicked;
@end