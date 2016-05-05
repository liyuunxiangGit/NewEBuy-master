////
//  MYEbuyCouponCell.m
//  SuningEBuy
//
//  Created by DP on 3/11/12.
//  Copyright (c) 2012 __zhaofk__. All rights reserved.
//

#import "MYEbuyCouponCell.h"

@implementation MYEbuyCouponCell

@synthesize  item = _item;

@synthesize  nameLbl = _nameLbl;
@synthesize  endDateLbl = _endDateLbl;
@synthesize  strParValueLbl = _strParValueLbl;
@synthesize  remainingLbl = _remainingLbl;


@synthesize  desEndDateLbl = _desEndDateLbl;
@synthesize  desStrParValueLbl = _desStrParValueLbl;
@synthesize  desRemainingLbl = _desRemainingLbl;
/*
 以下初始化几个lable，统一注释，不具体注释
 
 */

- (UILabel *)remainingLbl{
    if (nil == _remainingLbl) {
        
        _remainingLbl = [[UILabel alloc]init];
     	
        _remainingLbl.textAlignment = UITextAlignmentLeft;
        
        _remainingLbl.font = [UIFont systemFontOfSize:12];
        
        _remainingLbl.textColor = [UIColor grayColor];
        
        _remainingLbl.tag = 8;   
        
        [_remainingLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_remainingLbl setNumberOfLines:0];
        
        _remainingLbl.backgroundColor = [UIColor clearColor];
        
        _remainingLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_remainingLbl];
    }    
    return _remainingLbl;
}

- (UILabel *)desRemainingLbl{
    if (nil == _desRemainingLbl) {
        
        _desRemainingLbl = [[UILabel alloc]init];
     	
        _desRemainingLbl.textAlignment = UITextAlignmentLeft;
        
        _desRemainingLbl.font = [UIFont systemFontOfSize:12];
        
        _desRemainingLbl.textColor = [UIColor grayColor];
        
        _desRemainingLbl.tag = 6;   
        
        [_desRemainingLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_desRemainingLbl setNumberOfLines:0];
        
        _desRemainingLbl.backgroundColor = [UIColor clearColor];
        
        _desRemainingLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_desRemainingLbl];
    }    
    return _desRemainingLbl;
}

- (UILabel *)strParValueLbl{
    if (nil == _strParValueLbl) {
        
        _strParValueLbl = [[UILabel alloc]init];
     	
        _strParValueLbl.textAlignment = UITextAlignmentLeft;
        
        _strParValueLbl.font = [UIFont systemFontOfSize:12];
        
        _strParValueLbl.textColor = [UIColor grayColor];
        
        _strParValueLbl.tag = 5;   
        
        [_strParValueLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_strParValueLbl setNumberOfLines:0];
        
        _strParValueLbl.backgroundColor = [UIColor clearColor];
        
        _strParValueLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_strParValueLbl];
    }    
    return _strParValueLbl;
}

- (UILabel *)desStrParValueLbl{
    if (nil == _desStrParValueLbl) {
        
        _desStrParValueLbl = [[UILabel alloc]init];
     	
        _desStrParValueLbl.textAlignment = UITextAlignmentLeft;
        
        _desStrParValueLbl.font = [UIFont systemFontOfSize:12];
        
        _desStrParValueLbl.textColor = [UIColor grayColor];
        
        _desStrParValueLbl.tag = 4;   
        
        [_desStrParValueLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_desStrParValueLbl setNumberOfLines:0];
        
        _desStrParValueLbl.backgroundColor = [UIColor clearColor];
        
        _desStrParValueLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_desStrParValueLbl];
    }    
    return _desStrParValueLbl;
}

- (UILabel *)endDateLbl{
    if (nil == _endDateLbl) {
        
        _endDateLbl = [[UILabel alloc]init];
     	
        _endDateLbl.textAlignment = UITextAlignmentLeft;
        
        _endDateLbl.font = [UIFont systemFontOfSize:12];
        
        _endDateLbl.textColor = [UIColor grayColor];
        
        _endDateLbl.tag = 3;   
        
        [_endDateLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_endDateLbl setNumberOfLines:0];
        
        _endDateLbl.backgroundColor = [UIColor clearColor];
        
        _endDateLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_endDateLbl];
    }    
    return _endDateLbl;
}

