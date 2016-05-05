//
//  ShopCartItemCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartItemCell.h"

#import "AddressInfoDAO.h"
#import "RegexKitLite.h"
#import "ProductUtil.h"
#import <objc/runtime.h>
#import "SNGraphics.h"
#import "ShopCartV2ViewController.h"

@interface ShopCartItemCell()
{
    BOOL isEditAlliItems;
}

@end

@implementation ShopCartItemCell

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
        swipeLeft.delegate = self;
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        [self addGestureRecognizer:swipeLeft];
        
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        swipeRight.delegate = self;
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        [self addGestureRecognizer:swipeRight];
        
        [self addSubview:self.swipeEditView];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return NO;
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (!self.isAccessoryLastCell)
    {
        if (isEditAlliItems == YES) {
            if (_delegate && [_delegate respondsToSelector:@selector(presentEditAlertTip)]) {
                [_delegate presentEditAlertTip];
            }
            return;
        }
        self.item.editing = !self.editing;
        [self setEditing:!self.editing animated:YES];
    }
}

- (UIImageView *)line
{
    if (!_line) {
        _line = [[UIImageView alloc] init];
        _line.layer.zPosition = 1;
        [self addSubview:_line];
    }
    return _line;
}

- (void)setLineDotted:(BOOL)isDottedLine
{
    if (isDottedLine)
    {
        self.line.frame = CGRectMake(20, [ShopCartItemCell height:self.item]-0.5, 300, 0.5);
        self.line.image = [UIImage imageNamed:@"line_dotted.png"];
    }
    else
    {
        self.line.frame = CGRectMake(0, [ShopCartItemCell height:self.item]-0.5, 320, 0.5);
        self.line.image = [UIImage streImageNamed:@"line.png" capX:3 capY:0];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置编辑状态
    if (self.isAccessoryLastCell)
    {
        if (self.isEditing)
        {
            [self setEditing:NO];
        }
    }
    else
    {
        if (self.item.editing != self.isEditing)
        {
            [self setEditing:self.item.editing animated:NO];
        }
    }
    
}

#pragma mark -
#pragma mark ------------ 侧滑编辑视图 ------------

- (UIView *)swipeEditView
{
    if (!_swipeEditView) {
        self.productNumberFld.text = self.item.quantity;
        _swipeEditView = [UIControl new];
        _swipeEditView.backgroundColor = [UIColor clearColor];
        _swipeEditView.frame = CGRectMake(320, 0, 210, 98);
    }
    return _swipeEditView;
}

- (void)setSwipeEditView
{
    UIView *coverView = [UIView new];
    coverView.frame = CGRectMake(0, 0, 210, 78);
    coverView.backgroundColor = [UIColor cellBackViewColor];
    [self.swipeEditView addSubview:coverView];
    
    UILabel *swipeEditPriceLbl = [[UILabel alloc] init];
    swipeEditPriceLbl.backgroundColor = [UIColor clearColor];
    swipeEditPriceLbl.textColor = [UIColor orange_Red_Color];
    swipeEditPriceLbl.font = [UIFont systemFontOfSize:14];
    swipeEditPriceLbl.text = [self.item.itemPrice formatPriceString];
    swipeEditPriceLbl.frame = CGRectMake(7, 10, 75, 20);
    [self.swipeEditView addSubview:swipeEditPriceLbl];
    
    UILabel *swipeEditNumLbl = [[UILabel alloc] init];
    swipeEditNumLbl.backgroundColor = [UIColor clearColor];
    swipeEditNumLbl.textColor = [UIColor blackColor];
    swipeEditNumLbl.font = [UIFont systemFontOfSize:14];
    swipeEditNumLbl.text = [NSString stringWithFormat:@"x%@",STR_FROM_INT([self.item.quantity integerValue])];
    swipeEditNumLbl.frame = CGRectMake(10, 45, 50, 20);
    [self.swipeEditView addSubview:swipeEditNumLbl];
    
    self.numberDecreaseBtn.frame = CGRectMake(swipeEditNumLbl.right + 21, 43, 44, 30);
    [self.swipeEditView addSubview:self.numberDecreaseBtn];
    
    self.productNumberFld.frame = CGRectMake(self.numberDecreaseBtn.right - 4, 47, 37, 22);
    [self.swipeEditView addSubview:self.productNumberFld];
    
    self.numberIncreaseBtn.frame = CGRectMake(self.productNumberFld.right - 4, 43, 44, 30);
    [self.swipeEditView addSubview:self.numberIncreaseBtn];
}

#pragma mark -
#pragma mark 所有商品编辑视图

- (void)setEditView
{
    self.productNumberFld.text = self.item.quantity;
    self.numberTextFld.text = self.item.quantity;
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
    coverView.frame = CGRectMake(0, 0, 210, 78);
    coverView.backgroundColor = [UIColor cellBackViewColor];
    [editView addSubview:coverView];
    
    self.editPriceLbl.text = [self.item.itemPrice formatPriceString];
    self.editPriceLbl.frame = CGRectMake(7, 10, 75, 20);
    [editView addSubview:self.editPriceLbl];
    
    self.editNumLbl.text = [NSString stringWithFormat:@"x%@",STR_FROM_INT([self.item.quantity integerValue])];
    self.editNumLbl.frame = CGRectMake(10, 45, 50, 20);
    [editView addSubview:self.editNumLbl];
    
    self.numberTextFld.frame = CGRectMake(self.editNumLbl.right + 15, 37, 37, 32);
    [editView addSubview:self.numberTextFld];
    
    self.buyLaterButton.frame = CGRectMake(self.numberTextFld.right+5, 37, 37, 32);
    [editView addSubview:self.buyLaterButton];
    
    self.trashButton.frame = CGRectMake(self.buyLaterButton.right + 5, 37, 37, 32);
    [editView addSubview:self.trashButton];
    
    
    //抢购商品、小套餐内商品不可以改数量
    if ([self.item canModifyQuantity])
    {
        [self changeProductQuantity:[self.item.quantity integerValue]];
        self.numberTextFld.hidden = NO;
        self.productNumberFld.hidden = NO;
        self.numberDecreaseBtn.hidden = NO;
        self.numberIncreaseBtn.hidden = NO;
    }
    else
    {
        coverView.left = self.productNumberFld.right;
        coverView.width -= self.productNumberFld.right;
        self.numberTextFld.hidden = YES;
        self.productNumberFld.hidden = YES;
        self.numberDecreaseBtn.hidden = YES;
        self.numberIncreaseBtn.hidden = YES;
        self.buyLaterButton.frame = CGRectMake(self.editNumLbl.right+57, 37, 37, 32);
        self.trashButton.frame = CGRectMake(self.buyLaterButton.right + 5, 37, 37, 32);
        coverView.frame = CGRectMake(0, 0, 210, 78);
    }
    
    self.editingAccessoryView = editView;

}


#pragma mark -
#pragma mark Product Number Modify Handle Methods
- (void)cancelButtonClicked:(id)sender
{
    [self.productNumberFld resignFirstResponder];
    [self.numberTextFld resignFirstResponder];
}

- (void)doneButtonClicked:(id)sender
{
    [self.productNumberFld resignFirstResponder];
    [self.numberTextFld resignFirstResponder];
}

- (void)doneTapped:(id)sender
{
    [self.productNumberFld resignFirstResponder];
    [self.numberTextFld resignFirstResponder];
}

#pragma mark -
#pragma mark Text View Delegate Method

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.text.trim.length != 0)
    {
        [self changeProductQuantity:[textField.text integerValue]];
    }
}

