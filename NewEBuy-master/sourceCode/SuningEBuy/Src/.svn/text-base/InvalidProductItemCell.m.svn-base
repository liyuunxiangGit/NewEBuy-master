//
//  InvalidProductItemCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-5-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InvalidProductItemCell.h"
#import "AddressInfoDAO.h"
#import "ProductUtil.h"

@implementation InvalidProductItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc
{
    [_item removeObserver:self forKeyPath:@"editing"];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backgroundColor = [UIColor cellBackViewColor];
        
		self.autoresizesSubviews = YES;
        
        self.shouldIndentWhileEditing = NO;
        
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
    }
    return self;
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    self.item.editing = !self.editing;
    [self setEditing:!self.editing animated:YES];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置编辑状态
    
        if (self.item.editing != self.isEditing)
        {
            [self setEditing:self.item.editing animated:NO];
        }
    
    
}

#pragma mark -
#pragma mark 设置编辑视图

- (void)setEditView
{
    UIView *editView = [UIControl new];
    editView.backgroundColor = [UIColor clearColor];
    if (self.item.errorDesc.length)
    {
        editView.frame = CGRectMake(0, 0, 210, 98);
    }
    else
    {
        editView.frame = CGRectMake(0, 0, 210, 78);
    }
    
    UIView *coverView = [UIView new];
    coverView.frame = CGRectMake(0, 0, 210, 68);
    coverView.backgroundColor = [UIColor cellBackViewColor];
    [editView addSubview:coverView];

    self.editPriceLbl.text = [self.item.itemPrice formatPriceString];
    self.editPriceLbl.frame = CGRectMake(7, 10, 75, 20);
    [editView addSubview:self.editPriceLbl];
    
    self.editNumLbl.text = [NSString stringWithFormat:@"x%@",STR_FROM_INT([self.item.quantity integerValue])];
    self.editNumLbl.frame = CGRectMake(10, 45, 50, 20);
    [editView addSubview:self.editNumLbl];
    
    self.buyLaterButton.frame = CGRectMake(77, 30, 70, 44);
    [editView addSubview:self.buyLaterButton];

    self.trashButton.frame = CGRectMake(self.buyLaterButton.right + 5, 30, 44, 44);
    [editView addSubview:self.trashButton];
    
    self.editingAccessoryView = editView;
    
}

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(-20, 0, 90, 80);
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                      forState:UIControlStateSelected];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_unselect.png"]
                      forState:UIControlStateNormal];
        [_checkButton addTarget:self
                         action:@selector(modifyChecked)
               forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_checkButton];
    }
    return _checkButton;
}

- (EGOImageView *)productIconView
{
    if (!_productIconView)
    {
        _productIconView = [[EGOImageView alloc] initWithFrame:CGRectMake(50, 11, 58, 58)];
        
		_productIconView.backgroundColor =[UIColor clearColor];
        
        _productIconView.contentMode = UIViewContentModeScaleAspectFill;
        
        _productIconView.layer.borderWidth = 0.5;
        
        _productIconView.layer.masksToBounds = YES;
        
        _productIconView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    
    return _productIconView;
}


- (UILabel *)productNameLbl
{
    if (!_productNameLbl)
    {
		_productNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 8, 220, 40)];
        
		_productNameLbl.backgroundColor = [UIColor clearColor];
        
        _productNameLbl.font = [UIFont systemFontOfSize:14];
        _productNameLbl.textColor = [UIColor darkTextColor];
        _productNameLbl.shadowOffset = CGSizeMake(1, 1);
        _productNameLbl.shadowColor = [UIColor whiteColor];
        
        _productNameLbl.numberOfLines = 2;
        _productNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
        
		[self.contentView addSubview:_productNameLbl];
    }
    
    return _productNameLbl;
}

// 价格
- (UILabel *)productPriceLbl
{
    if (!_productPriceLbl)
    {
        _productPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(180, 44, 115, 27)];
		
		_productPriceLbl.backgroundColor = [UIColor clearColor];
        
        _productPriceLbl.textAlignment = UITextAlignmentRight;
        
		_productPriceLbl.font = [UIFont systemFontOfSize:14];
        
        _productPriceLbl.textColor = [UIColor orange_Red_Color];
        
        _productPriceLbl.adjustsFontSizeToFitWidth = YES;
        
        _productPriceLbl.shadowColor = [UIColor whiteColor];
        _productPriceLbl.shadowOffset = CGSizeMake(1, 1);
		
		[self.contentView addSubview:_productPriceLbl];
    }
    
    return _productPriceLbl;
}

