//
//  ShopCartShopHeaderView.m
//  SuningEBuy
//
//  Created by  liukun on 13-10-16.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ShopCartShopHeaderView.h"
#import "ShopCartV2ViewController.h"

@implementation ShopCartShopHeaderView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *line = [[UIImageView alloc] init];
        line.frame = CGRectMake(0, k_ShopCartShopHeaderView_Height-0.5, 320, 0.5);
        line.image = [UIImage streImageNamed:@"line.png" capX:3 capY:0];
        [self addSubview:line];
        [self goToShopBtn];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editStateDidChange) name:@"ShopCartEditStateDidChange" object:nil];
    }
    return self;
}

- (void)editStateDidChange
{
    //刷新编辑状态
    [self setEditButtonIsEditing:self.shopDTO.isEditing];
}

+ (CGFloat)height
{
    return k_ShopCartShopHeaderView_Height;
}

#pragma mark ----------------------------- views

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(0, 0, 50, 40);
        _checkButton.backgroundColor = [UIColor clearColor];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_unselect.png"]
                      forState:UIControlStateNormal];
        [_checkButton setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                      forState:UIControlStateSelected];
        [_checkButton addTarget:self
                         action:@selector(selectAllBtnTapped:)
               forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_checkButton];
    }
    return _checkButton;
}

- (UILabel *)shopNameLabel
{
    if (!_shopNameLabel)
    {
		_shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 180, 20)];
		_shopNameLabel.backgroundColor  = [UIColor clearColor];
        _shopNameLabel.font             = [UIFont systemFontOfSize:14.0];
        _shopNameLabel.textColor        = [UIColor colorWithRGBHex:0x313131];
        _shopNameLabel.textAlignment    = NSTextAlignmentLeft;
        _shopNameLabel.shadowColor      = [UIColor whiteColor];
        _shopNameLabel.shadowOffset     = CGSizeMake(1, 1);
        [self addSubview:_shopNameLabel];
    }
    return _shopNameLabel;
}

- (UILabel *)dicountLabel
{
    if (!_dicountLabel) {
        _dicountLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 20, 180, 15)];
        _dicountLabel.backgroundColor  = [UIColor clearColor];
        _dicountLabel.font             = [UIFont systemFontOfSize:14.0];
        _dicountLabel.textColor        = [UIColor colorWithRGBHex:0x707070];
        _dicountLabel.textAlignment    = NSTextAlignmentLeft;
        _dicountLabel.shadowColor      = [UIColor whiteColor];
        _dicountLabel.shadowOffset     = CGSizeMake(1, 1);
        _dicountLabel.hidden = YES;
        [self addSubview:_dicountLabel];
    }
    return _dicountLabel;
}

- (UILabel *)shopShipPriceLabel
{
    if (!_shopShipPriceLabel) {
        _shopShipPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, 10, 75, 20)];
        _shopShipPriceLabel.backgroundColor = [UIColor clearColor];
        _shopShipPriceLabel.font            = [UIFont systemFontOfSize:13.5];
        _shopShipPriceLabel.textColor       = [UIColor colorWithRGBHex:0x707070];
        _shopShipPriceLabel.textAlignment   = NSTextAlignmentRight;
        _shopShipPriceLabel.shadowColor     = [UIColor whiteColor];
        _shopShipPriceLabel.shadowOffset    = CGSizeMake(1, 1);
        _shopShipPriceLabel.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_shopShipPriceLabel];
    }
    return _shopShipPriceLabel;
}

- (UIButton *)editButton
{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(320-45, 0, 40, 40);
        _editButton.backgroundColor = [UIColor clearColor];
        
        [_editButton setImage:nil
                     forState:UIControlStateNormal];
        [_editButton setTitle:L(@"BTEdit")
                     forState:UIControlStateNormal];
        [_editButton setTitleColor:[UIColor colorWithRGBHex:0xff4a00]
                          forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_editButton addTarget:self
                        action:@selector(editButtonTapped:)
              forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_editButton];
    }
    return _editButton;
}

- (UIButton *)goToShopBtn
{
    if (!_goToShopBtn) {
        _goToShopBtn = [[UIButton alloc] init];
        _goToShopBtn.frame = CGRectMake(50, 0, 270, 40);
        _goToShopBtn.backgroundColor = [UIColor clearColor];
        [_goToShopBtn addTarget:self action:@selector(goToCShopAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_goToShopBtn];
    }
    return _goToShopBtn;
}

#pragma mark ----------------------------- actions

- (void)selectAllBtnTapped:(id)sender
{
    
    if ([_delegate respondsToSelector:@selector(shopHeaderView:selectAllTapped:)])
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"1010102"], nil]];
        [_delegate shopHeaderView:self selectAllTapped:self.shopDTO];
    }
}