- (void)textFieldChanged:(UITextField *)textField
{
    if (textField.text.trim.length != 0)
    {
        [self changeProductQuantity:[textField.text integerValue]];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((range.location == 0) && ([string isEqualToString:@"0"]))
    {
        return NO;
    }
    
    if (range.location >= 2)
    {
        return NO;
    }
    
    //限制非数字的字符
    if ((string.length > 0 && ![string isMatchedByRegex:@"^[0-9]*$"]) || [[string trim] intValue] > 99) {
        return NO;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010105"], nil]];
    if (textField.text.trim.length == 0)
    {

        self.productNumberFld.text =  self.item.quantity;
        
        self.numberTextFld.text = self.item.quantity;
        
        self.numberShowLbl.text = self.productNumberFld.text;
        
        if ([_delegate respondsToSelector:@selector(cartItemQuantityDidChange)]) {
            [_delegate cartItemQuantityDidChange];
        }
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

- (NSString *)cityShowValue
{
    NSString *cityName = self.item.cityName;
    
    if (cityName.trim.length == 0)
    {
        AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
        cityName = [dao getCityNameByCityCode:self.item.cityCode];
    }
    if ([cityName hasSuffix:L(@"Constant_City")])
    {
        cityName = [cityName substringToIndex:[cityName length]-1];
    }
    
    return cityName;
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

- (void)setItem:(ShopCartV2DTO *)item
{
    
}

- (void)setShopItemInfo:(ShopCartV2DTO *)item hasExpands:(BOOL)hasExpands
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
    
    self.isAccessoryLastCell = NO;
    isEditAlliItems = hasExpands;
    switch (item.packageType)
    {
        case PackageTypeNormal:
        {
            [self.contentView addSubview:self.checkButton];
            [self setCheckButtonIsChecked:_item];
            
            [self.contentView addSubview:self.productIconView];
            [self setIconImageURL];
            
            [self.contentView addSubview:self.productNameLbl];
            self.productNameLbl.frame = CGRectMake(118, 10, 305-118, [self nameLabelHeightWithWidth:305-118]);
            self.productNameLbl.numberOfLines = 2;
            self.productNameLbl.text = _item.productName;
            
            [self.contentView addSubview:self.productPriceLbl];
            self.productPriceLbl.frame = CGRectMake(118, 50, 90, 20);
            self.productPriceLbl.textAlignment = UITextAlignmentLeft;
            self.productPriceLbl.text = [self.item.itemPrice formatPriceString];
            if ([self.item.itemPrice floatValue] <= 0) {
                self.productPriceLbl.hidden = YES;
            }
            else
                self.productPriceLbl.hidden = NO;
            
            [self.contentView addSubview:self.cityLabel];
            self.cityLabel.frame = CGRectMake(105, 50, 90, 20);
            self.cityLabel.text = [self cityShowValue];
            
            [self.contentView addSubview:self.productNumberLbl];
            self.productNumberLbl.frame = CGRectMake(305-90, 50, 90, 20);
            self.productNumberLbl.text = [NSString stringWithFormat:@"%@:%@ ",L(@"Constant_Amount"),item.quantity];
            
            if (_item.errorDesc.length)
            {
                self.errorDescLbl.text = _item.errorDesc;
                self.errorDescLbl.left = self.productPriceLbl.left;
                self.errorDescLbl.width = 305 - self.errorDescLbl.left;
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
            else if(item.special == ShopCartSpecialMarket){
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
                [self setCheckButtonIsChecked:_item];
            }
            else
            {
                [self.checkButton removeFromSuperview];
                self.productNameLbl.textColor = [UIColor darkTextColor];
                self.productPriceLbl.textColor = [UIColor orange_Red_Color];
            }
            
            [self.contentView addSubview:self.productIconView];
            [self setIconImageURL];
            [self.contentView addSubview:self.productNameLbl];
            self.productNameLbl.numberOfLines = 2;
            self.productNameLbl.frame = CGRectMake(118, 10, 305-105, [self nameLabelHeightWithWidth:305-118]);
            self.productNameLbl.text = _item.productName;
            
            [self.contentView addSubview:self.productPriceLbl];
            self.productPriceLbl.frame = CGRectMake(118, 50, 90, 20);
            self.productPriceLbl.textAlignment = UITextAlignmentLeft;
            self.productPriceLbl.text = [self.item.itemPrice formatPriceString];
            
            if ([self.item.itemPrice floatValue] <= 0) {
                self.productPriceLbl.hidden = YES;
            }
            else
                self.productPriceLbl.hidden = NO;
            
            [self.cityLabel removeFromSuperview];
            
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
                [self setCheckButtonIsChecked:_item];
                
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
                
                [self.contentView addSubview:self.cityLabel];
                self.cityLabel.frame = CGRectMake(50, 50, 90, 20);
                self.cityLabel.text = [self cityShowValue];
                
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
                self.productNameLbl.textColor = [UIColor darkTextColor];
                self.productPriceLbl.textColor = [UIColor orange_Red_Color];
                
                [self.contentView addSubview:self.productIconView];
                [self setIconImageURL];
                [self.contentView addSubview:self.productNameLbl];
                self.productNameLbl.frame = CGRectMake(118, 10, 305-118, [self nameLabelHeightWithWidth:305-118]);
                self.productNameLbl.numberOfLines = 2;
                self.productNameLbl.text = _item.productName;
                
                [self.contentView addSubview:self.productPriceLbl];
                self.productPriceLbl.frame = CGRectMake(118, 50, 90, 20);
                self.productPriceLbl.textAlignment = UITextAlignmentLeft;
                self.productPriceLbl.text = [self.item.itemPrice formatPriceString];
                if ([self.item.itemPrice floatValue] <= 0) {
                    self.productPriceLbl.hidden = YES;
                }
                else
                    self.productPriceLbl.hidden = NO;
                
                [self.cityLabel removeFromSuperview];
                
                [self.productNumberLbl removeFromSuperview];
                [self.contentView addSubview:self.productNumberLbl];
                self.productNumberLbl.frame = CGRectMake(305-90, 50, 90, 20);
                self.productNumberLbl.textColor = [UIColor colorWithRGBHex:0x707070];
                self.productNumberLbl.text = [NSString stringWithFormat:@"%@:%@ ",L(@"Constant_Amount"),item.quantity];
                //                [self.numberShowLbl removeFromSuperview];
                
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
    [self setSwipeEditView];
    if (hasExpands) {
        if (self.item.editing) {
            self.item.editing = !self.item.editing;
            [self setEditing:!self.item.editing animated:YES];
        }
        [UIView animateWithDuration:0.3 animations:^{
            self.swipeEditView.frame = CGRectMake(110, 0, 210, 78);
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            self.swipeEditView.frame = CGRectMake(320, 0, 210, 78);
        }];
    }
}


- (void)setItem:(ShopCartV2DTO *)item isAccessoryLastCell:(BOOL)isLast
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
    
    self.isAccessoryLastCell = isLast;
    
    [self.checkButton removeFromSuperview];
    [self.productIconView removeFromSuperview];
    [self.productNameLbl removeFromSuperview];
    [self.productPriceLbl removeFromSuperview];
    [self.contentView addSubview:self.cityLabel];
    self.cityLabel.frame = CGRectMake(40, 20, 130, 20);
    self.cityLabel.text = [NSString stringWithFormat:@"%@%@",
                           L(@"ShopCart_Delivery_City:"), [self cityShowValue]];
    
    [self.contentView addSubview:self.productPriceLbl];
    self.productPriceLbl.frame = CGRectMake(200, 20, 90, 20);
    self.productPriceLbl.textAlignment = UITextAlignmentRight;
    self.productPriceLbl.text = [@(self.item.totalPrice) formatPriceString];
    if ([@(self.item.totalPrice) integerValue] <= 0) {
        self.productPriceLbl.hidden = YES;
    }
    else
        self.productPriceLbl.hidden = NO;
    
    [self.contentView addSubview:self.productNumberLbl];
    
    self.productNumberLbl.frame = CGRectMake(310-90, 50, 90, 20);
    if (_item.errorDesc.length)
    {
        self.productNumberLbl.textColor = [UIColor orange_Red_Color];
        self.productNumberLbl.text = _item.errorDesc;
    }
    else
    {
        self.productNumberLbl.textColor = [UIColor colorWithRGBHex:0x707070];
        self.productNumberLbl.text = [NSString stringWithFormat:@"%@:%@ ",L(@"Constant_Amount"),item.quantity];
    }
    
    TTVIEW_RELEASE_SAFELY(_specialMarkView);
}

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.backgroundColor = [UIColor clearColor];
        _checkButton.frame = CGRectMake(-20, 0, 90, 80);
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                          forState:UIControlStateSelected];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_unselect.png"]
                          forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_disabled_selected.png"] forState:UIControlStateDisabled];
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
        _errorDescLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 75, 115, 20)];
		
		_errorDescLbl.backgroundColor = [UIColor clearColor];
        
        _errorDescLbl.textAlignment = UITextAlignmentLeft;
        
		_errorDescLbl.font = [UIFont systemFontOfSize:14];
        
        _errorDescLbl.textColor = [UIColor orange_Red_Color];
        
        _errorDescLbl.adjustsFontSizeToFitWidth = YES;
        
		[self.contentView addSubview:_errorDescLbl];
    }
    
    return _errorDescLbl;
}


- (UILabel *)cityLabel
{
    if (!_cityLabel) {
        _cityLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 26.5, 190, 18.5)];
        _cityLabel.backgroundColor = [UIColor clearColor];
        _cityLabel.font = [UIFont systemFontOfSize:14];
        _cityLabel.textColor = [UIColor colorWithRGBHex:0x686868];
        
        _cityLabel.shadowOffset = CGSizeMake(1, 1);
        _cityLabel.shadowColor = [UIColor whiteColor];
        _cityLabel.adjustsFontSizeToFitWidth = YES;
        
        //隐藏不展示
        _cityLabel.hidden = YES;
    }
    return _cityLabel;
}

