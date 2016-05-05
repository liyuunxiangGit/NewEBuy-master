//
//  SNActivityProductCell.m
//  SuningEBuy
//
//  Created by 家兴 王 on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "SNActivityProductCell.h"
#import "ProductUtil.h"
#import "RegexKitLite.h"

#define BIG_ONE_IN_LINE_HEIGHT 340
#define SMALL_ONE_IN_LINE_HEGHT 80
#define TWO_IN_LINE_HEIGHT  190
#define THREE_IN_LINE_HEIGHT  140

@interface SNActivityProductCell ()

@property (nonatomic, strong) UIImageView  *seperateImageView;

//60*60
- (NSURL *)productSmallImageUrlForProductCode:(NSString *)productCode;

//160*160
- (NSURL *)productImageUrlForProductCode:(NSString *)productCode;

//400*400
- (NSURL *)productBigImageUrlForProductCode:(NSString *)productCode;

@end

@implementation SNActivityProductCell

@synthesize leftProductNameLbl = _leftProductNameLbl;
@synthesize leftPriceLbl = _leftPriceLbl;
@synthesize rightProductNameLbl = _rightProductNameLbl;
@synthesize rightPriceLbl = _rightPriceLbl;

@synthesize bigCenterPriceLbl=_bigCenterPriceLbl;
@synthesize bigCenterProductNameLbl=_bigCenterProductNameLbl;

@synthesize smallCenterPriceLbl=_smallCenterPriceLbl;
@synthesize smallCenterProductNameLbl=_smallCenterProductNameLbl;

@synthesize leftDTO = _leftDTO;
@synthesize rightDTO = _rightDTO;
@synthesize bigCenterDTO=_bigCenterDTO;
@synthesize smallCenterDTO=_smallCenterDTO;

@synthesize leftImage = _leftImage;
@synthesize rightImage = _rightImage;
@synthesize bigCenterImage=_bigCenterImage;
@synthesize smallCenterImage=_smallCenterImage;

@synthesize salesLeftMiddleImage=_salesLeftMiddleImage;
@synthesize salesRightMiddleImage=_salesRightMiddleImage;
@synthesize salesBigImage=_salesBigImage;
@synthesize salesSmallImage=_salesSmallImage;
@synthesize leftBgImage=_leftBgImage;
@synthesize rightBgImage=_rightBgImage;
@synthesize smallBgImage=_smallBgImage;

@synthesize seperateImageView = _seperateImageView;

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		self.contentView.backgroundColor = [UIColor clearColor];
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
	}
	return self;
}

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_leftProductNameLbl);
    TT_RELEASE_SAFELY(_leftPriceLbl);
    TT_RELEASE_SAFELY(_rightProductNameLbl);
    TT_RELEASE_SAFELY(_rightPriceLbl);
    TT_RELEASE_SAFELY(_bigCenterProductNameLbl);
    TT_RELEASE_SAFELY(_bigCenterPriceLbl);
    TT_RELEASE_SAFELY(_smallCenterProductNameLbl);
    TT_RELEASE_SAFELY(_smallCenterPriceLbl);
    TT_RELEASE_SAFELY(_leftDTO);
    TT_RELEASE_SAFELY(_rightDTO);
    TT_RELEASE_SAFELY(_bigCenterDTO);
    TT_RELEASE_SAFELY(_smallCenterDTO)
    TT_RELEASE_SAFELY(_leftImage);
    TT_RELEASE_SAFELY(_rightImage);
    TT_RELEASE_SAFELY(_bigCenterImage);
    TT_RELEASE_SAFELY(_smallCenterImage);
    TT_RELEASE_SAFELY(_salesLeftMiddleImage);
    TT_RELEASE_SAFELY(_salesRightMiddleImage);
    TT_RELEASE_SAFELY(_salesBigImage);
    TT_RELEASE_SAFELY(_salesSmallImage);
    
    TT_RELEASE_SAFELY(_leftBgImage);
    TT_RELEASE_SAFELY(_rightBgImage);
    TT_RELEASE_SAFELY(_smallBgImage);
    TT_RELEASE_SAFELY(_seperateImageView);
    
    
    TT_RELEASE_SAFELY(_salesBigBangNameLbl);
    TT_RELEASE_SAFELY(_salesSmallBangNameLbl);
    TT_RELEASE_SAFELY(_salesLeftBigBangNameLbl);
    TT_RELEASE_SAFELY(_salesRightBigBangNameLbl);
}

