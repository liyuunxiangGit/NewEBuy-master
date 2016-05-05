//
//  OSBubbleView.m
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSBubbleView.h"


@interface OSBubbleView() <EGOImageButtonDelegate>

@end

/*********************************************************************/

@implementation OSBubbleView

- (void)setUp
{
    UILongPressGestureRecognizer *longpressGesture  = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
    longpressGesture.minimumPressDuration           = 0.5;
    [self addGestureRecognizer:longpressGesture];
    
    UITapGestureRecognizer *tappressGesture  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapPress)];
    [self addGestureRecognizer:tappressGesture];
    
    [self bubbleImageView];
}

- (id)init
{
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)updateBubbleViewWithMessage:(OSMsgDTO *)message
{
    self.msgDTO = message;
    
    switch (message.type) {
        case OSMsgNormal:
        default:
        {
            _imageBtn.hidden = YES;
            self.messageLabel.hidden = NO;
            
            //计算frame
            CGSize textSize = message.visibleSize;
            CGFloat msgLeft = 10;
            if (message.isSelf)
            {
                self.bubbleImageView.image = [[UIImage imageNamed:OS_CHAT_BUBBLE_SELF]stretchableImageWithLeftCapWidth:12 topCapHeight:20];
                self.bubbleImageView.frame = CGRectMake(0, 0, textSize.width+2*kOSBubbleHorizontalMargin+kOSBubbleTipWidth, textSize.height+2*kOSBubbleVerticalMargin);
                self.size = self.bubbleImageView.size;
                msgLeft = kOSBubbleHorizontalMargin;
                self.messageLabel.textColor = RGBCOLOR(51, 51, 51);
            }
            else
            {
                self.bubbleImageView.image = [[UIImage imageNamed:OS_CHAT_BUBBLE_FRIEND]stretchableImageWithLeftCapWidth:22 topCapHeight:20];
                self.bubbleImageView.frame = CGRectMake(0, 0, textSize.width+2*kOSBubbleHorizontalMargin+kOSBubbleTipWidth, textSize.height+2*kOSBubbleVerticalMargin);
                self.size = self.bubbleImageView.size;
                msgLeft = kOSBubbleHorizontalMargin+kOSBubbleTipWidth;
                self.messageLabel.textColor = RGBCOLOR(102, 102, 102);
            }
            self.messageLabel.frame = CGRectMake(msgLeft, kOSBubbleVerticalMargin, textSize.width, textSize.height);
            self.messageLabel.attributedText = message.messageAttributedString;
            break;
        }
        case OSMsgScreenShot:
        {
            self.imageBtn.hidden = NO;
            _messageLabel.hidden = YES;
            
            CGSize contentSize = kOSBubbleImageSize;
            
            CGFloat msgLeft = 10;
            if (message.isSelf)
            {
                self.bubbleImageView.image = [[UIImage imageNamed:OS_CHAT_BUBBLE_SELF]stretchableImageWithLeftCapWidth:12 topCapHeight:20];
                self.bubbleImageView.frame = CGRectMake(0, 0, contentSize.width+2*kOSBubbleHorizontalMargin+kOSBubbleTipWidth, contentSize.height+2*kOSBubbleVerticalMargin);
                self.size = self.bubbleImageView.size;
                msgLeft = kOSBubbleHorizontalMargin;
            }
            else
            {
                self.bubbleImageView.image = [[UIImage imageNamed:OS_CHAT_BUBBLE_FRIEND]stretchableImageWithLeftCapWidth:22 topCapHeight:20];
                self.bubbleImageView.frame = CGRectMake(0, 0, contentSize.width+2*kOSBubbleHorizontalMargin+kOSBubbleTipWidth, contentSize.height+2*kOSBubbleVerticalMargin);
                self.size = self.bubbleImageView.size;
                msgLeft = kOSBubbleHorizontalMargin+kOSBubbleTipWidth;
                
            }
            self.imageBtn.frame = CGRectMake(msgLeft, kOSBubbleVerticalMargin, contentSize.width, contentSize.height);
            self.imageBtn.imageURL = [NSURL URLWithString:message.msg];
            break;
        }
    }
}

- (void)longPress
{
    if([_delegate respondsToSelector:@selector(bubbleViewLongPressed:)])
    {
        [_delegate bubbleViewLongPressed:self];
    }
}

- (void)tapPress
{
    if([_delegate respondsToSelector:@selector(bubbleViewTapPressed:)])
    {
        [_delegate bubbleViewTapPressed:self];
    }
}

- (void)imageBtnTapped:(id)sender
{
    if (self.msgDTO.type == OSMsgScreenShot &&
        [_delegate respondsToSelector:@selector(bubbleView:didTouchImageWithUrl:)])
    {
        [_delegate bubbleView:self didTouchImageWithUrl:[NSURL URLWithString:self.msgDTO.msg]];
    }
}

#pragma mark ----------------------------- views

- (UIImageView *)bubbleImageView
{
    if (!_bubbleImageView) {
        _bubbleImageView = [[UIImageView alloc] init];
        _bubbleImageView.backgroundColor = [UIColor clearColor];
        [self addSubview:_bubbleImageView];
    }
    return _bubbleImageView;
}

- (OSMessageLabel *)messageLabel
{
    if (!_messageLabel)
    {
        _messageLabel = [[OSMessageLabel alloc] init];
        _messageLabel.font = kOSBubbleTextFont;
        _messageLabel.textColor = kOSBubbleTextColor;
        _messageLabel.backgroundColor = [UIColor clearColor];
        _messageLabel.numberOfLines = 0;
        _messageLabel.lineBreakMode = NSLineBreakByCharWrapping;
        [self addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (EGOImageButton *)imageBtn
{
    if (!_imageBtn) {
        _imageBtn = [[EGOImageButton alloc] init];
        _imageBtn.delegate = self;
        [_imageBtn addTarget:self action:@selector(imageBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_imageBtn];
    }
    return _imageBtn;
}

#pragma mark ----------------------------- get height

+ (CGFloat)height:(OSMsgDTO *)message
{
    //计算frame
    if (message.type == OSMsgScreenShot)
    {
        CGSize contentSize = kOSBubbleImageSize;
        
        return contentSize.height+2*kOSBubbleVerticalMargin;
    }
    else
    {
        //如果已经进行过数组解析，则直接用结果计算
        CGSize textSize = message.visibleSize;
        return textSize.height+2*kOSBubbleVerticalMargin;
    }
}


@end
