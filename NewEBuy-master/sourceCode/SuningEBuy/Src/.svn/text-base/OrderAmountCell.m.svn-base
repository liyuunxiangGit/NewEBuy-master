//
//  OrderAmountCell.m
//  SuningEBuy
//
//  Created by Yang on 14-7-16.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "OrderAmountCell.h"

#define kPriceColor [UIColor colorWithHexString:@"#FF4800"]
#define kLightGray [UIColor colorWithHexString:@"#949494"]

@implementation OrderAmountCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


//订单金额行设置
- (void)setOrderAmountCell:(MemberOrderDetailsDTO *)detailDto
               WithNameDto:(MemberOrderNamesDTO *)nameDto
       WithSectionPosition:(int)section
          WithCellPosition:(int)row
{
    NSString *orderAmount = [self setStr:nameDto.prepayAmount];//订单金额
    NSString *productAmount = [self setStr:nameDto.totalPrice];//商品金额
    NSString *preferential = [self setStr:nameDto.totalDiscount];//卡卷优惠
    NSString *freight = nil;//运费

    if (IsStrEmpty(nameDto.supplierCode)) {
        freight = [self setStr:nameDto.totalShipCharge];//自营运费

    }
    else
    {
        freight = [self setStr:nameDto.totalShipPrice];//C店运费
    }

    
    //订单金额
    self.orderSum.frame = CGRectMake(15, 0, 200, 40);
    self.orderSum.text = L(@"MyEBuy_OrderAmount");
    self.orderSumPrice.frame = CGRectMake(self.orderSum.right, 0, 90, 40);
    self.orderSumPrice.text = [NSString stringWithFormat:@"￥%.2f",[orderAmount doubleValue]];
    //商品金额
    self.productSum.frame = CGRectMake(15,40,200, 25);
    self.productSum.text = L(@"MyEBuy_AmountOfGoods");
    self.productSumPrice.frame = CGRectMake(self.productSum.right,40,90, 25);
    self.productSumPrice.text = [NSString stringWithFormat:@"￥%.2f",[productAmount doubleValue]];

    //优惠
    self.privilegeSum.frame = CGRectMake(15,self.productSum.bottom,200, 25);
    self.privilegeSum.text = L(@"MyEBuy_CardDiscount");
    self.privilegeSumPrice.frame = CGRectMake(self.privilegeSum.right,self.productSum.bottom,90, 25);
    self.privilegeSumPrice.text = [NSString stringWithFormat:@"￥%.2f", [preferential doubleValue]];//(double)abs([preferential doubleValue]) ];

    //运费
    self.freightSum.frame = CGRectMake(15,self.privilegeSum.bottom,200, 25);
    self.freightSum.text = L(@"MyEBuy_FreightAmount");
    self.freightSumPrice.frame = CGRectMake(self.freightSum.right,self.privilegeSum.bottom,90, 25);
    self.freightSumPrice.text = [NSString stringWithFormat:@"￥%.2f",[freight doubleValue]];
    
    self.line.frame = CGRectMake(15, 39.5, 305, 0.5);

}

- (void)setSimCardInfo:(MemberOrderDetailsDTO *)detailDto
{
    self.phoneNumber.frame = CGRectMake(15, 0, 145, 40);
    self.phoneNumber.text = [NSString stringWithFormat:@"%@ :",L(@"LBMobilePhoneNumber")];
    
    self.phoneNumberContent.frame = CGRectMake(self.phoneNumber.right, 0, 145, 40);
    self.phoneNumberContent.text = detailDto.phoneNum;
    
    self.packageInformation.frame = CGRectMake(15, self.phoneNumber.bottom, 80, 40);
    self.packageInformation.text = [NSString stringWithFormat:@"%@ :",L(@"MyEBuy_PackageInformation")];
    
    NSString *packagePrice = detailDto.monthlyAmt;
    
    self.packageInformationContent.frame = CGRectMake(self.packageInformation.right, self.phoneNumber.bottom, 210, 40);
    self.packageInformationContent.text = [NSString stringWithFormat:@"￥%.2f-%@(%@%@%@)",[packagePrice doubleValue],detailDto.planTypeName,L(@"MyEBuy_Contract"),detailDto.signDuration,L(@"MyEBuy_Months")];
    self.line.frame = CGRectMake(0, 39.5, 320, 0.5);
}