-(void) setBigCenterItem:(SNActivityProductDTO *)bigCenterDto
{
    if (bigCenterDto != nil && bigCenterDto != _bigCenterDTO) 
    {
        
        
        _bigCenterDTO = bigCenterDto;
        
        [self loadBigCenterItem:bigCenterDto];
        
        self.bigCenterProductNameLbl.text = _bigCenterDTO.productName;
        
        if (_bigCenterDTO.productPrice == nil || [_bigCenterDTO.productPrice isEqualToString:@""]  || [_bigCenterDTO.productPrice isEqualToString:@"0"])
        {
            self.bigCenterPriceLbl.text = L(@"saleOut");
        }
        else
        {
            double priceNum = [_bigCenterDTO.productPrice doubleValue];
            if (priceNum > 0) {
                self.bigCenterPriceLbl.text = [NSString stringWithFormat:@"¥ %0.2f",priceNum];
            }else{
                self.bigCenterPriceLbl.text = L(@"saleOut");
            }
        }
        
//        if ([self.seperateImageView superview]==nil) {
//            [self.contentView addSubview:self.seperateImageView];
//            
//            [self setNeedsLayout];
//        }
    }
}

- (void)layoutSubviews{
 
    [super layoutSubviews];
    
//    CGRect frame = self.contentView.frame;
//    
//    self.seperateImageView.frame = CGRectMake(0, frame.size.height-2, frame.size.width, 2);
}

-(void) setSmallCenterItem:(SNActivityProductDTO *)smallCenterDto
{
    if (smallCenterDto != nil && smallCenterDto != _smallCenterDTO) 
    {
        
        if (IOS7_OR_LATER) {
            self.backgroundColor = [UIColor whiteColor];
        }else{
            UIImageView *bgView = [[UIImageView alloc] init];
            bgView.backgroundColor = [UIColor whiteColor];
            self.backgroundView = bgView;
        }
        
        _smallCenterDTO = smallCenterDto;
        
        [self loadSmallCenterItem:smallCenterDto];
        
        self.smallCenterProductNameLbl.text = _smallCenterDTO.productName;
        
        if (_smallCenterDTO.productPrice == nil || [_smallCenterDTO.productPrice isEqualToString:@""] || [_smallCenterDTO.productPrice isEqualToString:@"0"])
        {
            self.smallCenterPriceLbl.text = L(@"saleOut");
        }
        else
        {
            double priceNum = [_smallCenterDTO.productPrice doubleValue];
            if (priceNum > 0) {
                self.smallCenterPriceLbl.text = [NSString stringWithFormat:@"¥ %0.2f",priceNum];
            }else{
                self.smallCenterPriceLbl.text = L(@"saleOut");
            }
        }
    }
}

