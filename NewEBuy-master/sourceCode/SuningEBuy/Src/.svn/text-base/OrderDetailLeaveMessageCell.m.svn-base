//
//  OrderDetailLeaveMessageCell.m
//  SuningEBuy
//
//  Created by YANG on 14-5-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrderDetailLeaveMessageCell.h"

@implementation OrderDetailLeaveMessageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(MemberOrderNamesDTO *)dto
{
    CGSize stringSize = [dto.orderRemark heightWithFont:[UIFont systemFontOfSize:14.0f] width:280 linebreak:UILineBreakModeWordWrap];
    CGSize labelHeight = [dto.orderRemark sizeWithFont:[UIFont systemFontOfSize:14.0f]];
    NSInteger lineNumber = ceil(stringSize.height/labelHeight.height);
    self.leaveMessage.frame = CGRectMake(20, 0, 200, 35);
    self.leaveMessageContent.frame = CGRectMake(20, 35, 280, 22 * lineNumber);
    self.leaveMessageContent.text = dto.orderRemark;
    self.leaveMessage.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_BuyerLeaveWord")];
}

- (UILabel *)leaveMessage
{
    if (!_leaveMessage) {
        _leaveMessage = [[UILabel alloc] init];
        _leaveMessage.font = [UIFont systemFontOfSize:14.0f];
        _leaveMessage.backgroundColor = [UIColor clearColor];
        _leaveMessage.textColor = [UIColor blackColor];
        _leaveMessage.textAlignment = UITextAlignmentLeft;
       
        [self.contentView addSubview:_leaveMessage];
    }
    return _leaveMessage;
}

- (UILabel *)leaveMessageContent{
    if (!_leaveMessageContent) {
        _leaveMessageContent = [[UILabel alloc] init];
        _leaveMessageContent.font = [UIFont systemFontOfSize:14.0f];
        _leaveMessageContent.backgroundColor = [UIColor clearColor];
        _leaveMessageContent.textColor = [UIColor colorWithHexString:@"#707070"];
        _leaveMessageContent.textAlignment = UITextAlignmentLeft;
        _leaveMessageContent.lineBreakMode = NSLineBreakByWordWrapping;
        _leaveMessageContent.numberOfLines = 0;
        [self.contentView addSubview:_leaveMessageContent];
    }
    return _leaveMessageContent;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
