//
//  AdModel6Cell.m
//  SuningEBuy
//
//  Created by xmy on 18/7/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AdModel6Cell.h"
#import "ProductUtil.h"

#import "RegexKitLite.h"

#define ImageViewWidth 135
#define ImageViewHeight 115

#define ViewWidth  145
#define ViewHeight 180+30

@implementation AdModel6Cell


- (void)dealloc
{
    TT_RELEASE_SAFELY(_leftLabel);
    TT_RELEASE_SAFELY(_rightLabel);
    
    TT_RELEASE_SAFELY(_leftImageView);
    TT_RELEASE_SAFELY(_rightImageView);
    
    TT_RELEASE_SAFELY(_leftBackImageView);
    TT_RELEASE_SAFELY(_rightBackImageView);
    
    TT_RELEASE_SAFELY(leftPriceLabel_);
    TT_RELEASE_SAFELY(rightPriceLabel_);
    
    TT_RELEASE_SAFELY(leftDto_);
    TT_RELEASE_SAFELY(rightDto_);
    
    TT_RELEASE_SAFELY(_leftBackgroundView);
    TT_RELEASE_SAFELY(_rightBackgroundView);
    
    TT_RELEASE_SAFELY(_salesLeftSmallImage);
    TT_RELEASE_SAFELY(_salesRightSmallImage);
    
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
        
        self.userInteractionEnabled = YES;
        
	}
	
	return self;
}

//- (UILabel *)floorLbl{
//    
//    if (!_floorLbl) {
//        
//        UIFont *font = [UIFont boldSystemFontOfSize:12];
//        
//        _floorLbl = [[UILabel alloc] init];
//        
//        _floorLbl.textAlignment = UITextAlignmentLeft;
//        
//        _floorLbl.backgroundColor = [UIColor whiteColor];//RGBCOLOR(250, 231, 227);
//        
//        //        _floorLbl.textColor = RGBCOLOR(167, 63, 153);
//        
//        _floorLbl.textColor = [UIColor darkTextColor];
//        
//        _floorLbl.font = font;
//        
//        _floorLbl.autoresizingMask = UIViewAutoresizingNone;
//        
//        _floorLbl.adjustsFontSizeToFitWidth = YES;
//        
//        _floorLbl.shadowColor = [UIColor whiteColor];
//        
//        _floorLbl.shadowOffset = CGSizeMake(1, 1);
//        
//        [self.contentView addSubview:_floorLbl];
//    }
//    
//    return _floorLbl;
//}


- (UILabel *) leftLabel{
	
	if (!_leftLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:12];
		
		_leftLabel = [[UILabel alloc] init];
        
        _leftLabel.textAlignment = UITextAlignmentLeft;
		
		_leftLabel.backgroundColor = [UIColor clearColor];;//RGBCOLOR(242, 242, 242);//RGBCOLOR(250, 231, 227);
        
        _leftLabel.textColor = [UIColor darkTextColor];
        
		_leftLabel.font = font;
		
		_leftLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _leftLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        _leftLabel.numberOfLines = 2;
        
        _leftLabel.shadowColor = [UIColor clearColor];
        
        _leftLabel.shadowOffset = CGSizeMake(1, 1);
        
        [_leftLabel.layer setCornerRadius:6.0];
        
        [_leftLabel.layer  setMasksToBounds:YES];
        
		[self.leftBackgroundView addSubview:_leftLabel];
	}
	
	return _leftLabel;
}


- (UILabel *)leftPriceLabel{
    
    if (!leftPriceLabel_) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        leftPriceLabel_ = [[UILabel alloc] init];
        
        leftPriceLabel_.textAlignment = UITextAlignmentLeft;
        
        leftPriceLabel_.backgroundColor = [UIColor clearColor];//RGBCOLOR(250, 231, 227);
        
        leftPriceLabel_.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);
        
        leftPriceLabel_.font = font;
        
        leftPriceLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        leftPriceLabel_.adjustsFontSizeToFitWidth = YES;
        
        leftPriceLabel_.shadowColor = [UIColor whiteColor];
        
        leftPriceLabel_.shadowOffset = CGSizeMake(1, 1);
        
        [leftPriceLabel_.layer setCornerRadius:6.0];
        
        [leftPriceLabel_.layer  setMasksToBounds:YES];
        
        [self.leftBackgroundView addSubview:leftPriceLabel_];
        
        
    }
    
    return leftPriceLabel_;
    
}