-(void) setItem:(SNActivityProductDTO *)leftDto rightItem:(SNActivityProductDTO *)rightDto{
    
    if (leftDto != nil && leftDto != _leftDTO) 
    {
        
        
        _leftDTO = leftDto;
        
        [self loadLeftOrRightItem:_leftDTO isLeft:YES];
        
        self.leftProductNameLbl.text = _leftDTO.productName;
        
        if (_leftDTO.productPrice == nil || [_leftDTO.productPrice isEqualToString:@""] || [_leftDTO.productPrice isEqualToString:@"0"])
        {
            self.leftPriceLbl.text = L(@"saleOut");
        }
        else
        {
            double priceNum = [_leftDTO.productPrice doubleValue];
            if (priceNum > 0) {
                self.leftPriceLbl.text = [NSString stringWithFormat:@"¥ %0.2f",priceNum];
            }else{
                self.leftPriceLbl.text = L(@"saleOut");
            }
        }
    }
    
    if (rightDto != nil) {
        
        if (rightDto != _rightDTO) 
        {
            
            
            _rightDTO = rightDto;
            
            if ([self.rightProductNameLbl superview] == nil || [self.rightPriceLbl superview]==nil||[self.rightImage superview] == nil) {
                [self.contentView addSubview:self.rightProductNameLbl];
                [self.contentView addSubview:self.rightPriceLbl];
                [self.contentView addSubview:self.rightImage];
            }
            
            [self loadLeftOrRightItem:_rightDTO isLeft:NO];
            
            self.rightProductNameLbl.text = _rightDTO.productName;
            
            if (_rightDTO.productPrice == nil || [_rightDTO.productPrice isEqualToString:@""] || [_rightDTO.productPrice isEqualToString:@"0"])
            {
                self.rightPriceLbl.text = L(@"saleOut");
            }
            else
            {
                double priceNum = [_rightDTO.productPrice doubleValue];
                if (priceNum > 0) {
                    self.rightPriceLbl.text = [NSString stringWithFormat:@"¥ %0.2f",priceNum];
                }else{
                    self.rightPriceLbl.text = L(@"saleOut");
                }
            }
        }
        
        
    }else{
        //如果是单数，那么把最后的一个位置置空。
        
        TT_RELEASE_SAFELY(_rightDTO);
        
        [self.rightBgImage removeFromSuperview];
        
        [self.salesRightMiddleImage removeFromSuperview];
        
//        [self.rightImage removeFromSuperview];
//        
//        [self.rightPriceLbl removeFromSuperview];
//        
//        [self.rightProductNameLbl removeFromSuperview];
        
    }
    
}

- (void) setItem:(SNActivityProductDTO *)leftDto  rightItem:(SNActivityProductDTO *)rightDto withTag:(NSInteger)index
{
    self.leftDTO = leftDto;
    
    self.leftImage.userInteractionEnabled = YES;
    
    self.salesLeftBigBangNameLbl.text = self.leftDTO.bigBangName;//@"热销";
    if ([self.leftDTO.bigBangName isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesLeftMiddleImage.hidden = NO;
        
        [self.salesLeftMiddleImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"onsale_bigbang_bg.png"]]];
    }
    else
    {
        self.salesLeftMiddleImage.hidden = YES;
    }

    self.leftImage.imageURL = [self productImageUrlForProductCode:self.leftDTO.partNumber];
    
    self.leftProductNameLbl.text = self.leftDTO.productName;
    double price = [self.leftDTO.productPrice doubleValue];
    if (price <= 0) {
        self.leftPriceLbl.text = L(@"saleOut");
    }else{
        NSString *leftPrice = [NSString stringWithFormat:@"￥%.2f",price];
        self.leftPriceLbl.text = leftPrice;
    }
    
    self.rightDTO = rightDto;
    
    self.rightImage.userInteractionEnabled = YES;

    self.salesRightBigBangNameLbl.text = self.rightDTO.bigBangName;//@"热销";
    
    if ([self.rightDTO.bigBangName isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesRightMiddleImage.hidden = NO;
        [self.salesRightMiddleImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"onsale_bigbang_bg.png"]]];
    }
    else
    {
        self.salesRightMiddleImage.hidden = YES;
    }

    if (rightDto == nil) {
        
        [self.rightBgImage removeFromSuperview];
        
    }else{
        
        [self.contentView addSubview:self.rightBgImage];
        
        self.rightImage.imageURL = [self productImageUrlForProductCode:self.rightDTO.partNumber];
        
        self.rightProductNameLbl.text = self.rightDTO.productName;
        
        price = [self.rightDTO.productPrice doubleValue];
        if (price <= 0) {
            self.rightPriceLbl.text = L(@"saleOut");
        }else{
            NSString *rightPrice = [NSString stringWithFormat:@"￥%.2f",
                                    [self.rightDTO.productPrice doubleValue]];
            
            self.rightPriceLbl.text = rightPrice;
        }
        
        
    }
    
    [self setNeedsLayout];
}

