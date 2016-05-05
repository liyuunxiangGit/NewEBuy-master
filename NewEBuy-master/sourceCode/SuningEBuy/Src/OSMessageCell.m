//
//  OSMessageCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSMessageCell.h"

#define kOSMessageCellVerticalMargin    (10.0f)
#define kOSMessageCellTimeHeight        (20.0f)

@implementation OSMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

#pragma mark ----------------------------- views

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
		_timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_timeLabel.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        _timeLabel.font = [UIFont systemFontOfSize:14.0];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.layer.cornerRadius = 10;
        [self.contentView addSubview:_timeLabel];
    }
    return _timeLabel;
}

- (EGOImageButton *)iconImageButton
{
    if (!_iconImageButton) {
        _iconImageButton = [[EGOImageButton alloc] init];
        _iconImageButton.backgroundColor = [UIColor orangeColor];
        _iconImageButton.placeholderImage = nil;
        _iconImageButton.frame = CGRectMake(0, 0, 44.5, 44.5);
        [self.contentView addSubview:_iconImageButton];
    }
    return _iconImageButton;
}

- (OSBubbleView *)bubbleView
{
    if (!_bubbleView)
    {
        _bubbleView = [[OSBubbleView alloc] init];
        _bubbleView.delegate = self;
        _bubbleView.messageLabel.delegate = self;
        [self.contentView addSubview:_bubbleView];
    }
    return _bubbleView;
}

- (UIButton *)resendMessageButton
{
    if (!_resendMessageButton)
    {
        _resendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _resendMessageButton.frame = CGRectMake(0, 0, 30, 30);
        [_resendMessageButton setImage:[UIImage imageNamed:@"os_btn_resend.png"]
                              forState:UIControlStateNormal];
        [_resendMessageButton addTarget:self
                                 action:@selector(resendMessageButtonButtonClicked:)
                       forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_resendMessageButton];
    }
    return _resendMessageButton;
}

- (UIActivityIndicatorView *)messageSendingView
{
    if (!_messageSendingView)
    {
        _messageSendingView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _messageSendingView.color = [UIColor grayColor];
        [self.contentView addSubview:_messageSendingView];
        [_messageSendingView setHidesWhenStopped:YES];
    }
    return _messageSendingView;
}

- (UILabel *)waitSendLabel
{
    if (!_waitSendLabel)
    {
		_waitSendLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _waitSendLabel.font = [UIFont systemFontOfSize:10.0];
        _waitSendLabel.textAlignment = NSTextAlignmentCenter;
        _waitSendLabel.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        _waitSendLabel.textColor = [UIColor whiteColor];
        _waitSendLabel.layer.cornerRadius = 9;
        _waitSendLabel.text = L(@"OnlineService_WaitingIng");
        [self.contentView addSubview:_waitSendLabel];
    }
    return _waitSendLabel;
}


#pragma mark ----------------------------- update method

