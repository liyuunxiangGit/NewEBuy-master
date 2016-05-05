//
//  SKRuleCell.m
//  SuningEBuy
//
//  Created by cui zl on 13-3-7.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SKRuleCell.h"
#import "NSAttributedString+Attributes.h"

@implementation SKRuleCell

@synthesize lbl1 = _lbl1;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)dealloc
{
    TT_RELEASE_SAFELY(_lbl1);
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lbl1.frame = CGRectMake(10, 0, 300, 600);
    
}

-(void)setContentText:(NSString *)str
{
    NSMutableAttributedString  *attInfo = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSRange range1 = [str rangeOfString:L(@"SecondKill_HowToRaiseSuccessRate")];
    NSRange range2 = [str rangeOfString:L(@"SecondKill_WhyKillNothing")];
    NSRange range3 = [str rangeOfString:L(@"SecondKill_CanPayWhenReached")];
    NSRange range5 = [str rangeOfString:L(@"SecondKill_WillNeedBill")];
    
    [attInfo setTextColor:[UIColor darkGrayColor]];
    
    [attInfo setTextColor:RGBCOLOR(42, 73, 117) range:range1];
    [attInfo setTextColor:RGBCOLOR(42, 73, 117) range:range2];
    [attInfo setTextColor:RGBCOLOR(42, 73, 117) range:range3];
    [attInfo setTextColor:RGBCOLOR(42, 73, 117) range:range5];
    
    [attInfo setFont:[UIFont systemFontOfSize:15]];
    
    [attInfo setFont:[UIFont systemFontOfSize:16] range:range1];
    [attInfo setFont:[UIFont systemFontOfSize:16] range:range2];
    [attInfo setFont:[UIFont systemFontOfSize:16] range:range3];
    [attInfo setFont:[UIFont systemFontOfSize:16] range:range5];
    
    self.lbl1.attributedText = attInfo;
    TT_RELEASE_SAFELY(attInfo);
    
}

-(OHAttributedLabel *)lbl1
{
    if(_lbl1 == nil)
    {
        _lbl1 = [[OHAttributedLabel alloc]init];
        
        _lbl1.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_lbl1];
    }
    
    return _lbl1;
}


+(float)height:(NSString *)str
{
    
    return 600;
    
}

@end
