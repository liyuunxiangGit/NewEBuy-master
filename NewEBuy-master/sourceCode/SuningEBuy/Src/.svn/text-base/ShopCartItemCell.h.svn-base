//
//  ShopCartItemCell.h
//  SuningEBuy
//
//  Created by  liukun on 13-5-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UITextField+LeftPadding.h"
#import "ShopCartV2DTO.h"
#import "ToolBarTextField.h"
#import "keyboardNumberPadReturnTextField.h"

@class ShopCartItemCell;
@protocol ShopCartItemCellDelegate <NSObject>


- (void)cartItemCell:(ShopCartItemCell *)cell modifyCheckOfItem:(ShopCartV2DTO *)item;

- (void)deleteItemAtCell:(ShopCartItemCell *)cell;
- (void)removeToFavorite:(ShopCartV2DTO *)item;

- (void)cartItemQuantityDidChange;
- (void)presentEditAlertTip;

@end

@interface ShopCartItemCell : SNUITableViewCell <UITextFieldDelegate, LeftPaddingTextFieldDelegate,ToolBarTextFieldDelegate,ToolBarTextFieldDelegate,UIGestureRecognizerDelegate>

@property (nonatomic, retain)  EGOImageView     *productIconView;

@property (nonatomic, retain)  UILabel          *productNameLbl;

@property (nonatomic, retain)  UILabel          *productPriceLbl;

@property (nonatomic, retain)  UILabel          *productNumberLbl;

@property (nonatomic, retain)  UILabel          *errorDescLbl;

@property (nonatomic, retain)  ToolBarTextField *productNumberFld;

@property (nonatomic, retain)  ToolBarTextField *numberTextFld;

@property (nonatomic,retain)   UILabel          *numberShowLbl;

@property (nonatomic,retain)   UIButton         *numberIncreaseBtn;

@property (nonatomic,retain)   UIButton         *numberDecreaseBtn;

@property (nonatomic,assign)   id<ShopCartItemCellDelegate> delegate;

@property (nonatomic, retain) UILabel           *cityLabel;

@property (nonatomic, retain) UILabel           *remaidLabel;

//勾选按钮
@property (nonatomic, retain) UIButton          *checkButton;

@property (nonatomic, retain) UIImageView       *specialMarkView;

@property (nonatomic,retain)   ShopCartV2DTO  *item;  // 商品属性

@property (nonatomic, retain) UIButton          *buyLaterButton;
@property (nonatomic, strong) UIButton          *trashButton;

@property (nonatomic, strong) UILabel           *editPriceLbl;
@property (nonatomic, strong) UILabel           *editNumLbl;

@property (nonatomic, retain)  UILabel          *productNumberLblForEditView;
@property (nonatomic,retain)   UILabel          *numberShowLblForEditView;

@property (nonatomic, strong)   UIImageView     *line;

@property (nonatomic, assign)  BOOL isAccessoryLastCell;

@property (nonatomic, strong) UIView            *swipeEditView;

+ (CGFloat)height:(ShopCartV2DTO *)item;

- (void)setShopItemInfo:(ShopCartV2DTO *)item hasExpands:(BOOL)hasExpands;

//设置配件套餐最后一行
- (void)setItem:(ShopCartV2DTO *)item isAccessoryLastCell:(BOOL)isLast DEPRECATED_ATTRIBUTE;


- (void)setLineDotted:(BOOL)isDottedLine;

@end