- (void)updateMessageCellWithMessage:(OSMsgDTO *)message
{
    self.msgDTO = message;
    
    CGFloat top = kOSMessageCellVerticalMargin;
    if (message.shouldShowTime)
    {
        self.timeLabel.hidden = NO;
        NSString *timeStr = [NSDate stringFromDate:message.time withFormat:@"YYYY-MM-dd HH:mm"];
        CGSize timeSize = [timeStr sizeWithFont:self.timeLabel.font];
        CGFloat timeWidth = timeSize.width+20;
        self.timeLabel.frame = CGRectMake((320-timeWidth)/2, top, timeWidth, 20);
        self.timeLabel.text = timeStr;
        top = self.timeLabel.bottom+kOSMessageCellVerticalMargin;
    }
    else
    {
        self.timeLabel.hidden = YES;
    }
    
    if(message.isSelf)
    {
        self.iconImageButton.right = 320 - 15;
        self.iconImageButton.top = top;
        [self.iconImageButton setImage:[UIImage imageNamed:@"os_self_face.png"]
                              forState:UIControlStateNormal];
        
        [self.bubbleView updateBubbleViewWithMessage:message];
        self.bubbleView.right = self.iconImageButton.left - 10;
        self.bubbleView.top = top;
        
        self.resendMessageButton.right = self.bubbleView.left - 5;
        self.resendMessageButton.top = top + (self.bubbleView.height-self.resendMessageButton.height)/2;
        self.messageSendingView.right = self.bubbleView.left - 5;
        self.messageSendingView.top = top + (self.bubbleView.height-self.messageSendingView.height)/2;
        self.waitSendLabel.right = self.bubbleView.left - 2.5;
        self.waitSendLabel.top = top + (self.bubbleView.height-self.waitSendLabel.height)/2;
        switch (message.sendType)
        {
            case OSMessageWaitForSend:
            {
                self.resendMessageButton.hidden = YES;
                self.waitSendLabel.hidden = NO;
                [self.messageSendingView stopAnimating];
            }
                break;
            case OSMessageSending:
            {
                self.resendMessageButton.hidden = YES;
                self.waitSendLabel.hidden = YES;
                [self.messageSendingView startAnimating];
            }
                break;
            case OSMessageSendFail:
            {
                self.resendMessageButton.hidden = NO;
                self.waitSendLabel.hidden = YES;
                [self.messageSendingView stopAnimating];
            }
                break;
            case OSMessageSendSuccess:
            default:
            {
                self.resendMessageButton.hidden = YES;
                self.waitSendLabel.hidden = YES;
                [self.messageSendingView stopAnimating];
            }
                break;
        }
    }
    else
    {
        self.iconImageButton.left = 15;
        self.iconImageButton.top = top;
        [self.iconImageButton setImage:[UIImage imageNamed:@"os_kefu_face.png"]
                              forState:UIControlStateNormal];
        
        [self.bubbleView updateBubbleViewWithMessage:message];
        self.bubbleView.left = self.iconImageButton.right + 10;
        self.bubbleView.top = top;
        
        _resendMessageButton.hidden = YES;
        [_messageSendingView stopAnimating];
        _waitSendLabel.hidden = YES;
    }
}

#pragma mark ----------------------------- actions

- (void)resendMessageButtonButtonClicked:(id)sender
{
    if([_delegate respondsToSelector:@selector(messageCell:resendMsg:)])
    {
        [_delegate messageCell:self resendMsg:self.msgDTO];
    }
}

- (void)bubbleViewLongPressed:(OSBubbleView *)bubbleView
{
    if([_delegate respondsToSelector:@selector(messageCell:longPressBubbleWithMsg:)])
    {
        [_delegate messageCell:self longPressBubbleWithMsg:self.msgDTO];
    }
}

- (void)bubbleView:(OSBubbleView *)bubbleView didTouchImageWithUrl:(NSURL *)imgUrl
{
    if (imgUrl && [_delegate respondsToSelector:@selector(messageCell:didTouchImageWithImageUrl:)])
    {
        [_delegate messageCell:self didTouchImageWithImageUrl:imgUrl];
    }
}

- (void)messageLabel:(OSMessageLabel *)label didSelectLinkWithUrl:(NSURL *)url
{
    if (url && [_delegate respondsToSelector:@selector(messageCell:didSelectLinkWithUrl:)]) {
        [_delegate messageCell:self didSelectLinkWithUrl:url];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark ----------------------------- getHeight

+ (CGFloat)height:(OSMsgDTO *)msg
{
    CGFloat height = 0;
    CGFloat bubbleHeight = [OSBubbleView height:msg];
    height += 2*kOSMessageCellVerticalMargin;
    height += bubbleHeight;
    if (msg.shouldShowTime)
    {
        height+=kOSMessageCellVerticalMargin;
        height+=kOSMessageCellTimeHeight;
    }
    
    return height;
}

#pragma mark ----------------------------- 拷贝

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(copyClicked:)) {
        return YES;
    }
    return NO;
}


- (void)copyClicked:(id)sender
{
    //贴入剪贴板
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    [pasteBoard setString:self.msgDTO.msg];
}

@end
