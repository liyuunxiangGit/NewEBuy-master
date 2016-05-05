//
//  ProductButtonHeaderView.h
//  SuningEBuy
//
//  Created by  on 12-9-13.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
#import "ProductCommandDelegate.h"
#import "OHAttributedLabel.h"

@interface ProductButtonHeaderView : UIView
{

}

@property (nonatomic, strong) UIButton *addShoppingCartButton;
@property (nonatomic, strong) UIButton *addFavoriteButton;
@property (nonatomic, strong) UIButton *easilyBuyButton;
@property (nonatomic, weak) id<ProductCommandDelegate> delegate;
@property (nonatomic, strong) UIImageView *seperaterView;

@property (nonatomic, strong) UIButton *goToQiangguoDetail;
@property (nonatomic, strong) OHAttributedLabel *priceLabel;

+ (CGFloat)height;


- (void)setEnable:(BOOL)isEnable;

//刘坤，12-10-31，分别可以设置一键购按钮，和加入购物车按钮的enable
- (void)setEasilyEnable:(BOOL)ee addShopCartEnable:(BOOL)ae withRushPrice:(NSNumber *)price;

@end
