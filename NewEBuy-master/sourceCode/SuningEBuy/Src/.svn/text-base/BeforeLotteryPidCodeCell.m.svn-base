//
//  BeforeLotteryPidCodeCell.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-16.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "BeforeLotteryPidCodeCell.h"

@implementation BeforeLotteryPidCodeCell

-(void)dealloc
{
    TT_RELEASE_SAFELY(_pidNumLabel);
    
    TT_RELEASE_SAFELY(_timeLabel);
    
    TT_RELEASE_SAFELY(_weekLabel);
    
    TT_RELEASE_SAFELY(_cutLineImageView);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self.contentView addSubview:self.cutLineImageView];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


- (UILabel *)pidNumLabel
{
    if (!_pidNumLabel)
    {
        _pidNumLabel = [[UILabel alloc]init];
        
        _pidNumLabel.frame = CGRectMake(13, 17, 85, 15);
        
        _pidNumLabel.backgroundColor = [UIColor clearColor];
        
        _pidNumLabel.textColor = RGBCOLOR(71, 37, 62);
        
        _pidNumLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_pidNumLabel];
    }
    
    return _pidNumLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel)
    {
        _timeLabel = [[UILabel alloc]init];
        
        _timeLabel.frame = CGRectMake(_pidNumLabel.right+20, 17, 85, 15);
        
        _timeLabel.backgroundColor = [UIColor clearColor];
        
        _timeLabel.textColor = RGBCOLOR(71, 37, 62);
        
        _timeLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_timeLabel];
        
        
        
    }
    
    return _timeLabel;
}

- (UILabel *)weekLabel
{
    if (!_weekLabel)
    {
        _weekLabel = [[UILabel alloc]init];
        
        _weekLabel.frame = CGRectMake(_timeLabel.right+15, 17, 70, 15);
        
        _weekLabel.backgroundColor = [UIColor clearColor];
        
        _weekLabel.textColor = RGBCOLOR(71, 37, 62);
        
        _weekLabel.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_weekLabel];
    }
    
    return _weekLabel;
}

- (UIImageView *)cutLineImageView
{
    if (!_cutLineImageView)
    {
        _cutLineImageView = [[UIImageView alloc]init];
        
        _cutLineImageView.frame = CGRectMake(0,99, 320, 1);
        
        _cutLineImageView.image = [UIImage imageNamed:@"notice_cutLine.png"];
        
    }
    
    return _cutLineImageView;
}

//中奖号码用图片展示
- (void)setItem:(HistoryCodeDto *)dto lotteryID:(int)lotteryId;
{
    
    self.pidNumLabel.text = [NSString stringWithFormat:L(@"%@ issue"),dto.pidNumber];
    
    self.timeLabel.text = dto.pidTime;
    
    self.weekLabel.text = L(dto.week);
    //取出开奖号码中的每一个号码
    NSArray *arr = [dto.pidCode componentsSeparatedByString:@"|"];
    
    NSString *redString = [arr objectAtIndex:0];
    
    NSArray *redArray = [redString componentsSeparatedByString:@","];
    
    NSString *blueString = nil;
    
    NSArray *blueArray = nil;
    
    if ([arr count] >1)
    {
        blueString = [arr objectAtIndex:1];
    }
    if ([blueString length] >1)
    {
        blueArray = [blueString componentsSeparatedByString:@","];
        
    }
    
    for(int i=0;i<[redArray count];i++)
    {
        
        UILabel *redBallLabel = [[UILabel alloc]init];
        
        redBallLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lottery_redball"]];
        
        redBallLabel.textAlignment = UITextAlignmentCenter;
        
        redBallLabel.textColor = RGBCOLOR(255, 255, 255);
        //调整不同彩种红球的坐标
        if (lotteryId == 07)
        {
            redBallLabel.frame = CGRectMake(8+39*i, _pidNumLabel.bottom+18, 34, 34);
            
        }
        else
        {
            
            redBallLabel.frame = CGRectMake(10+45*i, _pidNumLabel.bottom+18, 34, 34);
        }
        
        
        redBallLabel.text = [redArray objectAtIndex:i];
        
        
        [self.contentView addSubview:redBallLabel];
        
        TT_RELEASE_SAFELY(redBallLabel)
        
    }
    
    if ([blueArray count] >=1)
    {
        for (int j= 0; j<[blueArray count]; j++)
        {
            
            UILabel *blueBallLabel = [[UILabel alloc]init];
            
            blueBallLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"lottery_blueball"]];
            
            blueBallLabel.textColor = RGBCOLOR(255, 255, 255);
            
            blueBallLabel.textAlignment = UITextAlignmentCenter;
            //调整不同彩种篮球的坐标
            if (lotteryId == 50)
            {
                blueBallLabel.frame = CGRectMake(234+45*j, _pidNumLabel.bottom+18, 34, 34);
                
            }
            else if(lotteryId == 07)
            {
                blueBallLabel.frame = CGRectMake(281+38*j, _pidNumLabel.bottom+18, 34, 34);
            }
            else
            {
                
                blueBallLabel.frame = CGRectMake(278+30*j, _pidNumLabel.bottom+18, 34, 34);
            }
            
            blueBallLabel.text = [blueArray objectAtIndex:j];
            
            [self.contentView addSubview:blueBallLabel];
            
            TT_RELEASE_SAFELY(blueBallLabel)
            
        }
        
    }
    
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
