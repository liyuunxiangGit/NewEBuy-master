//
//  CSProductDetailHeadCell.m
//  SuningEBuy
//
//  Created by xmy on 19/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CSProductDetailHeadCell.h"

#define KCSLblWidth 136
#define KCSLblHeight 18

#define KOrigionX 0

@implementation CSProductDetailHeadCell

- (id)init
{
    self = [super init];
    if (self) {
        [self addSubview:self.downCSLbl];
        [self addSubview:self.downPriceCSLbl];
        [self addSubview:self.eGoCSLbl];
        [self addSubview:self.eGoCSPriceLbl];
        [self addSubview:self.deliveryLbl];
        [self addSubview:self.deliveryFeeLbl];
        [self addSubview:self.cSellerPointLbl];

    }
    return self;
}



- (UILabel*)downCSLbl
{
    if(!_downCSLbl)
    {
        _downCSLbl = [[UILabel alloc] init];
        [self setLblProtery:_downCSLbl];

        _downCSLbl.text = L(@"Product_PriceReduction");
    }
    
    return _downCSLbl;
        
}

- (UILabel*)eGoCSLbl
{
    if(!_eGoCSLbl)
    {
        _eGoCSLbl = [[UILabel alloc] init];
        [self setLblProtery:_eGoCSLbl];
        _eGoCSLbl.text = [NSString stringWithFormat:@"%@:",L(@"yigouPrice")];
    }
    
    return _eGoCSLbl;
    
}

- (UILabel*)deliveryLbl
{
    if(!_deliveryLbl)
    {
        _deliveryLbl = [[UILabel alloc] init];
        [self setLblProtery:_deliveryLbl];
        _deliveryLbl.text = [NSString stringWithFormat:@"%@:",L(@"Product_DeliveryMoney")];
        
    }
    
    return _deliveryLbl;
}

- (UILabel*)cSellerPointLbl
{
    if(!_cSellerPointLbl)
    {
        _cSellerPointLbl = [[UILabel alloc] init];
        [self setLblProtery:_cSellerPointLbl];
    }
    
    return _cSellerPointLbl;
}

- (UILabel*)deliveryFeeLbl
{
    if(!_deliveryFeeLbl)
    {
        _deliveryFeeLbl = [[UILabel alloc] init];
        [self setLblProtery:_deliveryFeeLbl];
        _deliveryFeeLbl.font = [UIFont systemFontOfSize:15];
        _deliveryFeeLbl.textColor = [UIColor colorWithRGBHex:0x444444];
    }
    
    return _deliveryFeeLbl;
}

- (void)setLblProtery:(UILabel*)lbl
{
//    lbl = [[UILabel alloc] init];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:12];
    
    lbl.textColor = [UIColor colorWithRGBHex:0x666666];
    
    lbl.textAlignment = UITextAlignmentCenter;
    
//    [self addSubview:lbl];
}


- (StrikeThroughLabel*)downPriceCSLbl
{
    if(!_downPriceCSLbl)
    {
        _downPriceCSLbl = [[StrikeThroughLabel alloc] init];
        [self setStrikeThroughLabelProtery:_downPriceCSLbl];

        _downPriceCSLbl.isWithStrikeThrough = NO;
    }
    
    return _downPriceCSLbl;
}

- (StrikeThroughLabel*)eGoCSPriceLbl
{
    if(!_eGoCSPriceLbl)
    {
        _eGoCSPriceLbl = [[StrikeThroughLabel alloc] init];
        [self setStrikeThroughLabelProtery:_eGoCSPriceLbl];
        _eGoCSPriceLbl.isWithStrikeThrough = YES;
        _eGoCSPriceLbl.textColor = [UIColor colorWithRGBHex:0x666666];
    }
    
    return _eGoCSPriceLbl;
}


- (void)setStrikeThroughLabelProtery:(StrikeThroughLabel*)lbl
{
//    lbl = [[StrikeThroughLabel alloc] init];
    
    lbl.textAlignment = UITextAlignmentCenter;
    
    lbl.frame = CGRectMake(210, 65, 80, 18);
    
    lbl.adjustsFontSizeToFitWidth = YES;
    
    lbl.font = [UIFont systemFontOfSize:15.0];
    
    lbl.textColor =[UIColor colorWithRGBHex:0xff0000];
    
    lbl.backgroundColor = [UIColor clearColor];
    
//    [self addSubview:lbl];
    
}



