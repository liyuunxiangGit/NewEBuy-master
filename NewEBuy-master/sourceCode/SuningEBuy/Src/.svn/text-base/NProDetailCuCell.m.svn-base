//
//  NProDetailCuCell.m
//  SuningEBuy
//
//  Created by YANG on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProDetailCuCell.h"

@implementation NProDetailCuCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
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
    [super layoutSubviews];
    
    self.seperateLine1.frame = CGRectMake(0, 0, 320, 0.5);
//    self.seperateLine2.frame = CGRectMake(0, 39.5, 320, 0.5);
    self.arrowImageV.frame = CGRectMake(295, 12, 15/2, 24/2);
    self.colorLbl.frame = CGRectMake(15, 10, 200, 20);
}
- (UIImageView *)seperateLine1
{
    if (!_seperateLine1) {
        _seperateLine1 = [[UIImageView alloc] init];
        
        _seperateLine1.image = [UIImage streImageNamed:@"line.png"];
        
        _seperateLine1.backgroundColor = [UIColor blueColor];
        
        [self.contentView addSubview:_seperateLine1];
    }
    return _seperateLine1;
}

- (UIImageView *)seperateLine2
{
    if (!_seperateLine2) {
        _seperateLine2 = [[UIImageView alloc] init];
        
        _seperateLine2.image = [UIImage streImageNamed:@"line.png"];
        
        _seperateLine2.backgroundColor = [UIColor blueColor];
        
        [self.contentView addSubview:_seperateLine2];
    }
    return _seperateLine2;
}

- (UIImageView *)arrowImageV
{
    if(!_arrowImageV)
    {
        _arrowImageV = [[UIImageView alloc] init];
        
        _arrowImageV.backgroundColor = [UIColor clearColor];
        
        _arrowImageV.image = [UIImage imageNamed:@"arrow_right_gray.png"];
        
        [self.contentView addSubview:_arrowImageV];
    }
    
    return _arrowImageV;
}

- (UILabel*)colorLbl
{
    if(!_colorLbl)
    {
        _colorLbl = [[UILabel alloc] init];
        
        _colorLbl.backgroundColor = [UIColor clearColor];
        
        _colorLbl.font = [UIFont systemFontOfSize:14];
        
        _colorLbl.textColor = [UIColor colorWithRGBHex:0x666666];
        
        _colorLbl.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_colorLbl];
    }
    
    return _colorLbl;
}

- (void)setColorStr:(NSString *)colorStr withType:(ProductDeatailType)type
{
    if (type == PurchuseProduct) {
        self.seperateLine2.frame = CGRectMake(0, 39.5, 320, 0.5);
    }
    else
    {
        self.seperateLine2.frame = CGRectMake(15, 39.5, 305, 0.5);
    }
    
    if (IsStrEmpty(colorStr)) {
        self.colorLbl.text = L(@"select");
    }else
        self.colorLbl.text = colorStr;
}

@end