- (void)editButtonTapped:(id)sender
{
    if ([_delegate respondsToSelector:@selector(shopHeaderView:editItemsInShop:)])
    {
        [_delegate shopHeaderView:self editItemsInShop:self.shopDTO];
    }
    
    [self setEditButtonIsEditing:_shopDTO.isEditing];
}

- (void)setCheckButtonIsChecked:(BOOL)checked
{
    self.checkButton.selected = checked;
}

- (void)setEditButtonIsEditing:(BOOL)isEditing
{
    if (isEditing)
    {
        [self.editButton setImage:nil
                         forState:UIControlStateNormal];
        [self.editButton setTitle:L(@"BTFinish")
                         forState:UIControlStateNormal];
    }
    else
    {
        [self.editButton setImage:nil
                         forState:UIControlStateNormal];
        [self.editButton setTitle:L(@"BTEdit")
                         forState:UIControlStateNormal];
        
        
    }
}

- (void)goToCShopAction
{
    if([SNSwitch isOpenGoToShopExit] == YES)
    {
        if (!IsStrEmpty(self.shopDTO.shopCode)) {
            if (_delegate && [_delegate respondsToSelector:@selector(goToCShop:)]) {
                [_delegate goToCShop:self.shopDTO.shopCode];
            }
        }
    }
}

#pragma mark ----------------------------- set item

- (void)setShopDTO:(ShopCartShopDTO *)shopDTO
{
    if (_shopDTO != shopDTO)
    {
        _shopDTO = shopDTO;
    }
}

- (void)setHeadViewInfo:(ShopCartShopDTO *)shopDTO withIsExpand:(BOOL)isExpand isSelectNow:(BOOL)isSelectNow
{
    
    //自营商品满X元免运费的限制价格
    NSString *limit = [shopDTO.limitedAmount stringValue];
    UserInfoDTO         *usrBean = [UserCenter defaultCenter].userInfoDTO;
    if (!IsStrEmpty(shopDTO.shopCode)) {
        self.dicountLabel.hidden    = YES;
        self.shopNameLabel.frame    = CGRectMake(50, 10, 180, 20);
        
    }else
    {
        self.dicountLabel.hidden    = NO;
        self.shopNameLabel.frame    = CGRectMake(50, 5, 280, 15);
        
        //不是白金会员且未返回限制价格
        if (![usrBean.custLevelCN isEqualToString:L(@"SCPlatinumMember")]) {
            if (IsStrEmpty(limit)) {
                self.dicountLabel.hidden    = YES;
                self.shopNameLabel.frame    = CGRectMake(50, 10, 280, 20);
            }
        }
    }
    
    if ([usrBean.custLevelCN isEqualToString:L(@"SCPlatinumMember")]) {
        self.dicountLabel.text      = L(@"SCPlatinumMemberEnjoyDeliveryFree");
    }
    else
    {
        if ([limit isEqualToString:@"0"]) {
            self.dicountLabel.text      = L(@"SCNoFreight");
        }
        else
        {
            self.dicountLabel.text      = [NSString stringWithFormat:@"%@%@%@,%@",L(@"SCBeyond"),limit,L(@"Constant_RMB"),L(@"SCNoFreight")];
        }
        
    }
    
    self.shopNameLabel.text         = shopDTO.shopName;
    
    /**
     *  有勾选的商品的时候才展示运费
     *  @author kb
     *  @since  2.4.3
     */
    BOOL isHasChecked = NO;
    for (ShopCartV2DTO *dto in shopDTO.itemList) {
        if (dto.isChecked) {
            isHasChecked = YES;
            break;
        }
    }
    NSString *fee = [shopDTO.totalShipPrice stringValue];
    if (!isSelectNow) {
        if (!IsStrEmpty(fee) && isHasChecked) {
            
            if ([fee isEqualToString:@"0"]) {
                self.shopShipPriceLabel.text = L(@"SCNoFreight");
            }
            else
            {
                self.shopShipPriceLabel.text = [NSString stringWithFormat:@"%@:￥%.2f",L(@"Freight"),[fee doubleValue]];
            }
        }
    }
    
    if (isExpand) {
        [self setCheckButtonIsChecked:_shopDTO.isEditAllSelect];
    }
    else
    {
         [self setCheckButtonIsChecked:_shopDTO.isAllSelect];
    }
   
    
    //    [self setEditButtonIsEditing:_shopDTO.isEditing];
}

@end