- (EGOImageViewEx *)leftPriceImageView {
    if (!_leftPriceImageView) {
        _leftPriceImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(30, 5, 50, 13)];
        _leftPriceImageView.contentMode = UIViewContentModeLeft;
        
        _leftPriceImageView.backgroundColor =[UIColor clearColor];
        
        _leftPriceImageView.cacheOptions = (1 << 4);
        
//        _leftPriceImageView.contentMode = UIViewContentModeLeft;
        
        _leftPriceImageView.userInteractionEnabled = NO;
        _leftPriceImageView.hidden = YES;
        [self.leftBackgroundView addSubview:_leftPriceImageView];
    }
    return _leftPriceImageView;
}

- (EGOImageViewEx *)rightPriceImageView {
    if (!_rightPriceImageView) {
        _rightPriceImageView = [[EGOImageViewEx alloc] init];
        
        _rightPriceImageView.backgroundColor =[UIColor clearColor];
        
        _rightPriceImageView.cacheOptions = (1 << 4);
        
        _rightPriceImageView.contentMode = UIViewContentModeLeft;
        
        _rightPriceImageView.userInteractionEnabled = NO;
        _rightPriceImageView.hidden = YES;
        [self.rightBackgroundView addSubview:_rightPriceImageView];
    }
    return _rightPriceImageView;
}

- (UILabel *) rightLabel{
	
	if (!_rightLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:12];
		
		_rightLabel = [[UILabel alloc] init];
        
        _rightLabel.textAlignment = UITextAlignmentLeft;
		
		_rightLabel.backgroundColor = [UIColor clearColor];//RGBCOLOR(242, 242, 242);//RGBCOLOR(250, 231, 227);
        
        _rightLabel.textColor = [UIColor darkTextColor];
        
		_rightLabel.font = font;
		
		_rightLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _rightLabel.lineBreakMode = UILineBreakModeWordWrap;
        
        _rightLabel.numberOfLines = 2;
        
        _rightLabel.shadowColor = [UIColor clearColor];
        
        _rightLabel.shadowOffset = CGSizeMake(1, 1);
        
        [_rightLabel.layer setCornerRadius:6.0];
        
        [_rightLabel.layer  setMasksToBounds:YES];
        
        [self.rightBackgroundView addSubview:_rightLabel];
		
	}
	
	return _rightLabel;
}

- (UILabel *)rightPriceLabel{
    
    if (!rightPriceLabel_) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        rightPriceLabel_ = [[UILabel alloc] init];
        
        rightPriceLabel_.textAlignment = UITextAlignmentLeft;
        
        rightPriceLabel_.backgroundColor =[UIColor clearColor];// RGBCOLOR(242, 242, 242);//RGBCOLOR(250, 231, 227);
        
        rightPriceLabel_.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);
        
        rightPriceLabel_.font = font;
        
        rightPriceLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        rightPriceLabel_.adjustsFontSizeToFitWidth = YES;
        
        rightPriceLabel_.shadowColor = [UIColor whiteColor];
        
        rightPriceLabel_.shadowOffset = CGSizeMake(1, 1);
        
        [rightPriceLabel_.layer setCornerRadius:6.0];
        
        [rightPriceLabel_.layer  setMasksToBounds:YES];
        
        [self.rightBackgroundView addSubview:rightPriceLabel_];
    }
    
    return rightPriceLabel_;
}

- (EGOImageViewEx *)leftImageView{
	
	if (!_leftImageView) {
		
        //modified by zhangbeibei:20141020 调整商品图片为正方形
		_leftImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth)];
		
		_leftImageView.backgroundColor =[UIColor whiteColor];
        
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _leftImageView.userInteractionEnabled = YES;
        
        _leftImageView.exDelegate = self;
        
        _leftImageView.tag = 0;
        
//        [_leftImageView.layer setCornerRadius:6.0];
        
//        [_leftImageView.layer  setMasksToBounds:YES];
        
        [self.leftBackgroundView addSubview:_leftImageView];
        
	}
	
	return _leftImageView;
}

