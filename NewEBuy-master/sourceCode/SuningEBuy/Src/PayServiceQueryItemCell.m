//
//  PayServiceQueryItemCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-22.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PayServiceQueryItemCell.h"

#define  leftPadding    15

#define MOBILE_QUERY_CELL_HEIGHT 143

@implementation PayServiceQueryItemCell

@synthesize orderNOTextLabel = _orderNOTextLabel;

@synthesize orderNameTextLabel = _orderNameTextLabel;

@synthesize companyNameTextLabel = _companyNameTextLabel;

@synthesize payAmountLabel = _payAmountLabel;
@synthesize payAmountTextLabel = _payAmountTextLabel;

@synthesize payTimeTextLabel = _payTimeTextLabel;

@synthesize statusNameTextLabel = _statusNameTextLabel;

@synthesize itemDTO = _itemDTO;

@synthesize icon =_icon;

@synthesize topLine = _topLine;

@synthesize bottomLine = _bottomLine;

- (void)dealloc
{
    TTVIEW_RELEASE_SAFELY(_orderNOTextLabel);
    
    TTVIEW_RELEASE_SAFELY(_orderNameTextLabel);
    
    TTVIEW_RELEASE_SAFELY(_companyNameTextLabel);
    
    TTVIEW_RELEASE_SAFELY(_payTimeTextLabel);
    
    TTVIEW_RELEASE_SAFELY(_statusNameTextLabel);
    
    TT_RELEASE_SAFELY(_itemDTO);
    
    TT_RELEASE_SAFELY(_icon);
    
    TT_RELEASE_SAFELY(_topLine);
    
    TT_RELEASE_SAFELY(_bottomLine);
}


- (UILabel *)orderNOTextLabel
{
    if (_orderNOTextLabel == nil) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderNOTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 10, 160, size.height)];
		
		_orderNOTextLabel.backgroundColor = [UIColor clearColor];
		
		_orderNOTextLabel.textColor = [UIColor light_Black_Color];
		
		_orderNOTextLabel.font = font;
		
		_orderNOTextLabel.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderNOTextLabel];
        
    }
    return _orderNOTextLabel;
}


- (UILabel *)orderNameTextLabel
{
    if (_orderNameTextLabel == nil) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_orderNameTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 50, 230, size.height)];
        
        _orderNameTextLabel.textColor =[UIColor light_Black_Color];
		
		_orderNameTextLabel.backgroundColor = [UIColor clearColor];
		
		_orderNameTextLabel.font = font;
		
		_orderNameTextLabel.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_orderNameTextLabel];
	}
    return _orderNameTextLabel;
}



- (UILabel *)companyNameTextLabel
{
    if (_companyNameTextLabel == nil) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:12];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_companyNameTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 70, 200, size.height)];
		
		_companyNameTextLabel.backgroundColor = [UIColor clearColor];
		
		_companyNameTextLabel.font = font;
        
        _companyNameTextLabel.textColor = [UIColor dark_Gray_Color];
		
		_companyNameTextLabel.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_companyNameTextLabel];
	}
    return _companyNameTextLabel;
}

- (UILabel *)payAmountLabel
{
    if (_payAmountLabel == nil)
    {
        UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_payAmountLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftPadding, 115, 40, size.height)];
		
		_payAmountLabel.backgroundColor = [UIColor clearColor];
		
		_payAmountLabel.font = font;
		
        _payAmountLabel.textColor =[UIColor light_Black_Color];
        
		_payAmountLabel.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_payAmountLabel];
    }
    return _payAmountLabel;
}

- (UILabel *)payAmountTextLabel
{
    if (_payAmountTextLabel == nil) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_payAmountTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 115, 100, size.height)];
		
		_payAmountTextLabel.backgroundColor = [UIColor clearColor];
		
		_payAmountTextLabel.font = font;
        
        _payAmountTextLabel.textColor = [UIColor orange_Red_Color];
		
		_payAmountTextLabel.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_payAmountTextLabel];
	}
    return _payAmountTextLabel;
}


- (UILabel *)payTimeTextLabel
{
    if (_payTimeTextLabel == nil) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_payTimeTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(175, 10, 100, size.height)];
		
		_payTimeTextLabel.backgroundColor = [UIColor clearColor];
		
		_payTimeTextLabel.font = font;
        
        _payTimeTextLabel.textColor = [UIColor dark_Gray_Color];
		
		_payTimeTextLabel.autoresizingMask = UIViewAutoresizingNone;
		
        _payTimeTextLabel.textAlignment =UITextAlignmentRight;
        
		[self.contentView addSubview:_payTimeTextLabel];
	}
    return _payTimeTextLabel;
}


