//
//  ShopDetailHeadCell.m
//  SuningEBuy
//
//  Created by xmy on 7/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopDetailHeadCell.h"
#import "UITableViewCell+BgView.h"

#define KShopOrderInfoOriginX 10
#define KShopOrderInfoOriginY 5

#define KShopHeadWidth 80
#define KShopContextWidth 200
@implementation ShopDetailHeadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setLblProtery:(UILabel*)lbl
{
    lbl.textColor = RGBCOLOR(68, 68, 68);
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
}


- (void)setContextLblProtery:(UILabel*)lbl
{
    lbl.textColor = RGBCOLOR(68, 68, 68);
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.lineBreakMode = UILineBreakModeCharacterWrap;
    
    lbl.numberOfLines = 0;
    
}

- (UILabel*)payLbl
{
    if(!_payLbl)
    {
        _payLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_payLbl];
        
        _payLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_TotalPayment")];
        
        [self.contentView addSubview:_payLbl];
    }
    
    return _payLbl;
    
}

- (UILabel*)payContextLbl
{
    if(!_payContextLbl)
    {
        _payContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_payContextLbl];
        
        [self.contentView addSubview:_payContextLbl];
    }
    
    return _payContextLbl;
    
}


- (UILabel*)payWayLbl
{
    if(!_payWayLbl)
    {
        _payWayLbl = [[UILabel alloc] init];
        
        _payWayLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_PaymentWay")];
        
        [self setLblProtery:_payWayLbl];
        
        [self.contentView addSubview:_payWayLbl];
    }
    
    return _payWayLbl;
}

- (UILabel*)payWayContextLbl
{
    if(!_payWayContextLbl)
    {
        _payWayContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_payWayContextLbl];
        
        [self.contentView addSubview:_payWayContextLbl];
    }
    
    return _payWayContextLbl;
    
}


- (UILabel*)invoiceStyleLbl
{
    if(!_invoiceStyleLbl)
    {
        _invoiceStyleLbl = [[UILabel alloc] init];
        
        _invoiceStyleLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_InvoiceType")];
        
        [self setLblProtery:_invoiceStyleLbl];
        
        [self.contentView addSubview:_invoiceStyleLbl];
    }
    
    return _invoiceStyleLbl;
}

- (UILabel*)invoiceStyleContextLbl
{
    if(!_invoiceStyleContextLbl)
    {
        _invoiceStyleContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_invoiceStyleContextLbl];
        
        [self.contentView addSubview:_invoiceStyleContextLbl];
    }
    
    return _invoiceStyleContextLbl;
    
}

- (UIImageView*)lineView
{
    if(!_lineView)
    {
        _lineView = [[UIImageView alloc] init];
        
        _lineView.backgroundColor = [UIColor clearColor];
        
        _lineView.frame = CGRectMake(10, 5, 280, 1);
        
        _lineView.contentMode = UIViewContentModeScaleAspectFill;
        
        [_lineView setImage:[UIImage streImageNamed:@"new_order_line.png"]];
        
        [self.contentView addSubview:_lineView];
    }
    
    return _lineView;
    
}


- (UILabel*)consigneeNameLbl
{
    if(!_consigneeNameLbl)
    {
        _consigneeNameLbl = [[UILabel alloc] init];
        
        _consigneeNameLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_Consignee")];
        
        [self setLblProtery:_consigneeNameLbl];
        
        [self.contentView addSubview:_consigneeNameLbl];
    }
    
    return _consigneeNameLbl;
}

- (UILabel*)consigneeNameContextLbl
{
    if(!_consigneeNameContextLbl)
    {
        _consigneeNameContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_consigneeNameContextLbl];
        
        [self.contentView addSubview:_consigneeNameContextLbl];
    }
    
    return _consigneeNameContextLbl;
    
}

- (UILabel*)consigneeMobileLbl
{
    if(!_consigneeMobileLbl)
    {
        _consigneeMobileLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_consigneeMobileLbl];
        
        [self.contentView addSubview:_consigneeMobileLbl];
    }
    
    return _consigneeMobileLbl;
    
}


- (UILabel*)addressLbl
{
    if(!_addressLbl)
    {
        _addressLbl = [[UILabel alloc] init];
        
        _addressLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_Address")];
        
        [self setLblProtery:_addressLbl];
        
        [self.contentView addSubview:_addressLbl];
    }
    
    return _addressLbl;
}

- (UILabel*)addressContextLbl
{
    if(!_addressContextLbl)
    {
        _addressContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_addressContextLbl];
        
        [self.contentView addSubview:_addressContextLbl];
    }
    
    return _addressContextLbl;
    
}

- (UILabel*)invoiceLbl
{
    if(!_invoiceLbl)
    {
        _invoiceLbl = [[UILabel alloc] init];
        
        _invoiceLbl.text = [NSString stringWithFormat:@"%@:",L(@"MyEBuy_InvoiceHeader")];
        
        [self setLblProtery:_invoiceLbl];
        
        [self.contentView addSubview:_invoiceLbl];
    }
    
    return _invoiceLbl;
}

