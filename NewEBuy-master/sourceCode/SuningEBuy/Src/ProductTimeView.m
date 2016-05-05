//
//  ProductTimeView.m
//  SuningEBuy
//
//  Created by YANG on 14-7-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ProductTimeView.h"

#define Top     10
#define TimeWidth   10
#define TimeHeght   15

@implementation ProductTimeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
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

- (void)layoutSubviews
{
    self.titleLbl.frame = CGRectMake(15, Top, 140, TimeHeght);
    
    self.dayLbl.frame = CGRectMake(148, Top, TimeWidth, TimeHeght);
    self.dayLbl1.frame = CGRectMake(160, Top, TimeWidth, TimeHeght);
    self.dayLbl2.frame = CGRectMake(self.dayLbl1.right + 2, Top, TimeWidth, TimeHeght);
    self.dayLbl3.frame = CGRectMake(self.dayLbl2.right + 1, Top, 15, TimeHeght);
    
    self.hourLbl1.frame = CGRectMake(self.dayLbl3.right + 1, Top, TimeWidth, TimeHeght);
    self.hourLbl2.frame = CGRectMake(self.hourLbl1.right + 2, Top, TimeWidth, TimeHeght);
    self.hourLbl3.frame = CGRectMake(self.hourLbl2.right + 1, Top, 15, TimeHeght);
    
    self.miniteLbl1.frame = CGRectMake(self.hourLbl3.right + 1, Top, TimeWidth, TimeHeght);
    self.miniteLbl2.frame = CGRectMake(self.miniteLbl1.right + 2, Top, TimeWidth, TimeHeght);
    self.miniteLbl3.frame = CGRectMake(self.miniteLbl2.right + 1, Top, 15, TimeHeght);
    
    self.secondsLbl1.frame = CGRectMake(self.miniteLbl3.right + 1, Top, TimeWidth, TimeHeght);
    self.secondsLbl2.frame = CGRectMake(self.secondsLbl1.right + 2, Top, TimeWidth, TimeHeght);
    self.secondsLbl3.frame = CGRectMake(self.secondsLbl2.right + 1, Top, 15, TimeHeght);
    
    self.lineImgView.frame = CGRectMake(0, 24.5, 320, 0.5);
}

- (UILabel *)tipLabel
{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.frame = CGRectMake(0, Top, 320, TimeHeght);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = [UIColor orange_Red_Color];
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.hidden = YES;
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (UIImageView *)lineImgView
{
    if (!_lineImgView) {
        _lineImgView = [[UIImageView alloc] init];
        _lineImgView.backgroundColor = [UIColor clearColor];
        _lineImgView.image = [UIImage imageNamed:@"line.png"];
        [self addSubview:_lineImgView];
    }
    return _lineImgView;
}

- (void)setPropertyTitleLbl:(UILabel *)lbl
{
    lbl.backgroundColor = [UIColor clearColor];
    lbl.textColor = [UIColor blackColor];
    lbl.font = [UIFont systemFontOfSize:15];
    [self addSubview:lbl];
}

- (void)setPropertyTimeLbl:(UILabel *)lbl
{
    lbl.backgroundColor = [UIColor blackColor];
    lbl.textColor = [UIColor whiteColor];
    lbl.textAlignment = NSTextAlignmentCenter;
    lbl.font = [UIFont systemFontOfSize:14];
    [self addSubview:lbl];
}

- (UILabel *)titleLbl
{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.backgroundColor = [UIColor clearColor];
        _titleLbl.text = L(@"Product_CountingDown");
        _titleLbl.textColor = RGBCOLOR(249, 134, 19);
        _titleLbl.font = [UIFont systemFontOfSize:14];
        [self addSubview:_titleLbl];
    }
    return _titleLbl;
}

- (UILabel *)dayLbl
{
    if (!_dayLbl) {
        _dayLbl = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_dayLbl];
        _dayLbl.hidden = YES;
    }
    return _dayLbl;
}

- (UILabel *)dayLbl1
{
    if (!_dayLbl1) {
        _dayLbl1 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_dayLbl1];
    }
    return _dayLbl1;
}

- (UILabel *)dayLbl2
{
    if (!_dayLbl2) {
        _dayLbl2 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_dayLbl2];
    }
    return _dayLbl2;
}

- (UILabel *)dayLbl3
{
    if (!_dayLbl3) {
        _dayLbl3 = [[UILabel alloc] init];
        _dayLbl3.text = L(@"GBDay");
        [self setPropertyTitleLbl:_dayLbl3];
    }
    return _dayLbl3;
}

- (UILabel *)hourLbl1
{
    if (!_hourLbl1) {
        _hourLbl1 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_hourLbl1];
    }
    return _hourLbl1;
}

- (UILabel *)hourLbl2
{
    if (!_hourLbl2) {
        _hourLbl2 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_hourLbl2];
    }
    return _hourLbl2;
}

- (UILabel *)hourLbl3
{
    if (!_hourLbl3) {
        _hourLbl3 = [[UILabel alloc] init];
        _hourLbl3.text = L(@"GBHour");
        [self setPropertyTitleLbl:_hourLbl3];
    }
    return _hourLbl3;
}

- (UILabel *)miniteLbl1
{
    if (!_miniteLbl1) {
        _miniteLbl1 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_miniteLbl1];
    }
    return _miniteLbl1;
}

- (UILabel *)miniteLbl2
{
    if (!_miniteLbl2) {
        _miniteLbl2 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_miniteLbl2];
    }
    return _miniteLbl2;
}