-(void)loadBigCenterItem:(SNActivityProductDTO *)bigCenterDto
{
    NSURL *productURL = [self productBigImageUrlForProductCode:bigCenterDto.partNumber];
    
    self.bigCenterImage.imageURL=productURL;
    
    self.salesBigBangNameLbl.text = bigCenterDto.bigBangName;
    
    if ([bigCenterDto.bigBangName isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesBigImage.hidden = NO;
        
        [self.salesBigImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"onsale_bigbang_bg.png"]]];
    }
    else
    {
        self.salesBigImage.hidden = YES;
    }

     
}

-(void)loadSmallCenterItem:(SNActivityProductDTO *)smallCenterDto
{
    NSURL *productURL = [self productSmallImageUrlForProductCode:smallCenterDto.partNumber];
    
    self.smallCenterImage.imageURL=productURL;
    
    self.salesSmallBangNameLbl.text = smallCenterDto.bigBangName;
    
    if ([smallCenterDto.bigBangName isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesSmallImage.hidden = NO;
        
        [self.salesSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"onsale_bigbang_bg.png"]]];
    }
    else
    {
        self.salesSmallImage.hidden = YES;
    }
    
}

-(void)loadLeftOrRightItem:(SNActivityProductDTO *)dto isLeft:(BOOL)isLeft
{
    
    NSURL *productURL = [self productImageUrlForProductCode:dto.partNumber];
    
    if (isLeft) 
    {
        
        self.leftImage.imageURL = productURL;
        
        self.salesLeftBigBangNameLbl.text = dto.bigBangName;
        
        if ([dto.bigBangName isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
        {
            self.salesLeftMiddleImage.hidden = NO;
            
            [self.salesLeftMiddleImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_middle.png"]]];
        }
        else
        {
            self.salesLeftMiddleImage.hidden = YES;
        }
        
    }
    else
    {
        self.rightImage.imageURL = productURL;
        self.salesRightBigBangNameLbl.text = dto.bigBangName;
        
        if ([dto.bigBangName isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
        {
            self.salesRightMiddleImage.hidden = NO;
            
            [self.salesRightMiddleImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_middle.png"]]];
        }
        else
        {
            self.salesRightMiddleImage.hidden = YES;
        }
        
    }
    
}

//多图浏览使用小图160＊160
- (NSURL *)productImageUrlForProductCode:(NSString *)productCode
{
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        return [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize200x200];
    }
    else{
        
        return [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize160x160];
    }
}

//多图浏览使用小图60＊60
- (NSURL *)productSmallImageUrlForProductCode:(NSString *)productCode
{
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        return [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize120x120];
    }
    else{
        
        return [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize60x60];
    }
}

//多图浏览使用大图400＊400
- (NSURL *)productBigImageUrlForProductCode:(NSString *)productCode
{
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        return [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize400x400];
    }
    else{
        
        return [ProductUtil getImageUrlWithProductCode:productCode size:ProductImageSize400x400];
    }
}

- (UILabel*)salesLeftBigBangNameLbl
{
    if(!_salesLeftBigBangNameLbl)
    {
        _salesLeftBigBangNameLbl = [[UILabel alloc] init];
        _salesLeftBigBangNameLbl.backgroundColor = [UIColor clearColor];
        _salesLeftBigBangNameLbl.textColor = [UIColor whiteColor];
        _salesLeftBigBangNameLbl.font = [UIFont systemFontOfSize:12];
        _salesLeftBigBangNameLbl.frame = CGRectMake(0, 0, 45, 15);
        _salesLeftBigBangNameLbl.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4*(-1));
        [self.salesLeftMiddleImage insertSubview:_salesLeftBigBangNameLbl aboveSubview:_salesLeftMiddleImage];
        
    }
    
    return _salesLeftBigBangNameLbl;
}


- (UILabel*)salesRightBigBangNameLbl
{
    if(!_salesRightBigBangNameLbl)
    {
        _salesRightBigBangNameLbl = [[UILabel alloc] init];
        _salesRightBigBangNameLbl.backgroundColor = [UIColor clearColor];
        _salesRightBigBangNameLbl.textColor = [UIColor whiteColor];
        _salesRightBigBangNameLbl.font = [UIFont systemFontOfSize:12];
        _salesRightBigBangNameLbl.frame = CGRectMake(0, 0, 45, 15);
        _salesRightBigBangNameLbl.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4*(-1));
        [self.salesRightMiddleImage insertSubview:_salesRightBigBangNameLbl aboveSubview:_salesRightMiddleImage];
        
    }
    
    return _salesRightBigBangNameLbl;
}

- (UILabel*)salesBigBangNameLbl
{
    if(!_salesBigBangNameLbl)
    {
        _salesBigBangNameLbl = [[UILabel alloc] init];
        _salesBigBangNameLbl.backgroundColor = [UIColor clearColor];
        _salesBigBangNameLbl.textColor = [UIColor whiteColor];
        _salesBigBangNameLbl.font = [UIFont systemFontOfSize:12];
        _salesBigBangNameLbl.frame = CGRectMake(0, 0, 45, 15);
        _salesBigBangNameLbl.numberOfLines = 0;
        _salesBigBangNameLbl.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4*(-1));
        [self.salesBigImage insertSubview:_salesBigBangNameLbl aboveSubview:_salesBigImage];
        
    }
    
    return _salesBigBangNameLbl;
}