- (UILabel *)desEndDateLbl{
    if (nil == _desEndDateLbl) {
        
        _desEndDateLbl = [[UILabel alloc]init];
     	
        _desEndDateLbl.textAlignment = UITextAlignmentLeft;
        
        _desEndDateLbl.font = [UIFont systemFontOfSize:12];
        
        _desEndDateLbl.textColor = [UIColor grayColor];
        
        _desEndDateLbl.tag = 2;   
        
        [_desEndDateLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_desEndDateLbl setNumberOfLines:0];
        
        _desEndDateLbl.backgroundColor = [UIColor clearColor];
        
        _desEndDateLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_desEndDateLbl];
    }    
    return _desEndDateLbl;
}

- (UILabel *)nameLbl{
    if (nil == _nameLbl) {
        
        _nameLbl = [[UILabel alloc]init];
     	
        _nameLbl.textAlignment = UITextAlignmentLeft;
        
        _nameLbl.font = [UIFont systemFontOfSize:12];
        
        _nameLbl.textColor = [UIColor grayColor];
        
        _nameLbl.tag = 1;
        
        [_nameLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_nameLbl setNumberOfLines:0];
        
        _nameLbl.backgroundColor = [UIColor clearColor];
        
        //_nameLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        _nameLbl.lineBreakMode = UILineBreakModeWordWrap;
        
        [self.contentView addSubview:_nameLbl];
    }    
    return _nameLbl;
}


- (UILabel *)userRangLbl{
    if (nil == _userRangLbl) {
        
        _userRangLbl = [[UILabel alloc]init];
     	
        _userRangLbl.textAlignment = UITextAlignmentLeft;
        
        _userRangLbl.font = [UIFont systemFontOfSize:12];
        
        _userRangLbl.textColor = [UIColor grayColor];
        
        _userRangLbl.tag = 12;
        
        [_userRangLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_userRangLbl setNumberOfLines:0];
        
        _userRangLbl.backgroundColor = [UIColor clearColor];
        
        _userRangLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_userRangLbl];
    }
    return _userRangLbl;
}

- (UILabel *)desUserRangLbl{
    if (nil == _desUserRangLbl) {
        
        _desUserRangLbl = [[UILabel alloc]init];
     	
        _desUserRangLbl.textAlignment = UITextAlignmentLeft;
        
        _desUserRangLbl.font = [UIFont systemFontOfSize:12];
        
        _desUserRangLbl.textColor = [UIColor grayColor];
        
        _desUserRangLbl.tag = 10;
        
        [_desUserRangLbl setAdjustsFontSizeToFitWidth:NO];
        
        [_desUserRangLbl setNumberOfLines:0];
        
        _desUserRangLbl.backgroundColor = [UIColor clearColor];
        
        _desUserRangLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_desUserRangLbl];
    }
    return _desUserRangLbl;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.nameLbl.frame = CGRectMake(10, 0, 290,25);
    
    self.desEndDateLbl.frame = CGRectMake(10, 25, 80,25);
    self.endDateLbl.frame    = CGRectMake(90, 25, 120,25);
    
    self.desStrParValueLbl.frame = CGRectMake(10, 50, 80,25);
    self.strParValueLbl.frame    = CGRectMake(90, 50, 80,25);
    
    self.desRemainingLbl.hidden = _hiddenRemainLab;
    self.desRemainingLbl.frame = CGRectMake(10, 75, 80,25);
    
    self.remainingLbl.hidden = _hiddenRemainLab;
    self.remainingLbl.frame = CGRectMake(90, 75, 80,25);

//    if(_hiddenRemainLab == YES)
//    {
//        self.userRangLbl.frame = CGRectMake(10, 75, 80,25);
//        self.desUserRangLbl.frame = CGRectMake(90, 75, 80,25);
//    }
//    else
//    {
//        self.userRangLbl.frame = CGRectMake(10, 100, 80,25);
//        self.desUserRangLbl.frame = CGRectMake(90, 100, 80,25);
//    }

}

