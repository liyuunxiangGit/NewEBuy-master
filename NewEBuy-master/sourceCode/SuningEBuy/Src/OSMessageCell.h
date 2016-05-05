//
//  OSMessageCell.h
//  SuningEBuy
//
//  Created by  liukun on 13-11-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSBubbleView.h"
#import "OSMsgDTO.h"


@class OSMessageCell;
@protocol OSMessageCellDelegate <NSObject>
@optional
- (void)messageCell:(OSMessageCell *)cell resendMsg:(OSMsgDTO *)message;
- (void)messageCell:(OSMessageCell *)cell longPressBubbleWithMsg:(OSMsgDTO *)message;
- (void)messageCell:(OSMessageCell *)cell didTouchImageWithImageUrl:(NSURL *)imgUrl;
- (void)messageCell:(OSMessageCell *)cell didSelectLinkWithUrl:(NSURL *)url;

@end

@interface OSMessageCell : UITableViewCell <OSBubbleViewDelegate, OSMessageLabelDelegate>

@property(nonatomic,strong)  OSBubbleView                   *bubbleView;
@property(nonatomic,strong)  EGOImageButton                 *iconImageButton;
@property(nonatomic,assign)  OSMessageSendType               sendType;
@property(nonatomic,strong)  UIActivityIndicatorView        *messageSendingView;
@property(nonatomic,strong)  UIButton                       *resendMessageButton;
@property(nonatomic,strong)  UILabel                        *timeLabel;
@property(nonatomic,strong)  UILabel                        *waitSendLabel;

@property(nonatomic,assign)  id<OSMessageCellDelegate>       delegate;
@property(nonatomic,strong)  OSMsgDTO                       *msgDTO;


- (void)updateMessageCellWithMessage:(OSMsgDTO *)message;


+ (CGFloat)height:(OSMsgDTO *)msg;

@end
