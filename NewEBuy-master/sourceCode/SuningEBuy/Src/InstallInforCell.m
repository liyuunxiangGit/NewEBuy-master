//
//  InstallInforCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InstallInforCell.h"

@implementation InstallInforCell

@synthesize installInforDto = _installInforDto;

@synthesize orderTypeLabel = _orderTypeLabel;

@synthesize orderTypeDesLabel = _orderTypeDesLabel;

@synthesize serviceStateLabel = _serviceStateLabel;

@synthesize serviceStateDesLabel = _serviceStateDesLabel;

@synthesize installTimeLab = _installTimeLab;

@synthesize installTimeDesLab = _installTimeDesLab;

@synthesize typeLabel = _typeLabel;

@synthesize typesLabel = _typesLabel;

@synthesize phoLabel = _phoLabel;

@synthesize phoneLabel = _phoneLabel;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_installInforDto);
    TT_RELEASE_SAFELY(_orderTypeLabel);
    TT_RELEASE_SAFELY(_orderTypeDesLabel);
    TT_RELEASE_SAFELY(_serviceStateLabel);
    TT_RELEASE_SAFELY(_serviceStateDesLabel);
    TT_RELEASE_SAFELY(_installTimeLab);
    TT_RELEASE_SAFELY(_installTimeDesLab);
    TT_RELEASE_SAFELY(_typeLabel);
    TT_RELEASE_SAFELY(_typesLabel);
    TT_RELEASE_SAFELY(_phoLabel);
    TT_RELEASE_SAFELY(_phoneLabel);
    
}

