//
//  SNFilterPickCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-3-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SNFilterPickCell.h"

@implementation SNFilterPickCell

@synthesize accessoryLabel = _accessoryLabel;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_accessoryLabel);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        if (IOS7_OR_LATER)
            self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)accessoryLabel
{
    if (!_accessoryLabel)
    {
        _accessoryLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 5, 105, 30)];
        
        _accessoryLabel.backgroundColor = [UIColor clearColor];
        
        _accessoryLabel.font = [UIFont systemFontOfSize:14.0];
        
        _accessoryLabel.textAlignment = UITextAlignmentRight;
        
        _accessoryLabel.textColor = RGBCOLOR(53, 79, 138);
        
        [self.contentView addSubview:_accessoryLabel];
    }
    return _accessoryLabel;
}
@end
