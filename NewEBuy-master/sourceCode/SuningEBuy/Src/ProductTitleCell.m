//
//  ProductTitleCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-2-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ProductTitleCell.h"

@interface ProductTitleCell()


@end

////////////////////////////////////////////////////////////////////


@implementation ProductTitleCell

@synthesize productDetailDTO = _productDetailDTO;
@synthesize productNameLabel = _productNameLabel;
@synthesize productDescLabel = _productDescLabel;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_productDetailDTO);
    TTVIEW_RELEASE_SAFELY(_productNameLabel);
    TTVIEW_RELEASE_SAFELY(_productDescLabel);
    

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setItem:(DataProductBasic *)productDetail
{    
    if (_productDetailDTO != productDetail) {
        
        TT_RELEASE_SAFELY(_productDetailDTO);
              
        _productDetailDTO = productDetail;

        self.productDetailDTO = productDetail;
        
        self.productNameLabel.text = self.productDetailDTO.productName;

        self.productDescLabel.text = self.productDetailDTO.special;
        
        
        //小套餐商品不可点击
        if (productDetail.packageType == PackageTypeSmall) {
            self.accessoryType = UITableViewCellAccessoryNone;
        }else{
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
    
    [self.productDescLabel restartLabel];
    
    [self setNeedsLayout];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGSize nameSize = [self.productDetailDTO.productName sizeWithFont:[UIFont boldSystemFontOfSize:15.0] constrainedToSize:CGSizeMake(290, 200) lineBreakMode:UILineBreakModeCharacterWrap];
    
    self.productNameLabel.frame = CGRectMake(13, 5, 290, nameSize.height);
    
    //CGSize descSize = [self.productDetailDTO.special sizeWithFont:[UIFont boldSystemFontOfSize:12.0] constrainedToSize:CGSizeMake(280, 200) lineBreakMode:UILineBreakModeCharacterWrap];
    
    self.productDescLabel.frame = CGRectMake(13, self.productNameLabel.bottom+5, 280, 15);
}

+ (CGFloat)height:(DataProductBasic *)productDetail
{
    
    if (productDetail == nil)
    {
        return 0.0;
    }
    
    CGSize nameSize = [productDetail.productName sizeWithFont:[UIFont boldSystemFontOfSize:15.0] constrainedToSize:CGSizeMake(290, 200) lineBreakMode:UILineBreakModeCharacterWrap];
        
    return nameSize.height + 15 + 20;
}

- (UILabel *)productNameLabel
{
    if (!_productNameLabel)
    {
        _productNameLabel = [[UILabel alloc] init];
        
        _productNameLabel.backgroundColor = [UIColor clearColor];
        
        _productNameLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        _productNameLabel.numberOfLines = 0;
        
        [self.contentView addSubview:_productNameLabel];
    }
    return _productNameLabel;
}

- (MarqueeLabel *)productDescLabel
{
    if (!_productDescLabel)
    {
        _productDescLabel = [[MarqueeLabel alloc]
                             initWithFrame:CGRectMake(13, 30, 280, 15)
                             rate:80.0f
                             andFadeLength:5.0f];
        _productDescLabel.tag = 102;
        _productDescLabel.marqueeType = MLContinuous;
        _productDescLabel.numberOfLines = 1;
        _productDescLabel.opaque = NO;
        _productDescLabel.textAlignment = UITextAlignmentLeft;
        _productDescLabel.textColor = RGBCOLOR(111, 111, 111);
        _productDescLabel.backgroundColor = [UIColor clearColor];
        _productDescLabel.font = [UIFont boldSystemFontOfSize:12.0];
        _productDescLabel.animationCurve = UIViewAnimationOptionCurveLinear;

        [self.contentView addSubview:_productDescLabel];
    }
    return _productDescLabel;
}


@end
