//
//  ReturnPartLocationViewCell.m
//  SuningEBuy
//
//  Created by zl on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReturnPartLocationViewCell.h"
@interface ReturnPartLocationViewCell()
@property(nonatomic,strong)UILabel* label;
@end
@implementation ReturnPartLocationViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 80, 30)];
        _label.backgroundColor = [UIColor clearColor];
        _label.text = @"身边苏宁:";
        _label.font = [UIFont systemFontOfSize:16];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = UITextAlignmentLeft;
        
        [self.contentView addSubview:_label];

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
