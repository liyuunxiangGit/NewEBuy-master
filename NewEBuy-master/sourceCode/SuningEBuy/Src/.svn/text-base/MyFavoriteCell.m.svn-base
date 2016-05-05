//
//  MyFavoriteCell.m
//  SuningEBuy
//
//  Created by huangtf on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//
#import "MyFavoriteCell.h"
#import "ProductUtil.h"
#define  BOOLMARK_CELL_HEIGHT   80


@implementation MyFavoriteCell


@synthesize item                            = _item;
//@synthesize myFavoriteDateLbl               = _myFavoriteDateLbl;
@synthesize separatorLine                   = _separatorLine;
@synthesize addToShopCartBtn                = _addToShopCartBtn;
@synthesize iconImageView                   = _iconImageView;
@synthesize titleLbl                        = _titleLbl;
@synthesize subtitleLbl                     = _subtitleLbl;
@synthesize productDescriptionLabel         = _productDescriptionLabel;
-(void)dealloc
{
    TT_RELEASE_SAFELY(_subtitleLbl);
    
    TT_RELEASE_SAFELY(_titleLbl);
    
    TT_RELEASE_SAFELY(_addToShopCartBtn);
    
    TT_RELEASE_SAFELY(_item);
    
    TT_RELEASE_SAFELY(_iconImageView);
    
//    TT_RELEASE_SAFELY(_myFavoriteDateLbl);
    
    TT_RELEASE_SAFELY(_separatorLine);
    
    TT_RELEASE_SAFELY(_productDescriptionLabel);
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}


- (UILabel *)productDescriptionLabel
{
    if (!_productDescriptionLabel) {
        
		_productDescriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(77, 33,  220, 13)];
		
		_productDescriptionLabel.backgroundColor = [UIColor clearColor];
        
		_productDescriptionLabel.font = [UIFont systemFontOfSize:12.0];
        
        _productDescriptionLabel.textColor = [UIColor lightTextColor];//RGBCOLOR(165, 163, 158);
		
        //		productDescriptionLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        //        productDescriptionLabel_.numberOfLines = 2;
		
		[self.contentView addSubview:_productDescriptionLabel];
	}
	
	return _productDescriptionLabel;
}


//-(UILabel *)myFavoriteDateLbl
//{
//    if (!_myFavoriteDateLbl) {
//        
//        UIFont *font = [UIFont boldSystemFontOfSize:12];
////        CGSize size = [@"a" sizeWithFont:font];
//        _myFavoriteDateLbl = [[UILabel alloc] initWithFrame:CGRectMake(77, 52, 150, 12)];
//        _myFavoriteDateLbl.backgroundColor = [UIColor clearColor];
//        _myFavoriteDateLbl.font = font;
//        _myFavoriteDateLbl.autoresizingMask = UIViewAutoresizingNone;
////        [self.contentView addSubview:_myFavoriteDateLbl];
//    }
//    return _myFavoriteDateLbl;
//}

-(EGOImageView *)iconImageView
{
    if (!_iconImageView) 
    {
        
        _iconImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 12, 53, 53)];
        _iconImageView.backgroundColor = [UIColor clearColor];
        _iconImageView.contentMode = UIViewContentModeScaleAspectFill;
        _iconImageView.layer.borderWidth = 0.5;
//        _iconImageView.layer.cornerRadius = 5;
//        _iconImageView.layer.masksToBounds = YES;
        _iconImageView.userInteractionEnabled = YES;
        _iconImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView addSubview:_iconImageView];
        
    }

    return _iconImageView;
}

-(UIImageView *)separatorLine
{
    if (!_separatorLine) {
        _separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(15, 78, 305, 1)];
        _separatorLine.backgroundColor = [UIColor clearColor];
//        [self.contentView addSubview:_separatorLine];
    }
    
    return _separatorLine;
}

- (UIButton *)addToShopCartBtn
{
    if (!_addToShopCartBtn) {
        _addToShopCartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [_addToShopCartBtn setTitle:L(@"MyEBuy_BuyNow") forState:UIControlStateNormal];
        
        UIImage *image = [UIImage streImageNamed:@"yellowButton_new.png"];
        [_addToShopCartBtn setBackgroundImage:image forState:UIControlStateNormal];
                
        _addToShopCartBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
        
        [_addToShopCartBtn setTitleColor:[UIColor colorWithRGBHex:0x825201] forState:UIControlStateNormal];
     
//        [self.contentView addSubview:_addToShopCartBtn];
    }
    return _addToShopCartBtn;
}


+(CGFloat)height:(DataProductBasic *)item
{
    if (!item) {
        return BOOLMARK_CELL_HEIGHT;
    }
    
    return BOOLMARK_CELL_HEIGHT;

}

