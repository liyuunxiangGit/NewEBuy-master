//
//  LogisticCompanyDetailCell.m
//  SuningEBuy
//
//  Created by YANG on 14-5-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "LogisticCompanyDetailCell.h"
@implementation LogisticCompanyDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(NewSnxpressDTO *)dto
{
    CGSize stringSize = [dto.dlAddress heightWithFont:[UIFont systemFontOfSize:14.0f] width:220 linebreak:UILineBreakModeWordWrap];
    CGSize labelheight = [dto.dlAddress sizeWithFont:[UIFont systemFontOfSize:14.0f]];
    NSInteger lineNumber = ceil(stringSize.height/labelheight.height);

    self.cellBackgroundView.frame = CGRectMake(0, 20, 320, 55 + 20 * lineNumber);
    self.logisticCompany.frame = CGRectMake(15, 10, 70, 20);
    self.logisticCompanyContent.frame = CGRectMake(90, 10, 240, 20);
    self.logisticNumber.frame = CGRectMake(15, 30, 70, 20);
    self.logisticNumberContent.frame = CGRectMake(90, 30, 240, 20);
    self.logisticAddress.frame = CGRectMake(15, 50, 70, 20);
    self.logisticAddressContent.frame = CGRectMake(90, 50, 220, 20 * lineNumber);
    
    self.logisticAddressContent.text = dto.dlAddress;
    self.logisticCompanyContent.text = dto.expressCompany;
    self.logisticNumberContent.text = dto.expressNo;
//    self.leaveMessageContent.text = dto.orderRemark;
//    self.leaveMessage.text = @"用户留言 : ";
}


- (UILabel *)logisticCompany
{
    if (!_logisticCompany) {
        _logisticCompany = [[UILabel alloc] init];
        _logisticCompany.font = [UIFont systemFontOfSize:14.0f];
        _logisticCompany.backgroundColor = [UIColor clearColor];
        _logisticCompany.textColor = [UIColor blackColor];
        _logisticCompany.textAlignment = UITextAlignmentLeft;
        _logisticCompany.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_LogisticsCompany")];
        _logisticCompany.textColor = [UIColor colorWithHexString:@"707070"];
        [self.cellBackgroundView addSubview:_logisticCompany];
    }
    return _logisticCompany;
}

- (UILabel *)logisticCompanyContent{
    if (!_logisticCompanyContent) {
        _logisticCompanyContent = [[UILabel alloc] init];
        _logisticCompanyContent.font = [UIFont systemFontOfSize:14.0f];
        _logisticCompanyContent.backgroundColor = [UIColor clearColor];
        _logisticCompanyContent.textColor = [UIColor blackColor];
        _logisticCompanyContent.textAlignment = UITextAlignmentLeft;
        _logisticCompanyContent.text  =@"";
        [self.cellBackgroundView addSubview:_logisticCompanyContent];
    }
    return _logisticCompanyContent;
}

- (UILabel *)logisticNumber
{
    if (!_logisticNumber) {
        _logisticNumber = [[UILabel alloc] init];
        _logisticNumber.font = [UIFont systemFontOfSize:14.0f];
        _logisticNumber.backgroundColor = [UIColor clearColor];
        _logisticNumber.textColor = [UIColor blackColor];
        _logisticNumber.textAlignment = UITextAlignmentLeft;
        _logisticNumber.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_ExpressNumber")];
        _logisticNumber.textColor = [UIColor colorWithHexString:@"707070"];
        [self.cellBackgroundView addSubview:_logisticNumber];
    }
    return _logisticNumber;
}

- (UILabel *)logisticNumberContent{
    if (!_logisticNumberContent) {
        _logisticNumberContent = [[UILabel alloc] init];
        _logisticNumberContent.font = [UIFont systemFontOfSize:14.0f];
        _logisticNumberContent.backgroundColor = [UIColor clearColor];
        _logisticNumberContent.textColor = [UIColor blackColor];
        _logisticNumberContent.textAlignment = UITextAlignmentLeft;
        _logisticNumberContent.text = @"";
        [self.cellBackgroundView addSubview:_logisticNumberContent];
    }
    return _logisticNumberContent;
}
- (UILabel *)logisticAddress
{
    if (!_logisticAddress) {
        _logisticAddress = [[UILabel alloc] init];
        _logisticAddress.font = [UIFont systemFontOfSize:14.0f];
        _logisticAddress.backgroundColor = [UIColor clearColor];
        _logisticAddress.textColor = [UIColor blackColor];
        _logisticAddress.textAlignment = UITextAlignmentLeft;
        _logisticAddress.text = [NSString stringWithFormat:@"%@ : ",L(@"MyEBuy_DeliveryAddress")];
        _logisticAddress.textColor = [UIColor colorWithHexString:@"707070"];
        [self.cellBackgroundView addSubview:_logisticAddress];
    }
    return _logisticAddress;
}

- (UILabel *)logisticAddressContent{
    if (!_logisticAddressContent) {
        _logisticAddressContent = [[UILabel alloc] init];
        _logisticAddressContent.font = [UIFont systemFontOfSize:14.0f];
        _logisticAddressContent.backgroundColor = [UIColor clearColor];
        _logisticAddressContent.textColor = [UIColor blackColor];
        _logisticAddressContent.textAlignment = UITextAlignmentLeft;
        _logisticAddressContent.lineBreakMode = UILineBreakModeWordWrap;
        _logisticAddressContent.numberOfLines = 0;
        _logisticAddressContent.text = @"";
        [self.cellBackgroundView addSubview:_logisticAddressContent];
    }
    return _logisticAddressContent;
}

- (UIView *)cellBackgroundView
{
    if (!_cellBackgroundView) {
        _cellBackgroundView = [[UIView alloc] init];
        _cellBackgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_cellBackgroundView];
    }
    return _cellBackgroundView;
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
