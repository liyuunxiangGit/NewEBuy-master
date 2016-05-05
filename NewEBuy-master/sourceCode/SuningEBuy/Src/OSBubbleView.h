//
//  OSBubbleView.h
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSMsgDTO.h"
#import "OSMessageLabel.h"

#define kOSBubbleTextFont           [UIFont systemFontOfSize:15.0f]
#define kOSBubbleTextColor          [UIColor darkTextColor]
#define kOSBubbleMaxWidth           (204.0f)
#define kOSBubbleHorizontalMargin   (14.0f)
#define kOSBubbleVerticalMargin     (14.0f)
#define kOSBubbleTipWidth           (7.0f)
#define kOSBubbleMaxTextWidth       (kOSBubbleMaxWidth - kOSBubbleTipWidth - 2 * kOSBubbleHorizontalMargin)
#define kOSBubbleImageSize          (CGSizeMake(70,70))

@class OSBubbleView;
@protocol OSBubbleViewDelegate <NSObject>

@optional
- (void)bubbleViewLongPressed:(OSBubbleView *)bubbleView;    //长按
- (void)bubbleViewTapPressed:(OSBubbleView *)bubbleView;     //点按
- (void)bubbleView:(OSBubbleView *)bubbleView didTouchImageWithUrl:(NSURL *)imgUrl;

@end

@interface OSBubbleView : UIView <UIGestureRecognizerDelegate>
{

}

@property (nonatomic, strong) UIImageView *bubbleImageView;
@property (nonatomic, strong) OSMessageLabel *messageLabel;
@property (nonatomic, strong) EGOImageButton *imageBtn;
@property (nonatomic, assign) id<OSBubbleViewDelegate> delegate;

@property (nonatomic, strong) OSMsgDTO *msgDTO;


- (void)updateBubbleViewWithMessage:(OSMsgDTO *)message;


+ (CGFloat)height:(OSMsgDTO *)message;

@end