- (UILabel *)errorDescLbl
{
    if (!_errorDescLbl)
    {
        _errorDescLbl = [[UILabel alloc] initWithFrame:CGRectMake(40, 75, 115, 20)];
		
		_errorDescLbl.backgroundColor = [UIColor clearColor];
        
        _errorDescLbl.textAlignment = UITextAlignmentLeft;
        
		_errorDescLbl.font = [UIFont systemFontOfSize:14];
        
        _errorDescLbl.textColor = [UIColor orange_Red_Color];
        
		[self.contentView addSubview:_errorDescLbl];
    }
    
    return _errorDescLbl;
}

// 数量标题
- (UILabel *)productNumberLbl
{
    if (!_productNumberLbl)
    {
        _productNumberLbl = [[UILabel alloc] initWithFrame:CGRectMake(80, 47.5, 40, 27)];
		
		_productNumberLbl.backgroundColor = [UIColor clearColor];
        
        _productNumberLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        _productNumberLbl.text = L(@"Number:");
		_productNumberLbl.font = [UIFont systemFontOfSize:14];
        
        _productNumberLbl.textAlignment = UITextAlignmentRight;
    }
    
    return _productNumberLbl;
}

- (UIImageView *)specialMarkView
{
    if (!_specialMarkView)
    {
        _specialMarkView = [[UIImageView alloc] init];
        _specialMarkView.frame =
        CGRectMake(self.productIconView.left, self.productIconView.top, 24, 24);
    }
    return _specialMarkView;
}

