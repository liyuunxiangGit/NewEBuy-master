//
//  SellerDetailInfoCell.m
//  SuningEBuy
//
//  Created by xmy on 14/10/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "SellerDetailInfoCell.h"

@implementation SellerDetailInfoCell

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

- (UILabel*)sellerNameLbl
{
    if(!_sellerNameLbl)
    {
        _sellerNameLbl = [[UILabel alloc] init];
        
        _sellerNameLbl.frame = CGRectMake(15, 13, 200, 15);
        
        _sellerNameLbl.font = [UIFont systemFontOfSize:15];
        
        _sellerNameLbl.textColor = [UIColor blackColor];
        
        _sellerNameLbl.backgroundColor = [UIColor clearColor];
        
    }
    
    return _sellerNameLbl;
}

- (UIImageView*)starImageV
{
    if(!_starImageV)
    {
        _starImageV = [[UIImageView alloc] init];
        
        _starImageV.backgroundColor = [UIColor clearColor];
        
    }
    
    return _starImageV;
}

- (UILabel*)priceLbl
{
    if(!_priceLbl)
    {
        _priceLbl = [[UILabel alloc] init];
        
        _priceLbl.frame = CGRectMake(15, self.sellerNameLbl.bottom + 16, 83, 20);
        
        _priceLbl.textColor = [UIColor colorWithRGBHex:0xff4800];
        
        _priceLbl.font = [UIFont systemFontOfSize:18];
        
        _priceLbl.backgroundColor = [UIColor clearColor];
        
    }
    
    return _priceLbl;
}

- (UILabel *)priceIconLabel
{
    if (!_priceIconLabel) {
        _priceIconLabel = [[UILabel alloc] init];
        
        _priceIconLabel.frame = CGRectMake(15, self.sellerNameLbl.bottom + 16, 5, 15);
        
        _priceIconLabel.text = @"￥";
        
        _priceIconLabel.textColor = [UIColor colorWithRGBHex:0xff4800];
        
        _priceIconLabel.font = [UIFont systemFontOfSize:15];
        
        _priceIconLabel.backgroundColor = [UIColor clearColor];
    }
    return _priceIconLabel;
}

- (UIImageView*)giftImageV
{
    if(!_giftImageV)
    {
        _giftImageV = [[UIImageView alloc] init];
        
        _giftImageV.backgroundColor = [UIColor clearColor];
        
        _giftImageV.frame = CGRectMake(self.priceLbl.right, self.priceLbl.origin.y - 5, 22, 22);
        
    }
    
    return _giftImageV;
}

- (UILabel*)shippingLbl
{
    if(!_shippingLbl)
    {
        _shippingLbl = [[UILabel alloc] init];
        
        //_shippingLbl.frame = CGRectMake(10, self.priceLbl.bottom + 10, 152, 12);
        
        _shippingLbl.font = [UIFont systemFontOfSize:13];
        
        _shippingLbl.textColor = [UIColor colorWithRed:0X44/255.0
                                                 green:0X44/255.0
                                                  blue:0X44/255.0
                                                 alpha:1.0f];
        
        _shippingLbl.backgroundColor = [UIColor clearColor];
    }
    
    return _shippingLbl;
}

- (MarqueeLabel *)marqueeLabel
{
    if (!_marqueeLabel)
    {
        _marqueeLabel = [[MarqueeLabel alloc]
                         initWithFrame:CGRectMake(12, self.shippingLbl.bottom + 7, 261, 20)
                         rate:70.0f
                         andFadeLength:5.0f];
        _marqueeLabel.tag = 102;
        _marqueeLabel.marqueeType = MLContinuous;
        _marqueeLabel.numberOfLines = 1;
        _marqueeLabel.opaque = NO;
        _marqueeLabel.textAlignment = UITextAlignmentLeft;
        _marqueeLabel.textColor = [UIColor colorWithRGBHex:0x444444];
        _marqueeLabel.backgroundColor = [UIColor clearColor];
        _marqueeLabel.font = [UIFont boldSystemFontOfSize:12.0];
        _marqueeLabel.animationCurve = UIViewAnimationOptionCurveLinear;
        
//        [self.backImageV addSubview:_marqueeLabel];
    }
    return _marqueeLabel;
}


