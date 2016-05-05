//
//  TotalAmountCell.m
//  SuningEBuy
//
//  Created by DP on 3/11/12.
//  Copyright (c) 2012 __zhaofk__. All rights reserved.
//

#import "TotalAmountCell.h"

@implementation TotalAmountCell

@synthesize  totalAmountLbl = _totalAmountLbl;
@synthesize  desTotalAmountLbl = _desTotalAmountLbl;
@synthesize  desRmbLbl = _desRmbLbl;

- (void)layoutSubviews{
    [super layoutSubviews];
    self.desTotalAmountLbl.frame = CGRectMake(10, 0, 100,40);
    self.totalAmountLbl.frame = CGRectMake(110, 0, 75,40);
    self.desRmbLbl.frame = CGRectMake(185, 0, 30,40);
    
}

/*
 若请求结果集为空，则默认totalaAmount为"0"
 */
- (void)setItem:(NSString *)aItem
{   
//    NSString *str_totalAmountNumber= (aItem == nil || [aItem isEqualToString:@""]) ?@"0.00":aItem;
    NSString *snTeck = [UserCenter defaultCenter].userDiscountInfoDTO.coupon;
    self.totalAmountLbl.text = IsStrEmpty(snTeck)?@"0.00":snTeck;
    
    self.desRmbLbl.text=L(@"coupon RMB");
    self.desTotalAmountLbl.text=L(@"MyEBuy_CanUseCoupons");//L(@"coupon totalValue");
    [super setNeedsLayout];
}

-(void)dealloc{
	TT_RELEASE_SAFELY(_totalAmountLbl);
    TT_RELEASE_SAFELY(_desRmbLbl);
    TT_RELEASE_SAFELY(_desTotalAmountLbl);
	
	
}

//desTotalAmountLbl，存放“易购券明细”文字；
- (UILabel *)desTotalAmountLbl{
    
    if (nil == _desTotalAmountLbl) {
        
        _desTotalAmountLbl = [[UILabel alloc]init];
        
        _desTotalAmountLbl.textAlignment = UITextAlignmentLeft;
        
        _desTotalAmountLbl.font = [UIFont systemFontOfSize:14];
        
        _desTotalAmountLbl.textColor =[UIColor blackColor];// [UIColor grayColor];
        
        _desTotalAmountLbl.tag = 1;
        
        _desTotalAmountLbl.numberOfLines = 0; 
        
        _desTotalAmountLbl.backgroundColor = [UIColor clearColor];
        
        _desTotalAmountLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_desTotalAmountLbl];
    }
    return  _desTotalAmountLbl;
}
//totalAmountLbl，存放通过接口获取到的“totalAmount”数字；
- (UILabel *)totalAmountLbl{
    if (nil == _totalAmountLbl) {
        
        _totalAmountLbl = [[UILabel alloc]init];
        
        _totalAmountLbl.textAlignment = UITextAlignmentRight;
        
        _totalAmountLbl.font = [UIFont systemFontOfSize:14];
        
        _totalAmountLbl.textColor = RGBCOLOR(197, 26, 40);//[UIColor colorWithRGBHex:0xFF0000];//[UIColor redColor];
        
        _totalAmountLbl.tag = 2;
        
        _totalAmountLbl.numberOfLines = 0; 
        
        _totalAmountLbl.backgroundColor = [UIColor clearColor];
        
        _totalAmountLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_totalAmountLbl];
    }
    return  _totalAmountLbl;
}
//desRmbLbl，存放“元”文字；
- (UILabel *)desRmbLbl{
    
    if (nil == _desRmbLbl) {
        
        _desRmbLbl = [[UILabel alloc]init];
        
        _desRmbLbl.textAlignment = UITextAlignmentLeft;
        
        _desRmbLbl.font = [UIFont systemFontOfSize:14];
        
        _desRmbLbl.textColor = [UIColor blackColor];//[UIColor grayColor];
        
        _desRmbLbl.tag = 3;
        
        _desRmbLbl.numberOfLines = 0; 
        
        _desRmbLbl.backgroundColor = [UIColor clearColor];
        
        _desRmbLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_desRmbLbl];
    }
    return  _desRmbLbl;
}

@end
