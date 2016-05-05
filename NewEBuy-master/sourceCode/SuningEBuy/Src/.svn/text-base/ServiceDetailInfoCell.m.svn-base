//
//  ServiceDetailInfoCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-9-6.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceDetailInfoCell.h"

@implementation ServiceDetailInfoCell

@synthesize detailInfoDic = _detailInfoDic;

@synthesize conLabel = _conLabel;

@synthesize saleLabel = _saleLabel;

@synthesize nameLabel = _nameLabel;

@synthesize naLabel = _naLabel;

@synthesize numLabel = _numLabel;

@synthesize numvLabel = _numvLabel;

@synthesize typeLabel = _typeLabel;

@synthesize typesLabel = _typesLabel;

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_detailInfoDic);
    TT_RELEASE_SAFELY(_conLabel);
    TT_RELEASE_SAFELY(_saleLabel);
    TT_RELEASE_SAFELY(_nameLabel);
    TT_RELEASE_SAFELY(_naLabel);
    TT_RELEASE_SAFELY(_numLabel);
    TT_RELEASE_SAFELY(_numvLabel);
    TT_RELEASE_SAFELY(_typeLabel);
    TT_RELEASE_SAFELY(_typesLabel);
    
}

- (id)initWithReuseIndetifier:(NSString *)reuseIndetifier{
    
    if(self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndetifier]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.autoresizesSubviews = YES;
        
        self.contentView.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (UILabel *)conLabel{
    
    if (!_conLabel) {
        
        _conLabel = [[UILabel alloc] init];
        CGRect labelRect ;
        labelRect = CGRectMake(11,6,60,21);		
        _conLabel = [[UILabel alloc] initWithFrame:labelRect];
        _conLabel.backgroundColor = [UIColor clearColor];
        _conLabel.textAlignment = UITextAlignmentLeft;
        _conLabel.font = [UIFont systemFontOfSize:14];
        _conLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        _conLabel.tag = 1;
        
        [self.contentView addSubview:_conLabel];
    }
    
    return _conLabel;
}

- (UILabel *)saleLabel{
    
    if (!_saleLabel) {
        
        _saleLabel = [[UILabel alloc] init];
        CGRect saleRect ;
        saleRect = CGRectMake(75,6,200,21);		
        _saleLabel = [[UILabel alloc] initWithFrame:saleRect];
        _saleLabel.backgroundColor = [UIColor clearColor];
        _saleLabel.textAlignment = UITextAlignmentLeft;
        _saleLabel.font = [UIFont systemFontOfSize:14];
        _saleLabel.textColor = [UIColor colorWithRed:0/255.0 green:51/255.0 blue:153/255.0 alpha:1];
        _saleLabel.tag = 2;
        [_saleLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_saleLabel];
    }
    
    return _saleLabel;
}

- (UILabel *)nameLabel{
    
    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        CGRect nameRect ;
        nameRect = CGRectMake(11,33,90,21);		
        _nameLabel = [[UILabel alloc] initWithFrame:nameRect];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textAlignment = UITextAlignmentLeft;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        _nameLabel.tag = 3;
        
        [self.contentView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

- (UILabel *)naLabel{
    
    if (!_naLabel) {
        
        _naLabel = [[UILabel alloc] init];
        CGRect naRect ;
        naRect = CGRectMake(103,33,88,21);		
        _naLabel = [[UILabel alloc] initWithFrame:naRect];
        _naLabel.backgroundColor = [UIColor clearColor];
        _naLabel.textAlignment = UITextAlignmentLeft;
        _naLabel.font = [UIFont systemFontOfSize:12];
        _naLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _naLabel.tag = 4;
        [_naLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_naLabel];
    }
    
    return _naLabel;
}

- (UILabel *)numLabel{
    
    if (!_numLabel) {
        
        _numLabel = [[UILabel alloc] init];
        CGRect numRect ;
        numRect = CGRectMake(200,33,40,21);		
        _numLabel = [[UILabel alloc] initWithFrame:numRect];
        _numLabel.backgroundColor = [UIColor clearColor];
        _numLabel.textAlignment = UITextAlignmentLeft;
        _numLabel.font = [UIFont systemFontOfSize:14];
        _numLabel.textColor = [UIColor colorWithRed:99/255.0 green:99/255.0 blue:99/255.0 alpha:1];
        _numLabel.tag = 5;
        
        [self.contentView addSubview:_numLabel];
    }
    
    return _numLabel;
}

- (UILabel *)numvLabel{
    
    if (!_numvLabel) {
        
        _numvLabel = [[UILabel alloc] init];
        CGRect numvRect ;
        numvRect = CGRectMake(240,33,50,21);		
        _numvLabel = [[UILabel alloc] initWithFrame:numvRect];
        _numvLabel.backgroundColor = [UIColor clearColor];
        _numvLabel.textAlignment = UITextAlignmentLeft;
        _numvLabel.font = [UIFont systemFontOfSize:10];
        _numvLabel.textColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1];
        _numvLabel.tag = 6;
        [self.contentView addSubview:_numvLabel];
    }
    
    return _numvLabel;
}

- (UILabel *)typeLabel{
    
    if (!_typeLabel) {
        
        _typeLabel = [[UILabel alloc] init];
        CGRect typeRect ;
        typeRect = CGRectMake(11,60,110,21);		
        _typeLabel = [[UILabel alloc] initWithFrame:typeRect];
        _typeLabel.backgroundColor = [UIColor clearColor];
        _typeLabel.textAlignment = UITextAlignmentLeft;
        _typeLabel.font = [UIFont systemFontOfSize:14];
        _typeLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        _typeLabel.tag = 7;
        
        [self.contentView addSubview:_typeLabel];
    }
    
    return _typeLabel;
}

- (UILabel *)typesLabel{
    
    if (!_typesLabel) {
        
        _typesLabel = [[UILabel alloc] init];
        CGRect typesRect ;
        typesRect = CGRectMake(120,60,170,21);		
        _typesLabel = [[UILabel alloc] initWithFrame:typesRect];
        _typesLabel.backgroundColor = [UIColor clearColor];
        _typesLabel.textAlignment = UITextAlignmentLeft;
        _typesLabel.font = [UIFont systemFontOfSize:14];
        _typesLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1];
        _typesLabel.tag = 8;
        [_typesLabel setAdjustsFontSizeToFitWidth:NO];
        [self.contentView addSubview:_typesLabel];
    }
    
    return _typesLabel;
}


- (void)setDetailInfoCellContent:(NSMutableDictionary *)detailInfoDic
{
    self.conLabel.text = L(@"order Adress");
    
    self.nameLabel.text = L(@"ReachTime");
    
    self.numLabel.text = L(@"Amount");
    
    self.typeLabel.text = L(@"CancelReceipts");
    
    if (!detailInfoDic) {
        
        return;
    }
    
    if (detailInfoDic != _detailInfoDic) {
        
        
        _detailInfoDic = detailInfoDic;
    }
    
    if ([_detailInfoDic objectForKey:kDeliveryAddress]) {
        
        self.saleLabel.text = [_detailInfoDic objectForKey:kDeliveryAddress];
    }
    
    if ([_detailInfoDic objectForKey:kDeliveryDate]) {
        
        self.naLabel.text = [_detailInfoDic objectForKey:kDeliveryDate];
    }
    
    if ([_detailInfoDic objectForKey:kDeliverQuantity]) {
        
        self.numvLabel.text = [_detailInfoDic objectForKey:kDeliverQuantity];
    }
    
    if ([_detailInfoDic objectForKey:kChangeReturnDoc]) {
        
        self.typesLabel.text = [_detailInfoDic objectForKey:kChangeReturnDoc];
    }
}


@end
