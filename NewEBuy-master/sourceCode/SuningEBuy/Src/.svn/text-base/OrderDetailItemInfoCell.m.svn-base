//
//  OrderDetailItemInfoCell.m
//  SuningEBuy
//
//  Created by robin wang on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OrderDetailItemInfoCell.h"

#define  offsetX    10

#define  offsetY        5

#define  kLblHight        25

#define MOBILE_QUERY_CELL_HEIGHT 210

#define contentFont             13

#define offsetBackx             20

#define kPriceColor         [UIColor colorWithRed:204/255.0 green:0/255.0 blue:0/255.0 alpha:1.0];

@implementation OrderDetailItemInfoCell

@synthesize nameLbl  = _nameLbl;

@synthesize countLbl = _countLbl;

@synthesize priceLbl  = _priceLbl;


@synthesize checkCodeLbl = _checkCodeLbl;

@synthesize deliveryLbl = _deliveryLbl;

@synthesize invoiceTypeLbl = _invoiceTypeLbl;


@synthesize exWarrantyNameLabl = _exWarrantyNameLabl;

@synthesize exWarrantyCountLabl = _exWarrantyCountLabl;

@synthesize exWarrantyPriceLbl = _exWarrantyPriceLbl;

@synthesize displayOrderBtn = _displayOrderBtn;

@synthesize evaludateBtn = _evaludateBtn;

@synthesize logisticsBtn = _logisticsBtn;

@synthesize cancelOrderBtn = _cancelOrderBtn;

@synthesize policyDesc = _policyDesc;

@synthesize cellSeparatorLine= _cellSeparatorLine;

@synthesize merchItemDTO = _merchItemDTO;

@synthesize isNotShowButton;


- (void) dealloc {
    
    TT_RELEASE_SAFELY(_nameLbl);
    TT_RELEASE_SAFELY(_countLbl);
    TT_RELEASE_SAFELY(_priceLbl);
    
    TT_RELEASE_SAFELY(_checkCodeLbl);
    TT_RELEASE_SAFELY(_deliveryLbl);
    TT_RELEASE_SAFELY(_invoiceTypeLbl);
    
    TT_RELEASE_SAFELY(_exWarrantyNameLabl);
    
    TT_RELEASE_SAFELY(_exWarrantyCountLabl);
    
    TT_RELEASE_SAFELY(_exWarrantyPriceLbl);
    
    TT_RELEASE_SAFELY(_displayOrderBtn);
    
    TT_RELEASE_SAFELY(_evaludateBtn);
    TT_RELEASE_SAFELY(_logisticsBtn);
    
    TT_RELEASE_SAFELY(_cancelOrderBtn);
    
    TT_RELEASE_SAFELY(_policyDesc);
    
    TT_RELEASE_SAFELY(_cellSeparatorLine);
    
    TT_RELEASE_SAFELY(_merchItemDTO);
    
}

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
        self.backgroundColor= [UIColor cellBackViewColor];
	}
	
	return self;
}

-(UILabel *) nameLbl{
	
	if (!_nameLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:contentFont];
		
		_nameLbl = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, 0, 270, 30)];
		
		_nameLbl.backgroundColor = [UIColor clearColor];
        
		_nameLbl.font = font;
        
        _nameLbl.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1.0];
        
        _nameLbl.textAlignment = UITextAlignmentLeft;
		
		_nameLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_nameLbl];
	}
	
	return _nameLbl;
}

-(UILabel *) countLbl{
	
	if (!_countLbl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, _nameLbl.bottom,  60, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = L(@"Number:");
        [self.contentView addSubview: markLbl];
		
		_countLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _nameLbl.bottom,  100, 30)];
		
		_countLbl.backgroundColor = [UIColor clearColor];
        
        _countLbl.textColor = [UIColor blackColor];
        
		_countLbl.font = markFont;
        
        _countLbl.textAlignment = UITextAlignmentLeft;
		
		_countLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _countLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_countLbl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _countLbl;
    
}