- (UILabel*)invoiceContextLbl
{
    if(!_invoiceContextLbl)
    {
        _invoiceContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_invoiceContextLbl];
        
        [self.contentView addSubview:_invoiceContextLbl];
    }
    
    return _invoiceContextLbl;
    
}



- (void)setShopDetailHeadCellInfo:(ShopDetailDto*)dto WithItemDto:(ShopDetailItemDto*)itemDto
{
    [self setCoolBgViewWithCellPosition:CellPositionSingle];

    self.payContextLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.orderSaleAmount doubleValue]];
    self.payWayContextLbl.text = L(@"MyEBuy_StorePayment");//displayDto.policyDesc;

    NSString *taxTyp;
    
    if ([dto.invoiceType isEqualToString:@"PT"]
        || [dto.invoiceType isEqualToString:@"01"])
    {
        taxTyp = L(@"MyEBuy_OrdinaryInvoice");
    }else if ([dto.invoiceType isEqualToString:@"ZZ"]
              ||[dto.invoiceType isEqualToString:@"02"])
    {
        taxTyp = L(@"MyEBuy_VATinvoice");
    }else {
        taxTyp = dto.invoiceType;
    }
    
    self.invoiceStyleContextLbl.text = taxTyp;
    
    self.invoiceContextLbl.text = dto.invoiceTitle;
    
    self.payLbl.frame = CGRectMake(KShopOrderInfoOriginX, KShopOrderInfoOriginY, 60, 30);
    self.payContextLbl.frame = CGRectMake(self.payLbl.right+5, KShopOrderInfoOriginY, 80, 30);

    self.payWayLbl.frame = CGRectMake(KShopOrderInfoOriginX, self.payLbl.bottom, 60, 30);
    self.payWayContextLbl.frame = CGRectMake(self.payWayLbl.right+5, self.payLbl.bottom, 80, 30);
    
    self.invoiceStyleLbl.frame = CGRectMake(KShopOrderInfoOriginX, self.payWayLbl.bottom, 60, 30);
    self.invoiceStyleContextLbl.frame = CGRectMake(self.invoiceStyleLbl.right+5, self.payWayLbl.bottom, 80, 30);
    
    self.invoiceLbl.frame = CGRectMake(KShopOrderInfoOriginX, self.invoiceStyleLbl.bottom, 60, 30);
    self.invoiceContextLbl.frame = CGRectMake(self.invoiceLbl.right+5, self.invoiceStyleLbl.bottom, 80, 30);
    
    self.lineView.frame = CGRectMake(0, self.invoiceLbl.bottom+5, 300, 1);

    self.consigneeNameContextLbl.text = dto.receiveName;
    self.consigneeMobileLbl.text = dto.receiveMobile;
    
    NSString *addressStr = [dto.receiveAddress stringByReplacingOccurrencesOfString:@";" withString:@""];
    
    self.addressContextLbl.text = addressStr;
    
    self.consigneeNameLbl.frame = CGRectMake(KShopOrderInfoOriginX, self.lineView.bottom+5, 60, 30);
    self.consigneeNameContextLbl.frame = CGRectMake(self.consigneeNameLbl.right+5, self.lineView.bottom+5, 100, 30);
    self.consigneeMobileLbl.frame = CGRectMake(self.consigneeNameContextLbl.right+5, self.lineView.bottom+5, 90, 30);
    
    float addressheight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.receiveAddress WithLblWidth:200];

    self.addressLbl.frame = CGRectMake(KShopOrderInfoOriginX, self.consigneeNameLbl.bottom, 60, 30);
    self.addressContextLbl.frame = CGRectMake(self.addressLbl.right+5, self.consigneeNameLbl.bottom, 200, addressheight);
        
}

- (float)lblNumberOfLines:(UIFont*)lblFont WithLbl:(NSString*)lblStr WithLblWidth:(float)w
{
    CGSize labelHeight = [lblStr sizeWithFont:lblFont];
    
    CGSize contextSize = [lblStr heightWithFont:lblFont width:w linebreak:UILineBreakModeCharacterWrap];
    NSInteger lines = ceil(contextSize.height/labelHeight.height);
    
    if(lines > 1)
    {
        return labelHeight.height*lines;
    }
    else
    {
        return 30;//labelHeight.height;
    }
    
}

- (CGFloat)ShopDetailHeadCellHeight:(ShopDetailDto*)dto
{
    float addressheight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.receiveAddress WithLblWidth:200];
    
    return 170+addressheight;
}

+ (CGFloat)setShopDetailHeadCellHeight:(ShopDetailDto*)dto
{
    return [[ShopDetailHeadCell alloc] ShopDetailHeadCellHeight:dto];
}


@end
