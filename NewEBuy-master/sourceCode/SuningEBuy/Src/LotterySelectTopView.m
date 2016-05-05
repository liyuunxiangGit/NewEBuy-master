//
//  LotterySelectTopView.m
//  SuningEBuy
//
//  Created by shasha on 12-6-29.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "LotterySelectTopView.h"
#import "NSAttributedString+Attributes.h"

@implementation LotterySelectTopView
@synthesize pastTimesLabel = _pastTimesLabel;
@synthesize nowTimesLabel = _nowTimesLabel;
@synthesize seperateLine = _seperateLine;
@synthesize backGroudImageView = _backGroudImageView;

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = [UIColor uiviewBackGroundColor];
    }
    
    return self;
}


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_pastTimesLabel);
    
    TT_RELEASE_SAFELY(_nowTimesLabel);
    
    TT_RELEASE_SAFELY(_seperateLine);
    
    TT_RELEASE_SAFELY(_backGroudImageView);
    
}


-(void)setLabelsInfo:(LotteryHallDto *)dto{
    
    NSString *nowendtime = [dto.nowendtime substringWithRange:NSMakeRange(0, 16)];
    NSString *nowStr = [NSString stringWithFormat:L(@"LODeadLine1"),dto.nowpid,nowendtime];
    
    NSString *pastStr;
    
    if([dto.gid isEqualToString:@"01"]|| [dto.gid isEqualToString:@"50"])//双色球和大乐透
    {
        NSArray * arr = [dto.code  componentsSeparatedByString:@"|" ];
        
        NSString *redBallString = [arr objectAtIndex:0];
        
        NSString *blueBallString = [arr objectAtIndex:1];
        
        redBallString = [redBallString stringByReplacingOccurrencesOfString:@"," withString:@" "];
        
        if ([blueBallString length]> 1)
        {
            blueBallString = [blueBallString stringByReplacingOccurrencesOfString:@"," withString:@" "];
        }
        
        NSString *codeString = [NSString stringWithFormat:L(@"LODrawLotteryNumber1"),dto.pid,redBallString,blueBallString];
        
        NSMutableAttributedString *pastStr = [[NSMutableAttributedString alloc] initWithString:codeString];
        
        DLog("codeString ==== %@",pastStr);
        
        [pastStr setTextColor:[UIColor darkBlueColor]];
        
        [pastStr setTextColor:[UIColor darkRedColor] range:[codeString rangeOfString:redBallString]];
        
        [pastStr setFont:[UIFont systemFontOfSize:14]];
        
//        [pastStr setTextAlignment:CTTextAlignmentFromUITextAlignment(UITextAlignmentCenter) lineBreakMode:kCTLineBreakByTruncatingTail];
        
        self.pastTimesLabel.attributedText = pastStr;
        
        TT_RELEASE_SAFELY(pastStr);
    }
    else
    {
        NSString *luckyNumber = [dto.code stringByReplacingOccurrencesOfString:@"," withString:@" | "];
        if (IOS7_OR_LATER)
        {
            luckyNumber = [dto.code stringByReplacingOccurrencesOfString:@"," withString:@"   "];
        }
        pastStr = [NSString stringWithFormat:L(@"LODrawLotteryNumber1"),dto.pid,luckyNumber];
        
        NSMutableAttributedString *pastString = [[NSMutableAttributedString alloc] initWithString:pastStr];
        [pastString setFont:[UIFont systemFontOfSize:14]];
        if (IOS7_OR_LATER)
        {
            [pastString setTextColor:[UIColor colorWithRGBHex:0x313131]];
            
            [pastString setTextColor:[UIColor colorWithRGBHex:0xff0101] range:[pastStr rangeOfString:luckyNumber]];
        }
        else
        {
            [pastString setTextColor:[UIColor darkBlueColor]];
            
            [pastString setTextColor:[UIColor darkRedColor] range:[pastStr rangeOfString:luckyNumber]];
        }
        
        
//        [pastString setTextAlignment:CTTextAlignmentFromUITextAlignment(UITextAlignmentCenter) lineBreakMode:kCTLineBreakByTruncatingTail];
        
        self.pastTimesLabel.attributedText = pastString;
        
        TT_RELEASE_SAFELY(pastString);
        
    }
    
    
    
    
    self.nowTimesLabel.text = nowStr;
    
    [self layoutIfNeeded];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backGroudImageView.frame = CGRectMake(0, 0, 300+20, 40);
    
    self.pastTimesLabel.frame = CGRectMake(20, 2, 320, 18);
    
    //    self.seperateLine.frame = CGRectMake(0, 19, 320, 2);
    
    self.nowTimesLabel.frame = CGRectMake(20, 20, 320, 18);
    
}

- (OHAttributedLabel *)pastTimesLabel{
    
    if (!_pastTimesLabel) {
        
        _pastTimesLabel = [[OHAttributedLabel alloc] init];
        
        _pastTimesLabel.backgroundColor = [UIColor clearColor];
        
        [_pastTimesLabel setFont:[UIFont systemFontOfSize:14]];
        
        _pastTimesLabel.textColor = RGBCOLOR(141, 153,163);
        
        _pastTimesLabel.textAlignment = UITextAlignmentLeft;
        
        [self.backGroudImageView addSubview:_pastTimesLabel];
        
    }
    
    return _pastTimesLabel;
}

-(OHAttributedLabel*)nowTimesLabel{
    
    if (!_nowTimesLabel) {
        
        _nowTimesLabel = [[OHAttributedLabel alloc] init];
        
        _nowTimesLabel.backgroundColor = [UIColor clearColor];
        
        [_nowTimesLabel setFont:[UIFont systemFontOfSize:14]];
        if (IOS7_OR_LATER)
        {
             _nowTimesLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        }
        else
        _nowTimesLabel.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        
        _nowTimesLabel.textAlignment = UITextAlignmentLeft;
        
        [self.backGroudImageView addSubview:_nowTimesLabel];
        
    }
    
    return _nowTimesLabel;
}


-(UIImageView *)seperateLine{
    
    if (!_seperateLine) {
        
        _seperateLine = [[UIImageView alloc] init];
        
        _seperateLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        
        //        [self.backGroudImageView addSubview:_seperateLine];
        
    }
    
    return _seperateLine;
    
}

-(UIImageView *)backGroudImageView{
    
    if (!_backGroudImageView) {
        
        _backGroudImageView = [[UIImageView alloc] init];
        
        //_backGroudImageView.image = [UIImage imageNamed:@"ball_top_backgound.png"];
        _backGroudImageView.backgroundColor = [UIColor uiviewBackGroundColor];
        [self addSubview:_backGroudImageView];
        
    }
    
    return _backGroudImageView;
    
}


@end