//- (UILabel*)shippingFeeLbl
//{
//    if(!_shippingFeeLbl)
//    {
//        _shippingFeeLbl = [[UILabel alloc] init];
//
//        _shippingFeeLbl.frame = CGRectMake(self.shippingLbl.right, self.shippingLbl.origin.y, 100, 12);
//
//        _shippingFeeLbl.font = [UIFont systemFontOfSize:12];
//
//        _shippingFeeLbl.backgroundColor = [UIColor clearColor];
//
//    }
//
//    return _shippingFeeLbl;
//}

//- (UIScrollView *)scrollView
//{
//    if (!_scrollView)
//    {
//        _scrollView = [[UIScrollView alloc] init];
//        _scrollView.showsHorizontalScrollIndicator = NO;
//        _scrollView.showsVerticalScrollIndicator = NO;
//        _scrollView.scrollEnabled = YES;
//        _scrollView.backgroundColor = [UIColor clearColor];
//    }
//    return _scrollView;
//}
//
//- (UILabel*)deliveryLbl
//{
//    if(!_deliveryLbl)
//    {
//        _deliveryLbl = [[UILabel alloc] init];
//
//        _deliveryLbl.font = [UIFont systemFontOfSize:12];
//
//        _deliveryLbl.textColor = [UIColor colorWithRed:0X44/255.0
//                                                 green:0X44/255.0
//                                                  blue:0X44/255.0
//                                                 alpha:1.0f];
//
//        _deliveryLbl.backgroundColor = [UIColor clearColor];
//
//    }
//
//    return _deliveryLbl;
//}

//-(UIImageView *)backImageV
//{
//    if (!_backImageV) {
//        
//        _backImageV = [[UIImageView alloc] init];
//        
//        _backImageV.image = [UIImage streImageNamed:@"yellowbackground.png"];
//        _backImageV.frame = CGRectMake(10, 0, 301, 88);
//        
//    }
//    
//    return _backImageV;
//}

