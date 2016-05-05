//
//  CShopApplicationSecondCell.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-12-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CShopApplicationSecondCell.h"
#define   DefaultCellHeight      25.0f
#define   DefaultFont            [UIFont systemFontOfSize:14.0]
@implementation CShopApplicationSecondCell



- (void)dealloc
{
    
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor cellBackViewColor];
		self.autoresizesSubviews = YES;
        self.resonsLable.frame = CGRectMake(10.5, 24, 180, 25);
        self.introduceLable.frame = CGRectMake(10, 79.5, 180, DefaultCellHeight);
        
        //
        
        self.typeLable.frame = CGRectMake(10.5, 245.5, 280, 25);
        
        
        
    }
    return self;
}


- (UILabel *)resonsLable
{
    
    if (!_resonsLable)
    {
        _resonsLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, DefaultCellHeight)];
        
        _resonsLable.backgroundColor = [UIColor clearColor];
        
        _resonsLable.font = DefaultFont;
        _resonsLable.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_ReturnGoodsReason")];
        
        _resonsLable.textColor = RGBCOLOR(46, 46, 46);
        
        [self.contentView addSubview:_resonsLable];
    }
    
    return _resonsLable;
}




-(UIButton *)reasonsSelect
{
    if (!_reasonsSelect) {
        _reasonsSelect = [[UIButton alloc]init];
        _reasonsSelect.frame = CGRectMake(151.5, 0, 28.5, 25);
        _reasonsSelect.backgroundColor = [UIColor clearColor];
        [_reasonsSelect setBackgroundImage:[UIImage streImageNamed:@"tuihuoyuanyin-xuanze-xiala.png"] forState:UIControlStateNormal];
        //[_reasonsSelect setTitle:@"请选择" forState:UIControlStateNormal];
    }
    
    return _reasonsSelect;
}

- (UILabel *)introduceLable
{
    
    if (!_introduceLable)
    {
        _introduceLable = [[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, DefaultCellHeight)];
        
        _introduceLable.backgroundColor = [UIColor clearColor];
        
        _introduceLable.font = DefaultFont;
        _introduceLable.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_ReturnInstructions")];
        
        _introduceLable.textColor = RGBCOLOR(68, 68, 68);
        
        [self.contentView addSubview:_introduceLable];
    }
    
    return _introduceLable;
}

- (UILabel *)typeLable
{
    
    if (!_typeLable)
    {
        _typeLable = [[UILabel alloc] init];
        _typeLable.backgroundColor = [UIColor clearColor];
        
        _typeLable.font = DefaultFont;
        _typeLable.textColor = RGBCOLOR(68, 68, 68);
        
        [self.contentView addSubview:_typeLable];
    }
    
    return _typeLable;
}

#pragma mark ----------------------------- text view delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (range.location>=60)
    {
        return  NO;
    }
    else
    {
        return YES;
    }
}

- (void)setItem:(ReturnGoodsPrepareDTO *)prepareDto
{
    NSString *orderNumLblT = [NSString stringWithFormat:@"%@:    %@",L(@"MyEBuy_RefundWay"),prepareDto.returnType];
    //    NSString *productNameLblT = [NSString stringWithFormat:@"商品名称:%@",prepareDto.productName];
    //    NSString *productNoLblT = [NSString stringWithFormat:@"数量:%@",prepareDto.quantityValue];
    //    NSString *saleChannelLblT = [NSString stringWithFormat:@"销售商家:%@",prepareDto.vendorCShopName];
    //    NSString *severTypeLblT = [NSString stringWithFormat:@"服务类型:%@",@"退货"];
    self.typeLable.text = orderNumLblT;
    
    
    
}


@end