-(UILabel *) priceLbl{
	
	if (!_priceLbl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(_countLbl.right, _nameLbl.bottom,  40, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = L(@"Price:");
        [self.contentView addSubview: markLbl];
		
		_priceLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _nameLbl.bottom,  100, 30)];
		
		_priceLbl.backgroundColor = [UIColor clearColor];
        
        _priceLbl.textColor = kPriceColor;
        
		_priceLbl.font = markFont;
        
        _priceLbl.textAlignment = UITextAlignmentLeft;
		
		_priceLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _priceLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_priceLbl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _priceLbl;
    
}

-(UILabel *) checkCodeLbl{
	
	if (!_checkCodeLbl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, _priceLbl.bottom,  60, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = L(@"Check code:");
        [self.contentView addSubview: markLbl];
		
		_checkCodeLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _priceLbl.bottom,  100, 30)];
		
		_checkCodeLbl.backgroundColor = [UIColor clearColor];
        
        _checkCodeLbl.textColor = [UIColor blackColor];
        
		_checkCodeLbl.font = markFont;
        
        _checkCodeLbl.textAlignment = UITextAlignmentLeft;
		
		_checkCodeLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _checkCodeLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_checkCodeLbl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _checkCodeLbl;
    
}

-(UILabel *) deliveryLbl{
	
	if (!_deliveryLbl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(_checkCodeLbl.right, _priceLbl.bottom,  60, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = L(@"Delivery:");
        [self.contentView addSubview: markLbl];
		
		_deliveryLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _priceLbl.bottom,  100, 30)];
		
		_deliveryLbl.backgroundColor = [UIColor clearColor];
        
        _deliveryLbl.textColor = [UIColor blackColor];
        
		_deliveryLbl.font = markFont;
        
        _deliveryLbl.textAlignment = UITextAlignmentLeft;
		
		_deliveryLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _deliveryLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_deliveryLbl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _deliveryLbl;
    
}

-(UILabel *) invoiceTypeLbl{
	
	if (!_invoiceTypeLbl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, _deliveryLbl.bottom,  60, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = L(@"Invoice Type:");
        [self.contentView addSubview: markLbl];
		
		_invoiceTypeLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _deliveryLbl.bottom,  100, 30)];
		
		_invoiceTypeLbl.backgroundColor = [UIColor clearColor];
        
        _invoiceTypeLbl.textColor = [UIColor blackColor];
        
		_invoiceTypeLbl.font = markFont;
        
        _invoiceTypeLbl.textAlignment = UITextAlignmentLeft;
		
		_invoiceTypeLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _invoiceTypeLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_invoiceTypeLbl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _invoiceTypeLbl;
    
}

// WARRAWG

-(UIImageView *)cellSeparatorLine{
    if (_cellSeparatorLine == nil) {
        _cellSeparatorLine = [[UIImageView alloc]initWithFrame:CGRectMake(20, _invoiceTypeLbl.bottom, 260, 2)];
        UIImage *tempImage = [UIImage newImageFromResource:@"category_cellSeparatorLine.png"];
        _cellSeparatorLine.image = tempImage;
        
        [self.contentView addSubview: _cellSeparatorLine];
    }
    
    return _cellSeparatorLine;
}

-(UILabel *) exWarrantyNameLabl{
	
	if (!_exWarrantyNameLabl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, _invoiceTypeLbl.bottom+5,  60, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_SunshinePackage")];
        [self.contentView addSubview: markLbl];
		
		_exWarrantyNameLabl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _invoiceTypeLbl.bottom+5,  210, 30)];
		
		_exWarrantyNameLabl.backgroundColor = [UIColor clearColor];
        
        _exWarrantyNameLabl.textColor = [UIColor blackColor];
        
		_exWarrantyNameLabl.font = markFont;
        
        _exWarrantyNameLabl.textAlignment = UITextAlignmentLeft;
		
		_exWarrantyNameLabl.autoresizingMask = UIViewAutoresizingNone;
        
       // _exWarrantyNameLabl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_exWarrantyNameLabl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _exWarrantyNameLabl;
    
}

