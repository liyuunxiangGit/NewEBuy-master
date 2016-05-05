//
//  AdModel4Cell.m
//  SuningEBuy
//
//  Created by xmy on 18/7/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AdModel4Cell.h"
#import "ProductUtil.h"
#import "RegexKitLite.h"

#define ImageViewWidth 280
#define ImageViewHeight 270

#define ViewWidth 290
#define ViewHeight 280
@implementation AdModel4Cell

- (void)dealloc {
    TT_RELEASE_SAFELY(innerAdImageView_);
    TT_RELEASE_SAFELY(_productNameLbl);
    TT_RELEASE_SAFELY(_yiGouLbl);
    TT_RELEASE_SAFELY(_priceLbl);
    
    TT_RELEASE_SAFELY(_salesSmallImage);
    TT_RELEASE_SAFELY(_bigBackImageView)
    
}


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (UILabel *) productNameLbl{
	
	if (!_productNameLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:12];
		
		_productNameLbl = [[UILabel alloc] init];
        
        _productNameLbl.textAlignment = UITextAlignmentLeft;
		
		_productNameLbl.backgroundColor = [UIColor clearColor];
        
        _productNameLbl.textColor = [UIColor darkTextColor];
        
		_productNameLbl.font = font;
		
		_productNameLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _productNameLbl.lineBreakMode = UILineBreakModeWordWrap;
        
        _productNameLbl.numberOfLines = 2;
        
        _productNameLbl.shadowColor = [UIColor clearColor];
        
        _productNameLbl.shadowOffset = CGSizeMake(1, 1);
        
		[self.contentView addSubview:_productNameLbl];
	}
	
	return _productNameLbl;
}

- (UILabel *) yiGouLbl{
	
	if (!_yiGouLbl) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:12];
		
		_yiGouLbl = [[UILabel alloc] init];
        
        _yiGouLbl.textAlignment = UITextAlignmentLeft;
		
		_yiGouLbl.backgroundColor = [UIColor clearColor];
        
//        _yiGouLbl.textColor = RGBCOLOR(140, 121, 68);
        
		_yiGouLbl.font = font;
		
        _yiGouLbl.shadowColor = [UIColor clearColor];
        
        _yiGouLbl.shadowOffset = CGSizeMake(1, 1);
        
        _yiGouLbl.textColor = [UIColor dark_Gray_Color];// RGBCOLOR(219, 0, 0);
        
		[self.contentView addSubview:_yiGouLbl];
	}
	
	return _yiGouLbl;
}

- (UILabel *)priceLbl{
    
    if (!_priceLbl) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        
        _priceLbl = [[UILabel alloc] init];
        
        _priceLbl.textAlignment = UITextAlignmentLeft;
        
        _priceLbl.backgroundColor = [UIColor clearColor];
        
        _priceLbl.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);

        _priceLbl.font = font;
        
        _priceLbl.autoresizingMask = UIViewAutoresizingNone;
        
        _priceLbl.adjustsFontSizeToFitWidth = YES;
        
        _priceLbl.shadowColor = [UIColor clearColor];
        
        _priceLbl.shadowOffset = CGSizeMake(1, 1);
        
        [_priceLbl.layer setCornerRadius:6.0];
        
        [_priceLbl.layer  setMasksToBounds:YES];
        
        [self.contentView addSubview:_priceLbl];
        
        
    }
    
    return _priceLbl;
    
}

- (UILabel *)priceHintLabel {
    if (!_priceHintLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:14];
        
        _priceHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 25, 23)];
        _priceHintLabel.text = @"￥";
        _priceHintLabel.textAlignment = NSTextAlignmentLeft;
        _priceHintLabel.backgroundColor = [UIColor clearColor];
        _priceHintLabel.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);//RGBCOLOR(190, 3, 7);
        _priceHintLabel.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
        //        _priceHintLabel.autoresizingMask = UIViewAutoresizingNone;
        _priceHintLabel.hidden = YES;
        [self.contentView addSubview:_priceHintLabel];
    }
    return _priceHintLabel;
}

- (EGOImageViewEx *)priceImageView {
    if (!_priceImageView) {
        _priceImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(30, 5, 100, 13)];
        
        _priceImageView.backgroundColor =[UIColor clearColor];
        
        _priceImageView.cacheOptions = (1 << 4);
        
        _priceImageView.contentMode = UIViewContentModeLeft;
        
        _priceImageView.userInteractionEnabled = NO;
        _priceImageView.hidden = YES;
        [self.contentView addSubview:_priceImageView];
    }
    return _priceImageView;
}

- (UIImageView *)bigBackImageView
{
    if (!_bigBackImageView) {
        _bigBackImageView  = [[UIImageView alloc] init];
        
        _bigBackImageView.frame = CGRectMake(15, 10, ViewWidth, ViewHeight);
        
        _bigBackImageView.userInteractionEnabled = YES;
        
//        _bigBackImageView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
//        
//        _bigBackImageView.layer.borderWidth = 0.5f;
        //        [_leftBackgroundView.layer setCornerRadius:6.0];
        
        //        [_leftBackgroundView.layer  setMasksToBounds:YES];
        
        _bigBackImageView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_bigBackImageView];

    }
    return _bigBackImageView;
}