- (EGOImageViewEx *) rightImageView{
	
	if (!_rightImageView) {
		
		_rightImageView = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth)];
        
        _rightImageView.userInteractionEnabled = YES;
		
		_rightImageView.backgroundColor =[UIColor whiteColor];
        
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
                
        _rightImageView.exDelegate = self;
        
        _rightImageView.tag = 1;
        
//        [_rightImageView.layer setCornerRadius:6.0];
        
//        [_rightImageView.layer  setMasksToBounds:YES];
        
        [self.rightBackgroundView addSubview:_rightImageView];
	}
    
	return _rightImageView;
}

- (UIImageView*)leftBackImageView
{
    if(_leftBackImageView == nil)
    {
        _leftBackImageView = [[UIImageView alloc] init];
        
        _leftBackImageView.frame = CGRectMake(10, 10, ViewWidth, ViewHeight);
        
        _leftBackImageView.userInteractionEnabled = YES;
        
        [_leftBackImageView.layer setCornerRadius:6.0];
        
        [_leftBackImageView.layer  setMasksToBounds:YES];
        
        _leftBackgroundView.backgroundColor = [UIColor whiteColor];
        
        //        [self.contentView addSubview:_leftBackImageView];
    }
    
    return _leftBackImageView;
}

- (UIImageView*)rightBackImageView
{
    if(_rightBackImageView == nil)
    {
        //        _rightBackImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bangdan_back_btn.png"]];
        
        _rightBackImageView = [[UIImageView alloc] init];
        
        _rightBackImageView.frame = CGRectMake(162, 10, ViewWidth, ViewHeight);
        
        _rightBackImageView.backgroundColor = [UIColor clearColor];
        
        _rightBackImageView.userInteractionEnabled = YES;
        
        [_rightBackImageView.layer setCornerRadius:6.0];
        
        [_rightBackImageView.layer  setMasksToBounds:YES];
        
        //        [self.contentView addSubview:_rightBackImageView];
    }
    
    return _rightBackImageView;
}

- (UIView*)leftBackgroundView
{
    if(_leftBackgroundView == nil)
    {
        _leftBackgroundView = [[UIView alloc] init];
        
        _leftBackgroundView.frame = CGRectMake(10, 10, ViewWidth, ViewHeight);
        
        _leftBackgroundView.userInteractionEnabled = YES;
        
//        _leftBackgroundView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
//        _leftBackgroundView.layer.borderWidth = 0.5f;
//        [_leftBackgroundView.layer setCornerRadius:6.0];
        
//        [_leftBackgroundView.layer  setMasksToBounds:YES];
        
        _leftBackgroundView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_leftBackgroundView];
    }
    
    return _leftBackgroundView;
}

- (UIView*)rightBackgroundView
{
    if(_rightBackgroundView == nil)
    {
        _rightBackgroundView = [[UIView alloc] init];
        
        _rightBackgroundView.frame = CGRectMake(162, 10, ViewWidth, ViewHeight);
        
        _rightBackgroundView.userInteractionEnabled = YES;
        
//        _rightBackgroundView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
//        _rightBackgroundView.layer.borderWidth = 0.5f;

//        [_rightBackgroundView.layer setCornerRadius:6.0];
        
//        [_rightBackgroundView.layer  setMasksToBounds:YES];
        
        _rightBackgroundView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_rightBackgroundView];
    }
    
    return _rightBackgroundView;
}
-(UIImageView *)salesLeftSmallImage
{
    if (_salesLeftSmallImage == nil)
    {
        //modified by zhangbeibei:20141021 保持爆炸帖在商品图片的右上角
        _salesLeftSmallImage = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth - 33, -5, 33,36)];
        _salesLeftSmallImage.userInteractionEnabled = YES;
        
        _salesLeftSmallImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.leftImageView insertSubview:_salesLeftSmallImage aboveSubview:_leftImageView];
    }
    return _salesLeftSmallImage;
}
-(UIImageView *)salesRightSmallImage
{
    if (_salesRightSmallImage == nil)
    {
        _salesRightSmallImage = [[UIImageView alloc]initWithFrame:CGRectMake(ViewWidth - 33, -5, 33,36)];
        _salesRightSmallImage.userInteractionEnabled = YES;
        
        _salesRightSmallImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.rightImageView insertSubview:_salesRightSmallImage aboveSubview:_rightImageView];
    }
    return _salesRightSmallImage;
}