-(UILabel *)exWarrantyCountLabl{
	
	if (!_exWarrantyCountLabl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(offsetX, _exWarrantyNameLabl.bottom,  60, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = L(@"Number:");
        [self.contentView addSubview: markLbl];
		
		_exWarrantyCountLabl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _exWarrantyNameLabl.bottom,  100, 30)];
		
		_exWarrantyCountLabl.backgroundColor = [UIColor clearColor];
        
        _exWarrantyCountLabl.textColor = [UIColor blackColor];
        
		_exWarrantyCountLabl.font = markFont;
        
        _exWarrantyCountLabl.textAlignment = UITextAlignmentLeft;
		
		_exWarrantyCountLabl.autoresizingMask = UIViewAutoresizingNone;
        
        _exWarrantyCountLabl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_exWarrantyCountLabl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _exWarrantyCountLabl;
    
}

-(UILabel *) exWarrantyPriceLbl{
	
	if (!_exWarrantyPriceLbl) {
        
        UIFont *markFont = [UIFont boldSystemFontOfSize:contentFont];
		
		UILabel *markLbl = [[UILabel alloc] initWithFrame:CGRectMake(_exWarrantyCountLabl.right, _exWarrantyNameLabl.bottom,  40, 30)];
		
		markLbl.backgroundColor = [UIColor clearColor];
        
        markLbl.textColor = [UIColor grayColor];
        
		markLbl.font = markFont;
		
		markLbl.autoresizingMask = UIViewAutoresizingNone;
        
        markLbl.textAlignment = UITextAlignmentLeft;
        markLbl.text = L(@"Price:");
        [self.contentView addSubview: markLbl];
		
		_exWarrantyPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(markLbl.right, _exWarrantyNameLabl.bottom,  100, 30)];
		
		_exWarrantyPriceLbl.backgroundColor = [UIColor clearColor];
        
        _exWarrantyPriceLbl.textColor = kPriceColor;
        
		_exWarrantyPriceLbl.font = markFont;
        
        _exWarrantyPriceLbl.textAlignment = UITextAlignmentLeft;
		
		_exWarrantyPriceLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _exWarrantyPriceLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		[self.contentView addSubview:_exWarrantyPriceLbl];
        
        TT_RELEASE_SAFELY(markLbl);
	}
	
	return _exWarrantyPriceLbl;
    
}

-(UIButton *)evaludateBtn
{
    
    if(!_evaludateBtn){
        
        _evaludateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _evaludateBtn.frame = CGRectMake(15, 125, 75, 35);
        
        [_evaludateBtn setTitle:L(@"User Comment") forState:UIControlStateNormal];
        
        [_evaludateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _evaludateBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton_new.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_evaludateBtn setBackgroundImage:stretchableButtonImageNormal 
                                 forState:UIControlStateNormal];
        
    }
    
    return _evaludateBtn;
}

-(UIButton *)displayOrderBtn
{
    
    if(!_displayOrderBtn){
        
        _displayOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _displayOrderBtn.frame = CGRectMake(105, 125, 75, 35);
        
        [_displayOrderBtn setTitle:L(@"Show My Order") forState:UIControlStateNormal];
        
        [_displayOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _displayOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton_new.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_displayOrderBtn setBackgroundImage:stretchableButtonImageNormal 
                                    forState:UIControlStateNormal];
        
    }
    
    return _displayOrderBtn;
}

-(UIButton *)logisticsBtn
{
    
    if(!_logisticsBtn){
        
        _logisticsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _logisticsBtn.frame = CGRectMake(195, 125, 90, 35);
        
        [_logisticsBtn setTitle:L(@"InstallDetail") forState:UIControlStateNormal];
        
        [_logisticsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _logisticsBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton_new.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_logisticsBtn setBackgroundImage:stretchableButtonImageNormal 
                                 forState:UIControlStateNormal];
        
    }
    
    return _logisticsBtn;
}

