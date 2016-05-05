//
//  FlightListTitleView.m
//  SuningEBuy
//
//  Created by shasha on 12-5-22.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "FlightListTitleView.h"

@implementation FlightListTitleView
@synthesize timeLabel = _timeLabel;
@synthesize cityLabel = _cityLabel;
@synthesize timeStr = _timeStr;
@synthesize cityStr = _cityStr;
@synthesize lineImage = _lineImage;


- (id)init {
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
    
}


- (void)setTimeStr:(NSString *)timeStr{

    _timeStr = timeStr;
    
    self.timeLabel.text = self.timeStr;

}

- (void)setCityStr:(NSString *)cityStr{
    
    _cityStr = cityStr;
    
    self.cityLabel.text = self.cityStr;

}


- (UILabel *)timeLabel
{
    if (nil == _timeLabel ) 
    {
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.backgroundColor = [UIColor clearColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _timeLabel.textAlignment = UITextAlignmentLeft;
        _timeLabel.frame = CGRectMake(220, 10, 100, 20);
        _timeLabel.textColor = [UIColor blackColor];
        [self addSubview:_timeLabel];
    } 
    return _timeLabel;
}

- (UILabel *)cityLabel
{
    if (nil == _cityLabel ) 
    {
        _cityLabel = [[UILabel alloc]init];
        _cityLabel.backgroundColor = [UIColor clearColor];
        _cityLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _cityLabel.textAlignment = UITextAlignmentLeft;
        _cityLabel.frame = CGRectMake(15, 10, 200, 20);
        _cityLabel.textColor = [UIColor blackColor];
        [self addSubview:_cityLabel];
    } 
    return _cityLabel;
}

-(UIImageView *)lineImage{
    
    if (!_lineImage) {
        _lineImage = [[UIImageView alloc]init];
        UIImage *image = [UIImage newImageFromResource:@"line.png"];
        _lineImage.image = image;
        [self addSubview:_lineImage];
    }
    return _lineImage;
}

@end