- (void)setItem:(ShopCartV2DTO *)item
{
    if (item != _item) {
        
        if (_item) {
            [_item removeObserver:self forKeyPath:@"editing"];
        }
        _item = item;
        [_item addObserver:self
                forKeyPath:@"editing"
                   options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                   context:NULL];
    }
    
//    self.isAccessoryLastCell = NO;
    
    switch (item.packageType)
    {
        case PackageTypeNormal:
        {
            [self.contentView addSubview:self.checkButton];
            [self isItemChecked:_item];
            
            [self.contentView addSubview:self.productIconView];
            [self setIconImageURL];
            
            [self.contentView addSubview:self.productNameLbl];
            self.productNameLbl.frame = CGRectMake(115, 10, 305-115, [self nameLabelHeightWithWidth:305-115]);
            self.productNameLbl.numberOfLines = 2;
            self.productNameLbl.text = _item.productName;
            
            [self.contentView addSubview:self.productPriceLbl];
            self.productPriceLbl.frame = CGRectMake(115, 50, 90, 20);
            self.productPriceLbl.textAlignment = UITextAlignmentLeft;
            self.productPriceLbl.text = [self.item.itemPrice formatPriceString];
            if ([self.item.itemPrice floatValue] <= 0) {
                self.productPriceLbl.hidden = YES;
            }
            else
                self.productPriceLbl.hidden = NO;
            
            
            [self.contentView addSubview:self.productNumberLbl];
            self.productNumberLbl.frame = CGRectMake(305-90, 50, 90, 20);
            self.productNumberLbl.text = [NSString stringWithFormat:@"%@:%@ ",L(@"Constant_Amount"),item.quantity];
            
            if (_item.errorDesc.length)
            {
                self.errorDescLbl.text = _item.errorDesc;
                self.errorDescLbl.left = self.productPriceLbl.left;
                self.errorDescLbl.width = 310 - self.errorDescLbl.left;
            }
            else
            {
                TTVIEW_RELEASE_SAFELY(_errorDescLbl);
            }

            
            //设置促销标签
            if (item.special == ShopCartSpecialRush)
            {
                self.specialMarkView.image = [UIImage imageNamed:@"productDetail_headQiangGou.png"];
                [self.contentView addSubview:self.specialMarkView];
            }
            else if (item.special == ShopCartSpecialSimpleGroup)
            {
                self.specialMarkView.image = [UIImage imageNamed:@"productDetail_headTuanGou.png"];
                [self.contentView addSubview:self.specialMarkView];
            }
            else if (item.special == ShopCartSpecialMarket)
            {
                self.specialMarkView.image = [UIImage imageNamed:@"shopcart_bazaar.png"];
                [self.contentView addSubview:self.specialMarkView];
            }
            else
            {
                TTVIEW_RELEASE_SAFELY(_specialMarkView);
            }
            
            
            break;
        }
        case PackageTypeAccessory:
        {
            if (!item.isInnerProduct)
            {
                [self.contentView addSubview:self.checkButton];
                [self isItemChecked:_item];
            }
            else
            {
                [self.checkButton removeFromSuperview];
            }
            
            [self.contentView addSubview:self.productIconView];
            [self setIconImageURL];
            [self.contentView addSubview:self.productNameLbl];
            self.productNameLbl.numberOfLines = 2;
            self.productNameLbl.frame = CGRectMake(115, 10, 305-115, [self nameLabelHeightWithWidth:305-115]);
            self.productNameLbl.text = _item.productName;
            
            [self.contentView addSubview:self.productPriceLbl];
            self.productPriceLbl.frame = CGRectMake(115, 50, 90, 20);
            self.productPriceLbl.textAlignment = UITextAlignmentLeft;
            self.productPriceLbl.text = [self.item.itemPrice formatPriceString];
            if ([self.item.itemPrice floatValue] <= 0) {
                self.productPriceLbl.hidden = YES;
            }
            else
                self.productPriceLbl.hidden = NO;
            
            [self.contentView addSubview:self.productNumberLbl];
            self.productNumberLbl.frame = CGRectMake(305-90, 50, 90, 20);
            self.productNumberLbl.textColor = [UIColor colorWithRGBHex:0x707070];
            self.productNumberLbl.text = [NSString stringWithFormat:@"%@:%@ ",L(@"Constant_Amount"),item.quantity];
            
            if (_item.errorDesc.length)
            {
                self.errorDescLbl.left = self.productPriceLbl.left;
                self.errorDescLbl.width = 305 - self.errorDescLbl.left;
                
                self.errorDescLbl.text = _item.errorDesc;
            }
            else
            {
                TTVIEW_RELEASE_SAFELY(_errorDescLbl);
            }
            
            TTVIEW_RELEASE_SAFELY(_specialMarkView);
            break;
        }
        case PackageTypeSmall:
        {
            if (!item.isInnerProduct)
            {
                [self.contentView addSubview:self.checkButton];
                [self isItemChecked:_item];
                
                [self.productIconView removeFromSuperview];
                [self.contentView addSubview:self.productNameLbl];
                self.productNameLbl.frame = CGRectMake(50, 10, 305-50, [self nameLabelHeightWithWidth:305-50]);
                self.productNameLbl.numberOfLines = 2;
                self.productNameLbl.text = _item.productName;
                
                [self.contentView addSubview:self.productPriceLbl];
                self.productPriceLbl.frame = CGRectMake(50, 50, 90, 20);
                self.productPriceLbl.textAlignment = UITextAlignmentLeft;
                self.productPriceLbl.text = [self.item.itemPrice formatPriceString];
                if ([self.item.itemPrice floatValue] <= 0) {
                    self.productPriceLbl.hidden = YES;
                }
                else
                    self.productPriceLbl.hidden = NO;
                
                [self.contentView addSubview:self.productNumberLbl];
                self.productNumberLbl.frame = CGRectMake(305-90, 50, 90, 20);
                self.productNumberLbl.text = [NSString stringWithFormat:@"%@:%@ ",L(@"Constant_Amount"),item.quantity];
                
                if (_item.errorDesc.length)
                {
                    self.errorDescLbl.left = self.productPriceLbl.left;
                    self.errorDescLbl.width = 305 - self.errorDescLbl.left;
                    
                    self.errorDescLbl.text = _item.errorDesc;
                }
                else
                {
                    TTVIEW_RELEASE_SAFELY(_errorDescLbl);
                }
            }
            else
            {
                
                [self.checkButton removeFromSuperview];
                [self.contentView addSubview:self.productIconView];
                [self setIconImageURL];
                [self.contentView addSubview:self.productNameLbl];
                self.productNameLbl.frame = CGRectMake(115, 10, 305-115, [self nameLabelHeightWithWidth:305-115]);
                self.productNameLbl.numberOfLines = 2;
                self.productNameLbl.text = _item.productName;
                
                [self.contentView addSubview:self.productPriceLbl];
                self.productPriceLbl.frame = CGRectMake(115, 50, 90, 20);
                self.productPriceLbl.textAlignment = UITextAlignmentLeft;
                self.productPriceLbl.text = [self.item.itemPrice formatPriceString];
                if ([self.item.itemPrice floatValue] <= 0) {
                    self.productPriceLbl.hidden = YES;
                }
                else
                    self.productPriceLbl.hidden = NO;
                
                [self.productNumberLbl removeFromSuperview];
                
                if (_item.errorDesc.length)
                {
                    self.errorDescLbl.left = self.productPriceLbl.left;
                    self.errorDescLbl.width = 305 - self.errorDescLbl.left;
                    
                    self.errorDescLbl.text = _item.errorDesc;
                }
                else
                {
                    TTVIEW_RELEASE_SAFELY(_errorDescLbl);
                }
            }
            
            TTVIEW_RELEASE_SAFELY(_specialMarkView);
            
            break;
        }
        default:
            break;
    }
    
    [self setEditView];
}

- (void)setIconImageURL
{
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
    {
        self.productIconView.imageURL = [ProductUtil getImageUrlWithProductCode:self.item.partNumber
                                                                           size:ProductImageSize160x160];
    }
    else
    {
        self.productIconView.imageURL = [ProductUtil getImageUrlWithProductCode:self.item.partNumber
                                                                           size:ProductImageSize100x100];
    }
}

