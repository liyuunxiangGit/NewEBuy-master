//
//  NCouponFinalCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NCouponFinalCell.h"

@implementation NCouponFinalCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ----------------------------- subviews

- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
		_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _priceLabel.textColor = [UIColor light_Black_Color];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.shadowColor = [UIColor whiteColor];
        _priceLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        [self.contentView addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)couponNameLabel
{
    if (!_couponNameLabel)
    {
		_couponNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_couponNameLabel.backgroundColor = [UIColor clearColor];
        _couponNameLabel.font = [UIFont boldSystemFontOfSize:16.0];
        _couponNameLabel.textColor = [UIColor light_Black_Color];
        _couponNameLabel.textAlignment = NSTextAlignmentLeft;
        _couponNameLabel.shadowColor = [UIColor whiteColor];
        _couponNameLabel.shadowOffset = CGSizeMake(0.5, 0.5);
        [self.contentView addSubview:_couponNameLabel];
        
    }
    return _couponNameLabel;
}



#pragma mark ----------------------------- layout

- (void)setBalance:(NSString *)balance name:(NSString *)name
{
    //券余额
    NSString *balanceStr = [NSString stringWithFormat:@"￥%.2f",[balance doubleValue]];
    self.priceLabel.text = balanceStr;
    CGSize size = [balanceStr sizeWithFont:self.priceLabel.font];
    CGFloat width = size.width > 50 ? size.width : 50;
    width = MIN(width, 100);
    self.priceLabel.frame = CGRectMake(18, 12, width, 20);
    
    //券名称
    self.couponNameLabel.frame = CGRectMake(self.priceLabel.right+5, 12, 285-self.priceLabel.right, 20);
    self.couponNameLabel.text = name;
}

+ (CGFloat)height
{
    return 44;
}
@end
