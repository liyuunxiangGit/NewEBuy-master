//
//  ReturnGoodSDetailCell.m
//  SuningEBuy
//
//  Created by Yang on 14-7-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReturnGoodSDetailCell.h"

@implementation ReturnGoodSDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setBackTypeContent:(ReturnGoodsPrepareDTO *)returnDto
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 290, 40);
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    if (!IsStrEmpty(returnDto.payFreeForReturn)) {
        self.generalLabelOne.text = [NSString stringWithFormat:@"%@ : %@(%@%@%@)",L(@"MyEBuy_GoodsReturnMode"),L(@"MyEBuy_PickUpPackages"),L(@"MyEBuy_TakeCharge"),returnDto.payFreeForReturn,L(@"Constant_RMB")];
    }
    else
    {
        self.generalLabelOne.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_GoodsReturnMode"),L(@"MyEBuy_PickUpPackages")];
    }
}

- (void)setGoShopBackTypeContent:(ReturnGoodsPrepareDTO *)returnDto
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 290, 40);
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
    self.generalLabelOne.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_GoodsReturnMode"),L(@"MyEBuy_DeliveryToOriginalStore")];
}

- (void)setGoShopTakeAddress:(ReturnGoodsPrepareDTO *)returnDto shopAddress:(NSString *)address
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 290, 40);
    self.generalLabelOne.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_OriginalStoreAddress"),address];
}

- (void)setTakeAddress:(ReturnGoodsPrepareDTO *)returnDto
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 75, 40);
    self.generalLabelOne.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_TakeAddress")];
    self.generalLabelTwo.frame = CGRectMake(90, 0, 200, 40);
    NSString *province = returnDto.province;
    NSString *city = returnDto.city;
    NSString *area = returnDto.area;

    if (IsStrEmpty(returnDto.province)) {
        province = @"    ";
    }
    if (IsStrEmpty(returnDto.city)) {
        city = [NSString stringWithFormat:@"    %@",L(@"MyEBuy_City")];
    }
    if (IsStrEmpty(returnDto.area)) {
        area = [NSString stringWithFormat:@"    %@",L(@"MyEBuy_Area")];
    }
    self.generalLabelTwo.text = [NSString stringWithFormat:@"%@%@%@%@",province,L(@"MyEBuy_Province"),city,area];
    
    self.lineView.frame = CGRectMake(90, 39.5, 230, 0.5);
}

//退货数量
- (void)setReturnNumber:(ReturnGoodsPrepareDTO *)returnDto
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 290, 40);
    self.generalLabelOne.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_ReturnsNumber"),returnDto.quantityValue];
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);
}
//发票
- (void)setInvoice:(ReturnGoodsPrepareDTO *)returnDto taxType:(NSString *)taxType
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 290, 40);
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);

    if (( [taxType eq:@"0"] || [taxType eq:@"1"] ) && [returnDto.invoiceIsPrinted eq:@"1"]) {
        self.generalLabelOne.text = [NSString stringWithFormat:@"%@ : %@(%@)",L(@"MyEBuy_ReturnCredentials"),L(@"MyEBuy_Invoice"),L(@"MyEBuy_PrepareInvoiceAndSendBackGoodsTogether")];//[NSString stringWithFormat:@"退货数量 : %@",returnDto.quantityValue];

    }
    else
    {
        self.generalLabelOne.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_ReturnCredentials"),L(@"MyEBuy_Invoice")];
    }
    
}

- (void)setTakeTime:(ReturnGoodsPrepareDTO *)returnDto
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 120, 40);
    self.generalLabelOne.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_Pick-upTime")];

}

- (void)setPersonPhoneNumber:(ReturnGoodsPrepareDTO *)returnDto
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 80, 40);
    self.generalLabelOne.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_PhoneNumber")];
}

- (void)setPersonName:(ReturnGoodsPrepareDTO *)returnDto
{
    self.generalLabelOne.frame = CGRectMake(15, 0, 80, 40);
    self.generalLabelOne.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_Contact")];
    self.lineView.frame = CGRectMake(0, 39.5, 320, 0.5);


}

-(UILabel *)generalLabelOne{
    
    if (!_generalLabelOne) {
        _generalLabelOne = [[UILabel alloc]init];
        _generalLabelOne.backgroundColor = [UIColor clearColor];
        _generalLabelOne.font = [UIFont systemFontOfSize:16];
        _generalLabelOne.textColor = [UIColor blackColor];
        _generalLabelOne.textAlignment = UITextAlignmentLeft;
        _generalLabelOne.numberOfLines = 2;
        _generalLabelOne.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:_generalLabelOne];
    }
    return _generalLabelOne;
}

-(UILabel *)generalLabelTwo{
    
    if (!_generalLabelTwo) {
        _generalLabelTwo = [[UILabel alloc]init];
        _generalLabelTwo.backgroundColor = [UIColor clearColor];
        _generalLabelTwo.font = [UIFont systemFontOfSize:15];
        _generalLabelTwo.textColor = [UIColor blackColor];
        _generalLabelTwo.textAlignment = UITextAlignmentLeft;
        _generalLabelTwo.numberOfLines = 2;
        _generalLabelTwo.lineBreakMode = UILineBreakModeTailTruncation;
        [self.contentView addSubview:_generalLabelTwo];
    }
    return _generalLabelTwo;
}


- (UIImageView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIImageView alloc] init];
        _lineView.backgroundColor = [UIColor clearColor];
        _lineView.image = [UIImage streImageNamed:@"line.png"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
