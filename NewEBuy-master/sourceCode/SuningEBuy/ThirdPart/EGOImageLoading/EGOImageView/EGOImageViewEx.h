//
//  EGOImageViewEx.h
//  WingletterIOS
//
//  Created by Hubert Ryan on 11-5-24.
//  Copyright 2011 suning. All rights reserved.
//

#import "EGOImageView.h"

@protocol EGOImageViewExDelegate;

@interface EGOImageViewEx : EGOImageView {

	id <EGOImageViewExDelegate> exDelegate_;
    
}

@property (nonatomic, assign) id <EGOImageViewExDelegate> exDelegate;

@property (nonatomic, retain) UIActivityIndicatorView *activityView;

- (void)setFrame:(CGRect)frame;

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;
//捕获手指拖拽消息
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//捕获手指拿开消息
- (void) touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event;

@end



@protocol EGOImageViewExDelegate <NSObject>
@optional
- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx;
@end