- (UILabel *)leftHintLabel {
    if (!_leftHintLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        
        _leftHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 25, 23)];
        _leftHintLabel.text = @"￥";
        _leftHintLabel.textAlignment =  NSTextAlignmentLeft;
        _leftHintLabel.backgroundColor = [UIColor clearColor];
        _leftHintLabel.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);//RGBCOLOR(190, 3, 7);
        _leftHintLabel.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
        //        _priceHintLabel.autoresizingMask = UIViewAutoresizingNone;
        _leftHintLabel.hidden = YES;
        [self.leftBackgroundView addSubview:_leftHintLabel];
    }
    return _leftHintLabel;
}

- (UILabel *)rightHintLabel {
    if (!_rightHintLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        
        _rightHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 25, 23)];
        _rightHintLabel.text = @"￥";
        _rightHintLabel.textAlignment = NSTextAlignmentLeft;
        _rightHintLabel.backgroundColor = [UIColor clearColor];
        _rightHintLabel.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);//RGBCOLOR(190, 3, 7);
        _rightHintLabel.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
        //        _priceHintLabel.autoresizingMask = UIViewAutoresizingNone;
        _rightHintLabel.hidden = YES;
        [self.rightBackgroundView addSubview:_rightHintLabel];
    }
    return _rightHintLabel;
}



+ (CGFloat) height{
	return  ViewHeight+30;
}

- (UILabel*)salesLeftBigBangName
{
    if(!_salesLeftBigBangName)
    {
        _salesLeftBigBangName = [[UILabel alloc] init];
        _salesLeftBigBangName.backgroundColor = [UIColor clearColor];
        _salesLeftBigBangName.textColor = [UIColor whiteColor];
        _salesLeftBigBangName.font = [UIFont systemFontOfSize:12];
        _salesLeftBigBangName.frame = CGRectMake(12, 3, 15, 30);
        _salesLeftBigBangName.numberOfLines = 2;
        
        [self.salesLeftSmallImage insertSubview:_salesLeftBigBangName aboveSubview:_salesLeftSmallImage];
    }
    
    return _salesLeftBigBangName;
}

- (UILabel*)salesRightBigBangName
{
    if(!_salesRightBigBangName)
    {
        _salesRightBigBangName = [[UILabel alloc] init];
        _salesRightBigBangName.backgroundColor = [UIColor clearColor];
        _salesRightBigBangName.textColor = [UIColor whiteColor];
        _salesRightBigBangName.font = [UIFont systemFontOfSize:12];
        _salesRightBigBangName.frame = CGRectMake(12, 3, 15, 30);
        _salesRightBigBangName.numberOfLines = 2;
        [self.salesRightSmallImage insertSubview:_salesRightBigBangName aboveSubview:_salesRightSmallImage];
    }
    
    return _salesRightBigBangName;
}