/*
 从dto中取数据，付值给lable.text显示
 description：
 1 由于易购主站有“云钻兑换卷”特殊数据，会存在某些字段的内容为空，前端显示的时候，需要将空转化成“－－－”
 2 当接收到的数据不为空的时候，在“面值” “余额”字段后追加“元”，统一显示
 */
- (void)setItem:(MYEbuyCoumonDTO *)aItem
{   
    
    NSString *str_name = (aItem.name == nil || [aItem.name  isEqualToString:@""])?@"no name":aItem.name;
    
    NSString *str_strParValue = (aItem.strparValue == nil || [aItem.strparValue  isEqualToString:@""])?@"---":aItem.strparValue;
    
    NSString *str_remainingAmount = (aItem.remainingAmount == nil || [aItem.remainingAmount  isEqualToString:@""])?@"---":aItem.remainingAmount;
    
    if (aItem.endTime == nil || [aItem.endTime  isEqualToString:@""]) {
        self.endDateLbl.text = @"---";
    }else{
        self.endDateLbl.text = [aItem.endTime stringByPaddingToLength:10 withString:@" " startingAtIndex:0];
    }
    
    self.desEndDateLbl.text = L(@"coupon endDate");
    self.desStrParValueLbl.text 	= L(@"coupon strParValue");
    self.desRemainingLbl.text = L(@"coupon remainingValue");
    
    self.nameLbl.text = str_name;
    
    
    
    if ([str_strParValue isEqualToString:@"---"]) {
        self.strParValueLbl.text = str_strParValue;
    }
    else{
        self.strParValueLbl.text = [str_strParValue stringByAppendingString:L(@"coupon RMB")];
    }
    if ([str_strParValue isEqualToString:@"---"]) {
        self.remainingLbl.text = str_strParValue;
    }else{
        self.remainingLbl.text = [str_remainingAmount stringByAppendingString:L(@"coupon RMB")];
    }
    
    self.userRangLbl.text = L(@"MyEBuy_UseOfRules");
    if (IsStrEmpty(aItem.useRule)) {
        self.desUserRangLbl.text = @"";//aItem.useRule;
    }else{
        self.desUserRangLbl.text = aItem.useRule;
    }
    
    CGFloat ruleHeight = [self calculateUserRuleHeight:aItem.useRule];
    
    if(_hiddenRemainLab == YES)
    {
        self.userRangLbl.frame = CGRectMake(10, 75, 80,25);
        self.desUserRangLbl.frame = CGRectMake(90, 75, 200,ruleHeight);
    }
    else
    {
        self.userRangLbl.frame = CGRectMake(10, 100, 80,25);
        self.desUserRangLbl.frame = CGRectMake(90, 100, 200,ruleHeight);
    }

    [super setNeedsLayout];
}

- (CGFloat)calculateUserRuleHeight:(NSString*)str
{
    CGSize ruleSize = [str sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, MAXFLOAT)  lineBreakMode:UILineBreakModeCharacterWrap];
    
    if(ruleSize.height > 25)
    {
        return ruleSize.height + 5;
    }
    else
    {
        return 25;
    }
    
//    return ruleSize.height;
    
}

+ (CGFloat)setMyEbuyCouponCellHeight:(MYEbuyCoumonDTO *)aItem
{
//    if(!aItem)
//    {
        return [[MYEbuyCouponCell alloc] calculateUserRuleHeight:aItem.useRule];
//    }
//    else
//    {
//        return 0;
//    }
}

-(void)dealloc{
    
	TT_RELEASE_SAFELY(_nameLbl);
    TT_RELEASE_SAFELY(_endDateLbl);
    TT_RELEASE_SAFELY(_strParValueLbl);
	TT_RELEASE_SAFELY(_remainingLbl);
    
    TT_RELEASE_SAFELY(_desEndDateLbl);
    TT_RELEASE_SAFELY(_desStrParValueLbl);
	TT_RELEASE_SAFELY(_desRemainingLbl);
	
	
}


@end