- (NSString *)setStr:(NSString*)str
{
    if (str == nil)
    {
        str = @"";
    }
    
    return str;
}


- (UILabel*)orderSum
{
    if(!_orderSum)
    {
        _orderSum = [[UILabel alloc] init];
        
        _orderSum.textColor = [UIColor blackColor];// colorWithRGBHex:0x313131];
        
        _orderSum.backgroundColor = [UIColor clearColor];
        
        _orderSum.font = [UIFont systemFontOfSize:16];
        
        _orderSum.textAlignment = UITextAlignmentLeft;
        
        _orderSum.text = @"";
        
//        _orderSum.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_orderSum];
    }
    
    return _orderSum;
}

- (UILabel*)orderSumPrice
{
    if(!_orderSumPrice)
    {
        _orderSumPrice = [[UILabel alloc] init];
        
        _orderSumPrice.textColor = kPriceColor;
        
        _orderSumPrice.backgroundColor = [UIColor clearColor];
        
        _orderSumPrice.font = [UIFont systemFontOfSize:16];
        
        _orderSumPrice.textAlignment = UITextAlignmentRight;
        
        _orderSumPrice.text = @"";
        
//        _orderSumPrice.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_orderSumPrice];
    }
    
    return _orderSumPrice;
}

- (UILabel*)productSum
{
    if(!_productSum)
    {
        _productSum = [[UILabel alloc] init];
        
        _productSum.textColor = kLightGray;
        
        _productSum.backgroundColor = [UIColor clearColor];
        
        _productSum.font = [UIFont systemFontOfSize:12];
        
        _productSum.textAlignment = UITextAlignmentLeft;
        
        _productSum.text = @"";
        
//        _productSum.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_productSum];
    }
    
    return _productSum;
}

- (UILabel*)productSumPrice
{
    if(!_productSumPrice)
    {
        _productSumPrice = [[UILabel alloc] init];
        
        _productSumPrice.textColor = kPriceColor;
        
        _productSumPrice.backgroundColor = [UIColor clearColor];
        
        _productSumPrice.font = [UIFont systemFontOfSize:12];
        
        _productSumPrice.textAlignment = UITextAlignmentRight;
        
        _productSumPrice.text = @"";
        
//        _productSumPrice.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_productSumPrice];
    }
    
    return _productSumPrice;
}

- (UILabel*)privilegeSum
{
    if(!_privilegeSum)
    {
        _privilegeSum = [[UILabel alloc] init];
        
        _privilegeSum.textColor = kLightGray;
        
        _privilegeSum.backgroundColor = [UIColor clearColor];
        
        _privilegeSum.font = [UIFont systemFontOfSize:12];
        
        _privilegeSum.textAlignment = UITextAlignmentLeft;
        
        _privilegeSum.text = @"";
        
//        _privilegeSum.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_privilegeSum];
    }
    
    return _privilegeSum;
}

- (UILabel*)privilegeSumPrice
{
    if(!_privilegeSumPrice)
    {
        _privilegeSumPrice = [[UILabel alloc] init];
        
        _privilegeSumPrice.textColor = kPriceColor;
        
        _privilegeSumPrice.backgroundColor = [UIColor clearColor];
        
        _privilegeSumPrice.font = [UIFont systemFontOfSize:12];
        
        _privilegeSumPrice.textAlignment = UITextAlignmentRight;
        
        _privilegeSumPrice.text = @"";
        
//        _privilegeSumPrice.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_privilegeSumPrice];
    }
    
    return _privilegeSumPrice;
}


