//
//  ShopCartTotalPriceCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartTotalPriceCell.h"
#import "SNGraphics.h"

@implementation ShopCartTotalPriceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
        self.backgroundColor = [UIColor cellBackViewColor];
        
		self.autoresizesSubviews = YES;
        
//        self.backgroundView = self.bgView;
    }
    
    return self;
}

- (void)setLogic:(ShopCartLogic *)logic
{
    _logic = logic;
    
    self.goodsTotalLbl.text = L(@"productTotal");
    
    self.priceAmountLbl.text = [logic.userPayAllPrice formatPriceString];
    
    [self fareLabel];
    
    self.allPriceLabel.text = [NSString stringWithFormat:@"%@: %@", L(@"SCCommodityAmount"),[logic.productAllPrice formatPriceString]];
    
    self.discountLabel.text = [NSString stringWithFormat:@"%@: %@", L(@"Preferential"),[logic.totalDiscount formatPriceString]];
}


- (UILabel *)goodsTotalLbl
{
    if (!_goodsTotalLbl)
    {
        _goodsTotalLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 2, 100, 30)];
        
        _goodsTotalLbl.backgroundColor = [UIColor clearColor];
        
        _goodsTotalLbl.textColor = [UIColor colorWithRGBHex:0x444444];//[UIColor blackColor];
        
        _goodsTotalLbl.font = [UIFont systemFontOfSize:15.0f];
        
        _goodsTotalLbl.shadowColor = [UIColor whiteColor];
        
        _goodsTotalLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        
        [self.contentView addSubview:_goodsTotalLbl];
    }
    
    return _goodsTotalLbl;
}

- (UILabel *)priceAmountLbl
{
    if (!_priceAmountLbl)
    {
		_priceAmountLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 2, 170, 30)];
		
		_priceAmountLbl.backgroundColor = [UIColor clearColor];
        
        _priceAmountLbl.textColor = [UIColor colorWithRGBHex:0xdd0000];
        
		_priceAmountLbl.font = [UIFont systemFontOfSize:17];
        
        _priceAmountLbl.shadowColor = [UIColor whiteColor];
        
        _priceAmountLbl.shadowOffset = CGSizeMake(1, 1);
        
        [self.contentView addSubview:_priceAmountLbl];
		
    }
    
    return _priceAmountLbl;
}

- (UILabel *)discountLabel
{
    if (!_discountLabel)
    {
		_discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 280, 20)];
		
		_discountLabel.backgroundColor = [UIColor clearColor];
        
        _discountLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        
		_discountLabel.font = [UIFont systemFontOfSize:12];
        
        _discountLabel.shadowColor = [UIColor whiteColor];
        
        _discountLabel.shadowOffset = CGSizeMake(1, 1);
        
        _discountLabel.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:_discountLabel];
		
    }
    
    return _discountLabel;
}

- (UILabel *)allPriceLabel
{
    if (!_allPriceLabel)
    {
		_allPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 28, 280, 20)];
		
		_allPriceLabel.backgroundColor = [UIColor clearColor];
        
        _allPriceLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        
		_allPriceLabel.font = [UIFont systemFontOfSize:12];
        
        _allPriceLabel.shadowColor = [UIColor whiteColor];
        
        _allPriceLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self.contentView addSubview:_allPriceLabel];
		
    }
    
    return _allPriceLabel;
}

- (UILabel *)fareLabel
{
    if (!_fareLabel)
    {
		_fareLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 280, 20)];
		
		_fareLabel.backgroundColor = [UIColor clearColor];
        
        _fareLabel.textColor = [UIColor colorWithRGBHex:0x959595];
        
		_fareLabel.font = [UIFont systemFontOfSize:13];
        
        _fareLabel.shadowColor = [UIColor whiteColor];
        
        _fareLabel.shadowOffset = CGSizeMake(1, 1);
        
        _fareLabel.textAlignment = NSTextAlignmentRight;
        
        _fareLabel.text = L(@"SCNotIncludingFreight");
        
        [self.contentView addSubview:_fareLabel];
		
    }
    
    return _fareLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

+ (CGFloat)height
{
    return 54;
}

@end