- (UILabel *)miniteLbl3
{
    if (!_miniteLbl3) {
        _miniteLbl3 = [[UILabel alloc] init];
        _miniteLbl3.text = L(@"GBMinute");
        [self setPropertyTitleLbl:_miniteLbl3];
    }
    return _miniteLbl3;
}

- (UILabel *)secondsLbl1
{
    if (!_secondsLbl1) {
        _secondsLbl1 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_secondsLbl1];
    }
    return _secondsLbl1;
}

- (UILabel *)secondsLbl2
{
    if (!_secondsLbl2) {
        _secondsLbl2 = [[UILabel alloc] init];
        [self setPropertyTimeLbl:_secondsLbl2];
    }
    return _secondsLbl2;
}

- (UILabel *)secondsLbl3
{
    if (!_secondsLbl3) {
        _secondsLbl3 = [[UILabel alloc] init];
        _secondsLbl3.text = L(@"Seconds");
        [self setPropertyTitleLbl:_secondsLbl3];
    }
    return _secondsLbl3;
}

- (void)calculagraphTime:(double)seconds
{
    self.lineImgView.hidden = YES;
    self.tipLabel.hidden = YES;
    
    self.titleLbl.hidden = NO;
    self.dayLbl.hidden = NO;
    self.dayLbl1.hidden = NO;
    self.dayLbl2.hidden = NO;
    self.dayLbl3.hidden = NO;
    self.hourLbl1.hidden = NO;
    self.hourLbl2.hidden = NO;
    self.hourLbl3.hidden = NO;
    self.miniteLbl1.hidden = NO;
    self.miniteLbl2.hidden = NO;
    self.miniteLbl3.hidden = NO;
    self.secondsLbl1.hidden = NO;
    self.secondsLbl2.hidden = NO;
    self.secondsLbl3.hidden = NO;
    
    NSInteger day = seconds / (3600 * 24);
    NSInteger hour = (seconds - day * 3600 * 24) / 3600;
    NSInteger minute = (seconds - day * 3600 * 24 - hour * 3600) / 60;
    NSInteger second = (seconds - day * 3600 * 24 - hour * 3600 - minute * 60);
    
    if (day >= 100) {
        self.dayLbl.hidden = NO;
        
        NSString *dayStr = [NSString stringWithFormat:@"%03d",day];
        NSString *day1Str = [dayStr substringWithRange:NSMakeRange(0, 1)];
        NSString *day2Str = [dayStr substringWithRange:NSMakeRange(1, 1)];
        NSString *day3Str = [dayStr substringWithRange:NSMakeRange(2, 1)];
        
        self.dayLbl.text = day1Str;
        self.dayLbl1.text = day2Str;
        self.dayLbl2.text = day3Str;
        
    }else{
        self.dayLbl.hidden = YES;
        NSString *dayStr = [NSString stringWithFormat:@"%02d",day];
        NSString *day1Str = [dayStr substringWithRange:NSMakeRange(0, 1)];
        NSString *day2Str = [dayStr substringWithRange:NSMakeRange(1, 1)];
        
        self.dayLbl1.text = day1Str;
        self.dayLbl2.text = day2Str;
    }
    
    NSString *hourStr = [NSString stringWithFormat:@"%02d",hour];
    NSString *hour1Str = [hourStr substringWithRange:NSMakeRange(0, 1)];
    NSString *hour2Str = [hourStr substringWithRange:NSMakeRange(1, 1)];
    self.hourLbl1.text = hour1Str;
    self.hourLbl2.text = hour2Str;
    
    NSString *miniteStr = [NSString stringWithFormat:@"%02d",minute];
    NSString *minute1Str = [miniteStr substringWithRange:NSMakeRange(0, 1)];
    NSString *minute2Str = [miniteStr substringWithRange:NSMakeRange(1, 1)];
    self.miniteLbl1.text = minute1Str;
    self.miniteLbl2.text = minute2Str;
    
    NSString *secondStr = [NSString stringWithFormat:@"%02d",second];
    NSString *second1Str = [secondStr substringWithRange:NSMakeRange(0, 1)];
    NSString *second2Str = [secondStr substringWithRange:NSMakeRange(1, 1)];
    self.secondsLbl1.text = second1Str;
    self.secondsLbl2.text = second2Str;
}

- (void)setState:(NSInteger)state
{
    if (state == 1) {
        self.titleLbl.text = L(@"Product_PreorderStart");
    }
    else if (state == 2)
    {
        self.titleLbl.text = L(@"Product_PreorderEnd");
    }
    else if (state == 3){
        self.titleLbl.text = L(@"Product_PurchaseStart");
    }
    else if (state == 4){
        self.titleLbl.text = L(@"Product_PurchaseEnd");
    }
    else
    {
        self.titleLbl.text = L(@"Product_CountingDown");
    }
}

- (void)hiddenTimeLabel:(NSString *)tip
{
    self.tipLabel.hidden = NO;
    self.titleLbl.hidden = YES;
    self.dayLbl.hidden = YES;
    self.dayLbl1.hidden = YES;
    self.dayLbl2.hidden = YES;
    self.dayLbl3.hidden = YES;
    self.hourLbl1.hidden = YES;
    self.hourLbl2.hidden = YES;
    self.hourLbl3.hidden = YES;
    self.miniteLbl1.hidden = YES;
    self.miniteLbl2.hidden = YES;
    self.miniteLbl3.hidden = YES;
    self.secondsLbl1.hidden = YES;
    self.secondsLbl2.hidden = YES;
    self.secondsLbl3.hidden = YES;
    
    self.tipLabel.text = tip;
}

@end
