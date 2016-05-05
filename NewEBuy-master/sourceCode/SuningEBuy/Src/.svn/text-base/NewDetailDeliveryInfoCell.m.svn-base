//
//  NewDetailDeliveryInfoCell.m
//  SuningEBuy
//
//  Created by xmy on 31/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NewDetailDeliveryInfoCell.h"

#define KDetailInfoOriginX 10
#define KDetailInfoOriginY 5


@implementation NewDetailDeliveryInfoCell

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

- (UILabel*)verificationCodeLbl
{
    if(!_verificationCodeLbl)
    {
        _verificationCodeLbl = [[UILabel alloc] init];
        
        _verificationCodeLbl.text = [NSString stringWithFormat:@"%@:",L(@"LBVerificationCode")];
        
        [self setLblProtery:_verificationCodeLbl];
        
        [self.contentView addSubview:_verificationCodeLbl];
    }
    
    return _verificationCodeLbl;
}

- (UILabel*)verificationCodeContextLbl
{
    if(!_verificationCodeContextLbl)
    {
        _verificationCodeContextLbl = [[UILabel alloc] init];
        
        [self setContextLblProtery:_verificationCodeContextLbl];
        
        [self.contentView addSubview:_verificationCodeContextLbl];
    }
    
    return _verificationCodeContextLbl;
    
}


- (void)setDetailDeliveryInfo:(MemberOrderDetailsDTO *)dto WithNameDTO:(MemberOrderNamesDTO *)nameDTO
{

    self.consigneeNameContextLbl.text = dto.itemPlacerName;
    self.consigneeMobileLbl.text = dto.itemMobilePhone;
    self.addressContextLbl.text = dto.address;
    self.invoiceContextLbl.text = dto.invoice;
    self.verificationCodeContextLbl.text = dto.verificationCode;

    
    if(IsStrEmpty(nameDTO.supplierCode))
    {
        self.verificationCodeContextLbl.text = dto.verificationCode;
        self.verificationCodeContextLbl.hidden = NO;
        self.verificationCodeLbl.hidden = NO;
       
    }
    else
    {
        self.verificationCodeContextLbl.hidden = YES;
        self.verificationCodeLbl.hidden = YES;
        
    }
    

    float nameHeight;
    
    if(IsStrEmpty(dto.itemMobilePhone))
    {
        
        nameHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.itemPlacerName WithLblWidth:230];
        
        
    }
    else
    {
        nameHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.itemPlacerName WithLblWidth:120];
        
    }
    
    
    self.consigneeNameLbl.frame = CGRectMake(KDetailInfoOriginX,KDetailInfoOriginY, 50, nameHeight);
    
    if(IsStrEmpty(dto.itemMobilePhone))
    {
        self.consigneeNameContextLbl.frame = CGRectMake(self.consigneeNameLbl.right, KDetailInfoOriginY, 230, nameHeight);
        
    }
    else
    {
        self.consigneeNameContextLbl.frame = CGRectMake(self.consigneeNameLbl.right, KDetailInfoOriginY, 120, nameHeight);
        
        self.consigneeMobileLbl.frame = CGRectMake(self.consigneeNameContextLbl.right + 20, KDetailInfoOriginY, 90, nameHeight);
        
    }
    
    
    float addressheight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.address WithLblWidth:240];
    
    self.addressLbl.frame = CGRectMake(KDetailInfoOriginX, self.consigneeNameLbl.bottom, 40, addressheight);
    self.addressContextLbl.frame = CGRectMake(self.addressLbl.right, self.consigneeNameLbl.bottom, 240, addressheight);
    
    if(IsStrEmpty(nameDTO.supplierCode))
    {
        float invoiceHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.invoice WithLblWidth:110];
        
        self.invoiceLbl.frame = CGRectMake(KDetailInfoOriginX, self.addressLbl.bottom, 60, invoiceHeight);
        self.invoiceContextLbl.frame = CGRectMake(self.invoiceLbl.right, self.addressLbl.bottom, 110, invoiceHeight );
        self.invoiceContextLbl.frame = CGRectMake(self.invoiceLbl.right, self.addressLbl.bottom, 110, invoiceHeight );
        
        self.verificationCodeLbl.frame =  CGRectMake(self.invoiceContextLbl.right, self.addressLbl.bottom, 50, invoiceHeight );
        self.verificationCodeContextLbl.frame = CGRectMake(self.verificationCodeLbl.right, self.addressLbl.bottom, 60, invoiceHeight);
        self.verificationCodeContextLbl.text = dto.verificationCode;
        self.verificationCodeContextLbl.hidden = NO;
        self.verificationCodeLbl.hidden = NO;

           }
    else
    {
        float invoiceHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.invoice WithLblWidth:220];
        
        self.invoiceLbl.frame = CGRectMake(KDetailInfoOriginX, self.addressLbl.bottom, 60, invoiceHeight);
        
        self.invoiceContextLbl.frame = CGRectMake(self.invoiceLbl.right, self.addressLbl.bottom, 220, invoiceHeight );
        
        self.verificationCodeContextLbl.hidden = YES;
        self.verificationCodeLbl.hidden = YES;

        
    }

}

- (CGFloat)cellHeight:(MemberOrderDetailsDTO *)dto withName:(MemberOrderNamesDTO*)nameDto
{
    float nameHeight;
    
    if(IsStrEmpty(dto.itemMobilePhone))
    {
        
        nameHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.itemPlacerName WithLblWidth:230];
        
    }
    else
    {
        nameHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.itemPlacerName WithLblWidth:120];
        
    }
    
    float addressheight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.address WithLblWidth:240];
    
    float invoiceHeight ;
    
    if(IsStrEmpty(dto.verificationCode))
    {
        invoiceHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.invoice WithLblWidth:220];
        
    }
    else
    {
        invoiceHeight = [self lblNumberOfLines:[UIFont systemFontOfSize:13] WithLbl:dto.invoice WithLblWidth:110];
        
    }
    
    
    return nameHeight + addressheight + invoiceHeight + 10;
    
}

+ (CGFloat)DetailDeliveryInfoCellHeight:(MemberOrderDetailsDTO *)dto withName:(MemberOrderNamesDTO*)nameDto

{
    return [[NewDetailDeliveryInfoCell alloc] cellHeight:dto withName:nameDto];
}

@end
