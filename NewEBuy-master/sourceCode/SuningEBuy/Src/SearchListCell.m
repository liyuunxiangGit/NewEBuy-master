//
//  SearchListCell.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchListCell.h"
#import "ProductUtil.h"

@interface SearchListCell()

@property (nonatomic, strong) EGOImageView *productImageView;

@property (nonatomic, strong) UILabel *productNameLabel;

@property (nonatomic, strong) UILabel *productDescriptionLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) EvaluationView *evaluationView;

@property (nonatomic, strong) DataProductBasic *dataSource;

@property (nonatomic, strong) UIImageView *separatorLine;

@property (nonatomic, strong) UILabel *supplierNum;

//@property (nonatomic, strong) UILabel *supplierNumRe;

//@property (nonatomic, strong) EGOImageView *supplierNumImageView;

@property (nonatomic, strong) EGOImageView *minPriceImageView;

@property (nonatomic, strong) UILabel *minPrice;

@property (nonatomic, strong) UILabel *minPriceLabel;

//促销标签，分别是抢，团，促，降,顺序是固定的
@property (nonatomic, strong) UIImageView *qiangImgView;
@property (nonatomic, strong) UIImageView *tuanImgView;
@property (nonatomic, strong) UIImageView *quanImgView;
@property (nonatomic, strong) UIImageView *jiangImgView;
@property (nonatomic, strong) UIImageView *dajuhuiImgView;
@property (nonatomic, strong) UIImageView *yuyueImgView;
@property (nonatomic, strong) UILabel     *priceOfPromotionLabel;
@end

/*--------------------------------------Cute split line-------------------------------------------*/

@implementation SearchListCell

@synthesize productImageView = productImageView_;
@synthesize productDescriptionLabel = productDescriptionLabel_;
@synthesize productNameLabel = productNameLabel_;
@synthesize priceLabel = priceLabel_;
@synthesize evaluationView = evaluationView_;
@synthesize dataSource = dataSource_;
@synthesize separatorLine = _separatorLine;
@synthesize supplierNum = _supplierNum;
@synthesize minPrice = _minPrice;
@synthesize minPriceLabel = _minPriceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
        if (!IOS7_OR_LATER)
            self.contentView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.separatorLine];
    }
    return self;
}

- (void)dealloc
{
    TTVIEW_RELEASE_SAFELY(productImageView_);
    
    TTVIEW_RELEASE_SAFELY(productNameLabel_);
    
    TTVIEW_RELEASE_SAFELY(productDescriptionLabel_);
    
    TTVIEW_RELEASE_SAFELY(priceLabel_);
    
    TT_RELEASE_SAFELY(evaluationView_);
    
    TT_RELEASE_SAFELY(dataSource_);
    TT_RELEASE_SAFELY(_separatorLine);
    TT_RELEASE_SAFELY(_priceImageView);
    
    TT_RELEASE_SAFELY(_supplierNum);
    //TT_RELEASE_SAFELY(_supplierNumRe);
    //TT_RELEASE_SAFELY(_supplierNumImageView);
    TT_RELEASE_SAFELY(_minPriceImageView);
    TT_RELEASE_SAFELY(_minPrice);
    TT_RELEASE_SAFELY(_minPriceLabel);
}

