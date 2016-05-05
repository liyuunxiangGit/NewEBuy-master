//
//  ReceiveZiyingInfoCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReceiveZiyingInfoCell.h"
#import "ShopCartV2DTO.h"
#import "ProductUtil.h"

#define kImageWidth     54
#define kImageTop       12

@implementation ReceiveZiyingInfoCell

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

- (void)setProductList:(NSArray *)list
{
    ShopCartV2DTO *dto1 = [list objectAtIndex:0];
    ShopCartV2DTO *dto2 = [list objectAtIndex:1];
    
    if (list.count >= 2) {
        if (list.count == 2) {
            self.product2ImageView.hidden = YES;
            self.product3ImageView.frame = CGRectMake(self.product1ImageView.right + 10, kImageTop, kImageWidth, kImageWidth);
            
            if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
                self.product1ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto1.partNumber size:ProductImageSize160x160];
                self.product3ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto2.partNumber size:ProductImageSize160x160];
            }
            else{
                self.product1ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto1.partNumber size:ProductImageSize100x100];
                self.product3ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto2.partNumber size:ProductImageSize100x100];
            }
        }
        else
        {
            ShopCartV2DTO *dto3 = [list objectAtIndex:2];
            self.product2ImageView.hidden = NO;
            self.product3ImageView.frame = CGRectMake(self.product2ImageView.right + 10, kImageTop, kImageWidth, kImageWidth);
            
            if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
                self.product1ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto1.partNumber size:ProductImageSize160x160];
                self.product2ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto2.partNumber size:ProductImageSize160x160];
                self.product3ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto3.partNumber size:ProductImageSize160x160];
            }
            else{
                self.product1ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto1.partNumber size:ProductImageSize100x100];
                self.product2ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto1.partNumber size:ProductImageSize100x100];
                self.product3ImageView.imageURL = [ProductUtil getImageUrlWithProductCode:dto3.partNumber size:ProductImageSize100x100];
            }
        }
    }
    self.fadsImg.frame = CGRectMake(self.product3ImageView.right + 4, kImageTop + 25, 22, 4);
    self.totalNumLbl.frame = CGRectMake(self.fadsImg.right + 4, self.fadsImg.top - 8, 70, 20);
    self.numLbl.text = [NSString stringWithFormat:@"%d件",[list count]];
    self.totalNumLbl.text = [NSString stringWithFormat:@"共%d件商品",[list count]];
    
}

- (EGOImageView *)product1ImageView
{
    if (!_product1ImageView) {
        _product1ImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(15, kImageTop, kImageWidth, kImageWidth)];
        _product1ImageView.backgroundColor =[UIColor whiteColor];
        _product1ImageView.contentMode = UIViewContentModeScaleAspectFill;
        _product1ImageView.layer.borderWidth = 0.5;
        _product1ImageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        _product1ImageView.layer.masksToBounds = YES;
        _product1ImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        [self.contentView addSubview:_product1ImageView];
    }
    return _product1ImageView;
}

- (EGOImageView *)product2ImageView
{
    if (!_product2ImageView) {
        _product2ImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(self.product1ImageView.right + 10, kImageTop, kImageWidth, kImageWidth)];
        _product2ImageView.backgroundColor =[UIColor whiteColor];
        _product2ImageView.contentMode = UIViewContentModeScaleAspectFill;
        _product2ImageView.layer.borderWidth = 0.5;
        _product2ImageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        _product2ImageView.layer.masksToBounds = YES;
        _product2ImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        _product2ImageView.hidden = YES;
        [self.contentView addSubview:_product2ImageView];
    }
    return _product2ImageView;
}

- (EGOImageView *)product3ImageView
{
    if (!_product3ImageView) {
        _product3ImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 12, 54, 54)];
        _product3ImageView.backgroundColor =[UIColor whiteColor];
        _product3ImageView.contentMode = UIViewContentModeScaleAspectFill;
        _product3ImageView.layer.borderWidth = 0.5;
        _product3ImageView.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        _product3ImageView.layer.masksToBounds = YES;
        _product3ImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        [_product3ImageView addSubview:self.numLbl];
        [self.contentView addSubview:_product3ImageView];
    }
    return _product3ImageView;
}

- (UILabel *)numLbl
{
    if (!_numLbl) {
        _numLbl = [[UILabel alloc] initWithFrame:CGRectMake(29, 39, 25, 15)];
        _numLbl.backgroundColor = RGBCOLOR(255, 72, 0);
        _numLbl.textColor = [UIColor whiteColor];
        _numLbl.textAlignment = NSTextAlignmentCenter;
        _numLbl.font = [UIFont systemFontOfSize:12];
        _numLbl.adjustsFontSizeToFitWidth = YES;
    }
    return _numLbl;
}

- (UIImageView *)fadsImg
{
    if (!_fadsImg) {
        _fadsImg = [[UIImageView alloc] init];
        _fadsImg.backgroundColor = [UIColor clearColor];
        _fadsImg.image = [UIImage imageNamed:@"ShopCart_shenglve.png"];
        [self.contentView addSubview:_fadsImg];
    }
    return _fadsImg;
}

- (UILabel *)totalNumLbl
{
    if (!_totalNumLbl) {
        _totalNumLbl = [[UILabel alloc] init];
        _totalNumLbl.backgroundColor = [UIColor clearColor];
        _totalNumLbl.textAlignment = NSTextAlignmentLeft;
        _totalNumLbl.font = [UIFont systemFontOfSize:14];
        _totalNumLbl.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_totalNumLbl];
    }
    return _totalNumLbl;
}

@end
