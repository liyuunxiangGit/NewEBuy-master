//
//  MoreLotteryTypeCell.m
//  SuningLottery
//
//  Created by lizhen xiao on 12-9-29.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import "MoreLotteryTypeCell.h"

@implementation MoreLotteryTypeCell


@synthesize backgroundImageView = _backgroundImageView;
@synthesize lotteryImageView = _lotteryImageView;
@synthesize lotteryNameLbl = _lotteryNameLbl;
@synthesize lotteryMoreTypeLbl = _lotteryMoreTypeLbl;



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundImageView.frame = CGRectMake(10, 10, 300, 88);
        self.lotteryImageView.frame = CGRectMake(20, 35, 45, 45);
        self.lotteryNameLbl.frame = CGRectMake(self.lotteryImageView.right+10, 20, 80, 25);
        self.lotteryMoreTypeLbl.frame = CGRectMake(self.lotteryImageView.right+10, 45, 220, 50);
    }
    return self;
}


-(void)dealloc{
    
    TT_RELEASE_SAFELY(_backgroundImageView);
    TT_RELEASE_SAFELY(_lotteryImageView);
    TT_RELEASE_SAFELY(_lotteryNameLbl);
    TT_RELEASE_SAFELY(_lotteryMoreTypeLbl);
    
}


-(UIImageView *)backgroundImageView{
    
    if (_backgroundImageView == nil) {
        
        _backgroundImageView = [[UIImageView alloc]init];
        
        UIImage *image = [UIImage imageNamed:@"lottery_hall_background.png"];
        
        _backgroundImageView.image = image;
        
        [self.contentView addSubview:_backgroundImageView];
        
        _backgroundImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _backgroundImageView;
    
}




-(UIImageView *)lotteryImageView{
    
    if (_lotteryImageView == nil) {
        
        _lotteryImageView = [[UIImageView alloc]init];
        UIImage *image = [UIImage imageNamed:@"caipiao_more.png"];
        
        _lotteryImageView.image = image;
        
        [self.contentView addSubview:_lotteryImageView];
        
        _lotteryImageView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _lotteryImageView;
    
}

-(UILabel *)lotteryNameLbl{
    
    if (_lotteryNameLbl == nil) {
        
        _lotteryNameLbl = [[UILabel alloc]init];
        
        _lotteryNameLbl.backgroundColor = [UIColor clearColor];
        
        _lotteryNameLbl.font = [UIFont boldSystemFontOfSize:17.0];
        
        _lotteryNameLbl.text = L(@"more colorful species");
        
        _lotteryNameLbl.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_lotteryNameLbl];
        
    }
    
    return _lotteryNameLbl;
}

-(UILabel *)lotteryMoreTypeLbl{
    
    if (_lotteryMoreTypeLbl == nil) {
        
        _lotteryMoreTypeLbl = [[UILabel alloc]init];
        
        _lotteryMoreTypeLbl.backgroundColor = [UIColor clearColor];
        
        _lotteryMoreTypeLbl.font = [UIFont boldSystemFontOfSize:13.0];
        
        _lotteryMoreTypeLbl.numberOfLines = 0;
        
        _lotteryMoreTypeLbl.text = L(@"SMG football, seven Lottery Seven-color, arranged in three, arranged in five");
        
        _lotteryMoreTypeLbl.textColor = RGBCOLOR(51.0, 51.0, 51.0);
        
        [self.contentView addSubview:_lotteryMoreTypeLbl];
        
    }
    
    return _lotteryMoreTypeLbl;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
