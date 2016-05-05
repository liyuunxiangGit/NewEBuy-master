//
//  ElectronicInvoiceDetailCell.h
//  SuningEBuy
//
//  Created by Yang on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberOrderDetailsDTO.h"
@interface ElectronicInvoiceDetailCell : UITableViewCell

@property (nonatomic, strong) UILabel *invoiceNumber;             //电子发票号码
@property (nonatomic, strong) UILabel *printPassword;             //电子发票打印密码
@property (nonatomic, strong) UILabel *productName;                  //商品名
@property (nonatomic, strong) UILabel *invoiceCode;               //电子发票代码
@property (nonatomic, strong) UILabel *invoiceContent;            //电子发票内容;
@property (nonatomic, strong) UIImageView *backgroundImage;
@property (nonatomic, strong) UIImageView *line;
- (void)setElectronicInvoiceDetailCell:(MemberOrderDetailsDTO *)goodsDTO CShopList:(NSArray *)list row:(NSInteger)currentRow;

@end
