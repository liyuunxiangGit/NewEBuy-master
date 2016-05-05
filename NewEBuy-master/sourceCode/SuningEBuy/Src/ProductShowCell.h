//
//  ProductShowCell.h
//  SuningEBuy
//
//  Created by blues on 13-10-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductImageCell.h"
#import "SellerListDTO.h"
#import "DataProductBasic.h"


@interface ProductShowCell : ProductImageCell<NJPageScrollViewDataSource,NJPageScrollViewDelegate>

@property (nonatomic, strong) EGOImageView *productImageView; //商品展示图片
@property (nonatomic, strong) UILabel     *productNameLbl;   //商品名称
@property (nonatomic, strong) UILabel     *productFeatureLbl;//商品卖点

@property (nonatomic, strong) UIImageView *backImgView;      //背景视图

@property (nonatomic, strong) UIImageView *sparetionImg;

- (void)setProductDetailCell:(DataProductBasic *)aItem;

@end
