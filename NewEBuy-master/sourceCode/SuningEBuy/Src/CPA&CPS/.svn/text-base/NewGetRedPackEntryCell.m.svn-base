//
//  NewGetRedPackEntryCell.m
//  SuningEBuy
//
//  Created by sn－wahaha on 14-9-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NewGetRedPackEntryCell.h"

@implementation NewGetRedPackEntryCell

- (void)awakeFromNib {
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setGetRedPackCell:(NSIndexPath *)index{
    if (index.row==0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(17, 13, 150, 20)];
        label.backgroundColor = [UIColor clearColor];
        label.text = L(@"CPACPS_3MonthCommission");
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(157, 8, 300, 30)];
        label1.backgroundColor = [UIColor clearColor];
        label1.text = [NSString stringWithFormat:@"￥%@",_totalCach];
        label1.font = [UIFont boldSystemFontOfSize:30];
        label1.textColor = [UIColor colorWithRGBHex:0xfb4800];
        [self addSubview:label];
        [self addSubview:label1];
    }
    else{
        [self cellInit];
    }
}

-(void)cellInit{
    UILabel *label  = [[UILabel alloc] initWithFrame:CGRectMake(7, 13, 40, 50)];
    label.text =_month;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:35];
    label.textAlignment = NSTextAlignmentRight;
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(45, 40, 30, 20)];
    label1.font = [UIFont systemFontOfSize:13];
    label1.text = L(@"CPACPS_YueFen");
    label1.backgroundColor = [UIColor clearColor];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 17, 200, 20)];
    label2.font = [UIFont systemFontOfSize:13];
    label2.backgroundColor = [UIColor clearColor];
    label2.text = L(@"CPACPS_RecommendNewGetHongbao");
    UILabel *price = [[UILabel alloc] initWithFrame:CGRectMake(250, 17, 90, 20)];
    price.font = [UIFont systemFontOfSize:13];
    price.textColor = [UIColor orangeColor];
    price.backgroundColor = [UIColor clearColor];
    price.text = [NSString stringWithFormat:@"￥%@",_hongBao];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(80, 40, 200, 20)];
    label3.font = [UIFont systemFontOfSize:13];
    label3.backgroundColor = [UIColor clearColor];
    label3.text = L(@"CPACPS_FriendFanxian");
    UILabel *price1 = [[UILabel alloc] initWithFrame:CGRectMake(250, 40, 90, 20)];
    price1.font = [UIFont systemFontOfSize:13];
    price1.backgroundColor = [UIColor clearColor];
    price1.text = [NSString stringWithFormat:@"￥%@",_cashBack];
    price1.textColor = [UIColor orangeColor];

    [self addSubview:label];
    [self addSubview:label1];
    [self addSubview:label2];
    [self addSubview:label3];
    [self addSubview:price];
    [self addSubview:price1];
}
@end