- (EGOImageViewEx *)innerAdimageView{
    
    if (!innerAdImageView_) {
        
        innerAdImageView_ = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(5, 5, ImageViewWidth, ImageViewHeight)];
		
		innerAdImageView_.backgroundColor =[UIColor clearColor];
        
        innerAdImageView_.contentMode = UIViewContentModeScaleAspectFit;
        
        innerAdImageView_.userInteractionEnabled = YES;
        
        innerAdImageView_.exDelegate = self;
        
        innerAdImageView_.tag = 0;
        
//        innerAdImageView_.layer.masksToBounds = NO;
        
//        innerAdImageView_.layer.shadowOffset = CGSizeMake(0, 0);
        
//        innerAdImageView_.layer.shadowRadius = 2.0;
        
//        innerAdImageView_.layer.shadowColor = [UIColor blackColor].CGColor;
        
//        innerAdImageView_.layer.shadowOpacity = 0.8;
        
//        [innerAdImageView_.layer setCornerRadius:6.0];
        
//        [innerAdImageView_.layer  setMasksToBounds:YES];
        
        [self.bigBackImageView addSubview:innerAdImageView_];
}
    
    return innerAdImageView_;
}

-(UIImageView *)salesSmallImage
{
    if (_salesSmallImage == nil)
    {
        _salesSmallImage = [[UIImageView alloc]initWithFrame:CGRectMake(-10, -8, 74.5,72)];
        _salesSmallImage.userInteractionEnabled = YES;
        
        _salesSmallImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.innerAdimageView insertSubview:_salesSmallImage aboveSubview:innerAdImageView_];
    }
    return _salesSmallImage;
}

- (UILabel*)salesBigBangNameLbl
{
    if(!_salesBigBangNameLbl)
    {
        _salesBigBangNameLbl = [[UILabel alloc] init];
        _salesBigBangNameLbl.backgroundColor = [UIColor clearColor];
        _salesBigBangNameLbl.textColor = [UIColor whiteColor];
        _salesBigBangNameLbl.font = [UIFont systemFontOfSize:16];
        _salesBigBangNameLbl.frame = CGRectMake(10, 0, 45, 45);
        _salesBigBangNameLbl.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4*(-1));
         [self.salesSmallImage insertSubview:_salesBigBangNameLbl aboveSubview:_salesSmallImage];
    }
    
    return _salesBigBangNameLbl;
}

- (void)setItem:(InnerProductDTO *)ainnerDto withTag:(NSInteger)index
{
    self.innerDto = ainnerDto;
    self.innerAdimageView.userInteractionEnabled = YES;
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.innerAdimageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.innerDto.productCode size:ProductImageSize400x400];
    }
    else{
        
        self.innerAdimageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.innerDto.productCode size:ProductImageSize200x200];
    }
    
    self.innerAdimageView.tag = index;
    
    self.productNameLbl.text = self.innerDto.productName;
    
    //add by zhangbeibei:老的商品列表接口是返回了价格Sring，新的没有，需要自己显示价格图片
    double price = [self.innerDto.productPrice doubleValue];
    if (price <= 0) {
        
        if (self.innerDto.priceImageURL) {
            //显示价格图片
            self.priceHintLabel.hidden = NO;
            self.priceImageView.hidden = NO;
            self.priceImageView.imageURL = self.innerDto.priceImageURL;
            
        }
        else {
            //        self.priceLbl.text =  L(@"saleOut");
            self.priceHintLabel.hidden = YES;
            self.priceImageView.hidden = YES;
            self.yiGouLbl.text = L(@"saleOut");
            self.priceLbl.text = nil; // !!! 必须nil，cell重用 不会抹掉之前的数据
        }

    }else{

        self.priceHintLabel.hidden = YES;
        self.priceImageView.hidden = YES;
        self.yiGouLbl.text = L(@"PREbuyPrice");
        
        NSString *priceStr = [NSString stringWithFormat:@"￥%.2f",price];
        
        self.priceLbl.text = priceStr;
        
        self.priceLbl.textColor = RGBCOLOR(219, 0, 0);

    }
    
    self.salesBigBangNameLbl.text = self.innerDto.bigBang;//@"热销";
    
    if ([self.innerDto.bigBang isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesSmallImage.hidden = NO;
        
        [self.salesSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_big.png"]]];
    }
    else
    {
        self.salesSmallImage.hidden = YES;
    }
    
    [self setNeedsLayout];
}

- (void)updateCellProductPriceImage {
    if (self.priceImageView.hidden == NO) {
        self.priceImageView.imageURL = [ProductUtil minPriceImageOfProductId:self.innerDto.productId productCode:self.innerDto.productCode city:[Config currentConfig].defaultCity shopCode:self.innerDto.vendorCode];
    }
}

- (void)layoutSubviews{
	
    [super layoutSubviews];
    
    self.innerAdimageView.frame = CGRectMake(5, 5, ImageViewWidth,ImageViewHeight);
    self.productNameLbl.frame = CGRectMake(15, self.bigBackImageView.bottom+10, 300,40);
    self.yiGouLbl.frame = CGRectMake(15, self.productNameLbl.bottom+5, 50, 18);
    self.priceLbl.frame = CGRectMake(self.yiGouLbl.right, self.productNameLbl.bottom+5, 250,18);
    self.priceHintLabel.frame = CGRectMake(self.yiGouLbl.right-42-10, self.productNameLbl.bottom+3, 16,23);
    self.priceImageView.frame = CGRectMake(self.priceHintLabel.right+2, self.productNameLbl.bottom+7, 70,13);

    
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    DataProductBasic *productDto = self.innerDto.transformToProductDTO;
   
    if ([self.imageDidDelegate conformsToProtocol:@protocol(Model4Delegate)])
    {
        if ([self.imageDidDelegate respondsToSelector:@selector(cellImageDidClicked:)])
        {
            [self.imageDidDelegate cellImageDidClicked:productDto];
        }
    }
    
    TT_RELEASE_SAFELY(productDto);
    
}


@end