- (void)setSellerDetailCell:(SellerListDTO *)aItem andCell:(DataProductBasic *)secondItem
{
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.sellerNameLbl.text = aItem.shopName;
    
    CGFloat grade = [aItem.shopGrade floatValue];
    
    [self starImageViewSet:grade];
    
    self.contentView.frame = CGRectMake(0, 0, 320, 75);
    
    if ([aItem.productPrice doubleValue] > 0)
    {
        self.priceLbl.text = [NSString stringWithFormat:@"%@",aItem.productPrice];
    }
    else
    {
        self.priceLbl.text = L(@"Product_NotSaleNow");
    }
    self.priceIconLabel.frame = CGRectMake(15, self.sellerNameLbl.bottom + 15, 12, 15);
    self.priceLbl.frame = CGRectMake(28, self.sellerNameLbl.bottom + 12, 83, 20);
    
    
    CGFloat fareValue = [aItem.fare doubleValue];
    if (fareValue > 0) {
        NSString *strOne = [NSString stringWithFormat:@"+%@：￥%.2f",L(@"Product_DeliveryMoney"), fareValue];
        CGSize strOneSize = [strOne sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(150, 100) lineBreakMode:NSLineBreakByCharWrapping];
        self.shippingLbl.frame = CGRectMake(320-15-strOneSize.width, self.priceLbl.origin.y - 2, strOneSize.width, 20);
        
        self.shippingLbl.text = strOne;
    }
    else if (IsStrEmpty(aItem.fare))
    {
        self.shippingLbl.text = @"";
    }
    else {
        NSString *strTwo = L(@"Product_NoDeliveryMoney");
        CGSize strTwoSize = [strTwo sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(150, 100) lineBreakMode:NSLineBreakByWordWrapping];
        self.shippingLbl.frame = CGRectMake(320-15-strTwoSize.width, self.priceLbl.origin.y - 2, strTwoSize.width, 20);
        self.shippingLbl.text = strTwo;
    }
    
    
    //    int a = [aItem.sellerSpeed intValue];
    //
    //    NSString *deliveryStr = [NSString stringWithFormat:@"预计%d天送达", a];
    //
    //    CGSize strSize = [deliveryStr sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(150, 100) lineBreakMode:NSLineBreakByCharWrapping];
    //
    //    self.deliveryLbl.frame = CGRectMake(12, self.shippingLbl.bottom + 10, strSize.width, 12);
    //
    //    self.deliveryLbl.text = [NSString stringWithFormat:@"预计%d天送达", a];
    
    //CGSize size = [title  sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(1000, 13) lineBreakMode:NSLineBreakByWordWrapping];
    
    //    self.marqueeLabel = [[MarqueeLabel alloc] initWithFrame:CGRectMake(12, self.shippingLbl.bottom + 7, 261, 20) rate:30.0f andFadeLength:10.0f];
    //    self.marqueeLabel.numberOfLines = 1;
    //    self.marqueeLabel.opaque = NO;
    //    self.marqueeLabel.enabled = YES;
    //    self.marqueeLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    //    self.marqueeLabel.textAlignment = UITextAlignmentLeft;
    //    self.marqueeLabel.textColor = [UIColor colorWithRed:0X44/255.0
    //                                                  green:0X44/255.0
    //                                                   blue:0X44/255.0
    //                                                  alpha:1.000];
    //    self.marqueeLabel.backgroundColor = [UIColor clearColor];
    //    self.marqueeLabel.font = [UIFont systemFontOfSize:12];
    
    //    [self.backImageV addSubview:self.marqueeLabel];
    
    
    
    
    
    //    self.scrollView.frame = CGRectMake(12, self.shippingLbl.bottom + 10, 261, 100);
    //
    //    self.deliveryLbl.text = aItem.inventoryInfo;
    //    self.deliveryLbl.frame = CGRectMake(0, 0, size.width, 12);
    //
    //    self.scrollView.contentSize = CGSizeMake(1000, 13);
    //
    //    [self.backImageV addSubview:self.scrollView];
    //    [self.scrollView addSubview:self.deliveryLbl];
    
//    [self.contentView addSubview:self.backImageV];
    [self.contentView addSubview:self.sellerNameLbl];
    [self.contentView addSubview:self.priceIconLabel];
    [self.contentView addSubview:self.priceLbl];
    [self.contentView addSubview:self.shippingLbl];
    //[self.backImageV addSubview:self.shippingFeeLbl];
    
//    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_arrow.png"]];
//    arrowView.frame = CGRectMake(283, 35, 9, 15);
//    arrowView.backgroundColor = [UIColor clearColor];
//    [self.backImageV addSubview:arrowView];
    
//    UIImageView *lineView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fengexian.png"]];
//    lineView.frame = CGRectMake(10, 34, 264, 2);
//    lineView.backgroundColor = [UIColor clearColor];
//    [self.backImageV addSubview:lineView];
    
    //    [self.backImageV addSubview:self.giftImageV];
    
//    self.marqueeLabel.text = aItem.inventoryInfo;
//    [self.marqueeLabel restartLabel];
    
    //    NSInteger sCode = [aItem.shopCode integerValue];
    //    if (sCode == 0)
    //    {
    //        NSInteger gFlag = [secondItem.qianggouFlag integerValue];
    //        if (gFlag == 1)
    //        {
    //            [self.giftImageV setImage:[UIImage imageNamed:@"iphone_qiang.png"]];
    //            self.priceLbl.text = [NSString stringWithFormat:@"￥%@",secondItem.qianggouPrice];
    //        }
    //    }
}

- (void)starImageViewSet:(CGFloat)starNum
{
    float fStar = floorf(starNum);
    float decimalStar = starNum - fStar;
    
    for(int i = 0; i < 5; i++)
    {
        UIImageView *starImageV = [[UIImageView alloc] init];
        starImageV.backgroundColor = [UIColor clearColor];
        starImageV.frame = CGRectMake(self.sellerNameLbl.right + (i + 1)*15, 13, 13, 13);
        
        if (i < fStar)
        {
            [starImageV setImage:[UIImage imageNamed:@"orange_star.png"]];
        }
        else if (i == fStar)
        {
            if (decimalStar < 0.2)
            {
                [starImageV setImage:[UIImage imageNamed:@"gray_star.png"]];
            }
            else if (decimalStar >= 0.2 && decimalStar <= 0.7)
            {
                [starImageV setImage:[UIImage imageNamed:@"half_star.png"]];
            }
            else
            {
                [starImageV setImage:[UIImage imageNamed:@"orange_star.png"]];
            }
        }
        else
        {
            [starImageV setImage:[UIImage imageNamed:@"gray_star.png"]];
        }
        
        [self.contentView addSubview:starImageV];
    }
}

@end
