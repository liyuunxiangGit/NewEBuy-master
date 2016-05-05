//
//  HistoryLotteryPidCodeCell.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-16.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "HistoryLotteryPidCodeCell.h"

@implementation HistoryLotteryPidCodeCell

- (void)dealloc
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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.cutLineImageView.frame = CGRectMake(0, 69, 320, 1);
    }

    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    
}

- (void)setItem:(HistoryCodeDto *)dto lotteryID:(int)lotteryId
{
    
    

    self.pidNumLabel.text = [NSString stringWithFormat:L(@"%@ issue"), dto.pidNumber];

    self.timeLabel.text = dto.pidTime;

    self.weekLabel.text = L(dto.week);
    // 取出开奖号码中的每一个号码
    NSArray *arr = [dto.pidCode componentsSeparatedByString:@"|"];

    NSString *redString = [arr objectAtIndex:0];

    NSArray *redArray = [redString componentsSeparatedByString:@","];

    NSString *blueString = nil;

    NSArray *blueArray = nil;

    if ([arr count] > 1)
    {
        blueString = [arr objectAtIndex:1];
    }

    if ([blueString length] > 1)
    {
        blueArray = [blueString componentsSeparatedByString:@","];
    }

    for (int i = 0; i < [redArray count]; i++)
    {
        UILabel *redBallLabel = [[UILabel alloc]init];

        redBallLabel.textColor = RGBCOLOR(214, 24, 9);

        redBallLabel.backgroundColor = [UIColor whiteColor];

        redBallLabel.textAlignment = UITextAlignmentCenter;

//        redBallLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_system_background@2x.png"]];

        // 调整不同彩种红球号码的坐标
        if (lotteryId == 07)
        {
            redBallLabel.frame = CGRectMake(8 + 39 * i, _pidNumLabel.bottom + 5, 35, 35);
        }
        else
        {
            redBallLabel.frame = CGRectMake(10 + 45 * i, _pidNumLabel.bottom + 5, 35, 35);
        }

        redBallLabel.text = [redArray objectAtIndex:i];

        [self.contentView addSubview:redBallLabel];

        TT_RELEASE_SAFELY(redBallLabel)
    }

    if ([blueArray count] >= 1)
    {
        for (int j = 0; j < [blueArray count]; j++)
        {
            UILabel *blueBallLabel = [[UILabel alloc]init];

            blueBallLabel.textColor = RGBCOLOR(1, 7, 248);

            blueBallLabel.backgroundColor = [UIColor whiteColor];

//            blueBallLabel.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"home_system_background@2x.png"]];

            blueBallLabel.textAlignment = UITextAlignmentCenter;

            // 调整不同彩种篮球号码的坐标
            if (lotteryId == 50)
            {
                blueBallLabel.frame = CGRectMake(234 + 45 * j, _pidNumLabel.bottom + 5, 35, 35);
            }
            else if (lotteryId == 07)
            {
                blueBallLabel.frame = CGRectMake(281 + 38 * j, _pidNumLabel.bottom + 5, 35, 35);
            }
            else
            {
                blueBallLabel.frame = CGRectMake(278 + 30 * j, _pidNumLabel.bottom + 5, 35, 35);
            }

            blueBallLabel.text = [blueArray objectAtIndex:j];

            [self.contentView addSubview:blueBallLabel];

            TT_RELEASE_SAFELY(blueBallLabel)
        }
    }
}

- (UILabel *)pidNumLabel
{
    if (!_pidNumLabel)
    {
        _pidNumLabel = [[UILabel alloc]init];

        _pidNumLabel.frame = CGRectMake(13, 10, 85, 15);

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

        _timeLabel.frame = CGRectMake(_pidNumLabel.right + 20, 10, 85, 15);

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

        _weekLabel.frame = CGRectMake(_timeLabel.right + 15, 10, 70, 15);

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

        _cutLineImageView.image = [UIImage imageNamed:@"notice_cutLine"];

        [self.contentView addSubview:_cutLineImageView];
    }

    return _cutLineImageView;
}

@end
