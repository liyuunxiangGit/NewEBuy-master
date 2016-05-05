//
//  ProductPackageView.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"
#import "OHAttributedLabel.h"
#import "NSAttributedString+Attributes.h"


@protocol PackageProductCellDelegate;

@interface PackageProductCell : UITableViewCell

@property (nonatomic, weak) id<PackageProductCellDelegate> myDelegate;

@property (nonatomic, strong) UIButton  *checkButton;
@property (nonatomic, strong) UILabel   *nameLabel;
@property (nonatomic, strong) UILabel   *priceLabel;
@property (nonatomic, strong) DataProductBasic   *item;

@property (nonatomic, strong) EGOImageView    *productView;
@property (nonatomic, strong) UIImageView *backView;

@property (nonatomic, strong) UIView *suppImageView;

@property (nonatomic, strong) UIImageView *detailMark;

@property (nonatomic, strong) UIImageView *separationLineImg;


@end

@protocol PackageProductCellDelegate <NSObject>

- (void)reloadSuperTableView;

@end

/*********************************************************************/
@class ProductPackageView;
//@protocol ProductPackageViewDelegate <NSObject>
//
//@optional
//- (void)packageView:(ProductPackageView *)view didSelectProduct:(DataProductBasic *)product;
//- (void)seeMoreAccessoryPackageProduct;
//
//- (void)selectPocket;
//
//@end

@interface ProductPackageView : UITableViewCell <UITableViewDataSource, UITableViewDelegate>
{
    
}

//@property (nonatomic, unsafe_unretained) id<ProductPackageViewDelegate> delegate;

@property (nonatomic, strong) OHAttributedLabel *tipLabel;
@property (nonatomic, strong) OHAttributedLabel *discountLabel;
@property (nonatomic, strong) UITableView *subTableView;
@property (nonatomic, strong) DataProductBasic *item;
@property (nonatomic, strong) UILabel *titleLab;
@property(nonatomic,strong)UIImageView *separatorLine;
+ (CGFloat)height:(DataProductBasic *)item;
@end
