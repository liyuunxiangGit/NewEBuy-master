//
//  ShopCartShopHeaderView.h
//  SuningEBuy
//
//  Created by  liukun on 13-10-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShopCartShopDTO.h"
#import "CommonView.h"

@class ShopCartShopHeaderView;
@protocol ShopCartShopHeaderViewDelegate <NSObject>

@required
- (void)shopHeaderView:(ShopCartShopHeaderView *)headerView selectAllTapped:(ShopCartShopDTO *)shop;
- (void)shopHeaderView:(ShopCartShopHeaderView *)headerView editItemsInShop:(ShopCartShopDTO *)shop;

- (void)cartItemQuantityDidChange;

- (void)goToCShop:(NSString *)shopCode;

@end

#define k_ShopCartShopHeaderView_Height     40

@interface ShopCartShopHeaderView : CommonView

@property (nonatomic, retain) UIButton         *checkButton;
@property (nonatomic, retain) UILabel          *shopNameLabel;
@property (nonatomic, retain) UILabel          *shopShipPriceLabel;
@property (nonatomic, retain) UILabel          *dicountLabel;
@property (nonatomic, retain) UIButton         *editButton;
@property (nonatomic, retain) UIButton         *goToShopBtn;


@property (nonatomic, strong) ShopCartShopDTO *shopDTO;
@property (nonatomic, weak) id<ShopCartShopHeaderViewDelegate> delegate;

- (void)setHeadViewInfo:(ShopCartShopDTO *)shopDTO withIsExpand:(BOOL)isExpand isSelectNow:(BOOL)isSelectNow;
+ (CGFloat)height;

@end