- (UILabel *)salesSmallBangNameLbl{
    if (!_salesSmallBangNameLbl) {
        _salesSmallBangNameLbl = [[UILabel alloc] init];
        _salesSmallBangNameLbl.backgroundColor = [UIColor clearColor];
        _salesSmallBangNameLbl.textColor = [UIColor whiteColor];
        _salesSmallBangNameLbl.font = [UIFont systemFontOfSize:12];
        _salesSmallBangNameLbl.frame = CGRectMake(0, 0, 45, 15);
        _salesSmallBangNameLbl.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4*(-1));
        [self.salesSmallImage insertSubview:_salesSmallBangNameLbl aboveSubview:_salesSmallImage];
    }
    return _salesSmallBangNameLbl;
}


-(EGOImageViewEx *)leftImage
{
    if (_leftImage == nil)
    {
        _leftImage = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(0, 0, 145, 125)];
        _leftImage.backgroundColor = [UIColor whiteColor];
        _leftImage.userInteractionEnabled = YES;
        _leftImage.exDelegate = self;
        _leftImage.contentMode = UIViewContentModeScaleAspectFit;
        _leftImage.tag = 0;
        
        [self.leftBgImage addSubview:_leftImage];
    }
    
    return _leftImage;
    
}

-(EGOImageViewEx *)rightImage
{
    if (_rightImage == nil) 
    {
        _rightImage = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(0, 0, 145, 125)];
        _rightImage.backgroundColor = [UIColor whiteColor];
        _rightImage.userInteractionEnabled = YES;
        _rightImage.exDelegate = self;
        _rightImage.contentMode = UIViewContentModeScaleAspectFit;
        _rightImage.tag = 1;
        
        [self.rightBgImage addSubview:_rightImage];
    }
    return _rightImage;
    
}

-(EGOImageViewEx *)bigCenterImage
{
    if (_bigCenterImage == nil) 
    {
        _bigCenterImage = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(15, 10, 290, 280)];
        _bigCenterImage.userInteractionEnabled = YES;
        _bigCenterImage.exDelegate = self;
        
        _bigCenterImage.contentMode = UIViewContentModeScaleToFill;
        _bigCenterImage.backgroundColor = [UIColor whiteColor];
        
        _bigCenterImage.layer.borderWidth = 0.5;
        _bigCenterImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
//        _bigCenterImage.layer.masksToBounds = NO;
//        _bigCenterImage.layer.shadowOffset = CGSizeMake(0, 0);
//        _bigCenterImage.layer.shadowRadius = 2.0;
//        _bigCenterImage.layer.shadowColor = [UIColor blackColor].CGColor;
//        _bigCenterImage.layer.shadowOpacity = 0.8;
//        _bigCenterImage.layer.cornerRadius = 8.0;
//        
        _bigCenterImage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        _bigCenterImage.tag = 2;
        
//        //liukun 2012-6-8， 解决正方形图片不能圆角的问题
//        _bigCenterImage.isRoundCorner = YES;
//        _bigCenterImage.imageCornerRadis = 8.0;
//        
        [self.contentView addSubview:_bigCenterImage];
    }
    return _bigCenterImage;
}

