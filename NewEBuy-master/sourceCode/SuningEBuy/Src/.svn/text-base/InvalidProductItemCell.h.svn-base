//
//  InvalidProductItemCell.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNUITableViewCell.h"


#import "ShopCartV2DTO.h"

@protocol InvalidProductItemCellDelegate;

@interface InvalidProductItemCell : SNUITableViewCell

@property (nonatomic, weak)    id<InvalidProductItemCellDelegate>  delegate;

@property (nonatomic, retain)  EGOImageView     *productIconView;

@property (nonatomic, retain)  UILabel          *productNameLbl;

@property (nonatomic, retain)  UILabel          *productPriceLbl;

@property (nonatomic, retain)  UILabel          *productNumberLbl;

@property (nonatomic, retain)  UILabel          *errorDescLbl;
//勾选按钮
@property (nonatomic, retain) UIButton          *checkButton;

@property (nonatomic, retain) UIImageView       *specialMarkView;

@property (nonatomic,retain)   ShopCartV2DTO  *item;  // 商品属性

@property (nonatomic, retain) UILabel           *cityLabel;

@property (nonatomic, strong) UILabel           *editPriceLbl;
@property (nonatomic, strong) UILabel           *editNumLbl;

@property (nonatomic, retain) UIButton          *buyLaterButton;
@property (nonatomic, strong) UIButton          *trashButton;

+ (CGFloat)height:(ShopCartV2DTO *)item;

@end

@protocol InvalidProductItemCellDelegate <NSObject>

- (void)deleteItemWithCell:(InvalidProductItemCell *)cell;
- (void)removeToAddFavorite:(ShopCartV2DTO *)item;
- (void)reloadInvalidTableView;

@end
