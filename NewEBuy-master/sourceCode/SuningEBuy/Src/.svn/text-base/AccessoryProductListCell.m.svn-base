//
//  AccessoryProductListCell.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccessoryProductListCell.h"
#import "ProductUtil.h"

@implementation AccessoryProductListCell

- (void)dealloc
{
    TT_RELEASE_SAFELY(_checkButton);
    TT_RELEASE_SAFELY(_iconImageView);
    TT_RELEASE_SAFELY(_nameLabel);
    TT_RELEASE_SAFELY(_priceLabel);
    TT_RELEASE_SAFELY(_oldPriceLabel);
    TT_RELEASE_SAFELY(_item);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark set item

- (void)setItem:(DataProductBasic *)item
{
    if (_item != item) {
        _item = item;
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg])
        {
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode
                                                                             size:ProductImageSize160x160];
        }
        else
        {
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode
                                                                             size:ProductImageSize100x100];
        }
        self.nameLabel.text = item.productName;
        
        NSString *price = [NSString stringWithFormat:@"￥%.2f",
                           [item.accessoryPackagePrice doubleValue]];
        self.priceLabel.text = price;
        
        NSString *oldPrice = [NSString stringWithFormat:@"%@:￥%.2f",L(@"yigouPrice"),
                           [item.suningPrice doubleValue]];
        self.oldPriceLabel.text = oldPrice;
    }
}

#pragma mark -
#pragma mark views

- (EGOImageView *)iconImageView
{
    if (!_iconImageView) {
        _iconImageView = [[EGOImageView alloc] init];
        _iconImageView.frame = CGRectMake(50, 8, 64, 64);
        _iconImageView.layer.cornerRadius = 5.0;
        _iconImageView.layer.borderColor = [UIColor grayColor].CGColor;
        _iconImageView.layer.borderWidth = 0.5;
        _iconImageView.clipsToBounds = YES;
        [self.contentView addSubview:_iconImageView];
    }
    return _iconImageView;
}

- (UIButton *)checkButton
{
    if (!_checkButton) {
        _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _checkButton.frame = CGRectMake(3, 18, 44, 44);
        [_checkButton addTarget:self
                         action:@selector(modifyChecked)
               forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_checkButton];
    }
    return _checkButton;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
		_nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 12, 170, 20)];
        
		_nameLabel.backgroundColor = [UIColor clearColor];
        
        _nameLabel.font = [UIFont boldSystemFontOfSize:14.0];
        
        _nameLabel.shadowColor = [UIColor whiteColor];
        _nameLabel.shadowOffset = CGSizeMake(1, 1);
                
		[self.contentView addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel)
    {
		_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 50, 170, 20)];
        
		_priceLabel.backgroundColor = [UIColor clearColor];
        
        _priceLabel.font = [UIFont boldSystemFontOfSize:16.0];
        
        _priceLabel.textColor = [UIColor darkRedColor];
        
        _priceLabel.adjustsFontSizeToFitWidth = YES;
        
        _priceLabel.shadowColor = [UIColor whiteColor];
        _priceLabel.shadowOffset = CGSizeMake(1, 1);
        
		[self.contentView addSubview:_priceLabel];
    }
    
    return _priceLabel;
}

- (StrikeThroughLabel *)oldPriceLabel
{
    if (!_oldPriceLabel)
    {
		_oldPriceLabel = [[StrikeThroughLabel alloc] initWithFrame:CGRectMake(120, 30, 170, 20)];
        _oldPriceLabel.isWithStrikeThrough = YES;
		_oldPriceLabel.backgroundColor = [UIColor clearColor];
        _oldPriceLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _oldPriceLabel.textColor = [UIColor lightGrayColor];
        _oldPriceLabel.adjustsFontSizeToFitWidth = YES;
        
        _oldPriceLabel.shadowColor = [UIColor whiteColor];
        _oldPriceLabel.shadowOffset = CGSizeMake(1, 1);
        
		[self.contentView addSubview:_oldPriceLabel];
    }
    return _oldPriceLabel;
}


#pragma mark -
#pragma mark action

- (void)modifyChecked
{
    if ([_delegate respondsToSelector:@selector(accessoryProductCheckStateShouldChange:)])
    {
        BOOL shouldChange = [_delegate accessoryProductCheckStateShouldChange:self.tag];
        if (shouldChange)
        {
            [self setCheckButtonIsChecked:!isChecked];
        }
    }
}

- (void)setCheckButtonIsChecked:(BOOL)checked
{
    isChecked = checked;
    if (checked)
    {
        [self.checkButton setImage:[UIImage imageNamed:@"shop_cart_checked.png"]
                          forState:UIControlStateNormal];
    }
    else
    {
        [self.checkButton setImage:[UIImage imageNamed:@"shop_cart_unchecked.png"]
                          forState:UIControlStateNormal];
    }
}

+ (CGFloat)height
{
    return 80;
}
@end
