//
//  GroupProductColockView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-9.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "GroupProductColockView.h"

@interface GroupProductColockView()

@property (nonatomic, strong) UIImageView *imageHourTitle;
@property (nonatomic, strong) UIImageView *imageHourContent;
@property (nonatomic, strong) UIImageView *imageHourLine;

@property (nonatomic, strong) UIImageView *imageMinuteTitle;
@property (nonatomic, strong) UIImageView *imageMinuteContent;
@property (nonatomic, strong) UIImageView *imageMinuteLine;

@property (nonatomic, strong) UIImageView *imageSecondTitle;
@property (nonatomic, strong) UIImageView *imageSecondContent;
@property (nonatomic, strong) UIImageView *imageSecondLine;

@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *secondLabel;

- (void)addSubviewsNeeded;

@end

///////////////////////////////////////////////////////////////

@implementation GroupProductColockView

@synthesize imageHourTitle = _imageHourTitle;
@synthesize imageHourContent = _imageHourContent;
@synthesize imageHourLine = _imageHourLine;

@synthesize imageMinuteTitle = _imageMinuteTitle;
@synthesize imageMinuteContent = _imageMinuteContent;
@synthesize imageMinuteLine = _imageMinuteLine;

@synthesize imageSecondTitle = _imageSecondTitle;
@synthesize imageSecondContent = _imageSecondContent;
@synthesize imageSecondLine = _imageSecondLine;

@synthesize hourLabel = _hourLabel;
@synthesize minuteLabel = _minuteLabel;
@synthesize secondLabel = _secondLabel;

- (void)dealloc
{
    TTVIEW_RELEASE_SAFELY(_imageHourTitle);
    TTVIEW_RELEASE_SAFELY(_imageHourContent);
    TTVIEW_RELEASE_SAFELY(_imageHourLine);
    
    TTVIEW_RELEASE_SAFELY(_imageMinuteLine);
    TTVIEW_RELEASE_SAFELY(_imageMinuteTitle);
    TTVIEW_RELEASE_SAFELY(_imageSecondContent);
    
    TTVIEW_RELEASE_SAFELY(_imageSecondContent);
    TTVIEW_RELEASE_SAFELY(_imageSecondLine);
    TTVIEW_RELEASE_SAFELY(_imageSecondTitle);
    
    TTVIEW_RELEASE_SAFELY(_hourLabel);
    TTVIEW_RELEASE_SAFELY(_minuteLabel);
    TTVIEW_RELEASE_SAFELY(_secondLabel);
    
}

- (id)init
{
    self = [super init];
    if (self) 
    {
        self.size = CGSizeMake(129, 44);
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubviewsNeeded];
    }
    return self;
}

- (void)setTime:(NSTimeInterval)seconds
{
    NSInteger hour = seconds / 3600;
    
    NSInteger minute = (seconds - hour * 3600) / 60;
    
    NSInteger second = (seconds - hour * 3600 - minute * 60);
    
    if (hour >= 100)
    {
        self.hourLabel.text = [NSString stringWithFormat:@"%03d", hour];
    }
    else
    {
        self.hourLabel.text = [NSString stringWithFormat:@"%02d", hour];
    }
    
    self.minuteLabel.text = [NSString stringWithFormat:@"%02d", minute];
    
    self.secondLabel.text = [NSString stringWithFormat:@"%02d", second];
    
    [self setNeedsLayout];
}

- (void)addSubviewsNeeded
{
    self.imageHourContent.backgroundColor = [UIColor clearColor];
    
    self.imageHourTitle.backgroundColor = [UIColor clearColor];

    self.imageMinuteContent.backgroundColor = [UIColor clearColor];
    self.imageMinuteTitle.backgroundColor = [UIColor clearColor];
    
    self.imageSecondContent.backgroundColor = [UIColor clearColor];
    self.imageSecondTitle.backgroundColor = [UIColor clearColor];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageHourContent.frame = CGRectMake(5, 11, self.imageHourContent.size.width, self.imageHourContent.size.height);
    
    self.imageHourTitle.frame = CGRectMake(self.imageHourContent.left + 6.25, 0, self.imageHourTitle.size.width, self.imageHourTitle.size.height);
    
    self.hourLabel.frame = self.imageHourContent.frame;
    
    self.imageHourLine.frame = CGRectMake(self.imageHourContent.left + 3, self.imageHourContent.top + self.imageHourContent.height/2, self.imageHourLine.size.width, self.imageHourLine.size.height);
    //
    self.imageMinuteContent.frame = CGRectMake(self.imageHourContent.right + 10, 11, self.imageMinuteContent.size.width, self.imageMinuteContent.size.height);
    
    self.imageMinuteTitle.frame = CGRectMake(self.imageMinuteContent.left + 3.5, 0, self.imageMinuteTitle.size.width, self.imageMinuteTitle.size.height);
    
    self.minuteLabel.frame = self.imageMinuteContent.frame;
    
    self.imageMinuteLine.frame = CGRectMake(self.imageMinuteContent.left + 3, self.imageMinuteContent.top + self.imageMinuteContent.height/2, self.imageMinuteLine.size.width, self.imageMinuteLine.size.height);
    //
    self.imageSecondContent.frame = CGRectMake(self.imageMinuteContent.right + 10, 11, self.imageSecondContent.size.width, self.imageSecondContent.size.height);
    
    self.imageSecondTitle.frame = CGRectMake(self.imageSecondContent.left + 2.5, 0, self.imageSecondTitle.size.width, self.imageSecondTitle.size.height);
    
    self.secondLabel.frame = self.imageSecondContent.frame;
    
    self.imageSecondLine.frame = CGRectMake(self.imageSecondContent.left + 3, self.imageSecondContent.top + self.imageSecondContent.height/2, self.imageSecondLine.size.width, self.imageSecondLine.size.height);
}

