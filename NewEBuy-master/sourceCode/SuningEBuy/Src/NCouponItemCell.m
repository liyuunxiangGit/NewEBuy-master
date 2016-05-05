//
//  NCouponItemCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NCouponItemCell.h"

@implementation NCouponItemCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier ischeckbuttonshow:(BOOL)isshow
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.ischeckbuttonshow = isshow;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark ----------------------------- views

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(5, 10, 40, 40);
        [_checkButton addTarget:self
                         action:@selector(modifyChecked)
               forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_checkButton];
    }
    return _checkButton;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
		_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _priceLabel.textColor = [UIColor orange_Red_Color];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
        _priceLabel.shadowColor = [UIColor whiteColor];
        _priceLabel.shadowOffset = CGSizeMake(0, 0);
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
        _couponNameLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _couponNameLabel.textColor = [UIColor light_Black_Color];
        _couponNameLabel.textAlignment = NSTextAlignmentLeft;
        _couponNameLabel.shadowColor = [UIColor whiteColor];
        _couponNameLabel.shadowOffset = CGSizeMake(0, 0);
        [self.contentView addSubview:_couponNameLabel];
        
    }
    return _couponNameLabel;
}

- (UILabel *)endDateLabel
{
    if (!_endDateLabel)
    {
		_endDateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
		_endDateLabel.backgroundColor = [UIColor clearColor];
        _endDateLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _endDateLabel.textColor = [UIColor dark_Gray_Color];
        _endDateLabel.textAlignment = NSTextAlignmentLeft;
        _endDateLabel.shadowColor = [UIColor whiteColor];
        _endDateLabel.shadowOffset = CGSizeMake(0, 0);
        [self.contentView addSubview:_endDateLabel];
    }
    return _endDateLabel;
}

#pragma mark ----------------------------- action

- (void)modifyChecked
{
    if (self.item.couponType == CouponTypeVoucherCode)
    {
        //do nothing
    }
    else
    {
        if ([_delegate respondsToSelector:@selector(couponCell:shouldChangeCouponSelectState:)])
        {
            BOOL should = [_delegate couponCell:self shouldChangeCouponSelectState:self.item];
            
            if (should)
            {
                self.item.isSelected = !self.item.isSelected;
                
                [self.checkButton setSelected:self.item.isSelected];
                
                if ([_delegate respondsToSelector:@selector(couponCell:didChangeCouponSelectState:)])
                {
                    [_delegate couponCell:self didChangeCouponSelectState:self.item];
                }
            }
        }
    }
}

#pragma mark ----------------------------- layout

- (void)setItem:(GiftCouponDTO *)item
{
    if (_item != item) {
        _item = item;
        
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
    if ([self.item.exclusive isEqualToString:@"1"])
    {
        [self.checkButton setImage:[UIImage imageNamed:@"checkbox_unselect.png"]
                          forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"checkbox_selected.png"]
                          forState:UIControlStateSelected];
    }
    else
    {
        [self.checkButton setImage:[UIImage imageNamed:@"checkbox_unselect.png"]
                          forState:UIControlStateNormal];
        [self.checkButton setImage:[UIImage imageNamed:@"checkbox_selected.png"]
                          forState:UIControlStateSelected];
    }
    
    if (self.item.couponType == CouponTypeVoucherCode)
    {
        self.checkButton.selected = YES;    //直降code,绑定订单
    }
    else
    {
        self.checkButton.selected = self.item.isSelected;
    }
    
    self.checkButton.frame = CGRectMake(5, 10, 40, 40);
    
    //券余额
    NSString *balance = self.item.balance?self.item.balance:@"0";
    NSString *balanceStr = [NSString stringWithFormat:@"￥%.2f",[balance doubleValue]];
    self.priceLabel.text = balanceStr;
    CGSize size = [balanceStr sizeWithFont:self.priceLabel.font];
    CGFloat width = size.width > 50 ? size.width : 50;
    width = MIN(width, 100);
    if (_ischeckbuttonshow) {
        self.priceLabel.frame = CGRectMake(self.checkButton.right+5, 10, width, 15);
        
        //券名称
        self.couponNameLabel.frame = CGRectMake(self.checkButton.right+5, self.priceLabel.bottom + 10, 100, 15);
        self.couponNameLabel.text = [self.item formatedName];
        //失效日期
        self.endDateLabel.frame = CGRectMake(self.couponNameLabel.right + 5, self.priceLabel.bottom + 10, 315 - self.couponNameLabel.right, 15);
        self.endDateLabel.text = [NSString stringWithFormat:@"%@：%@", L(@"PFExpiryDate"),self.item.endDate];
    }
    else{
        self.priceLabel.frame = CGRectMake(5, 10, width, 15);
        
        //券名称
        self.couponNameLabel.frame = CGRectMake(5, self.priceLabel.bottom + 10, 100, 15);
        self.couponNameLabel.text = [self.item formatedName];
        //失效日期
        self.endDateLabel.frame = CGRectMake(160, self.priceLabel.bottom + 10, 315 - self.couponNameLabel.right, 15);
        self.endDateLabel.text = [NSString stringWithFormat:@"%@：%@", L(@"PFExpiryDate"),self.item.endDate];
    }
    
    
}

-(void)resetframe{
    CGRect frame ;
    if (_ischeckbuttonshow) {
        frame =self.priceLabel.frame;
        frame.origin.x=5;
        self.priceLabel.frame = frame;
        frame =self.couponNameLabel.frame;
        frame.origin.x=5;
        self.couponNameLabel.frame = frame;
        self.endDateLabel.frame = CGRectMake(160, self.priceLabel.bottom + 10, 315 - self.couponNameLabel.right, 15);
        
    }
    else{
        frame =self.priceLabel.frame;
        frame.origin.x=self.checkButton.right+5;
        self.priceLabel.frame = frame;
        frame =self.couponNameLabel.frame;
        frame.origin.x=self.checkButton.right+5;
        self.couponNameLabel.frame = frame;
        self.endDateLabel.frame = CGRectMake(self.couponNameLabel.right + 5, self.priceLabel.bottom + 10, 315 - self.couponNameLabel.right, 15);
        
        
    }
    
}

+ (CGFloat)height
{
    return 60;
}

@end