- (void)setItem:(DataProductBasic *)item
{
//    if (dataSource_ != item) {
//        self.dataSource = item;
    self.qiangImgView.hidden = YES;
    self.tuanImgView.hidden = YES;
    self.quanImgView.hidden = YES;
    self.jiangImgView.hidden = YES;
    self.dajuhuiImgView.hidden = YES;
    self.yuyueImgView.hidden = YES;
    self.priceOfPromotionLabel.hidden = YES;
    
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize160x160];
        }
        else{
            
            self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize100x100];
        }
        
        self.productNameLabel.text = item.productName;
        CGSize textSize = [item.productName sizeWithFont:[UIFont systemFontOfSize:16.0] constrainedToSize:CGSizeMake(186, 45)];
        
        self.productDescriptionLabel.text = item.special;
        
        self.priceLabel.text = @"￥";
        
        self.supplierNum.text = [NSString stringWithFormat:@"%@%@%@",item.supplierNum,L(@"Unit"),L(@"Search_Seller")];
        
        self.minPrice.text =  L(@"Search_FromSale");
    
        self.minPriceLabel.text = @"￥";
        
        //评论数
        if (item.countOfarticle)
            self.labelCommentCount.text = [NSString stringWithFormat:@"%@%@%@", item.countOfarticle,L(@"Unit_Tiao"),L(@"Comment")];
        else
            self.labelCommentCount.text = [NSString stringWithFormat:@"0%@%@",L(@"Unit_Tiao"),L(@"Comment")];
        
        if ( [item.supplierNum intValue]< 2) {
            [self.supplierNum setHidden:YES];
            [self.minPrice setHidden:YES];
            [self.minPriceLabel setHidden:YES];
            [self.minPriceImageView setHidden:YES];
            self.labelCommentCount.hidden = NO;
            
            self.productNameLabel.frame = CGRectMake(110, 7, 320 - 110 - 15, textSize.height);
            if (textSize.height < 30)
                self.productDescriptionLabel.frame = CGRectMake(110, 7 + textSize.height + 16,  320 - 110 - 15, 12);
            else
                self.productDescriptionLabel.frame = CGRectMake(110, 7 + textSize.height + 6,  320 - 110 - 15, 12);
            self.priceLabel.frame = CGRectMake(110, 72, 150, 14);
            self.priceImageView.frame = CGRectMake(123, 70, 150, 14);
            self.priceOfPromotionLabel.frame = self.priceImageView.frame;
            //self.evaluationView.frame = CGRectMake(230, 58, 70, 19);
            
            if ([item.countOfarticle intValue] == 0)
                self.labelCommentCount.hidden = YES;
        }else{
            [self.supplierNum setHidden:NO];
            [self.minPrice setHidden:NO];
            [self.minPriceImageView setHidden:NO];
            [self.minPriceLabel setHidden:NO];
            self.labelCommentCount.hidden = NO;
            
            self.productNameLabel.frame = CGRectMake(110, 7, 320 - 110 - 15, textSize.height);
            if (textSize.height < 30)
                self.productDescriptionLabel.frame = CGRectMake(110, 7 + textSize.height + 16,  320 - 110 - 15, 12);
            else
                self.productDescriptionLabel.frame = CGRectMake(110, 7 + textSize.height + 6,  320 - 110 - 15, 12);
            
            self.priceLabel.frame = CGRectMake(110, 72, 150, 14);
            self.priceImageView.frame = CGRectMake(123, 70, 150, 14);
            self.priceOfPromotionLabel.frame = self.priceImageView.frame;
            
            self.labelCommentCount.frame = CGRectMake(110, 90, self.labelCommentCount.size.width, self.labelCommentCount.size.height);
            
            self.supplierNum.frame = CGRectMake(185, 90, self.supplierNum.size.width, self.supplierNum.size.height);
            //self.evaluationView.frame = CGRectMake(230, 46, 70, 19);
        }
        

        NSString *cityId = item.cityCode.length > 0 ? item.cityCode : [Config currentConfig].defaultCity;
        
        
        
        //self.priceImageView.imageURL = [ProductUtil bestPriceImageOfProductId:item.productId city:cityId];
        
        self.minPriceImageView.imageURL = [ProductUtil minPriceImageOfProductId:item.productId
                                                                           city:cityId];
//        self.minPriceImageView.imageURL = [ProductUtil minPriceImageOfPartNumber:item.partnumber city:cityId];
        //NSString *evalStr = self.dataSource.evaluation;
        //[self.evaluationView setStarsImages:evalStr];
        
        
        //促销标签
        NSString *sscxkg = [SNSwitch getSearchPromotionValue];
        if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"2"])
        {
            [self refreshWithsscxkgOf2:item];
        }
        else if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"1"])
        {
            [self refreshWithsscxkgOf1:item];
        }
        else if ([sscxkg isEqualToString:@"0"] || IsNilOrNull(sscxkg))
        {
            self.priceImageView.hidden = NO;
            self.priceOfPromotionLabel.hidden = YES;
            
            self.qiangImgView.hidden = YES;
            self.tuanImgView.hidden = YES;
            self.quanImgView.hidden = YES;
            self.jiangImgView.hidden = YES;
        }
//    }
    
    [self setNeedsLayout];
//    [self setNeedsDisplay];
}