-(UIButton *)cancelOrderBtn
{
    
    if(!_cancelOrderBtn){
        
        _cancelOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _cancelOrderBtn.frame = CGRectMake(135, 58, 75, 35);
        
        [_cancelOrderBtn setTitle:L(@"Cancel Order") forState:UIControlStateNormal];
        
        [_cancelOrderBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _cancelOrderBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        
        
        UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton_new.png"];
        UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [_cancelOrderBtn setBackgroundImage:stretchableButtonImageNormal 
                                   forState:UIControlStateNormal];
        
    }
    
    return _cancelOrderBtn;
}

- (void)setMerchItemDTO:(MemberOrderDetailsDTO *)merchItemDTO
{
    if (merchItemDTO != _merchItemDTO) 
    {
        TT_RELEASE_SAFELY(_merchItemDTO);
        
        _merchItemDTO = merchItemDTO;   
        
        self.nameLbl.text = _merchItemDTO.productName;
        
        self.countLbl.text = _merchItemDTO.quantityInIntValue;
        
        NSString *marketPrice = [NSString stringWithFormat:@"￥%.2f",[_merchItemDTO.totalProduct floatValue]];
        self.priceLbl.text = marketPrice;
        
        self.checkCodeLbl.text = _merchItemDTO.verificationCode;
        
        self.deliveryLbl.text = _merchItemDTO.currentShipModeType;
        
        NSString *taxTyp;
        if ([_merchItemDTO.taxType isEqualToString:@"0"]) {
            taxTyp = L(@"General invoice");
        }else if ([_merchItemDTO.taxType isEqualToString:@"1"]) {
            taxTyp = L(@"VAT invoice");
        }else if ([_merchItemDTO.taxType isEqualToString:@"5"]){
            taxTyp = L(@"NO invoice");
        }
        else {
            taxTyp = @"";
        }
        self.invoiceTypeLbl.text = taxTyp;
        
        // buttton:::
        if (self.isNotShowButton ==YES) {
        
        }else
        {    
            if ([_merchItemDTO.oiStatus isEqualToString:@"C"]) {
                if ( ![_merchItemDTO.isBundle isEqual:@"1"]) {
                    [self.contentView addSubview:self.displayOrderBtn];
                }
                //[self.contentView addSubview:_evaludateBtn];
                [self.contentView addSubview:self.logisticsBtn];
                
            }else if([_merchItemDTO.oiStatus isEqualToString:@"M"] && [_merchItemDTO.policyDesc hasPrefix:L(@"MyEBuy_CashOnDelivery")]){
                self.logisticsBtn.frame = CGRectMake(195, 125, 90, 35);
                
                [self.contentView addSubview:self.logisticsBtn];
                
                //[self.contentView addSubview:self.cancelOrderBtn];
            }
        }
        //warrent::::
        if ([_merchItemDTO.exWarrantyFlag isEqualToString:@"0"] == NO) {
            
            self.cellSeparatorLine.tag = 34;
            
            self.exWarrantyNameLabl.text = _merchItemDTO.exWarrantyName;
            
            NSString *marketPrice = [NSString stringWithFormat:@"￥%.2f",[_merchItemDTO.exWarrantyPrice floatValue]];
            self.exWarrantyCountLabl.text = _merchItemDTO.exWarrantyQuantity;
            
            self.exWarrantyPriceLbl.text =marketPrice;
            
            self.displayOrderBtn.top = self.exWarrantyPriceLbl.bottom+3;
            
            self.logisticsBtn.top = self.exWarrantyPriceLbl.bottom+3;
        }
        
    }
}    

#define ORDER_LIST_CELL_HEIGHT 125
+ (CGFloat)detailheight:(MemberOrderDetailsDTO *)item isShowButton:(BOOL)isShow{
    
    float cellHeight = ORDER_LIST_CELL_HEIGHT;
    
    if (isShow ==YES) {
        cellHeight +=40;
    }
    
    if ([item.exWarrantyFlag isEqualToString:@"0"] == NO) {
        
        cellHeight +=65;
    }

    return cellHeight;
}

+ (CGFloat)height:(MemberOrderDetailsDTO *)item{
	
    float cellHeight = ORDER_LIST_CELL_HEIGHT;
    
	if (item == nil) {
        
		return cellHeight;
	}
    
    if ([item.exWarrantyFlag isEqualToString:@"0"] == NO) {
        
        cellHeight +=65;
    }
    
    if ([item.oiStatus isEqualToString:@"C"] || [item.oiStatus eq:@"SOMED"] || [item.oiStatus eq:@"SD"] || [item.oiStatus eq:@"SC"]|| [item.oiStatus eq:@"WD"]) {
        return	(cellHeight+40);
    }else if([item.oiStatus isEqualToString:@"M"] && [item.policyDesc hasPrefix:L(@"recceive paid"
)]){
        return (cellHeight+40);
    }else {
        return	cellHeight;
    }
    
}


@end
