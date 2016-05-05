//
//  ReceiveInfoProductCell.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ReceiveInfoProductCell.h"
#import "ProductUtil.h"

#define defaultFont             [UIFont boldSystemFontOfSize:15.0]

@implementation ReceiveInfoProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)setShopCartDto:(ShopCartV2DTO *)shopCartDto
{
    _shopCartDto = shopCartDto;

    self.productImageView.frame = CGRectMake(15, 12, 54, 54);
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:shopCartDto.partNumber size:ProductImageSize160x160];
    }
    else{
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:shopCartDto.partNumber size:ProductImageSize100x100];
    }
    
    self.priceLabel.frame = CGRectMake(self.productImageView.right + 10, 47, 105, 20);
    self.priceLabel.text = [NSString stringWithFormat:@"￥%0.2f",[shopCartDto.itemPrice doubleValue]];
//    self.priceImageView.imageURL = [ProductUtil minPriceImageOfProductId:shopCartDto.catentryId
//                                                                    city:shopCartDto.cityCode];
//    self.priceImageView.frame = CGRectMake(self.priceLabel.right, 48, 100, 24);

    self.productName.text = _shopCartDto.productName;
    self.productName.frame = CGRectMake(self.productImageView.right + 10, 7, 220, 34);
    self.productNum.textColor = [UIColor grayColor];
    self.productNum.font = [UIFont boldSystemFontOfSize:13.0];
    self.productNum.textAlignment = NSTextAlignmentRight;
    self.productNum.text = [NSString stringWithFormat:@"%@：%@",L(@"Constant_Amount"),_shopCartDto.quantity];
    self.productNum.frame = CGRectMake(205 , 47, 100, 20);
    
}

- (void)setFee:(NSString *)fee withShopName:(NSString *)shopName
{
    self.productImageView.frame = CGRectMake(0, 0, 0, 0);
    self.priceLabel.text = @"";
    self.productName.text = shopName;
    self.productName.frame = CGRectMake(18, 7, 180, 34);
    self.productNum.textAlignment = NSTextAlignmentRight;
    self.productNum.textColor = [UIColor grayColor];
    self.productNum.font = [UIFont boldSystemFontOfSize:13.0];
    NSRange range = [fee rangeOfString:@"￥"];
    if (range.length >0)//包含
    {
        self.productNum.text = [NSString stringWithFormat:@"%@：%@",L(@"Freight"),fee];
        
    }
    else//不包含
    {
        self.productNum.text = [NSString stringWithFormat:@"%@：￥%0.2f",L(@"Freight"),[fee doubleValue]];
        
    }
    self.productNum.frame = CGRectMake(205, 5, 100, 34);
}

- (UILabel *)productName
{
    if (!_productName) {
        _productName = [[UILabel alloc] init];
        _productName.backgroundColor = [UIColor clearColor];
        _productName.text = L(@"PFCollectStephenKimAston");
        _productName.font = defaultFont;
        _productName.textColor = [UIColor light_Black_Color];
        [self.contentView addSubview:_productName];
    }
    return _productName;
}

- (EGOImageView *)productImageView
{
    if (!_productImageView) {
		_productImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 12, 54, 54)];
		_productImageView.backgroundColor =[UIColor whiteColor];
        _productImageView.contentMode = UIViewContentModeScaleAspectFill;
//        _productImageView.layer.cornerRadius = 5;
        _productImageView.layer.borderWidth = 0.5;
        _productImageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        _productImageView.layer.masksToBounds = YES;
        _productImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        [self.contentView addSubview:_productImageView];
	}
	return _productImageView;
}

- (UILabel *)productNum
{
    if (!_productNum) {
        _productNum = [[UILabel alloc] init];
        _productNum.backgroundColor = [UIColor clearColor];
        _productNum.text = [NSString stringWithFormat:@"%@：1",L(@"Constant_Amount")];
        _productNum.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_productNum];
    }
    return _productNum;
}


- (EGOImageView *)priceImageView
{
    if (!_priceImageView)
    {
		_priceImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(108, 46, 150, 14)];
		_priceImageView.backgroundColor = [UIColor clearColor];
        _priceImageView.contentMode = UIViewContentModeLeft;
        _priceImageView.placeholderImage = nil;
        _priceImageView.refreshCached = YES;
		[self.contentView addSubview:_priceImageView];
	}
	return _priceImageView;
}


- (UILabel *)priceLabel
{
    if (!_priceLabel) {
		UIFont *font = [UIFont boldSystemFontOfSize:14];
		_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(94, 48, 150, 14)];
		_priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.text = @"￥";
		_priceLabel.textColor = [UIColor orange_Red_Color];
		_priceLabel.font = font;
		_priceLabel.autoresizingMask = UIViewAutoresizingNone;
		[self.contentView addSubview:_priceLabel];
	}
    
	return _priceLabel;
}



@end