- (void)refreshWithsscxkgOf2:(DataProductBasic *)item
{
    self.priceImageView.hidden = YES;
    
    self.priceOfPromotionLabel.hidden = NO;
    self.priceLabel.textColor = RGBCOLOR(250, 86, 0);
    
    //促销价为0说明发生了错误，换为原来的价格图片
    if ([item.minPriceOfPromotion floatValue] == 0)
    {
        self.priceImageView.hidden = NO;
        self.priceOfPromotionLabel.hidden = YES;
        self.priceLabel.textColor = [UIColor colorWithRGBHex:0xDD0000];
    }
    self.priceOfPromotionLabel.text = item.minPriceOfPromotion;
    
    if (item.iSdaJuHui)
    {
        self.qiangImgView.hidden = YES;
        self.tuanImgView.hidden = YES;
        self.quanImgView.hidden = YES;
        self.jiangImgView.hidden = YES;
        self.dajuhuiImgView.hidden = NO;
    }
    else if (item.flagOfPromotionImgView > 0)
    {
        if (item.flagOfPromotionImgView & YU) //预约是单独的，跟大聚惠一样
        {
            self.qiangImgView.hidden = YES;
            self.tuanImgView.hidden = YES;
            self.quanImgView.hidden = YES;
            self.jiangImgView.hidden = YES;
            self.dajuhuiImgView.hidden = YES;
            self.yuyueImgView.hidden = NO;
            
            return;
        }
        else
        {
            self.dajuhuiImgView.hidden = YES;
            
            BOOL bQiang = !(item.flagOfPromotionImgView & Qiang);
            self.qiangImgView.hidden = bQiang;
            
            BOOL bTuan = !(item.flagOfPromotionImgView & Tuan);
            self.tuanImgView.hidden = bTuan;
            
            BOOL bQuan = !(item.flagOfPromotionImgView & Quan);
            self.quanImgView.hidden = bQuan;
            
            BOOL bJiang = !(item.flagOfPromotionImgView & Jiang);
            self.jiangImgView.hidden = bJiang;
            
            NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:4];
            if (!bQiang)
            {
                [arr1 addObject:self.qiangImgView];
            }
            
            if (!bTuan)
            {
                [arr1 addObject:self.tuanImgView];
            }
            
            if (!bQuan)
            {
                [arr1 addObject:self.quanImgView];
            }
            
            if (!bJiang)
            {
                [arr1 addObject:self.jiangImgView];
            }
            
            NSArray *arr2 = [arr1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                UIView *v1 = (UIView *)obj1;
                UIView *v2 = (UIView *)obj2;
                
                if (v1.tag > v2.tag)
                    return NSOrderedAscending;
                else
                    return NSOrderedDescending;
            }];
            
            int x = 283;
            for (UIImageView *v in arr2) {
                v.frame = CGRectMake(x, 63, 20, 20);
                x -= 30;
                
                if (x < 193)
                    break;
            }
        }
    }
    else if (item.flagOfPromotionImgView == 0)
    {
        self.qiangImgView.hidden = YES;
        self.tuanImgView.hidden = YES;
        self.quanImgView.hidden = YES;
        self.jiangImgView.hidden = YES;
        self.dajuhuiImgView.hidden = YES;
    }
}


- (void)refreshWithsscxkgOf1:(DataProductBasic *)item
{
    self.priceImageView.hidden = YES;
    
    self.priceOfPromotionLabel.hidden = NO;
    self.priceLabel.textColor = RGBCOLOR(250, 86, 0);
    
    //促销价为0说明发生了错误，换为原来的价格图片
    if ([item.minPriceOfPromotion floatValue] == 0)
    {
        self.priceImageView.hidden = NO;
        self.priceOfPromotionLabel.hidden = YES;
        self.priceLabel.textColor = [UIColor colorWithRGBHex:0xDD0000];
    }
    self.priceOfPromotionLabel.text = item.minPriceOfPromotion;
    
    if (item.flagOfPromotionImgView > 0)
    {
        
        BOOL bQiang = !(item.flagOfPromotionImgView & Qiang);
        self.qiangImgView.hidden = bQiang;
        
        BOOL bTuan = !(item.flagOfPromotionImgView & Tuan);
        self.tuanImgView.hidden = bTuan;
        
        BOOL bQuan = !(item.flagOfPromotionImgView & Quan);
        self.quanImgView.hidden = bQuan;
        
        BOOL bJiang = !(item.flagOfPromotionImgView & Jiang);
        self.jiangImgView.hidden = bJiang;
        
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:4];
        if (!bQiang)
        {
            [arr1 addObject:self.qiangImgView];
        }
        
        if (!bTuan)
        {
            [arr1 addObject:self.tuanImgView];
        }
        
        if (!bQuan)
        {
            [arr1 addObject:self.quanImgView];
        }
        
        if (!bJiang)
        {
            [arr1 addObject:self.jiangImgView];
        }
        
        NSArray *arr2 = [arr1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            UIView *v1 = (UIView *)obj1;
            UIView *v2 = (UIView *)obj2;
            
            if (v1.tag > v2.tag)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }];
        
        int x = 283;
        for (UIImageView *v in arr2) {
            v.frame = CGRectMake(x, 63, 20, 20);
            x -= 30;
            
            if (x < 193)
                break;
        }
        
        
    }
    else
    {
        self.qiangImgView.hidden = YES;
        self.tuanImgView.hidden = YES;
        self.quanImgView.hidden = YES;
        self.jiangImgView.hidden = YES;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.backgroundColor = RGBCOLOR(243, 243, 243);
    
}
//
//- (void)prepareForReuse
//{
//    [super prepareForReuse];
//    self.qiangImgView.hidden = YES;
//    self.tuanImgView.hidden = YES;
//    self.quanImgView.hidden = YES;
//    self.jiangImgView.hidden = YES;
//}
#pragma mark -
#pragma mark view setters