- (CGFloat)nameLabelHeightWithWidth:(CGFloat)width
{
    UIFont *font = self.productNameLbl.font;
    CGFloat lineHeight = font.lineHeight;
    CGSize size = [self.item.productName sizeWithFont:font
                                    constrainedToSize:CGSizeMake(width, 1000)
                                        lineBreakMode:NSLineBreakByCharWrapping];
    return size.height > lineHeight ? lineHeight*2 : lineHeight;
}

+ (CGFloat)height:(ShopCartV2DTO *)item
{
    if (item.errorDesc.length)
    {
        return 100.0f;
    }
    else
    {
        if (item.limitCount.length) {
            return 100.0f;
        }
        return 80.0f;
    }
}

- (UIButton *)trashButton
{
    if (!_trashButton) {
        _trashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_trashButton setImage:[UIImage imageNamed:@"shopcart_trash.png"]
                      forState:UIControlStateNormal];
        [_trashButton addTarget:self
                         action:@selector(MessageShow)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _trashButton;
}

- (UIButton *)buyLaterButton{
    
    if (!_buyLaterButton) {
        
        _buyLaterButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 40, 20, 20)];
        [_buyLaterButton addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [_buyLaterButton setImage:[UIImage imageNamed:@"shopcart_addCollect.png"]
                         forState:UIControlStateNormal];
    }
    
    return _buyLaterButton;
}

- (UILabel *)editPriceLbl
{
    if (!_editPriceLbl) {
        _editPriceLbl = [[UILabel alloc] init];
        _editPriceLbl.backgroundColor = [UIColor clearColor];
        _editPriceLbl.textColor = [UIColor orange_Red_Color];
        _editPriceLbl.font = [UIFont systemFontOfSize:14];
        _editPriceLbl.shadowOffset = CGSizeMake(1, 1);
        _editPriceLbl.shadowColor = [UIColor whiteColor];
    }
    return _editPriceLbl;
}

- (UILabel *)editNumLbl
{
    if (!_editNumLbl) {
        _editNumLbl = [[UILabel alloc] init];
        _editNumLbl.backgroundColor = [UIColor clearColor];
        _editNumLbl.textColor = [UIColor blackColor];
        _editNumLbl.font = [UIFont systemFontOfSize:14];
        _editNumLbl.shadowOffset = CGSizeMake(1, 1);
        _editNumLbl.shadowColor = [UIColor whiteColor];
    }
    return _editNumLbl;
}

#pragma mark -
#pragma mark ------------ deleteItem Method ------------

- (void)deleteItem:(id)sender
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010113"], nil]];
    if ([_delegate respondsToSelector:@selector(deleteItemWithCell:)])
    {
        [_delegate deleteItemWithCell:self];
    }
}
-(void)MessageShow
{
    BBAlertView *alert =  [[BBAlertView alloc] initWithTitle:nil
                                                     message:L(@"SCDeleteTheGood")
                                                    delegate:nil
                                           cancelButtonTitle:L(@"Cancel")
                                           otherButtonTitles:L(@"Confirmation")];
    [alert setConfirmBlock:^{
        
        [self deleteItem:self.item];
        
    }];
    
    [alert show];
    
}


#pragma mark -
#pragma mark ------------ addFavorite Method ------------

- (void)addToFavorite:(id)sender
{
    if ([_delegate respondsToSelector:@selector(removeToAddFavorite:)])
    {
        [_delegate removeToAddFavorite:self.item];
    }
}

#pragma mark -
#pragma mark ------------ check method ------------
- (void)isItemChecked:(ShopCartV2DTO *)item
{
    self.checkButton.selected = item.isDeleteItemCheck;
}

- (void)modifyChecked
{
    self.item.isDeleteItemCheck = !self.item.isDeleteItemCheck;
    
    [self setCheckButtonIsChecked:self.item.isDeleteItemCheck];
    
    if ([_delegate respondsToSelector:@selector(reloadInvalidTableView)])
    {
        [_delegate reloadInvalidTableView];
    }
}

- (void)setCheckButtonIsChecked:(BOOL)checked
{
    if (checked)
    {
        self.checkButton.selected = YES;
    }
    else
    {
        self.checkButton.selected = NO;
    }

}

#pragma mark ----------------------------- kvo edit state

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"editing"] && [object isKindOfClass:[ShopCartV2DTO class]])
    {
        BOOL isEdit = [[change objectForKey:NSKeyValueChangeNewKey] boolValue];
        
        if (self.isEditing != isEdit) {
            [self setEditing:isEdit animated:YES];
        }
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShopCartEditStateDidChange" object:nil];
}
@end
