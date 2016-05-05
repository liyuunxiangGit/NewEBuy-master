//
//  BallInfoCell.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BallInfoCell.h"

@implementation BallInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self addSubview:self.infoLabel];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
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

- (void)dealloc{
	
	TT_RELEASE_SAFELY(_infoLabel);
}

- (RTLabel *)infoLabel{
    
    if (_infoLabel == nil) {
        _infoLabel = [[RTLabel alloc] initWithFrame:CGRectMake(120, 6, 170, 20)];
        
        _infoLabel.font = [UIFont systemFontOfSize:12];
        _infoLabel.backgroundColor = [UIColor clearColor];
        _infoLabel.textColor = [UIColor colorWithRGBHex:0x313131];
    }
    
    return _infoLabel;
    
}@end