- (UILabel *)labelCommentCount
{
    if (!_labelCommentCount) {
        _labelCommentCount = [[UILabel alloc] initWithFrame:CGRectMake(110, 90, 70, 12)];
        _labelCommentCount.backgroundColor = [UIColor clearColor];
        _labelCommentCount.textColor = [UIColor colorWithRGBHex:0xa2a2a2];
        _labelCommentCount.font = [UIFont systemFontOfSize:10.0];
        _labelCommentCount.autoresizingMask = UIViewAutoresizingNone;
        _labelCommentCount.textAlignment = NSTextAlignmentLeft;
        [self.contentView addSubview:_labelCommentCount];
    }
    
    return _labelCommentCount;
}

- (UIImageView *)separatorLine
{
    if (!_separatorLine)
    {
        _separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 104.5, 320, 0.5) ];
        
        _separatorLine.image = [UIImage imageNamed:@"line"];
        
    }
    return _separatorLine;
}

- (EGOImageView *)productImageView
{
    if (!productImageView_) {
		
        CGRect productFrame =  CGRectMake(15, 10, 85, 85);
		productImageView_ = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 85, 85)];
        
		productImageView_.backgroundColor =[UIColor whiteColor];
        
        productImageView_.contentMode = UIViewContentModeScaleAspectFill;
                
        productImageView_.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        UIView *suppImageView = [[UIView alloc] initWithFrame:productFrame];
        suppImageView.backgroundColor = [UIColor clearColor];
        suppImageView.layer.borderWidth = 0.5;
        suppImageView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        
        [self.contentView addSubview: suppImageView];
        
        [suppImageView addSubview:productImageView_];
        TT_RELEASE_SAFELY(suppImageView);
	}
	
	return productImageView_;
}

- (UILabel *)productNameLabel
{
    if (!productNameLabel_) {
		productNameLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, 206, 35)];
		productNameLabel_.backgroundColor = [UIColor clearColor];
		productNameLabel_.font = [UIFont systemFontOfSize:15.0];
		productNameLabel_.autoresizingMask = UIViewAutoresizingNone;
        productNameLabel_.textColor = [UIColor colorWithRGBHex:0x313131];
        productNameLabel_.numberOfLines = 2;
        productNameLabel_.textAlignment = NSTextAlignmentLeft;
		[self.contentView addSubview:productNameLabel_];
	}
	return productNameLabel_;
}

- (EGOImageView *)priceImageView
{
    if (!_priceImageView)
    {
		_priceImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(123, 46, 150, 12)];
		_priceImageView.backgroundColor = [UIColor clearColor];
        _priceImageView.contentMode = UIViewContentModeLeft;
        _priceImageView.placeholderImage = nil;
        _priceImageView.refreshCached = YES;
		[self.contentView addSubview:_priceImageView];
	}
	return _priceImageView;
}

