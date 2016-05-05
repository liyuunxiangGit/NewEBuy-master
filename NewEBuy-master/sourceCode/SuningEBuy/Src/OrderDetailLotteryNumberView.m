//
//  OrderDetailLotteryNumberView.m
//  SuningLottery
//
//  Created by yangbo on 4/12/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import "OrderDetailLotteryNumberView.h"

#define ORDER_LOTTERY_NUMBER_VIEW_OFFSET_X 17   //订单明细视图originX

#define ORDER_LOTTERY_NUMBER_VIEW_WIDTH ([[UIScreen mainScreen] bounds].size.width)  //订单明细视图宽度

#define ORDER_LOTTERY_NUMBER_BALL_WIDTH 35      //彩球宽度和高度

@implementation OrderDetailLotteryNumberView

- (id)initWithAwardNumber:(NSString *)code
{
    if(self = [super init])
    {
        
        self.backgroundColor = [UIColor clearColor];
        
        UILabel *tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(ORDER_LOTTERY_NUMBER_VIEW_OFFSET_X, 14, ORDER_LOTTERY_NUMBER_VIEW_WIDTH - ORDER_LOTTERY_NUMBER_VIEW_OFFSET_X * 2, 17)];
        tagLabel.text = L(@"WinLottery number");
        tagLabel.textColor = RGBACOLOR(0xb4, 0x4e, 0x4b, 1);
        tagLabel.font = [UIFont systemFontOfSize:17.0f];
        tagLabel.backgroundColor = [UIColor clearColor];
        tagLabel.shadowColor = [UIColor whiteColor];
        tagLabel.shadowOffset = CGSizeMake(0, 1);
        [self addSubview:tagLabel];
        
        float height = 0;
        
        //未开奖显示等待开奖
        if([code length] == 0)
        {
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, CGRectGetMaxY(tagLabel.frame)+10, 200, 20)];
            tipLabel.textAlignment = UITextAlignmentLeft;
            tipLabel.font = [UIFont  systemFontOfSize:13];
            tipLabel.textColor = RGBACOLOR(0x41, 0x1f, 0x1d, 1);
            tipLabel.backgroundColor = [UIColor clearColor];
            tipLabel.shadowColor = [UIColor whiteColor];
            tipLabel.shadowOffset = CGSizeMake(0, 1);
            tipLabel.text = L(@"WaitsLottery");
            [self addSubview:tipLabel];
            
            height = CGRectGetMaxY(tipLabel.frame);
            
        }else{
            NSArray *redBallArray = nil;        //红球号码数组
            NSArray *blueBallArray = nil;       //篮球号码数组
            
            NSArray *separetorArray = [code componentsSeparatedByString:@"|"];
            if([separetorArray count] > 0)
            {
                redBallArray = [[separetorArray objectAtIndex:0] componentsSeparatedByString:@","];
            }
            if([separetorArray count] > 1)
            {
                blueBallArray = [[separetorArray objectAtIndex:1] componentsSeparatedByString:@","];
            }
            
            float ballLeftOffset = 17;      //彩球距离左边界距离
            float ballOffsetX = 7;          //左右彩球间隔
            float ballOffsetY = 7;          //上下彩球间隔
            int   oneLineBallCount = 7;     //一行放置的彩球个数
            
            for (int i = 0; i < [redBallArray count]; i++) {
                
                UIView *ball = [self ballViewWithNumber:[redBallArray objectAtIndex:i] isRed:YES];
                ball.frame = CGRectMake(ballLeftOffset + (ORDER_LOTTERY_NUMBER_BALL_WIDTH+ballOffsetX)*(i%7),CGRectGetMaxY(tagLabel.frame)+10 + (ballOffsetY + ORDER_LOTTERY_NUMBER_BALL_WIDTH)*(i/oneLineBallCount), ORDER_LOTTERY_NUMBER_BALL_WIDTH, ORDER_LOTTERY_NUMBER_BALL_WIDTH);
                
                [self addSubview:ball];
            }
            
            for (int i = 0; i < [blueBallArray count]; i++) {
                
                UIView *ball = [self ballViewWithNumber:[blueBallArray objectAtIndex:i] isRed:NO];
                ball.frame = CGRectMake(ballLeftOffset + (ORDER_LOTTERY_NUMBER_BALL_WIDTH+ballOffsetX)*((i + [redBallArray count])%7),CGRectGetMaxY(tagLabel.frame)+10 + (ballOffsetY + ORDER_LOTTERY_NUMBER_BALL_WIDTH)*((i + [redBallArray count])/oneLineBallCount), ORDER_LOTTERY_NUMBER_BALL_WIDTH, ORDER_LOTTERY_NUMBER_BALL_WIDTH);
                
                [self addSubview:ball];
            }
            
            height = CGRectGetMaxY(tagLabel.frame)+10 + (ballOffsetY + ORDER_LOTTERY_NUMBER_BALL_WIDTH) * (([redBallArray count] + [blueBallArray count])/oneLineBallCount + 1);
        }
        
        
        self.frame = CGRectMake(0, 0, ORDER_LOTTERY_NUMBER_VIEW_WIDTH, height+10);
    }
    return self;
}

//返回彩球View
- (UIView *)ballViewWithNumber:(NSString *)number isRed:(BOOL)yesOrNo
{
    UIImageView *ballView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ORDER_LOTTERY_NUMBER_BALL_WIDTH, ORDER_LOTTERY_NUMBER_BALL_WIDTH)];
    if(yesOrNo)
    {
        ballView.image = [UIImage imageNamed:@"lottery_redball.png"];
    }else{
        ballView.image = [UIImage imageNamed:@"lottery_blueball.png"];
    }
    
    UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ORDER_LOTTERY_NUMBER_BALL_WIDTH, ORDER_LOTTERY_NUMBER_BALL_WIDTH)];
    numberLabel.backgroundColor = [UIColor   clearColor];
    numberLabel.textAlignment = UITextAlignmentCenter;
    numberLabel.font = [UIFont systemFontOfSize:18];
    numberLabel.textColor = [UIColor whiteColor];
//    numberLabel.shadowColor = [UIColor blackColor];
//    numberLabel.shadowOffset = CGSizeMake(0, -1);
    numberLabel.text = number;
    [ballView addSubview:numberLabel];
    
    [self addSubview:ballView];
   
    return ballView;
}

@end
