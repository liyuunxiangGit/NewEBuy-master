//
//  integralDetailTableViewCell.m
//  SuningEBuy
//
//  Created by suning on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "integralDetailTableViewCell.h"

@implementation integralDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.iconImageView];
        
        [self addSubview:self.commodityNameLabel];
        
        [self addSubview:self.integralLabel];
    }
    return self;
}

-(SNUIImageView*)iconImageView
{
    if (!_iconImageView)
    {
        _iconImageView = [[SNUIImageView alloc]initWithFrame:CGRectMake(15, 19, 30, 22)];
        
    }
    return _iconImageView;
}

-(UILabel*)commodityNameLabel
{
    if (!_commodityNameLabel)
    {
        _commodityNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_iconImageView.right+20, 0, 150, 60)];
        
        _commodityNameLabel.backgroundColor = [UIColor clearColor];
        
        _commodityNameLabel.textColor = UIColorFromRGB(0x313131);
        
        _commodityNameLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    return _commodityNameLabel;
}

-(UILabel*)integralLabel
{
    if (!_integralLabel)
    {
        _integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(_commodityNameLabel.right, 0, 72, 60)];
        
        _integralLabel.backgroundColor = [UIColor clearColor];
        
        _integralLabel.textColor = UIColorFromRGB(0xfc7c26);
        
        _integralLabel.font = [UIFont systemFontOfSize:14.0f];
        
        _integralLabel.textAlignment = UITextAlignmentRight;
    }
    return _integralLabel;
}

@end