- (UILabel *)priceOfPromotionLabel
{
    if (!_priceOfPromotionLabel)
    {
        _priceOfPromotionLabel = [[UILabel alloc] initWithFrame:CGRectMake(123, 46, 150, 12)];
        _priceOfPromotionLabel.backgroundColor = [UIColor clearColor];
        _priceOfPromotionLabel.textAlignment = NSTextAlignmentLeft;
        _priceOfPromotionLabel.textColor = RGBCOLOR(250, 86, 0);
        _priceOfPromotionLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_priceOfPromotionLabel];
    }
    
    return _priceOfPromotionLabel;
}

- (UILabel *)productDescriptionLabel
{
    if (!productDescriptionLabel_) {
        
		productDescriptionLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(110, 27,  206, 12)];
		
		productDescriptionLabel_.backgroundColor = [UIColor clearColor];
        
		productDescriptionLabel_.font = [UIFont systemFontOfSize:10.5];
        
        productDescriptionLabel_.textColor = [UIColor colorWithRGBHex:0xa2a2a2];
		
		productDescriptionLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        productDescriptionLabel_.numberOfLines = 1;
		
		[self.contentView addSubview:productDescriptionLabel_];
	}
	
	return productDescriptionLabel_;
}

- (UILabel *)priceLabel
{
    if (!priceLabel_) {
		
		UIFont *font = [UIFont systemFontOfSize:16];
		
		priceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(94, 48, 150, 14)];
		
		priceLabel_.backgroundColor = [UIColor clearColor];
		priceLabel_.textColor = [UIColor colorWithRGBHex:0xDD0000];
		priceLabel_.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
		priceLabel_.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:priceLabel_];
	}
    
	return priceLabel_;
}


- (UILabel *)supplierNum
{
    if (!supplierNum_) {
        supplierNum_ = [[UILabel alloc] initWithFrame:CGRectMake(94, 68, 60, 12)];
        supplierNum_.backgroundColor = [UIColor clearColor];
        supplierNum_.textColor = [UIColor colorWithRGBHex:0xa2a2a2];
        supplierNum_.font = [UIFont systemFontOfSize:10.0];
        supplierNum_.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:supplierNum_];
    }
    
    return supplierNum_;
}

//- (UILabel *)supplierNumRe
//{
//    if (!supplierNumRe_) {
//        supplierNumRe_ = [[UILabel alloc] initWithFrame:CGRectMake(120, 68, 150, 12)];
//        supplierNumRe_.backgroundColor = [UIColor clearColor];
//        supplierNumRe_.textColor = [UIColor colorWithRGBHex:0x444444];
//        supplierNumRe_.font = [UIFont systemFontOfSize:10.0];
//        supplierNumRe_.autoresizingMask = UIViewAutoresizingNone;
//        [self.contentView addSubview:supplierNumRe_];
//    }
//    
//    return supplierNumRe_;
//}
//
//- (EGOImageView *)supplierNumImageView
//{
//    if (!_supplierNumImageView)
//    {
//		_supplierNumImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(114, 68, 150, 12)];
//		_supplierNumImageView.backgroundColor = [UIColor clearColor];
//        _supplierNumImageView.contentMode = UIViewContentModeLeft;
//        _supplierNumImageView.placeholderImage = nil;
//        _supplierNumImageView.cacheAge = kEGOCacheAgeOneLifeCycle;
//		[self.contentView addSubview:_supplierNumImageView];
//	}
//	return _supplierNumImageView;
//}

- (EGOImageView *)minPriceImageView
{
    if (!_minPriceImageView)
    {
		_minPriceImageView = [[EGOImageView alloc] init];//WithFrame:CGRectMake(280 - size.width, 68, size.width, 20)];
		_minPriceImageView.backgroundColor = [UIColor clearColor];
        _minPriceImageView.contentMode = UIViewContentModeScaleToFill;
        _minPriceImageView.placeholderImage = nil;
        _minPriceImageView.delegate = self;
        _minPriceImageView.refreshCached = YES;
		[self.contentView addSubview:_minPriceImageView];
	}
	return _minPriceImageView;
}

- (UILabel *)minPriceLabel
{
    if (!minPriceLabel_) {
		
		UIFont *font = [UIFont systemFontOfSize:10];
		
		minPriceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(230, 88, 10, 12)];
		
		minPriceLabel_.backgroundColor = [UIColor clearColor];
		minPriceLabel_.textColor = [UIColor colorWithRGBHex:0x707070];
		minPriceLabel_.font = font;
		priceLabel_.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:minPriceLabel_];
	}
    
	return minPriceLabel_;
}