-(EGOImageViewEx *)smallCenterImage
{
    if (_smallCenterImage == nil) 
    {
        _smallCenterImage = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
        _smallCenterImage.userInteractionEnabled = YES;
        _smallCenterImage.exDelegate = self;
        
        _smallCenterImage.contentMode = UIViewContentModeScaleAspectFit;
        _smallCenterImage.backgroundColor = [UIColor whiteColor];
        _smallCenterImage.layer.borderWidth = 0.5f;
        _smallCenterImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
         _smallCenterImage.tag = 3;
        
        [self.smallBgImage addSubview:_smallCenterImage];
    }
    return _smallCenterImage;
    
}

-(UIImageView *)salesLeftMiddleImage
{
    if (_salesLeftMiddleImage == nil) 
    {
        _salesLeftMiddleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        _salesLeftMiddleImage.userInteractionEnabled = YES;
        
        _salesLeftMiddleImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.leftBgImage insertSubview:_salesLeftMiddleImage aboveSubview:_leftImage];
    }
    return _salesLeftMiddleImage;
}

-(UIImageView *)salesRightMiddleImage
{
    if (_salesRightMiddleImage == nil) 
    {
        _salesRightMiddleImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40,40)];
        _salesRightMiddleImage.userInteractionEnabled = YES;
        
        _salesRightMiddleImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.rightBgImage insertSubview:_salesRightMiddleImage aboveSubview:_rightImage];
    }
    return _salesRightMiddleImage;
}

-(UIImageView *)salesBigImage
{
    if (_salesBigImage == nil) 
    {
        _salesBigImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 40,40)];
        _salesBigImage.userInteractionEnabled = YES;
        
        _salesBigImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.contentView insertSubview:_salesBigImage aboveSubview:_bigCenterImage];
    }
    return _salesBigImage;
}

-(UIImageView *)salesSmallImage
{
    if (_salesSmallImage == nil) 
    {
        _salesSmallImage = [[UIImageView alloc]initWithFrame:CGRectMake(320-40, 0, 40,40)];
        _salesSmallImage.userInteractionEnabled = YES;
        
        _salesSmallImage.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_2);
        
        _salesSmallImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.smallBgImage insertSubview:_salesSmallImage aboveSubview:_smallCenterImage];
    }
    return _salesSmallImage;
}

-(UIImageView *)leftBgImage
{
    
    if (_leftBgImage == nil) 
    {
        _leftBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 145, 180)];
        _leftBgImage.userInteractionEnabled = YES;
        
        _leftBgImage.contentMode = UIViewContentModeScaleAspectFit;
//        [_leftBgImage setImage:[UIImage imageNamed:@"OnSale_LeftRightBG.png"]];
        _leftBgImage.backgroundColor = [UIColor whiteColor];
        _leftBgImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _leftBgImage.layer.borderWidth = 0.5f;
        [self.contentView addSubview:_leftBgImage];
    }
    return _leftBgImage;
}

-(UIImageView *)rightBgImage
{
    
    if (_rightBgImage == nil) 
    {
        _rightBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(165, 10, 145, 180)];
        _rightBgImage.userInteractionEnabled = YES;
        
        _rightBgImage.contentMode = UIViewContentModeScaleAspectFit;
//        [_rightBgImage setImage:[UIImage imageNamed:@"OnSale_LeftRightBG.png"]];
        
        _rightBgImage.backgroundColor = [UIColor whiteColor];
        _rightBgImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _rightBgImage.layer.borderWidth = 0.5f;
        
        [self.contentView addSubview:_rightBgImage];
    }
    return _rightBgImage;
}

-(UIImageView *)smallBgImage
{
    
    if (_smallBgImage == nil) 
    {
        _smallBgImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 100)];
        _smallBgImage.userInteractionEnabled = YES;
        
        _smallBgImage.contentMode = UIViewContentModeScaleAspectFit;
//        [_smallBgImage setImage:[UIImage imageNamed:@"OnSale_SmallBG.png"]];
        
        [self.contentView addSubview:_smallBgImage];
    }
    return _smallBgImage;
}