- (UIButton *)buyLaterButton{
    
    if (!_buyLaterButton) {
        
        _buyLaterButton = [[UIButton alloc] init];
        [_buyLaterButton addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [_buyLaterButton setImage:[UIImage imageNamed:@"shopcart_addcollect_normal.png"]
                         forState:UIControlStateNormal];
    }
    
    return _buyLaterButton;
}

- (void)addToFavorite:(id)sender
{
    if ([_delegate respondsToSelector:@selector(removeToFavorite:)])
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010106"], nil]];
        [_delegate removeToFavorite:self.item];
    }
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

// 数量显示标签
- (UILabel *)numberShowLbl
{
    if (!_numberShowLbl)
    {
		_numberShowLbl = [[UILabel alloc] init];
		
		_numberShowLbl.backgroundColor = [UIColor clearColor];
        
        _numberShowLbl.textColor = [UIColor blackColor];
        
		_numberShowLbl.font = [UIFont systemFontOfSize:14];
        
        _numberShowLbl.shadowOffset = CGSizeMake(1, 1);
        _numberShowLbl.shadowColor = [UIColor whiteColor];
        
    }
    
    return _numberShowLbl;
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

- (UIButton *)numberDecreaseBtn
{
    if (!_numberDecreaseBtn)
    {
        _numberDecreaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _numberDecreaseBtn.frame = CGRectMake(0, 0, 28, 22);
        _numberDecreaseBtn.backgroundColor = [UIColor clearColor];
        //        _numberDecreaseBtn.backgroundColor = RGBCOLOR(194, 194, 194);
        //
        //        _numberDecreaseBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        //        _numberDecreaseBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //        _numberDecreaseBtn.layer.borderWidth = 1.0f;
        //        _numberDecreaseBtn.layer.borderColor = [UIColor grayColor].CGColor;
//        _numberDecreaseBtn.layer.cornerRadius = 4;
        
        //        [_numberDecreaseBtn setTitle:@"-" forState:UIControlStateNormal];
        //        [_numberDecreaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        _numberDecreaseBtn.tag = 10;
        
//        [_numberDecreaseBtn setBackgroundImage:[UIImage imageNamed:@"shopcart_decreaseProduct_btn.png"] forState:UIControlStateNormal];
        [_numberDecreaseBtn setImage:[UIImage imageNamed:@"productDetail_delete_enabled.png"] forState:UIControlStateNormal];
        [_numberDecreaseBtn setImage:[UIImage imageNamed:@"productDetail_delete_disabled.png"] forState:UIControlStateDisabled];
        [_numberDecreaseBtn setImage:[UIImage imageNamed:@"productDetail_delete_clicked.png"] forState:UIControlStateHighlighted];
//        [_numberDecreaseBtn setBackgroundImage:[UIImage imageNamed:@"productDetail_delete_disabled.png"] forState:UIControlStateDisabled];
        
        [_numberDecreaseBtn addTarget:self action:@selector(decreaseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _numberDecreaseBtn;
}

- (ToolBarTextField *)productNumberFld
{
    if (!_productNumberFld)
    {
        _productNumberFld = [[ToolBarTextField alloc] initWithFrame:CGRectMake(30, 0, 50, 27)];
        
        _productNumberFld.font = [UIFont systemFontOfSize:14.0];
        
        _productNumberFld.delegate = self;
        
        _productNumberFld.delegate = self;
        
        _productNumberFld.textAlignment = UITextAlignmentCenter;
        
        _productNumberFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [_productNumberFld endEditing:NO];
        
        _productNumberFld.keyboardType = UIKeyboardTypeNumberPad;
        
        _productNumberFld.borderStyle = UITextBorderStyleNone;
        
        _productNumberFld.tag = 12;
        
        _productNumberFld.toolBarDelegate = self;
        
        [_productNumberFld setBackgroundColor:[UIColor cellBackViewColor]];
        
        _productNumberFld.clearButtonMode = UITextFieldViewModeNever;
        
        _productNumberFld.layer.borderWidth = 0.5;
        
        _productNumberFld.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        
        [_productNumberFld setBackground:[UIImage imageNamed:@"productDetail_productNum.png"]];
        
        [_productNumberFld addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _productNumberFld;
}

- (ToolBarTextField *)numberTextFld
{
    if (!_numberTextFld)
    {
        _numberTextFld = [[ToolBarTextField alloc] initWithFrame:CGRectMake(30, 0, 50, 27)];
        
        _numberTextFld.font = [UIFont systemFontOfSize:14.0];
        
        _numberTextFld.delegate = self;
        
        _numberTextFld.delegate = self;
        
        _numberTextFld.textAlignment = UITextAlignmentCenter;
        
        _numberTextFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        [_numberTextFld endEditing:NO];
        
        _numberTextFld.keyboardType = UIKeyboardTypeNumberPad;
        
        _numberTextFld.borderStyle = UITextBorderStyleNone;
        
        _numberTextFld.tag = 13;
        
        _numberTextFld.toolBarDelegate = self;
        
        [_numberTextFld setBackground:[UIImage imageNamed:@"productDetail_productNum.png"]];
        
        _numberTextFld.clearButtonMode = UITextFieldViewModeNever;
        
//        _numberTextFld.layer.borderWidth = 0.5;
        
//        _numberTextFld.layer.borderColor = [UIColor light_Gray_Color].CGColor;
        
        [_numberTextFld addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    
    return _numberTextFld;
}

- (UIButton *)numberIncreaseBtn
{
    if (!_numberIncreaseBtn)
    {
        _numberIncreaseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _numberIncreaseBtn.frame = CGRectMake(85, 0, 28, 22);
        _numberIncreaseBtn.backgroundColor = [UIColor clearColor];
        //        _numberIncreaseBtn.backgroundColor = RGBCOLOR(194, 194, 194);
        //        _numberIncreaseBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20];
        //        _numberIncreaseBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
        //        _numberIncreaseBtn.layer.borderWidth = 1.0f;
        //        _numberIncreaseBtn.layer.borderColor = [UIColor grayColor].CGColor;
//        _numberIncreaseBtn.layer.cornerRadius = 4;
        
        //        [_numberIncreaseBtn setTitle:@"+" forState:UIControlStateNormal];
        //        [_numberIncreaseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_numberIncreaseBtn setImage:[UIImage imageNamed:@"productDetail_add_enabled.png"] forState:UIControlStateNormal];
        [_numberIncreaseBtn setImage:[UIImage imageNamed:@"productDetail_add_disabled.png"] forState:UIControlStateDisabled];
        [_numberIncreaseBtn setImage:[UIImage imageNamed:@"productDetail_add_clicked.png"] forState:UIControlStateHighlighted];
//        [_numberIncreaseBtn setBackgroundImage:[UIImage imageNamed:@"productDetail_add_disabled.png"] forState:UIControlStateDisabled];
        _numberIncreaseBtn.tag = 11;
        
        [_numberIncreaseBtn addTarget:self action:@selector(increaseBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _numberIncreaseBtn;
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

//减少数量
- (void)decreaseBtnClicked:(id)sender
{
    NSUInteger quantity = [self.item.editQuantity integerValue];
    if (quantity > 1)
    {
        quantity -= 1;
        [self changeProductQuantity:quantity];
    }
}

- (void)increaseBtnClicked:(id)sender
{
    NSUInteger quantity = [self.item.editQuantity integerValue];
    if (quantity < 99)
    {
        quantity += 1;
        [self changeProductQuantity:quantity];
    }
}

- (void)changeProductQuantity:(NSInteger)quantity
{
    NSInteger currentQuantity = [self.item.editQuantity integerValue];
    if (currentQuantity != quantity)
    {
        DLog(@"\nquantity change from %d to %d", currentQuantity, quantity);
        NSString *str = STR_FROM_INT(quantity);
        self.productNumberFld.text = str;
        self.numberTextFld.text = str;
        self.numberShowLbl.text = [NSString stringWithFormat:@"x%@",str];
        self.item.editQuantity = str;
        
        if ([_delegate respondsToSelector:@selector(cartItemQuantityDidChange)]) {
            [_delegate cartItemQuantityDidChange];
        }
    }
    
    if (quantity == 1)
    {
        self.numberDecreaseBtn.enabled = NO;
    }
    else
    {
        self.numberDecreaseBtn.enabled = YES;
    }
    
    if (quantity == 99)
    {
        self.numberIncreaseBtn.enabled = NO;
    }
    else
    {
        self.numberIncreaseBtn.enabled = YES;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
}

+ (CGFloat)height:(ShopCartV2DTO *)item
{
    if (item.errorDesc.length)
    {
        return 100.0f;
    }
    else
    {
        return 80.0f;
    }
}

- (void)modifyChecked
{
    if (isEditAlliItems == YES) {
        self.item.isDeleteItemCheck = !self.item.isDeleteItemCheck;
        if ([_delegate respondsToSelector:@selector(cartItemCell:modifyCheckOfItem:)]) {
            [_delegate cartItemCell:self modifyCheckOfItem:nil];
        }
    }
    else
    {
        if ([_delegate respondsToSelector:@selector(cartItemCell:modifyCheckOfItem:)])
        {
            [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010103"], nil]];
            [_delegate cartItemCell:self modifyCheckOfItem:self.item];
        }
    }
}

- (void)setCheckButtonIsChecked:(ShopCartV2DTO *)item
{
    if (isEditAlliItems == YES) {
        self.checkButton.selected = item.isDeleteItemCheck;
    }else
    {
        self.checkButton.selected = item.isChecked;
    }
    if (item.packageType == PackageTypeNormal) {
        if (_item.isCanntCheck)
        {
            self.checkButton.enabled = NO;
            self.productNameLbl.textColor = [UIColor light_Gray_Color];
            self.productPriceLbl.textColor = [UIColor light_Gray_Color];
        }
        else
        {
            self.checkButton.enabled = YES;
            self.productNameLbl.textColor = [UIColor darkTextColor];
            self.productPriceLbl.textColor = [UIColor orange_Red_Color];
        }
    }
    else if (item.packageType == PackageTypeSmall || item.packageType == PackageTypeAccessory)
    {
        if (!item.isInnerProduct) {
            if (_item.isCanntCheck)
            {
                self.checkButton.enabled = NO;
                self.productNameLbl.textColor = [UIColor light_Gray_Color];
                self.productPriceLbl.textColor = [UIColor light_Gray_Color];
            }
            else
            {
                self.checkButton.enabled = YES;
                self.productNameLbl.textColor = [UIColor darkTextColor];
                self.productPriceLbl.textColor = [UIColor orange_Red_Color];
            }
        }
    }
    
    
}

- (UIButton *)trashButton
{
    if (!_trashButton) {
        _trashButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_trashButton setImage:[UIImage imageNamed:@"shopcart_shanchu_normal.png"]
                      forState:UIControlStateNormal];
        [_trashButton setImage:[UIImage imageNamed:@"shopcart_shanchu_highlight.png"]
                      forState:UIControlStateHighlighted];
        [_trashButton addTarget:self
                         action:@selector(MessageShow)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _trashButton;
}

- (void)deleteItem:(id)sender
{
    if ([_delegate respondsToSelector:@selector(deleteItemAtCell:)])
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010107"], nil]];
        [_delegate deleteItemAtCell:self];
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

// 数量标题
- (UILabel *)productNumberLblForEditView
{
    if (!_productNumberLblForEditView)
    {
        _productNumberLblForEditView = [[UILabel alloc] initWithFrame:CGRectMake(105, 47.5, 40, 27)];
		
		_productNumberLblForEditView.backgroundColor = [UIColor clearColor];
        
        _productNumberLblForEditView.textColor = [UIColor colorWithRGBHex:0x858585];
        _productNumberLblForEditView.text = L(@"Number:");
		_productNumberLblForEditView.font = [UIFont systemFontOfSize:14];
        
        _productNumberLblForEditView.shadowOffset = CGSizeMake(1, 1);
        _productNumberLblForEditView.shadowColor = [UIColor whiteColor];
        
        _productNumberLblForEditView.textAlignment = UITextAlignmentRight;
    }
    
    return _productNumberLblForEditView;
}

// 数量显示标签
- (UILabel *)numberShowLblForEditView
{
    if (!_numberShowLblForEditView)
    {
		_numberShowLblForEditView = [[UILabel alloc] initWithFrame:CGRectMake(150, 47.5, 20, 27)];
		
		_numberShowLblForEditView.backgroundColor = [UIColor clearColor];
        
        _numberShowLblForEditView.textColor = [UIColor colorWithRGBHex:0x313131];
        
		_numberShowLblForEditView.font = [UIFont systemFontOfSize:14];
        
        _numberShowLblForEditView.shadowOffset = CGSizeMake(1, 1);
        _numberShowLblForEditView.shadowColor = [UIColor whiteColor];
        
		[self.contentView addSubview:_numberShowLblForEditView];
    }
    
    return _numberShowLblForEditView;
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
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShopCartEditStateDidChange" object:nil];
}

@end
