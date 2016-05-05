//
//  ShopCartTitleView.m
//  SuningEBuy
//
//  Created by  liukun on 13-10-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartTitleView.h"
#import "UITableViewCell+BgView.h"

@implementation ShopCartTitleView

+ (instancetype)view
{
    ShopCartTitleView *view = [ShopCartTitleView new];
    view.backgroundColor = RGBACOLOR(255, 255, 255, 0.9);
    view.frame = CGRectMake(0, 0, 320, [ShopCartTitleView height]);
    
    UIImageView *line = [[UIImageView alloc] init];
    line.frame = CGRectMake(0, 0, 320, 0.5);
    line.image = [UIImage streImageNamed:@"line.png"];
    [view addSubview:line];
    
    return view;
}

#pragma mark ----------------------------- set logic

- (void)setLogic:(ShopCartLogic *)logic
{
    if (_logic != logic)
    {
        _logic = logic;
        
    }
    
    self.checkButton.selected = self.logic.isAllSelected;
    
    self.goodsTotalLbl.text = [NSString stringWithFormat:@"%@:",L(@"Constant_Total")];
    
    if (!IsStrEmpty([logic.userPayAllPrice formatPriceString])) {
        if (IOS6_OR_LATER) {
            NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:[logic.userPayAllPrice formatPriceString]];
            [priceStr addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:15.0f]
                             range:NSMakeRange(0, priceStr.length)];
            [priceStr addAttribute:NSForegroundColorAttributeName
                             value:[UIColor orange_Red_Color]
                             range:NSMakeRange(0, priceStr.length)];
            NSAttributedString *fareStr = [[NSAttributedString alloc]
                                           initWithString:L(@"SCIncludingFreight")
                                           attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12.0f],
                                                        NSForegroundColorAttributeName: [UIColor colorWithRGBHex:0x707070]}];
            [priceStr appendAttributedString:fareStr];
            self.priceAmountLbl.attributedText = priceStr;
        } else {
            self.priceAmountLbl.text = [logic.userPayAllPrice formatPriceString];
            self.fareLabel.text = L(@"SCIncludingFreight");
        }
    }
    
    
    
    //    self.allPriceLabel.text = [NSString stringWithFormat:@"商品总额: %@", [logic.productAllPrice formatPriceString]];
    
    self.discountLabel.text = [NSString stringWithFormat:@"%@: %@", L(@"SCPreferential"),[logic.totalDiscount formatPriceString]];
    
    int count = self.logic.checkedCartItemCount;
    if (count > 0)
    {
        if (count > 99)
        {
            [self.jiesuanButton setTitle:[NSString stringWithFormat:@"%@(99+)",L(@"SCSettleAccounts")]
                                forState:UIControlStateNormal];
        }
        else
        {
            [self.jiesuanButton setTitle:[NSString stringWithFormat:@"%@(%d)", L(@"SCSettleAccounts"),count]
                                forState:UIControlStateNormal];

        }
        self.jiesuanButton.enabled = YES;
    }
    else
    {
        [self.jiesuanButton setTitle:L(@"SCSettleAccounts") forState:UIControlStateNormal];
        self.jiesuanButton.enabled = NO;
    }
}

- (void)setJiesuanButtonEnable:(BOOL)isEnable
{
    int count = self.logic.checkedCartItemCount;
    if (count > 0)
    {
        self.jiesuanButton.enabled = YES && isEnable;
    }
    else
    {
        self.jiesuanButton.enabled = NO && isEnable;
    }
}

- (UILabel *)goodsTotalLbl
{
    if (!_goodsTotalLbl)
    {
        _goodsTotalLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 100, 20)];
        
        _goodsTotalLbl.backgroundColor = [UIColor clearColor];
        
        _goodsTotalLbl.textColor = [UIColor colorWithRGBHex:0x313131];//[UIColor blackColor];
        
        _goodsTotalLbl.font = [UIFont systemFontOfSize:13.0f];
        
        _goodsTotalLbl.shadowColor = [UIColor whiteColor];
        
        _goodsTotalLbl.shadowOffset = CGSizeMake(0.5, 0.5);
        
        [self addSubview:_goodsTotalLbl];
    }
    
    return _goodsTotalLbl;
}

- (UILabel *)priceAmountLbl
{
    if (!_priceAmountLbl)
    {
		_priceAmountLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 125, 20)];
		
		_priceAmountLbl.backgroundColor = [UIColor clearColor];
        
        _priceAmountLbl.textColor = [UIColor orange_Red_Color];
        
		_priceAmountLbl.font = [UIFont systemFontOfSize:16.0f];
        
        _priceAmountLbl.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_priceAmountLbl];
		
    }
    
    return _priceAmountLbl;
}

- (UILabel *)discountLabel
{
    if (!_discountLabel)
    {
		_discountLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 280, 20)];
		
		_discountLabel.backgroundColor = [UIColor clearColor];
        
        _discountLabel.textColor = [UIColor colorWithRGBHex:0x707070];
        
		_discountLabel.font = [UIFont systemFontOfSize:13.0f];
        
        _discountLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_discountLabel];
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
        
        [self addSubview:_allPriceLabel];
		
    }
    
    return _allPriceLabel;
}

- (UILabel *)fareLabel
{
    if (!_fareLabel)
    {
		_fareLabel = [[UILabel alloc] initWithFrame:CGRectMake(170, 10, 80, 20)];
        
        if (!IOS6_OR_LATER) {
            _fareLabel.frame =CGRectMake(150, 10, 80, 20);
        }
		_fareLabel.backgroundColor = [UIColor clearColor];
        
        _fareLabel.textColor = [UIColor colorWithRGBHex:0x707070];
        
		_fareLabel.font = [UIFont systemFontOfSize:12];
        
        _fareLabel.shadowColor = [UIColor whiteColor];
        
        _fareLabel.shadowOffset = CGSizeMake(1, 1);
        
        _fareLabel.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:_fareLabel];
		
    }
    
    return _fareLabel;
}

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(0, 10, 50, 40);
        _checkButton.backgroundColor = [UIColor clearColor];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_unselect.png"]
                      forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                      forState:UIControlStateSelected];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (UIButton *)jiesuanButton
{
    if (!_jiesuanButton) {
        _jiesuanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _jiesuanButton.frame = CGRectMake(205, 10, 100, 40);
        _jiesuanButton.backgroundColor = [UIColor clearColor];
        [_jiesuanButton setBackgroundImage:[UIImage streImageNamed:@"submit_button_normal.png"]
                                  forState:UIControlStateNormal];
        [_jiesuanButton setBackgroundImage:[UIImage streImageNamed:@"button_white_disable.png"]
                                  forState:UIControlStateDisabled];
        [_jiesuanButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_jiesuanButton];
    }
    return _jiesuanButton;
}


+ (CGFloat)height
{
    return 60.;
}

@end
