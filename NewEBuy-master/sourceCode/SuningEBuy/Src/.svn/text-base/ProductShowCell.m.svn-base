//
//  ProductShowCell.m
//  SuningEBuy
//
//  Created by blues on 13-10-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductShowCell.h"
#import "NSAttributedString+Attributes.h"

@implementation ProductShowCell

//- (UIImageView *)backImgView
//{
//    if (!_backImgView)
//    {
//        _backImgView = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"new_home_guanggao_background.png"]];
//        _backImgView.frame = CGRectMake(10, 10, 301, 164);
//    }
//    return _backImgView;
//}

- (EGOImageView *)productImageView
{
    if (!_productImageView)
    {
        _productImageView = [[EGOImageView alloc] init];
        _productImageView.frame = CGRectMake(5, 5, 100, 100);
        _productImageView.backgroundColor = [UIColor clearColor];
//        [_productImageView.layer setCornerRadius:8];
//        [_productImageView.layer setBorderWidth:1];
    }
    return _productImageView;
}

- (UILabel *)productNameLbl
{
    if (!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] init];
        _productNameLbl.textColor = [UIColor blackColor];
        _productNameLbl.backgroundColor = [UIColor clearColor];
    }
    return _productNameLbl;
}

- (UILabel *)productFeatureLbl
{
    if (!_productFeatureLbl) {
        _productFeatureLbl = [[UILabel alloc] init];
        _productFeatureLbl.textColor = RGBCOLOR(96, 96, 96);
        _productFeatureLbl.backgroundColor = [UIColor clearColor];
    }
    return _productFeatureLbl;
}

- (UIImageView *)sparetionImg
{
    if (!_sparetionImg) {
        _sparetionImg = [[UIImageView alloc] init];
        _sparetionImg.frame = CGRectMake(0, 129, 320, 0.5);
        _sparetionImg.backgroundColor = [UIColor clearColor];
        _sparetionImg.image = [UIImage imageNamed:@"line.png"];
    }
    return _sparetionImg;
}

- (void)setProductDetailCell:(DataProductBasic *)aItem
{
//    [self addSubview:self.backImgView];
    [self.contentView addSubview:self.productImageView];
    [self.contentView addSubview:self.productNameLbl];
    [self.contentView addSubview:self.productFeatureLbl];
    [self.contentView addSubview:self.sparetionImg];
    
    
    NSString * productName = aItem.productName;
    CGSize nameSize = [productName sizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:CGSizeMake(195, 60) lineBreakMode:NSLineBreakByCharWrapping];
    self.productNameLbl.frame = CGRectMake(115, 20, 195, nameSize.height);
    self.productNameLbl.text = productName;
    self.productNameLbl.numberOfLines = 0;
    self.productNameLbl.font = [UIFont systemFontOfSize:16];
    
    CGFloat maxHeight = [UIFont systemFontOfSize:14].lineHeight * 2;
    NSString * productFeature = aItem.productFeature;
    CGSize featureSize = [productFeature sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(195, maxHeight) lineBreakMode:NSLineBreakByCharWrapping];
    self.productFeatureLbl.frame = CGRectMake(115, self.productNameLbl.bottom + 5, 195
                                              , featureSize.height);
    self.productFeatureLbl.text = productFeature;
//    self.productFeatureLbl.lineBreakMode = NSLineBreakByCharWrapping;
    self.productFeatureLbl.numberOfLines = 0;
    self.productFeatureLbl.font = [UIFont systemFontOfSize:14];
    
    
    NSArray *smallImages = nil;
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        //清晰
        
        smallImages = [ProductUtil getImageUrlListWithProduct:aItem size:ProductImageSize400x400];
    }
    else{
        //一般
        
        smallImages = [ProductUtil getImageUrlListWithProduct:aItem size:ProductImageSize200x200];
        
    }
    self.smallImageUrls = smallImages;
    self.productImageView.imageURL = [self.smallImageUrls objectAtIndex:0];
}

@end








