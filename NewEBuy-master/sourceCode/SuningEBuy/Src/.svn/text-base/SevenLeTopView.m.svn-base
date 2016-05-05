//
//  SevenLeTopView.m
//  SuningLottery
//
//  Created by yang yulin on 13-4-7.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "SevenLeTopView.h"
#import "NSAttributedString+Attributes.h"



@implementation SevenLeTopView

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.backgroundColor = RGBCOLOR(244, 243, 236);
    }
    
    return self;
}


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_pastTimesLabel);
    
    TT_RELEASE_SAFELY(_nowTimesLabel);
    
    TT_RELEASE_SAFELY(_backGroudImageView);
    
}


-(void)setLabelsInfo:(LotteryHallDto *)dto{
    
    NSString *nowfendtime = [dto.nowendtime substringWithRange:NSMakeRange(0, 16)];
    
    NSString *nowStr = [NSString stringWithFormat:L(@"LODeadLine"),dto.nowpid,nowfendtime];
    
    NSArray * arr = [dto.code  componentsSeparatedByString:@"|" ];
    
    NSString *baseBallString = [arr objectAtIndex:0];
    
    NSString *specialBallString = [arr objectAtIndex:1];
    
    baseBallString = [baseBallString stringByReplacingOccurrencesOfString:@"," withString:@" "];
    
    NSString *codeString = [NSString stringWithFormat:L(@"LODrawLotteryNumber"),dto.pid,baseBallString,specialBallString];

    NSMutableAttributedString *pastStr = [[NSMutableAttributedString alloc] initWithString:codeString];
    
    DLog("codeString ==== %@",pastStr);
    
    //if (IOS7_OR_LATER)
    {
        [pastStr setTextColor:[UIColor colorWithRGBHex:0x313131]];
        
        [pastStr setTextColor:[UIColor darkRedColor] range:[codeString rangeOfString:baseBallString]];
    }
//    else
//    {
//        [pastStr setTextColor:[UIColor darkBlueColor]];
//        
//        [pastStr setTextColor:[UIColor darkRedColor] range:[codeString rangeOfString:baseBallString]];
//    }
    
    
    [pastStr setFont:[UIFont systemFontOfSize:14]];
    
    
    self.pastTimesLabel.attributedText = pastStr;
    
    TT_RELEASE_SAFELY(pastStr);
    
    self.nowTimesLabel.text = nowStr;
    
    [self layoutIfNeeded];
    
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    self.backGroudImageView.frame = CGRectMake(2, 0, 300, 45);
    
    self.pastTimesLabel.frame = CGRectMake(10, 2, 320, 18);

    self.nowTimesLabel.frame = CGRectMake(10, 20, 320, 18);
    
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
        //if (IOS7_OR_LATER)
        {
            _nowTimesLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        }
//        else
//        _nowTimesLabel.textColor = RGBCOLOR(102.0, 51.0, 51.0);
        
        _nowTimesLabel.textAlignment = UITextAlignmentLeft;
        
        [self.backGroudImageView addSubview:_nowTimesLabel];
        
    }
    
    return _nowTimesLabel;
}


-(UIImageView *)backGroudImageView{
    
    if (!_backGroudImageView) {
        
        _backGroudImageView = [[UIImageView alloc] init];
//        if (!IOS7_OR_LATER)
//            _backGroudImageView.image = [UIImage imageNamed:@"ball_top_backgound.png"];
//        else
            _backGroudImageView.backgroundColor = [UIColor uiviewBackGroundColor];
        [self addSubview:_backGroudImageView];
        
    }
    
    return _backGroudImageView;
    
}


@end
