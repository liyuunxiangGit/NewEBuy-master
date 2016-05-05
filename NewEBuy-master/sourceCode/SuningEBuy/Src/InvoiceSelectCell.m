//
//  InvoiceSelectCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InvoiceSelectCell.h"

@implementation InvoiceSelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)selectImgView
{
    if (!_selectImgView) {
        _selectImgView = [[UIImageView alloc] init];
        _selectImgView.backgroundColor = [UIColor clearColor];
        _selectImgView.image = [UIImage imageNamed:@"checkbox_unselect.png"];
        [self.contentView addSubview:_selectImgView];
    }
    return _selectImgView;
}

- (void)layoutSubviews
{
    self.selectImgView.frame = CGRectMake(15, 15, 22, 22);
    self.titleLabel.frame = CGRectMake(45, 17, 200, 20);
}

- (void)setTitle:(NSString *)title canSelect:(BOOL)canSelect
{
    self.titleLabel.text = title;
    if (canSelect) {
        self.selectImgView.image = [UIImage imageNamed:@"checkbox_selected.png"];
    }
    else
    {
        self.selectImgView.image = [UIImage imageNamed:@"checkbox_disabled_selected.png"];
    }
}

- (void)setItem:(NSString *)title isSelect:(BOOL)isSelect
{
    self.titleLabel.text = title;
    
    [self setCheckButtonIsChecked:isSelect];
}

- (void)setCheckButtonIsChecked:(BOOL)checked
{
    if (checked)
    {
        self.selectImgView.image = [UIImage imageNamed:@"checkbox_selected.png"];
        
    }
    else
    {
        self.selectImgView.image = [UIImage imageNamed:@"checkbox_unselect.png"];
        
    }
}

@end
