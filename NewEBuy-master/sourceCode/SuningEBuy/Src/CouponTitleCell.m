//
//  CouponTitleCell.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CouponTitleCell.h"

@implementation CouponTitleCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 8, 60, 15)];
        moneyLabel.text = L(@"LOPrice");
        moneyLabel.font = [UIFont systemFontOfSize:12];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        [self addSubview:moneyLabel];
        TT_RELEASE_SAFELY(moneyLabel);
        
        UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 8, 50, 15)];
        timeLabel.text = L(@"LOValidityPeriod");
        timeLabel.font = [UIFont systemFontOfSize:12];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        [self addSubview:timeLabel];
        TT_RELEASE_SAFELY(timeLabel);
        
        UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(260, 8, 50, 15)];
        nameLabel.text = L(@"LOName");
        nameLabel.font = [UIFont systemFontOfSize:12];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        [self addSubview:nameLabel];
        TT_RELEASE_SAFELY(nameLabel);
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
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

@end