-(void)setItem:(DataProductBasic *)aitem
{
    if (aitem != _item) {
        _item = aitem;
        self.titleLbl.text = _item.productName;
        
        self.subtitleLbl.textColor = [UIColor orange_Red_Color];
        CGFloat price = [_item.price floatValue];
        if (price <= 0) {
            self.subtitleLbl.text = L(@"MyEBuy_SoldOut");
        }else{
            self.subtitleLbl.text = [NSString stringWithFormat:@"￥%.2f",price];
        }
//        NSString *cityId = _item.cityCode.length > 0 ? _item.cityCode : [Config currentConfig].defaultCity;
        
        
        
        //self.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:item.productId city:cityId];
        
//        self.subtitleImg.imageURL = [ProductUtil minPriceImageOfProductId:_item.productId
//                                                                           city:cityId];
        
        
        self.vendorNameLbl.text = _item.vendorName;
//        NSString *collectTime = [[NSString alloc] initWithFormat:@"%@:%@",L(@"bookmark time"),_item.collectTime];
//        self.myFavoriteDateLbl.text = collectTime;
//        self.myFavoriteDateLbl.textColor = [UIColor grayColor];
//        self.myFavoriteDateLbl.font = [UIFont systemFontOfSize:13];
//        TT_RELEASE_SAFELY(collectTime);
        
        self.productDescriptionLabel.text = _item.special;
        
//        self.iconImageView.imageURL = aitem.productImageURL;
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:aitem.productCode size: ProductImageSize160x160];
        }
        else{
        
            self.iconImageView.imageURL = [ProductUtil getImageUrlWithProductCode:aitem.productCode size: ProductImageSize100x100];
        }
//        self.separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];
        self.separatorLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
    }
}


-(UILabel *) titleLbl{
	
	if (!_titleLbl) {
		
		UIFont *font = [UIFont systemFontOfSize:14.f];
		
//		CGSize size = [@"a" sizeWithFont:font];
		
		_titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(77, 15, 100, 20)];
		
		_titleLbl.backgroundColor = [UIColor clearColor];
		
		_titleLbl.font = font;
		
		_titleLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_titleLbl];
	}
    
	return _titleLbl;
}

- (UILabel *)vendorNameLbl
{
    if (!_vendorNameLbl) {
        
        _vendorNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(77, 50, 220, 20)];
        
        _vendorNameLbl.backgroundColor = [UIColor clearColor];
        
        _vendorNameLbl.font = [UIFont systemFontOfSize:13];
        
        _vendorNameLbl.textColor = [UIColor grayColor];
        
        _vendorNameLbl.autoresizingMask = UIViewAutoresizingNone;
        
        [self.contentView addSubview:_vendorNameLbl];
    }
    return _vendorNameLbl;
}

-(UILabel *) subtitleLbl{
	
	if (!_subtitleLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:15];
		
//		CGSize size = [@"a" sizeWithFont:font];
		
		_subtitleLbl = [[UILabel alloc] initWithFrame:CGRectMake(77, 32, 150, 20)];
		
		_subtitleLbl.backgroundColor = [UIColor clearColor];
		
		_subtitleLbl.font = font;
		
		_subtitleLbl.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:_subtitleLbl];
	}
	
	return _subtitleLbl;
}

-(void)layoutSubviews
{
    [super layoutSubviews];

//    float paddingTop = (self.contentView.height-self.titleLbl.height-self.subtitleLbl.height-12-5*2)/2;
    self.titleLbl.top = self.iconImageView.top;
    self.titleLbl.left = self.iconImageView.right+10;
    self.titleLbl.width = self.contentView.width-self.iconImageView.width -40;
    
//    self.productDescriptionLabel.top = self.subtitleLbl.bottom+5;
//    self.productDescriptionLabel.left = self.titleLbl.left;
//    self.productDescriptionLabel.width = 130;

    
//    self.subtitleLbl.top = self.productDescriptionLabel.bottom+ 13;
//    self.subtitleLbl.left = self.productDescriptionLabel.left;
//    self.subtitleLbl.width = self.productDescriptionLabel.width;
    
    
//    self.productDescriptionLabel.top = self.subtitleLbl.bottom+5;
//    self.productDescriptionLabel.left = self.titleLbl.left;
//    self.productDescriptionLabel.width = 130;

    self.addToShopCartBtn.frame = CGRectMake(226, 42, 80, 30);
    
//    self.addToShopCartBtn.frame = CGRectMake(self.myFavoriteDateLbl.right + 18, self.myFavoriteDateLbl.top - 10, 80, 30);

}




@end
