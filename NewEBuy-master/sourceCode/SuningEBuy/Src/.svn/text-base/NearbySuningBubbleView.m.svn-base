
//
//  NearbySuningBubbleView.m
//  SuningEBuy
//
//  Created by cui zl on 13-3-28.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NearbySuningBubbleView.h"

@implementation NearbySuningBubbleView

@synthesize titleLbl = _titleLbl;
@synthesize detailLbl = _detailLbl;
@synthesize detailBtn = _detailBtn;
@synthesize leftImg = _leftImg;
@synthesize nearbySuningDto = _nearbySuningDto;
@synthesize arrowImg = _arrowImg;

//static const float kBorderWidth = 10.0f;
//static const float kEndCapWidth = 20.0f;
//static const float kMaxLabelWidth = 220.0f;

-(void)dealloc
{
    
    TT_RELEASE_SAFELY(_titleLbl);
    TT_RELEASE_SAFELY(_detailLbl);
    TT_RELEASE_SAFELY(_detailBtn);
    TT_RELEASE_SAFELY(_leftImg);
    TT_RELEASE_SAFELY(_nearbySuningDto);
    gotoDetailBlock = nil;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)setBgImg
{
    self.userInteractionEnabled = YES;
    [self.leftImg removeFromSuperview];
    [self.arrowImg removeFromSuperview];
    [self addSubview:self.leftImg];
    [self sendSubviewToBack:self.leftImg];
    
}

- (BOOL)showFromRect:(CGRect)rect {
    if (self.nearbySuningDto == nil) {
        return NO;
    }
    
    [self setBgImg];
    
    self.titleLbl.text = [NSString stringWithFormat:@"%@", self.nearbySuningDto.name];
    if ([self.nearbySuningDto.distance isEqualToString:@"-1.0"]) {
        
    }else{
        self.distanceLabel.text = [NSString stringWithFormat:@"%0.2fkm",[self.nearbySuningDto.distance doubleValue]];
    }
    
    self.detailLbl.text = self.nearbySuningDto.address;//[NSString stringWithFormat:@"%@-%@km",self.nearbySuningDto.address,@"2000"];
    self.titleLbl.frame = CGRectZero;
    if (!self.arrowImg.superview) {
        [self.leftImg addSubview:self.arrowImg];
    }
    [self addSubview:self.detailBtn];
    
    return YES;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)layoutSubviews
{
    self.titleLbl.frame = CGRectMake(5, 5, self.width - 30, 25);
    self.leftImg.frame = CGRectMake(0, 0, self.width, 60);
    self.arrowImg.frame = CGRectMake(self.titleLbl.right - 3, 17, 22, 22);
    self.detailBtn.frame = CGRectMake(0, 0, self.width, 60);
    if ([self.nearbySuningDto.distance isEqualToString:@"-1.0"]) {
        self.detailLbl.frame = CGRectMake(5, 30, self.width -30, 20);
    }else{
        self.detailLbl.frame = CGRectMake(5, 30, self.width - 55 -30, 20);
        self.distanceLabel.frame = CGRectMake(self.detailLbl.right, 30, 55, 20);
    }
}

-(void)setGoToDetailBlock:(SNBasicBlock)block
{
    if(gotoDetailBlock != block){
        
        gotoDetailBlock = [block copy];
    }
}

-(UILabel *)titleLbl
{
    
    if(_titleLbl == nil)
    {
        _titleLbl = [[UILabel alloc]init];
        
        _titleLbl.font = [UIFont systemFontOfSize:14];
        
        _titleLbl.backgroundColor = [UIColor clearColor];
        
        _titleLbl.textColor = [UIColor whiteColor];
        
        _titleLbl.textAlignment = UITextAlignmentLeft;
        
        [self.detailBtn addSubview:_titleLbl];
    }
    return _titleLbl;
}

-(UILabel *)detailLbl
{
    if(_detailLbl == nil)
    {
        _detailLbl = [[UILabel alloc]init];
        
        _detailLbl.font = [UIFont systemFontOfSize:11];
        
        _detailLbl.backgroundColor = [UIColor clearColor];
        
        _detailLbl.textColor = [UIColor whiteColor];
        
        _detailLbl.contentMode = UIViewContentModeCenter;
        
        //        _detailLbl.text = @"详情";
        
        _detailLbl.textAlignment = UITextAlignmentLeft;
        
        [self.detailBtn addSubview:_detailLbl];
    }
    return _detailLbl;
    
}


-(UILabel *)distanceLabel
{
    if(_distanceLabel == nil)
    {
        _distanceLabel = [[UILabel alloc]init];
        
        _distanceLabel.font = [UIFont systemFontOfSize:11];
        
        _distanceLabel.backgroundColor = [UIColor clearColor];
        
        _distanceLabel.textColor = [UIColor whiteColor];
        
        _distanceLabel.contentMode = UIViewContentModeCenter;
        
        //        _detailLbl.text = @"详情";
        
        _distanceLabel.textAlignment = NSTextAlignmentRight;
        
        [self.detailBtn addSubview:_distanceLabel];
    }
    return _distanceLabel;
    
}

-(UIButton *)detailBtn
{
    if(_detailBtn == nil)
    {
        _detailBtn = [[UIButton alloc]init];
        
        [_detailBtn setBackgroundColor:[UIColor clearColor]];
        
        [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _detailBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        
        [_detailBtn addTarget:self action:@selector(goToDetail) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailBtn;
}

-(UIImageView*)leftImg
{
    if(_leftImg == nil)
    {
        
        UIImage *imageNormal, *imageHighlighted;
        imageNormal = [UIImage imageNamed:@"bubbleView.png"] ;//stretchableImageWithLeftCapWidth:10 topCapHeight:13];
        imageHighlighted = [UIImage imageNamed:@"bubbleView.png"];
        //                            stretchableImageWithLeftCapWidth:10 topCapHeight:13];
        _leftImg = [[UIImageView alloc] initWithImage:imageNormal
                                     highlightedImage:imageHighlighted];
        _leftImg.tag = 11;
        
        _leftImg.userInteractionEnabled = YES;
        
    }
    
    return _leftImg;
}

- (UIImageView *)arrowImg
{
    if (!_arrowImg) {
        _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bubbleView_arrow.png"]];
        _arrowImg.backgroundColor = [UIColor clearColor];
        _arrowImg.userInteractionEnabled = YES;
    }
    return _arrowImg;
}

-(void)goToDetail
{
    if(gotoDetailBlock)
    {
        gotoDetailBlock();
    }
}

@end