-(BBVerticalAlignmentLabel *)leftProductNameLbl{
    if (_leftProductNameLbl == nil) {
        _leftProductNameLbl = [[BBVerticalAlignmentLabel alloc] initWithFrame:CGRectMake(5, 125, 135, 15)];
        _leftProductNameLbl.backgroundColor =  [UIColor clearColor];
        _leftProductNameLbl.textColor = [UIColor light_Black_Color];
        _leftProductNameLbl.font = [UIFont systemFontOfSize:13.0];
        
        _leftProductNameLbl.numberOfLines = 2;
        _leftProductNameLbl.height = _leftProductNameLbl.font.lineHeight * 2;
        _leftProductNameLbl.verticalAlignment = BBVerticalAlignmentTop;
        
        _leftProductNameLbl.textAlignment = UITextAlignmentLeft;
//        _leftProductNameLbl.shadowOffset = CGSizeMake(1, 1);
        [self.leftBgImage addSubview:_leftProductNameLbl];
        
    }
    return _leftProductNameLbl;
    
}

-(UILabel *)leftPriceLbl{
    if (_leftPriceLbl == nil) {
        _leftPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 160, 135, 16)];
        _leftPriceLbl.backgroundColor = [UIColor clearColor];
        _leftPriceLbl.textAlignment = UITextAlignmentLeft;
        _leftPriceLbl.textColor = [UIColor orange_Red_Color];
        _leftPriceLbl.font = [UIFont systemFontOfSize:16.0];
//        _leftPriceLbl.shadowOffset = CGSizeMake(1, 1);
//        _leftPriceLbl.shadowColor = [UIColor whiteColor];
        [self.leftBgImage addSubview:_leftPriceLbl];
        
    }
    return _leftPriceLbl;
}

-(BBVerticalAlignmentLabel *)rightProductNameLbl{
    
    if (_rightProductNameLbl == nil) {
        _rightProductNameLbl = [[BBVerticalAlignmentLabel alloc]initWithFrame:CGRectMake(5, 125, 135, 15)];
        _rightProductNameLbl.backgroundColor =  [UIColor clearColor];
        _rightProductNameLbl.textColor = [UIColor light_Black_Color];
        _rightProductNameLbl.font = [UIFont systemFontOfSize:13.0];
        _rightProductNameLbl.textAlignment = UITextAlignmentLeft;
        
        _rightProductNameLbl.numberOfLines = 2;
        _rightProductNameLbl.height = _rightProductNameLbl.font.lineHeight * 2;
        _rightProductNameLbl.verticalAlignment = BBVerticalAlignmentTop;
        
        
//        _rightProductNameLbl.shadowOffset = CGSizeMake(1, 1);
//        _rightProductNameLbl.shadowColor = [UIColor whiteColor];
        [self.rightBgImage addSubview:_rightProductNameLbl];
    }
    return _rightProductNameLbl;
    
}

-(UILabel *)rightPriceLbl{
    
    if (_rightPriceLbl == nil) {
        
        _rightPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(5, 160, 135, 16)];
        _rightPriceLbl.backgroundColor = [UIColor clearColor];
        _rightPriceLbl.textAlignment = UITextAlignmentLeft;
        _rightPriceLbl.textColor = [UIColor orange_Red_Color];
//        _rightPriceLbl.shadowOffset = CGSizeMake(1, 1);
//        _rightPriceLbl.shadowColor = [UIColor whiteColor];
        _rightPriceLbl.font = [UIFont systemFontOfSize:16.0];
        [self.rightBgImage addSubview:_rightPriceLbl];
        
    }
    return _rightPriceLbl;
}

-(BBVerticalAlignmentLabel *)bigCenterProductNameLbl{
    if (_bigCenterProductNameLbl == nil) {
        _bigCenterProductNameLbl = [[BBVerticalAlignmentLabel alloc]initWithFrame:CGRectMake(15, 295, 290, 15)];
        _bigCenterProductNameLbl.backgroundColor =  [UIColor clearColor];
        _bigCenterProductNameLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _bigCenterProductNameLbl.font = [UIFont systemFontOfSize:14.0];
        _bigCenterProductNameLbl.numberOfLines = 2;
        _bigCenterProductNameLbl.height = _bigCenterProductNameLbl.font.lineHeight * 2;
        _bigCenterProductNameLbl.verticalAlignment = BBVerticalAlignmentTop;
        
        _bigCenterProductNameLbl.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_bigCenterProductNameLbl];
        
    }
    return _bigCenterProductNameLbl;
    
}

