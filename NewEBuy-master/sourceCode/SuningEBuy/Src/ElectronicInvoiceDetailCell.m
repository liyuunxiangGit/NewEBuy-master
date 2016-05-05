//
//  ElectronicInvoiceDetailCell.m
//  SuningEBuy
//
//  Created by Yang on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ElectronicInvoiceDetailCell.h"

#define ScreenWidth 320

@implementation ElectronicInvoiceDetailCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setElectronicInvoiceDetailCell:(MemberOrderDetailsDTO *)goodsDTO CShopList:(NSArray *)list row:(NSInteger)currentRow
{
    if (IsNilOrNull(goodsDTO))
    {
        return;
    }

    NSString *productName = [self setStr:goodsDTO.productName];//商品名
    NSString *invoiceCode = [self setStr:goodsDTO.invoiceCode];//发票代码
    NSString *invoiceNumber = [self setStr:goodsDTO.invoiceNumber];//发票号码
    NSString *printPwd = [self setStr:goodsDTO.printPwd];//发票打印密码
    NSString *invoiceContent = [self setStr:goodsDTO.invoiceDescription];//发票内容
    self.backgroundImage.frame = CGRectMake(15, 0, 290, 135);
    self.line.frame = CGRectMake(20, 39.5, 250, 1);
    //商品名称
    self.productName.frame = CGRectMake(20, 0, 270, 40);
    self.productName.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_ProductName"),productName];
    //代码
    self.invoiceCode.frame = CGRectMake(20, 45, 270, 20);
    self.invoiceCode.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_InvoiceCode"),invoiceCode];
    //号码
    self.invoiceNumber.frame = CGRectMake(20 , self.invoiceCode.bottom, 270, 20);
    self.invoiceNumber.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_InvoiceNumber"),invoiceNumber];
    //打印密码
    self.printPassword.frame = CGRectMake(20, self.invoiceNumber.bottom, 270, 20);
    self.printPassword.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_PrintPassword"),printPwd];
    //发票内容
    self.invoiceContent.frame = CGRectMake(20, self.printPassword.bottom, 270, 20);
    self.invoiceContent.text = [NSString stringWithFormat:@"%@ : %@",L(@"MyEBuy_InvoiceContent"),invoiceContent];
    
}

- (NSString *)setStr:(NSString*)str
{
    if (str == nil)
    {
        str = @"";
    }

    return str;
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

//名称
- (UILabel*)productName
{
    if(!_productName)
    {
        _productName = [[UILabel alloc] init];
        
        _productName.textColor = [UIColor blackColor];
        
        _productName.backgroundColor = [UIColor clearColor];
        
        _productName.textAlignment = UITextAlignmentLeft;
        
        _productName.font = [UIFont systemFontOfSize:16];
        
        [self.backgroundImage addSubview:_productName];
    }
    
    return _productName;
}

//代码
- (UILabel*)invoiceCode
{
    if(!_invoiceCode)
    {
        _invoiceCode = [[UILabel alloc] init];
        
        _invoiceCode.textColor = [UIColor colorWithHexString:@"#707070"];
        
        _invoiceCode.backgroundColor = [UIColor clearColor];
        
        _invoiceCode.font = [UIFont systemFontOfSize:14];
        
        _invoiceCode.textAlignment = UITextAlignmentLeft;
        
        [self.backgroundImage addSubview:_invoiceCode];
    }
    
    return _invoiceCode;
}

//号码
- (UILabel*)invoiceNumber
{
    if(!_invoiceNumber)
    {
        _invoiceNumber = [[UILabel alloc] init];
        
        _invoiceNumber.textColor = [UIColor colorWithHexString:@"#707070"];
        
        _invoiceNumber.backgroundColor = [UIColor clearColor];
        
        _invoiceNumber.font = [UIFont systemFontOfSize:14];
        
        _invoiceNumber.textAlignment = UITextAlignmentLeft;
        
        [self.backgroundImage addSubview:_invoiceNumber];
    }
    
    return _invoiceNumber;
}

//打印密码
- (UILabel*)printPassword
{
    if(!_printPassword)
    {
        _printPassword = [[UILabel alloc] init];
        
        _printPassword.textColor = [UIColor colorWithHexString:@"#707070"];
        
        _printPassword.backgroundColor = [UIColor clearColor];
        
        _printPassword.font = [UIFont systemFontOfSize:14];
        
        _printPassword.textAlignment = UITextAlignmentLeft;
        
        [self.backgroundImage addSubview:_printPassword];
    }
    
    return _printPassword;
}

//发票内容
- (UILabel*)invoiceContent
{
    if(!_invoiceContent)
    {
        _invoiceContent = [[UILabel alloc] init];
        
        _invoiceContent.textColor = [UIColor colorWithHexString:@"#707070"];
        
        _invoiceContent.backgroundColor = [UIColor clearColor];
        
        _invoiceContent.font = [UIFont systemFontOfSize:14];
        
        _invoiceContent.textAlignment = UITextAlignmentLeft;
                
        [self.backgroundImage addSubview:_invoiceContent];
    }
    
    return _invoiceContent;
}

 - (UIImageView *)backgroundImage
{
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] init];
        _backgroundImage.image = [UIImage imageNamed:@"Electronic_Invoice_Cell_Background_Image.png"];
        [self.contentView addSubview:_backgroundImage];
    }
    return _backgroundImage;
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
        [self.backgroundImage addSubview:_line];
    }
    return _line;
}

@end