- (UILabel *)minPrice
{
    if (!minPrice_) {
        minPrice_ = [[UILabel alloc] initWithFrame:CGRectMake(280, 88, 40, 12)];
        minPrice_.backgroundColor = [UIColor clearColor];
        minPrice_.textColor = [UIColor colorWithRGBHex:0x707070];
        minPrice_.font = [UIFont systemFontOfSize:10.0];
        minPrice_.autoresizingMask = UIViewAutoresizingNone;
        [self.contentView addSubview:minPrice_];
    }
    
    return minPrice_;
}

- (EvaluationView *)evaluationView{
    
    if (!evaluationView_) {
        
        evaluationView_ = [[EvaluationView alloc] init];
        
        evaluationView_.backgroundColor = [UIColor clearColor];
        
        evaluationView_.frame = CGRectMake(230, 46, 70, 19);
        
        //[self.contentView addSubview:evaluationView_];
    }
    return evaluationView_;
    
}

#pragma -mark
#pragma EGOImageViewDelegate

- (void)imageViewLoadedImage:(EGOImageView*)imageView
{
    CGSize  size;
    
    size.width  = imageView.image.size.width * 5/8 ;
    size.height = imageView.image.size.height * 5/8;
    
    self.minPriceImageView.frame = CGRectMake(280 - size.width , 105 - 5 - size.height, size.width, size.height);
    self.minPriceLabel.frame = CGRectMake(280 - size.width - 12, 105 - 5 - size.height, 10, 12);
    self.minPrice.frame = CGRectMake(280, 105 - 5 - size.height - 2, 40, 12);
}

#pragma mark - 促销标签
- (UIImageView *)qiangImgView
{
    if (!_qiangImgView)
    {
        _qiangImgView = [[UIImageView alloc] initWithFrame:CGRectMake(193, 63, 20, 20)];
        _qiangImgView.image = [UIImage imageNamed:@"Search_Qiang.png"];
        _qiangImgView.hidden = YES;
        _qiangImgView.tag = 1000;
        [self.contentView addSubview:_qiangImgView];
    }
    
    return _qiangImgView;
}

- (UIImageView *)tuanImgView
{
    if (!_tuanImgView)
    {
        _tuanImgView = [[UIImageView alloc] initWithFrame:CGRectMake(223, 63, 20, 20)];
        _tuanImgView.image = [UIImage imageNamed:@"Search_Tuan.png"];
        _tuanImgView.hidden = YES;
        _tuanImgView.tag = 1001;
        [self.contentView addSubview:_tuanImgView];
    }
    return _tuanImgView;
}

- (UIImageView *)quanImgView
{
    if (!_quanImgView)
    {
        _quanImgView = [[UIImageView alloc] initWithFrame:CGRectMake(253, 63, 20, 20)];
        _quanImgView.image = [UIImage imageNamed:@"Search_Quan.png"];
        _quanImgView.hidden = YES;
        _quanImgView.tag = 1002;
        [self.contentView addSubview:_quanImgView];
    }
    return _quanImgView;
}

- (UIImageView *)jiangImgView
{
    if (!_jiangImgView)
    {
        _jiangImgView = [[UIImageView alloc] initWithFrame:CGRectMake(283, 63, 20, 20)];
        _jiangImgView.image = [UIImage imageNamed:@"Search_Jiang.png"];
        _jiangImgView.hidden = YES;
        _jiangImgView.tag = 1003;
        [self.contentView addSubview:_jiangImgView];
    }
    return _jiangImgView;
}

- (UIImageView *)dajuhuiImgView
{
    if (!_dajuhuiImgView)
    {
        _dajuhuiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(283, 63, 20, 20)];
        _dajuhuiImgView.image = [UIImage imageNamed:@"search_bigparty.png"];
        _dajuhuiImgView.hidden = YES;
        _dajuhuiImgView.tag = 1004;
        
        [self.contentView addSubview:_dajuhuiImgView];
    }
    
    return _dajuhuiImgView;
}

- (UIImageView *)yuyueImgView
{
    if (!_yuyueImgView)
    {
        _yuyueImgView = [[UIImageView alloc] initWithFrame:CGRectMake(283, 63, 20, 20)];
        _yuyueImgView.image = [UIImage imageNamed:@"search_preorder.png"];
        _yuyueImgView.hidden = YES;
        _yuyueImgView.tag = 1004;
        
        [self.contentView addSubview:_yuyueImgView];
    }
    
    return _yuyueImgView;
}
@end
