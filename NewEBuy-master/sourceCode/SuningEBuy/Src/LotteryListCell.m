//
//  LotteryListCell.m
//  SuningLottery
//
//  Created by yangbo on 4/7/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "LotteryListCell.h"
#import "BallSelectConstant.h"


@implementation LotteryListCell

- (id)initWithBallNumberDto:(BallNumberDTO *)dto index:(int)index
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //背景
        UIImageView *backgroundImageView = [[UIImageView alloc]init];
        backgroundImageView.frame = CGRectMake(10, 0, [[UIScreen mainScreen] bounds].size.width-20, LOTTERY_LIST_CELL_HEIGHT);
        backgroundImageView.backgroundColor = [UIColor whiteColor];
        backgroundImageView.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, LOTTERY_LIST_CELL_HEIGHT);
    
        UIView *v = [[UIView alloc]initWithFrame:CGRectMake(0, LOTTERY_LIST_CELL_HEIGHT-1, [[UIScreen mainScreen] bounds].size.width, 1)];
        v.backgroundColor = [UIColor colorWithRGBHex:0xdcdcdc];
        [backgroundImageView addSubview:v];
            
        
//        else
//        {
//            if (index % 2 == 1) {
//                
//                backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_1.png"];
//            }else{
//                backgroundImageView.image = [UIImage imageNamed:@"lottertList_cell_background_2.png"];
//            }
//        }
        
        [self.contentView addSubview:backgroundImageView];
        
        //号码投注类型label高度
        float desLabelHeight = 25;
        
        //号码label
        UILabel *numberLabel = [[UILabel alloc] init];
        numberLabel.backgroundColor = [UIColor clearColor];
        numberLabel.numberOfLines = 0;
        numberLabel.textColor = [UIColor darkRedColor];
        numberLabel.textAlignment = UITextAlignmentLeft;
        
        UIFont *font = [UIFont systemFontOfSize:17.0f];
        numberLabel.font = font;
        
        NSString *numberString = [dto numberShowString];
        
        CGSize size = [numberString sizeWithFont:font constrainedToSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width-10 - 30, 1000)];
        size.height = size.height > 42 ? 42 : size.height;
        
        numberLabel.frame = CGRectIntegral(CGRectMake(10, (LOTTERY_LIST_CELL_HEIGHT - (size.height + desLabelHeight))/2, [self bounds].size.width -10 - 30, size.height));
        
        numberLabel.text = numberString;
        [self.contentView addSubview:numberLabel];
        
        UILabel *desLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(numberLabel.frame), [[UIScreen mainScreen] bounds].size.width-10 - 30, desLabelHeight)];
        desLabel.backgroundColor = [UIColor clearColor];
        desLabel.font = [UIFont systemFontOfSize:14.0f];
        desLabel.textColor =  RGBCOLOR(51.0, 0, 0);
        desLabel.text =  [dto lotterySelectionTypeString];

        [self.contentView addSubview:desLabel];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
