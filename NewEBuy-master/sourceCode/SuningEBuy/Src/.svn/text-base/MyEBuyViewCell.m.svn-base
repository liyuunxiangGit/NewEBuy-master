//
//  MyEBuyViewCell.m
//  SuningEBuy
//
//  Created by zl on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "MyEBuyViewCell.h"

@implementation MyEBuyViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor cellBackViewColor];
        _leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 9, 25, 25)];
        [self.contentView addSubview:_leftImage];
        
        _labTip = [[UILabel alloc] initWithFrame:CGRectMake(60, 12, 100, 15)];
        _labTip.font = [UIFont boldSystemFontOfSize:15];
        _labTip.backgroundColor = [UIColor clearColor];
        _labTip.textColor = [UIColor light_Black_Color];
        [self.contentView addSubview:_labTip];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellDetail.png"]];
        self.accessoryView = arrow;
    }
    return self;
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
