//
//  ReceiveInfoTotalPriceCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-6-2.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReceiveInfoTotalPriceCell.h"

#define defaltFont  [UIFont systemFontOfSize:14.0f]

@implementation ReceiveInfoTotalPriceCell

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
    self.productNameLbl.frame = CGRectMake(15, 7, 120, 20);
    self.fareNameLbl.frame = CGRectMake(15, 30, 120, 20);
    self.discountNameLbl.frame = CGRectMake(15, 55, 120, 20);
    self.productPriceLbl.frame = CGRectMake(140, 7, 165, 20);
    self.farePriceLbl.frame = CGRectMake(140, 30, 165, 20);
    self.discountPriceLbl.frame = CGRectMake(140, 55, 165, 20);
}

- (void)setPropertyNameLbl:(UILabel *)lbl;
{
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = defaltFont;
    lbl.textColor = [UIColor grayColor];
    lbl.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lbl];
}

- (UILabel *)productNameLbl
{
    if (!_productNameLbl) {
        _productNameLbl = [[UILabel alloc] init];
        [self setPropertyNameLbl:_productNameLbl];
        _productNameLbl.text = [NSString stringWithFormat:@"%@：",L(@"PFCommodityAmount")];
    }
    return _productNameLbl;
}

- (UILabel *)fareNameLbl
{
    if (!_fareNameLbl) {
        _fareNameLbl = [[UILabel alloc] init];
        [self setPropertyNameLbl:_fareNameLbl];
        _fareNameLbl.text = [NSString stringWithFormat:@"%@：",L(@"Freight")];
    }
    return _fareNameLbl;
}

- (UILabel *)discountNameLbl
{
    if (!_discountNameLbl) {
        _discountNameLbl = [[UILabel alloc] init];
        [self setPropertyNameLbl:_discountNameLbl];
        _discountNameLbl.text = [NSString stringWithFormat:@"%@：",L(@"Preferential")];
    }
    return _discountNameLbl;
}

- (void)setPropertyPriceLbl:(UILabel *)lbl
{
    lbl.backgroundColor = [UIColor clearColor];
    lbl.font = defaltFont;
    lbl.textColor = [UIColor orange_Red_Color];
    lbl.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lbl];
}

- (UILabel *)productPriceLbl
{
    if (!_productPriceLbl) {
        _productPriceLbl = [[UILabel alloc] init];
        [self setPropertyPriceLbl:_productPriceLbl];
    }
    return _productPriceLbl;
}

- (UILabel *)farePriceLbl
{
    if (!_farePriceLbl) {
        _farePriceLbl = [[UILabel alloc] init];
        [self setPropertyPriceLbl:_farePriceLbl];
    }
    return _farePriceLbl;
}

- (UILabel *)discountPriceLbl
{
    if (!_discountPriceLbl) {
        _discountPriceLbl = [[UILabel alloc] init];
        [self setPropertyPriceLbl:_discountPriceLbl];
    }
    return _discountPriceLbl;
}

- (void)setProductPrice:(NSString *)price fare:(NSString *)fare discount:(NSString *)discount
{
    self.productPriceLbl.text = price;
    self.farePriceLbl.text = [NSString stringWithFormat:@"+%@",fare];
    if ([discount isEqualToString:@"￥0.00"]) {
        self.discountNameLbl.hidden = YES;
        self.discountPriceLbl.hidden = YES;
    }
    else{
        self.discountNameLbl.hidden = NO;
        self.discountPriceLbl.hidden = NO;
        self.discountPriceLbl.text = [NSString stringWithFormat:@"-%@",discount];
    }
    
}

+ (CGFloat)height:(NSString *)discount
{
    if ([discount isEqualToString:@"￥0.00"]) {
        return 60.0f;
    }
    else
    {
        return 80.0f;
    }
}

@end