- (UILabel *)statusNameTextLabel
{
    if (_statusNameTextLabel == nil) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		
		CGSize size = [@"a" sizeWithFont:font];
		
		_statusNameTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(235, 115, 80, size.height)];
		
		_statusNameTextLabel.backgroundColor = [UIColor clearColor];
		
		_statusNameTextLabel.font = font;
        
        _statusNameTextLabel.textColor =[UIColor dark_Gray_Color];
		
        _statusNameTextLabel.textAlignment =UITextAlignmentRight;
        
		_statusNameTextLabel.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_statusNameTextLabel];
	}
    return _statusNameTextLabel;
}

- (UIImageView *)icon
{
    if (!_icon) {
        _icon =[[UIImageView alloc]init];
        
        _icon.backgroundColor =[UIColor clearColor];
        
        _icon.frame =CGRectMake(15, 52, 40, 40);
        
        [self.contentView addSubview:_icon];
        
    }
    return _icon;
}

- (UIImageView *)topLine
{
    if (!_topLine) {
        _topLine =[[UIImageView alloc]init];
        
        _topLine.backgroundColor =[UIColor clearColor];
        
        _topLine.frame =CGRectMake(0, 39, 320, 1);
        
        _topLine.image=[UIImage imageNamed:@"category_cellSeparatorLine.png"];
        
        [self.contentView addSubview:_topLine];
    }
    return _topLine;
}

- (UIImageView *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine =[[UIImageView alloc]init];
        
        _bottomLine.backgroundColor =[UIColor clearColor];
        
        _bottomLine.frame =CGRectMake(0, 104, 320, 1);
        
        _bottomLine.image =[UIImage imageNamed:@"category_cellSeparatorLine.png"];
        
        [self.contentView addSubview:_bottomLine];
    }
    return _bottomLine;
}

- (void)setItemDTO:(PayServiceQueryDTO *)itemDTO
{
    if (itemDTO != _itemDTO)
    {
        TT_RELEASE_SAFELY(_itemDTO);
        
        _itemDTO = itemDTO;
        
        NSString *no =IsStrEmpty(_itemDTO.orderNo)?@"--":_itemDTO.orderNo;
        self.orderNOTextLabel.text = [NSString stringWithFormat:@"%@%@",L(@"BTOrderId"),no];
        
        self.orderNameTextLabel.text = IsStrEmpty(_itemDTO.orderName)?@"--":_itemDTO.orderName;
        
        self.companyNameTextLabel.text = IsStrEmpty(_itemDTO.companyName)?@"--":_itemDTO.companyName;
        
        self.payAmountLabel.text = L(@"VPTotal");
        self.payAmountTextLabel.text = [[NSString stringWithFormat:@"￥ %.2f", [_itemDTO.payAmount floatValue] / 100] stringByAppendingString:L(@" yuan")];
        
        self.payTimeTextLabel.text = [_itemDTO.payTime substringToIndex:10];
        
        self.statusNameTextLabel.text = _itemDTO.statusName;
        
        if ([self.typeCode isEqualToString:@"01"]) {
            self.icon.image =[UIImage imageNamed:@"order_WaterIcon.png"];
        }
        else if([self.typeCode isEqualToString:@"02"])
        {
            self.icon.image =[UIImage imageNamed:@"order_ElectricIcon.png"];
        }
        else
            self.icon.image =[UIImage imageNamed:@"order_GasIcon.png"];
        
        [self setNeedsLayout];
    }
}

+ (CGFloat)height:(PayServiceQueryDTO *)item
{
    if (!item)
    {
        return MOBILE_QUERY_CELL_HEIGHT;
    }
    
    return MOBILE_QUERY_CELL_HEIGHT;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.orderNOTextLabel.frame =CGRectMake(leftPadding, 10, 200, 20);
    
    self.payTimeTextLabel.frame =CGRectMake(215, 10, 100, 20);
    
    self.topLine.frame =CGRectMake(0, 39, 320, 1);
    
    self.icon.frame =CGRectMake(leftPadding, 52, 40, 40);
    
    self.orderNameTextLabel.frame =CGRectMake(75, 50, 230, 20);
    
    self.companyNameTextLabel.frame =CGRectMake(75, 70, 230, 20);
    
    self.bottomLine.frame =CGRectMake(0, 104, 320, 1);
    
    self.payAmountLabel.frame =CGRectMake(15, 115, 60, 20);
    
    self.payAmountTextLabel.frame = CGRectMake(75, 115, 120, 20);
    
    self.statusNameTextLabel.frame = CGRectMake(235, 115, 80, 20);
}



@end