-(BOOL)isDownCSLblBool:(DataProductBasic*)downDto
{
    if([downDto.marketPrice doubleValue] > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)isEGOCSLblBool:(DataProductBasic*)downDto
{
    if([downDto.suningPrice doubleValue] > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (BOOL)isFareBool:(DataProductBasic*)downDto
{
    if([downDto.fare doubleValue] > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


- (void)setCSHeadCell:(DataProductBasic*)dto
{
    
    self.cSellerPointLbl.hidden = YES;
    
    self.eGoCSLbl.hidden = YES;
    
    self.eGoCSPriceLbl.hidden = YES;
    
    self.downPriceCSLbl.hidden = YES;
    
    self.downCSLbl.hidden = YES;
    
    self.deliveryFeeLbl.hidden = YES;
    
    self.deliveryLbl.hidden = YES;

    
    NSString *eGPriceString = @"¥  ";
    NSString *downPrice = @"¥  ";


    self.dataDto = dto;
    
    if([self isEGOCSLblBool:dto] == YES)
    {
        self.cSellerPointLbl.hidden = YES;
        
        self.eGoCSLbl.hidden = NO;
        
        self.eGoCSPriceLbl.hidden = NO;
        
        self.eGoCSLbl.font = [UIFont systemFontOfSize:13];
        
        eGPriceString = [dto.suningPrice formatPriceString];

        self.eGoCSPriceLbl.text = [NSString stringWithFormat:@"¥ %.2f",[dto.suningPrice floatValue]];
        
       if([self isDownCSLblBool:dto] == YES)
        {
            self.downPriceCSLbl.hidden = NO;
            
            self.downCSLbl.hidden = NO;
            
            self.eGoCSLbl.font = [UIFont systemFontOfSize:12];
            
            downPrice = [dto.marketPrice formatPriceString];
            
            self.downPriceCSLbl.text= [NSString stringWithFormat:@"¥ %.2f",[dto.marketPrice floatValue]];
            
            self.eGoCSLbl.frame = CGRectMake(KOrigionX, 15, KCSLblWidth, KCSLblHeight);
            
            self.eGoCSPriceLbl.frame = CGRectMake(KOrigionX, self.eGoCSLbl.bottom+3, KCSLblWidth, KCSLblHeight);
            
            self.downCSLbl.frame = CGRectMake(KOrigionX, self.eGoCSPriceLbl.bottom+10, KCSLblWidth, KCSLblHeight);
            
            self.downPriceCSLbl.frame = CGRectMake(KOrigionX, self.downCSLbl.bottom+3, KCSLblWidth, KCSLblHeight);
            
            self.downPriceCSLbl.font = [UIFont systemFontOfSize:18];
            
            self.deliveryFeeLbl.hidden = NO;
            
            if([self isFareBool:dto] == YES)
            {
                self.deliveryFeeLbl.text = [NSString stringWithFormat:@"¥ %@",dto.fare];
                self.deliveryLbl.hidden = NO;
                
                self.deliveryLbl.frame = CGRectMake(KOrigionX, self.downPriceCSLbl.bottom+15, KCSLblWidth, KCSLblHeight);
                
                self.deliveryFeeLbl.frame = CGRectMake(KOrigionX, self.deliveryLbl.bottom+3, KCSLblWidth, KCSLblHeight);
                self.deliveryFeeLbl.font = [UIFont systemFontOfSize:15];

            }
            else
            {
                self.deliveryFeeLbl.text = L(@"Product_NoDeliveryMoney");
                self.deliveryLbl.hidden = YES;
                
                self.deliveryFeeLbl.frame = CGRectMake(KOrigionX, self.downPriceCSLbl.bottom+10, KCSLblWidth, KCSLblHeight);
        
                self.deliveryFeeLbl.font = [UIFont systemFontOfSize:12];
            }

        }
        else
        {
            self.downCSLbl.hidden = YES;
            self.downPriceCSLbl.hidden = YES;
            self.eGoCSPriceLbl.isWithStrikeThrough = NO;
            self.eGoCSPriceLbl.textColor = [UIColor colorWithRGBHex:0xff0000];
            self.eGoCSPriceLbl.font = [UIFont systemFontOfSize:18];
            
            self.eGoCSLbl.frame = CGRectMake(KOrigionX, 40, KCSLblWidth, KCSLblHeight);
            
            self.eGoCSPriceLbl.frame = CGRectMake(KOrigionX, self.eGoCSLbl.bottom+3, KCSLblWidth, KCSLblHeight);
            self.deliveryFeeLbl.hidden = NO;
            
            if([self isFareBool:dto] == YES)
            {
                self.deliveryFeeLbl.text = [NSString stringWithFormat:@"¥ %@",dto.fare];
                self.deliveryLbl.hidden = NO;
                
                self.deliveryLbl.frame = CGRectMake(KOrigionX, self.eGoCSPriceLbl.bottom+15, KCSLblWidth, KCSLblHeight);
                
                self.deliveryFeeLbl.frame = CGRectMake(KOrigionX, self.deliveryLbl.bottom+3, KCSLblWidth, KCSLblHeight);
                
                self.deliveryFeeLbl.font = [UIFont systemFontOfSize:15];

            }
            
            else
            {
                self.deliveryFeeLbl.text = L(@"Product_NoDeliveryMoney");
                self.deliveryLbl.hidden = YES;
                
                self.deliveryFeeLbl.frame = CGRectMake(KOrigionX, self.eGoCSPriceLbl.bottom+15, KCSLblWidth, KCSLblHeight);
                self.deliveryFeeLbl.font = [UIFont systemFontOfSize:12];

            }
            

        }
    
    }
    else
    {
        self.downCSLbl.hidden = YES;
        
        self.downPriceCSLbl.hidden = YES;
        
        self.eGoCSLbl.hidden = YES;
        
        self.eGoCSPriceLbl.hidden = YES;
        
        self.deliveryLbl.hidden = YES;
        
        self.deliveryFeeLbl.hidden = YES;
        
        self.cSellerPointLbl.hidden = NO;
        self.cSellerPointLbl.text = L(@"Sorry, Not enough stock");//@"售罄";
        self.cSellerPointLbl.font = [UIFont systemFontOfSize:15];
        self.cSellerPointLbl.frame = CGRectMake(KOrigionX, 40, 136, 75);
        self.cSellerPointLbl.numberOfLines = 0;
        self.cSellerPointLbl.lineBreakMode = UILineBreakModeCharacterWrap;
        self.cSellerPointLbl.textAlignment = UITextAlignmentLeft;
        [self addSubview:self.cSellerPointLbl];
    }
    
}



@end