- (UILabel*)freightSum
{
    if(!_freightSum)
    {
        _freightSum = [[UILabel alloc] init];
        
        _freightSum.textColor = kLightGray;
        
        _freightSum.backgroundColor = [UIColor clearColor];
        
        _freightSum.font = [UIFont systemFontOfSize:12];
        
        _freightSum.textAlignment = UITextAlignmentLeft;
        
        _freightSum.text = @"";
        
//        _freightSum.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_freightSum];
    }
    
    return _freightSum;
}

- (UILabel*)freightSumPrice
{
    if(!_freightSumPrice)
    {
        _freightSumPrice = [[UILabel alloc] init];
        
        _freightSumPrice.textColor = kPriceColor;
        
        _freightSumPrice.backgroundColor = [UIColor clearColor];
        
        _freightSumPrice.font = [UIFont systemFontOfSize:12];
        
        _freightSumPrice.textAlignment = UITextAlignmentRight;
        
        _freightSumPrice.text = @"";
        
        
//        _freightSumPrice.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_freightSumPrice];
    }
    
    return _freightSumPrice;
}

- (UILabel*)phoneNumber
{
    if(!_phoneNumber)
    {
        _phoneNumber = [[UILabel alloc] init];
        
        _phoneNumber.textColor = [UIColor blackColor];
        
        _phoneNumber.backgroundColor = [UIColor clearColor];
        
        _phoneNumber.font = [UIFont systemFontOfSize:16];
        
        _phoneNumber.textAlignment = UITextAlignmentLeft;
        
        _phoneNumber.text = @"";
        
        //        _privilegeSum.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_phoneNumber];
    }
    
    return _phoneNumber;
}

- (UILabel*)phoneNumberContent
{
    if(!_phoneNumberContent)
    {
        _phoneNumberContent = [[UILabel alloc] init];
        
        _phoneNumberContent.textColor = kLightGray;
        
        _phoneNumberContent.backgroundColor = [UIColor clearColor];
        
        _phoneNumberContent.font = [UIFont systemFontOfSize:16];
        
        _phoneNumberContent.textAlignment = UITextAlignmentRight;
        
        _phoneNumberContent.text = @"";
        
        //        _privilegeSumPrice.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_phoneNumberContent];
    }
    
    return _phoneNumberContent;
}


- (UILabel*)packageInformation
{
    if(!_packageInformation)
    {
        _packageInformation = [[UILabel alloc] init];
        
        _packageInformation.textColor = [UIColor blackColor];
        
        _packageInformation.backgroundColor = [UIColor clearColor];
        
        _packageInformation.font = [UIFont systemFontOfSize:16];
        
        _packageInformation.textAlignment = UITextAlignmentLeft;
        
        _packageInformation.text = @"";
        
        //        _freightSum.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_packageInformation];
    }
    
    return _packageInformation;
}

- (UILabel*)packageInformationContent
{
    if(!_packageInformationContent)
    {
        _packageInformationContent = [[UILabel alloc] init];
        
        _packageInformationContent.textColor = kLightGray;
        
        _packageInformationContent.backgroundColor = [UIColor clearColor];
        
        _packageInformationContent.font = [UIFont systemFontOfSize:15];
        
        _packageInformationContent.textAlignment = UITextAlignmentLeft;
        
        _packageInformationContent.lineBreakMode = UILineBreakModeCharacterWrap;
        
        _packageInformationContent.numberOfLines = 0;
        
        _packageInformationContent.text = @"";
        
        
        //        _freightSumPrice.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_packageInformationContent];
    }
    
    return _packageInformationContent;
}

- (void)setLblProtery:(UILabel*)lbl
{
    lbl.textColor = [UIColor colorWithRGBHex:0x313131];
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:13];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.text = @"";
    
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [self.contentView addSubview:_line];
    }
    return _line;
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