-(UILabel *)bigCenterPriceLbl{
    if (_bigCenterPriceLbl == nil) {
        _bigCenterPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 327, 285, 15)];
        _bigCenterPriceLbl.backgroundColor = [UIColor clearColor];
        _bigCenterPriceLbl.textAlignment = UITextAlignmentLeft;
        _bigCenterPriceLbl.textColor = [UIColor orange_Red_Color];
        _bigCenterPriceLbl.font = [UIFont boldSystemFontOfSize:14.0];
        [self.contentView addSubview:_bigCenterPriceLbl];
        
    }
    return _bigCenterPriceLbl;
}

-(BBVerticalAlignmentLabel *)smallCenterProductNameLbl{
    if (_smallCenterProductNameLbl == nil) {
        _smallCenterProductNameLbl = [[BBVerticalAlignmentLabel alloc]initWithFrame:CGRectMake(85, 12, 290-85, 14)];
        _smallCenterProductNameLbl.backgroundColor =  [UIColor clearColor];
        _smallCenterProductNameLbl.textColor = [UIColor light_Black_Color];
        _smallCenterProductNameLbl.font = [UIFont boldSystemFontOfSize:14.0];
        
        _smallCenterProductNameLbl.numberOfLines = 2;
        _smallCenterProductNameLbl.height = _smallCenterProductNameLbl.font.lineHeight * 2;
        _smallCenterProductNameLbl.verticalAlignment = BBVerticalAlignmentTop;
        
        _smallCenterProductNameLbl.textAlignment = UITextAlignmentLeft;
        [self.smallBgImage insertSubview:_smallCenterProductNameLbl belowSubview:_salesSmallImage];
        
    }
    return _smallCenterProductNameLbl;
    
}

-(UILabel *)smallCenterPriceLbl{
    if (_smallCenterPriceLbl == nil) {
        _smallCenterPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(85, 50, 170, 15)];
        _smallCenterPriceLbl.backgroundColor = [UIColor clearColor];
        _smallCenterPriceLbl.textAlignment = UITextAlignmentLeft;
        _smallCenterPriceLbl.textColor = [UIColor orangeColor];
        _smallCenterPriceLbl.font = [UIFont systemFontOfSize:16.0];
        [self.smallBgImage addSubview:_smallCenterPriceLbl];
        
    }
    return _smallCenterPriceLbl;
}

- (UIImageView *)seperateImageView{

    if (!_seperateImageView) {
        _seperateImageView = [[UIImageView alloc] init];
        [_seperateImageView setImage:[UIImage streImageNamed:@"category_cellSeparatorLine@2x.png"]];        
    }
    return _seperateImageView;

}

-(void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    DLog(@"The current image is %d  here ", imageViewEx.tag);
    NSInteger index = imageViewEx.tag;
    DataProductBasic *tempDto = nil;
    if (index%2 == 0)
    {
        tempDto = self.leftDTO.transformToProductDTO;
        
    }
    else
    {
        tempDto = self.rightDTO.transformToProductDTO;

    }
    
    if (index==2) {
        tempDto = self.bigCenterDTO.transformToProductDTO;
        
    }
    
    if (index==3) {
        tempDto = self.smallCenterDTO.transformToProductDTO;

    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION object:tempDto];
    
    TT_RELEASE_SAFELY(tempDto);
    
}

+ (CGFloat)height:(NSInteger)sortType
{
    CGFloat heght = 0;
    switch (sortType) {
        case 0:
            heght = BIG_ONE_IN_LINE_HEIGHT;
            break;
        case 1:
            heght = SMALL_ONE_IN_LINE_HEGHT;
            break;
        case 2:
            heght = TWO_IN_LINE_HEIGHT;
            break;
        case 3:
            heght = THREE_IN_LINE_HEIGHT;
            break;
        default:
            break;
    }
    return heght;
}
@end