- (id)initWithReuseIndetifier:(NSString *)reuseIndetifier{
    
    if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndetifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.autoresizesSubviews = YES;
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
- (UILabel *)installTimeLab{
    
    if (!_installTimeLab) {
        
        CGRect nameRect ;
        nameRect = CGRectMake(0,5,110,20);
        _installTimeLab = [[UILabel alloc] initWithFrame:nameRect];
        _installTimeLab.backgroundColor = [UIColor clearColor];
        _installTimeLab.textAlignment = UITextAlignmentRight;
        _installTimeLab.font = [UIFont systemFontOfSize:14];
        _installTimeLab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _installTimeLab.backgroundColor = [UIColor clearColor];
        _installTimeLab.tag = 25;
        
        [self.contentView addSubview:_installTimeLab];
    }
    
    return _installTimeLab;
}

- (UILabel *)installTimeDesLab{
    
    if (!_installTimeDesLab) {
        
        CGRect naRect ;
        naRect = CGRectMake(120,5,150,20);
        _installTimeDesLab = [[UILabel alloc] initWithFrame:naRect];
        _installTimeDesLab.backgroundColor = [UIColor clearColor];
        _installTimeDesLab.textAlignment = UITextAlignmentLeft;
        _installTimeDesLab.font = [UIFont systemFontOfSize:14];
        _installTimeDesLab.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _installTimeDesLab.backgroundColor = [UIColor clearColor];
        _installTimeDesLab.tag =26;
        [_installTimeDesLab setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_installTimeDesLab];
    }
    
    return _installTimeDesLab;
}

- (UILabel *)orderTypeLabel{
    
    if (!_orderTypeLabel) {
        
        CGRect labelRect ;
        labelRect = CGRectMake(0,30,110,20);
        _orderTypeLabel = [[UILabel alloc] initWithFrame:labelRect];
        _orderTypeLabel.backgroundColor = [UIColor clearColor];
        _orderTypeLabel.textAlignment = UITextAlignmentRight;
        _orderTypeLabel.font = [UIFont systemFontOfSize:14];
        _orderTypeLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _orderTypeLabel.backgroundColor = [UIColor clearColor];
        _orderTypeLabel.tag = 21;
        
        [self.contentView addSubview:_orderTypeLabel];
    }
    
    return _orderTypeLabel;
}

- (UILabel *)orderTypeDesLabel{
    
    if (!_orderTypeDesLabel) {
        
        CGRect saleRect ;
        saleRect = CGRectMake(120,30,150,20);
        _orderTypeDesLabel = [[UILabel alloc] initWithFrame:saleRect];
        _orderTypeDesLabel.backgroundColor = [UIColor clearColor];
        _orderTypeDesLabel.textAlignment = UITextAlignmentLeft;
        _orderTypeDesLabel.font = [UIFont systemFontOfSize:12];
        _orderTypeDesLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _orderTypeDesLabel.backgroundColor = [UIColor clearColor];
        _orderTypeDesLabel.tag = 22;
        [_orderTypeDesLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_orderTypeDesLabel];
    }
    
    return _orderTypeDesLabel;
}

- (UILabel *)serviceStateLabel{
    
    if (!_serviceStateLabel) {
        
        CGRect numRect ;
        numRect = CGRectMake(0,55,110,20);
        _serviceStateLabel = [[UILabel alloc] initWithFrame:numRect];
        _serviceStateLabel.backgroundColor = [UIColor clearColor];
        _serviceStateLabel.textAlignment = UITextAlignmentRight;
        _serviceStateLabel.font = [UIFont systemFontOfSize:14];
        _serviceStateLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _serviceStateLabel.backgroundColor = [UIColor clearColor];
        _serviceStateLabel.tag = 23;
        
        [self.contentView addSubview:_serviceStateLabel];
    }
    
    return _serviceStateLabel;
}

- (UILabel *)serviceStateDesLabel{
    
    if (!_serviceStateDesLabel) {
        
        CGRect numvRect ;
        numvRect = CGRectMake(120,55,150,20);
        _serviceStateDesLabel = [[UILabel alloc] initWithFrame:numvRect];
        _serviceStateDesLabel.backgroundColor = [UIColor clearColor];
        _serviceStateDesLabel.textAlignment = UITextAlignmentLeft;
        _serviceStateDesLabel.font = [UIFont systemFontOfSize:14];
        _serviceStateDesLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _serviceStateDesLabel.backgroundColor = [UIColor clearColor];
        _serviceStateDesLabel.tag = 24;
        [self.contentView addSubview:_serviceStateDesLabel];
    }
    
    return _serviceStateDesLabel;
}


- (UILabel *)typeLabel{
    
    if (!_typeLabel) {
        
        CGRect typeRect ;
        typeRect = CGRectMake(0,80,110,20);
        _typeLabel = [[UILabel alloc] initWithFrame:typeRect];
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.textAlignment = UITextAlignmentRight;
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.tag = 27;
        
        [self.contentView addSubview:_typeLabel];
    }
    
    return _typeLabel;
}

- (UILabel *)typesLabel{
    
    if (!_typesLabel) {
        
        CGRect typesRect ;
        typesRect = CGRectMake(120,80,150,20);
        _typesLabel = [[UILabel alloc] initWithFrame:typesRect];
        _typesLabel.backgroundColor = [UIColor clearColor];
        _typesLabel.textAlignment = UITextAlignmentLeft;
        _typesLabel.font = [UIFont systemFontOfSize:14];
        _typesLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _typesLabel.backgroundColor = [UIColor clearColor];
        _typesLabel.tag = 28;
        [_typesLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_typesLabel];
        
    }
    
    return _typesLabel;
}

- (UILabel *)phoLabel{
    
    if (!_phoLabel) {
        
        CGRect phoRect ;
        phoRect = CGRectMake(0,105,110,20);
        _phoLabel = [[UILabel alloc] initWithFrame:phoRect];
        _phoLabel.backgroundColor = [UIColor clearColor];
        _phoLabel.textAlignment = UITextAlignmentRight;
        _phoLabel.font = [UIFont systemFontOfSize:14];
        _phoLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _phoLabel.backgroundColor = [UIColor clearColor];
        _phoLabel.tag = 29;
        
        [self.contentView addSubview:_phoLabel];
    }
    
    return _phoLabel;
}

- (UILabel *)phoneLabel{
    
    if (!_phoneLabel) {
        
        CGRect phoneRect ;
        phoneRect = CGRectMake(120,105,150,20);
        _phoneLabel = [[UILabel alloc] initWithFrame:phoneRect];
        _phoneLabel.backgroundColor = [UIColor clearColor];
        _phoneLabel.textAlignment = UITextAlignmentLeft;
        _phoneLabel.font = [UIFont systemFontOfSize:14];
        _phoneLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _phoneLabel.backgroundColor = [UIColor clearColor];
        _phoneLabel.tag = 30;
        [_phoneLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_phoneLabel];
    }
    
    return _phoneLabel;
}

- (void)setInstallInforCellContent:(ServiceDetailDTO *)inforDto{
    
    self.orderTypeLabel.text = L(@"OrderType");
    
    self.serviceStateLabel.text = L(@"ServiceState");
    
    self.installTimeLab.text = L(@"InstallTime");
    
    self.typeLabel.text = L(@"EngineerName");
    
    self.phoLabel.text = L(@"EngineerMobile");
    
    if (!inforDto) {
        
        return;
    }
    
    if (inforDto != _installInforDto) {
        
        self.installInforDto = inforDto;
        
        self.orderTypeDesLabel.text = inforDto.serviceOrderName;

        self.serviceStateDesLabel.text = inforDto.serviceStatus;
        
        self.installTimeDesLab.text = [NSString stringWithFormat:@"%@  %@",inforDto.serviceDate,inforDto.serviceTime];

        self.typesLabel.text = inforDto.workerName;

        self.phoneLabel.text =inforDto.workerTel;
    }
}


@end
