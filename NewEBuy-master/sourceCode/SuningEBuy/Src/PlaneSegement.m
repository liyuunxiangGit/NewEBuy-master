//
//  PlaneSegement.m
//  SuningEBuy
//
//  Created by david on 14-1-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PlaneSegement.h"

@implementation PlaneSegement

-(id)initWithLeftItem:(NSString *)leftItem
            rightItem:(NSString *)rightItem{
    
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.oneButton];
        [self addSubview:self.twoButton];
        [self addSubview:self.oneLine];
        [self addSubview:self.twoLine];
        [self addSubview:self.verticalLine];
        
        [self.oneButton setTitle:leftItem forState:UIControlStateNormal];
        [self.twoButton setTitle:rightItem forState:UIControlStateNormal];

    }
    return self;
}

-(void)setCheckedIndex:(NSInteger)index{

    UIImage *enableImage = [UIImage newImageFromResource:@"segment_gray_line.png"];
    UIImage *disableImage = [UIImage newImageFromResource:@"segment_orange_line.png"];
    
    if (index == 0) {
        
        self.oneButton.enabled = NO;
        self.twoButton.enabled = YES;
        
        self.oneLine.image = disableImage;
        self.oneLine.frame = CGRectMake(0, 32, 160, 3);
        self.twoLine.image = enableImage;
        self.twoLine.frame = CGRectMake(160, 34, 160, 1);
        
    }else{
        
        self.oneButton.enabled = YES;
        self.twoButton.enabled = NO;
        
        self.oneLine.image = enableImage;
        self.oneLine.frame = CGRectMake(0, 34, 160, 1);
        self.twoLine.image = disableImage;
        self.twoLine.frame = CGRectMake(160, 32, 160, 3);
    }
}


-(UIButton *)oneButton{

    if (_oneButton == nil) {
        _oneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _oneButton.frame = CGRectMake(0, 0, 160, 35);
        _oneButton.backgroundColor = [UIColor whiteColor];
        _oneButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_oneButton setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateDisabled];
        [_oneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_oneButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _oneButton.enabled = NO;
    }
    return _oneButton;
}


-(UIButton *)twoButton{
    
    if (_twoButton == nil) {
        _twoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _twoButton.frame = CGRectMake(160, 0, 160, 35);
        _twoButton.backgroundColor = [UIColor whiteColor];
        _twoButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        [_twoButton setTitleColor:[UIColor orange_Red_Color] forState:UIControlStateDisabled];
        [_twoButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_twoButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        _twoButton.enabled = YES;
    }
    return _twoButton;
}

-(UIImageView *)oneLine{
    
    if (!_oneLine) {
        _oneLine = [[UIImageView alloc]init];
        _oneLine.frame = CGRectMake(0, 32, 160, 3);
        UIImage *disableImage = [UIImage newImageFromResource:@"segment_orange_line.png"];
        _oneLine.image = disableImage;
    }
    return _oneLine;
}

-(UIImageView *)twoLine{
    
    if (!_twoLine) {
        _twoLine = [[UIImageView alloc]init];
        _twoLine.frame = CGRectMake(160, 34, 160, 1);
        UIImage *enableImage = [UIImage newImageFromResource:@"segment_gray_line.png"];
        _twoLine.image = enableImage;
    }
    return _twoLine;
}


-(UIImageView *)verticalLine{
    
    if (!_verticalLine) {
        _verticalLine = [[UIImageView alloc]init];
        _verticalLine.frame = CGRectMake(159, 8, 1, 19);
        UIImage *image = [UIImage newImageFromResource:@"segment_vertical_line.png"];
        _verticalLine.image = image;
    }
    return _verticalLine;
}

-(void)buttonAction:(id)sender{
    
    UIButton *button  = (UIButton *)sender;
    
    UIImage *enableImage = [UIImage newImageFromResource:@"segment_gray_line.png"];
    UIImage *disableImage = [UIImage newImageFromResource:@"segment_orange_line.png"];
    
    NSInteger index;
    
    if (button == self.oneButton) {
        
        self.oneButton.enabled = NO;
        self.twoButton.enabled = YES;
        
        self.oneLine.image = disableImage;
        self.oneLine.frame = CGRectMake(0, 32, 160, 3);
        self.twoLine.image = enableImage;
        self.twoLine.frame = CGRectMake(160, 34, 160, 1);
        index = 0;
        
    }else{
        
        self.oneButton.enabled = YES;
        self.twoButton.enabled = NO;
        
        self.oneLine.image = enableImage;
        self.oneLine.frame = CGRectMake(0, 34, 160, 1);
        self.twoLine.image = disableImage;
        self.twoLine.frame = CGRectMake(160, 32, 160, 3);
        index = 1;

    }
    
    if ([self.delegate respondsToSelector:@selector(planeSegement:)]) {
        
        [self.delegate planeSegement:index];
    }
}

@end
