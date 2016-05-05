//
//  NProDetailSpotSupportCell.m
//  SuningEBuy
//
//  Created by Kristopher on 14-10-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProDetailSpotSupportCell.h"

@implementation NProDetailSpotSupportCell

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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.arrowImageV.frame = CGRectMake(295, 12, 15/2, 24/2);
    self.contentLabel.frame = CGRectMake(45, 10, 200, 20);
    self.showImageV.frame = CGRectMake(15, 10, 20, 20);
}

- (UIImageView *)arrowImageV
{
    if(!_arrowImageV)
    {
        _arrowImageV = [[UIImageView alloc] init];
        
        _arrowImageV.backgroundColor = [UIColor clearColor];
        
        _arrowImageV.image = [UIImage imageNamed:@"arrow_right_gray.png"];
        
        [self.contentView addSubview:_arrowImageV];
    }
    
    return _arrowImageV;
}

- (UILabel*)contentLabel
{
    if(!_contentLabel)
    {
        _contentLabel = [[UILabel alloc] init];
        
        _contentLabel.backgroundColor = [UIColor clearColor];
        
        _contentLabel.font = [UIFont systemFontOfSize:14];
        
        _contentLabel.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_contentLabel];
    }
    
    return _contentLabel;
}

- (UIImageView *)showImageV
{
    if (!_showImageV) {
        _showImageV = [[UIImageView alloc] init];
        
        _showImageV.image = [UIImage streImageNamed:@"fujinmendian.png"];
        
        _showImageV.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_showImageV];
    }
    return _showImageV;
}

+ (CGFloat)getCellHeight{
    return 40.0;
}

@end
