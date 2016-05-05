//
//  MobliePayHeadView.m
//  SuningEBuy
//
//  Created by david david on 12-8-9.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "MobliePayHeadView.h"

@interface MobliePayHeadView()

@property(nonatomic,strong) UILabel *phoneNoLabel;
@property(nonatomic,strong) UILabel *mobilequoLabel;
@property(nonatomic,strong) UILabel *payPriceLabel;
@property(nonatomic,strong) UILabel *factPayPriceLabel;

@end

@implementation MobliePayHeadView

@synthesize phoneNoLabel = _phoneNoLabel;
@synthesize mobilequoLabel = _mobilequoLabel;
@synthesize payPriceLabel = _payPriceLabel;
@synthesize factPayPriceLabel = _factPayPriceLabel;


- (void)dealloc {
    
    TT_RELEASE_SAFELY(_phoneNoLabel);
    TT_RELEASE_SAFELY(_mobilequoLabel);
    TT_RELEASE_SAFELY(_payPriceLabel);
    TT_RELEASE_SAFELY(_factPayPriceLabel);
    
}

-(UILabel *)phoneNoLabel{

    if (_phoneNoLabel == nil) {
        
        _phoneNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 280, 20)];
        
        _phoneNoLabel.font =[UIFont systemFontOfSize:14];
        
        _phoneNoLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_phoneNoLabel];
    }
    
    return _phoneNoLabel;
}

-(UILabel *)mobilequoLabel{
    
    if (_mobilequoLabel == nil) {
        
        _mobilequoLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.phoneNoLabel.bottom, 280, 20)];
        
        _mobilequoLabel.font =[UIFont systemFontOfSize:14];
        
        _mobilequoLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_mobilequoLabel];

    }
    
    return _mobilequoLabel;
}

-(UILabel *)payPriceLabel{
    
    if (_payPriceLabel == nil) {
        
        _payPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.mobilequoLabel.bottom, 280, 20)];
        
        _payPriceLabel.font =[UIFont systemFontOfSize:14];
        
        _payPriceLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_payPriceLabel];
        
    }
    
    return _payPriceLabel;
}

-(UILabel *)factPayPriceLabel{
    
    if (_factPayPriceLabel == nil) {
        
        _factPayPriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, self.payPriceLabel.bottom, 280, 20)];
        
        _factPayPriceLabel.font =[UIFont systemFontOfSize:14];
        
        _factPayPriceLabel.backgroundColor = [UIColor clearColor];
        
        [self addSubview:_factPayPriceLabel];
    }
    
    return _factPayPriceLabel;
}

-(void)setItem:(payMobileOrderDTO *)dto{
    
    if (dto == nil) {
        
        return;
    }
    
    
    NSString *__mobileNumber = dto.mobileNumber == nil?@"--":dto.mobileNumber;
    NSString *__mobilequo = dto.mobilequo == nil?@"--":dto.mobilequo;
    
    NSString *__payPrice = @"--";
    NSString *__factPayPrice = @"--";

    
    if (dto.payPrice) {
     
        double dPayPrice = [dto.payPrice doubleValue];
        
        dPayPrice = dPayPrice/100.0;
        
        __payPrice = [NSString stringWithFormat:@"%0.2f%@",dPayPrice,L(@"Money Unit")];
        
    }
   
    if (dto.factPayPrice) {
        
        double dFactPayPrice = [dto.factPayPrice doubleValue];
        
        dFactPayPrice = dFactPayPrice/100.0;
        
        __factPayPrice = [NSString stringWithFormat:@"%0.2f%@",dFactPayPrice,L(@"Money Unit")];
        
    }
    
    self.phoneNoLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"Phone number"),__mobileNumber];
    self.mobilequoLabel.text = [NSString stringWithFormat:@"%@%@",L(@"VPOwnership1"),__mobilequo];
    self.payPriceLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"Select amount"),__payPrice];
    self.factPayPriceLabel.text = [NSString stringWithFormat:@"%@：%@",L(@"Sale price"),__factPayPrice];
    

}




@end