- (UIImageView *)imageHourTitle
{
    if (!_imageHourTitle) 
    {
        _imageHourTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20.5, 7.5)];
        
        _imageHourTitle.image = [UIImage imageNamed:@"product_gp_hours.png"];
        
        [self addSubview:_imageHourTitle];
    }
    return _imageHourTitle;
}

- (UIImageView *)imageHourContent
{
    if (!_imageHourContent) 
    {
        _imageHourContent = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_colock_background.png"]];
        
        [self addSubview:_imageHourContent];
    }
    return _imageHourContent;
}

- (UIImageView *)imageHourLine
{
    if (!_imageHourLine)
    {
        _imageHourLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_colock_line.png"]];
        
        [self addSubview:_imageHourLine];
    }
    return _imageHourLine;
}

- (UIImageView *)imageMinuteTitle
{
    if (!_imageMinuteTitle) 
    {
        _imageMinuteTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 26, 7.5)];
        
        _imageMinuteTitle.image = [UIImage imageNamed:@"product_gp_minutes.png"];
        
        [self addSubview:_imageMinuteTitle];
    }
    return _imageMinuteTitle;
}

- (UIImageView *)imageMinuteContent
{
    if (!_imageMinuteContent) 
    {
        _imageMinuteContent = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_colock_background.png"]];
        
        [self addSubview:_imageMinuteContent];
    }
    return _imageMinuteContent;
}

- (UIImageView *)imageMinuteLine
{
    if (!_imageMinuteLine)
    {
        _imageMinuteLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_colock_line.png"]];
        
        [self addSubview:_imageMinuteLine];
    }
    return _imageMinuteLine;
}

- (UIImageView *)imageSecondTitle
{
    if (!_imageSecondTitle) 
    {
        _imageSecondTitle = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28, 8)];
        
        _imageSecondTitle.image = [UIImage imageNamed:@"product_gp_seconds.png"];
        
        [self addSubview:_imageSecondTitle];
    }
    return _imageSecondTitle;
}

- (UIImageView *)imageSecondContent
{
    if (!_imageSecondContent) 
    {
        _imageSecondContent = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_colock_background.png"]];
        
        [self addSubview:_imageSecondContent];
    }
    return _imageSecondContent;
}

- (UIImageView *)imageSecondLine
{
    if (!_imageSecondLine)
    {
        _imageSecondLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"product_colock_line.png"]];
        
        [self addSubview:_imageSecondLine];
    }
    return _imageSecondLine;
}

- (UILabel *)hourLabel
{
    if (!_hourLabel)
    {
        _hourLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 33, 31)];
        
        _hourLabel.textAlignment = UITextAlignmentCenter;
        
        _hourLabel.backgroundColor = [UIColor clearColor];
        
        _hourLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17.0];
        
        _hourLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_hourLabel];
    }
    return _hourLabel;
}

- (UILabel *)minuteLabel
{
    if (!_minuteLabel)
    {
        _minuteLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 33, 31)];
        
        _minuteLabel.textAlignment = UITextAlignmentCenter;
        
        _minuteLabel.backgroundColor = [UIColor clearColor];
        
        _minuteLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17.0];
        
        _minuteLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_minuteLabel];
    }
    return _minuteLabel;
}

- (UILabel *)secondLabel
{
    if (!_secondLabel)
    {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 33, 31)];
        
        _secondLabel.textAlignment = UITextAlignmentCenter;
        
        _secondLabel.backgroundColor = [UIColor clearColor];
        
        _secondLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:17.0];
        
        _secondLabel.textColor = [UIColor whiteColor];
        
        [self addSubview:_secondLabel];
    }
    return _secondLabel;
}

@end