- (void)setItem:(InnerProductDTO *)aLeftDto
      rightItem:(InnerProductDTO *)aRightDto
        withTag:(NSInteger)index
{
    self.leftDto = aLeftDto;
    
    self.leftImageView.userInteractionEnabled = YES;
    
    self.salesLeftBigBangName.text = self.leftDto.bigBang;//@"热销";
    
    if ([self.leftDto.bigBang isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesLeftSmallImage.hidden = NO;
        
        [self.salesLeftSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_middle.png"]]];
    }
    else
    {
        self.salesLeftSmallImage.hidden = YES;
    }
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.leftImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.leftDto.productCode size:ProductImageSize200x200];
    }
    else{
        //add by zhangbeibei:20141021 陈磊要求修改尺寸
        self.leftImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.leftDto.productCode size:ProductImageSize160x160];
    }
    
    self.leftLabel.text = self.leftDto.productName;
    
    //add by zhangbeibei:老的商品列表接口是返回了价格Sring，新的没有，需要自己显示价格图片
    double price = [self.leftDto.productPrice doubleValue];
    if (price <= 0) {
        if (self.leftDto.priceImageURL) {
            //显示价格图片
            self.leftHintLabel.hidden = NO;
            self.leftPriceImageView.hidden = NO;
            self.leftPriceImageView.imageURL = self.leftDto.priceImageURL;
        }
        else {
            self.leftHintLabel.hidden = YES;
            self.leftPriceImageView.hidden = YES;
            self.leftPriceLabel.text = L(@"saleOut");
        }
    }
    else {
        NSString *leftPrice = [NSString stringWithFormat:@"￥%.2f",price];
        self.leftPriceLabel.text = leftPrice;
    }
    
    self.rightDto = aRightDto;
    self.salesRightBigBangName.text = self.rightDto.bigBang;//@"热销";
    
    if ([self.rightDto.bigBang isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesRightSmallImage.hidden = NO;
        [self.salesRightSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_middle.png"]]];
    }
    else
    {
        self.salesRightSmallImage.hidden = YES;
    }
    
    if (aRightDto == nil) {
        
        [self.rightBackgroundView removeFromSuperview];
        
    }else{
        
        [self.contentView addSubview:self.rightBackgroundView];
        self.rightImageView.userInteractionEnabled = YES;
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.rightImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.rightDto.productCode size:ProductImageSize200x200];
        }
        else{
            
            self.rightImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.rightDto.productCode size:ProductImageSize160x160];
        }
        self.rightLabel.text = self.rightDto.productName;
        
        price = [self.rightDto.productPrice doubleValue];
        if (price <= 0) {
            if (self.rightDto.priceImageURL) {
                //显示价格图片
                self.rightHintLabel.hidden = NO;
                self.rightPriceImageView.hidden = NO;
                self.rightPriceImageView.imageURL = self.rightDto.priceImageURL;
            }
            else {
                self.rightPriceLabel.text = L(@"saleOut");
                self.rightHintLabel.hidden = YES;
                self.rightPriceImageView.hidden = YES;
            }
        }else{
            NSString *rightPrice = [NSString stringWithFormat:@"￥%.2f",
                                    [self.rightDto.productPrice doubleValue]];
            
            self.rightPriceLabel.text = rightPrice;
        }
        
        
    }
    
    [self setNeedsLayout];
}


- (void)updateCellProductPriceImage {
    if (self.leftPriceImageView.hidden == NO) {
        self.leftPriceImageView.imageURL = [ProductUtil minPriceImageOfProductId:self.leftDto.productId productCode:self.leftDto.productCode city:[Config currentConfig].defaultCity shopCode:self.leftDto.vendorCode];
    }
    
    if (self.rightPriceImageView.hidden == NO) {
        self.rightPriceImageView.imageURL = [ProductUtil minPriceImageOfProductId:self.rightDto.productId productCode:self.rightDto.productCode city:[Config currentConfig].defaultCity shopCode:self.rightDto.vendorCode];
    }
}


- (void)layoutSubviews{
	
    [super layoutSubviews];
    
    self.leftLabel.frame = CGRectMake(8, self.leftImageView.bottom + 2, ViewWidth - 8,32);
    self.leftPriceLabel.frame = CGRectMake(8, self.leftLabel.bottom + 2, ViewWidth - 8,18);
    self.leftHintLabel.frame = CGRectMake(6, self.leftLabel.bottom + 2, 16,23);
    self.leftPriceImageView.frame = CGRectMake(self.leftHintLabel.right+2, self.leftLabel.bottom + 6, 70, 13);
    
    self.rightLabel.frame = CGRectMake(8, self.rightImageView.bottom + 2, ViewWidth - 8,32);
    self.rightPriceLabel.frame = CGRectMake(8, self.rightLabel.bottom + 2, ViewWidth - 8,18);;
    self.rightHintLabel.frame = CGRectMake(6, self.rightLabel.bottom + 2, 16,23);
    self.rightPriceImageView.frame = CGRectMake(self.rightHintLabel.right+2, self.rightLabel.bottom + 6, 70, 13);
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    NSInteger viewTag = imageViewEx.tag;
    
    DataProductBasic *productDto = nil;
    
    if (viewTag == 0)
    {
        productDto = self.leftDto.transformToProductDTO;
    }
    else if(viewTag == 1)
    {
        productDto = self.rightDto.transformToProductDTO;
    }
    
    if (productDto && [self.imageDidDelegate respondsToSelector:@selector(cellImageDidClicked:)])
    {
        [self.imageDidDelegate cellImageDidClicked:productDto];
    }

}


@end
