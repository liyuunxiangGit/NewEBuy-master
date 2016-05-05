//
//  GBPayTableviewCell.m
//  SuningEBuy
//
//  Created by xingxianping on 14-2-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "GBPayTableviewCell.h"

@implementation GBPayTableviewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 70, 30)];
        _titleLabel.font =[UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor =[UIColor light_Black_Color];
        _titleLabel.backgroundColor =[UIColor clearColor];
        
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        _detailLabel =[[UILabel alloc]initWithFrame:CGRectMake(100, 5, 205, 30)];
        _detailLabel.font =[UIFont boldSystemFontOfSize:15];
        _detailLabel.textColor =[UIColor light_Black_Color];
        _detailLabel.backgroundColor =[UIColor clearColor];
        
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (void)setTitle:(NSString *)title detailStr:(NSString *)detail
{
    if (IsStrEmpty(title)) {
        self.titleLabel.text =@"--";
    }
    else
    {
        self.titleLabel.text =title;
    }
    if (IsStrEmpty(detail)) {
        [self.detailLabel removeFromSuperview];
    }
    else
        self.detailLabel.text =detail;
}
@end
