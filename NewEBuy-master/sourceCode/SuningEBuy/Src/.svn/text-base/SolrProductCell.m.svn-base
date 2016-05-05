//
//  SolrProductCell.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SolrProductCell.h"
#import "ProductUtil.h"
#import "RegexKitLite.h"

@interface SolrProductCell()

@property (nonatomic, strong) EGOImageView *productImageView;

@property (nonatomic, strong) UILabel *productNameLabel;

@property (nonatomic, strong) UILabel *productDescriptionLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) EvaluationView *evaluationView;

@property (nonatomic, strong) DataProductBasic *dataSource;

@property (nonatomic, strong) UIImageView *separatorLine;

@end

/*--------------------------------------Cute split line-------------------------------------------*/

@implementation SolrProductCell

@synthesize productImageView = productImageView_;
@synthesize productDescriptionLabel = productDescriptionLabel_;
@synthesize productNameLabel = productNameLabel_;
@synthesize priceLabel = priceLabel_;
@synthesize evaluationView = evaluationView_;
@synthesize dataSource = dataSource_;
@synthesize isShowEvaluation = _isShowEvaluation;
@synthesize separatorLine = _separatorLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.isShowEvaluation = YES;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;		
        
//		self.contentView.backgroundColor = [UIColor clearColor];
        
        self.backgroundColor = [UIColor whiteColor];
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
    
}

- (UIImageView *)salesSmallImage
{
    if (!_salesSmallImage) {
        _salesSmallImage = [[UIImageView alloc]initWithFrame:CGRectMake(272, -4, 51,48)];
        _salesSmallImage.userInteractionEnabled = YES;
        _salesSmallImage.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_salesSmallImage];
        [self.contentView bringSubviewToFront:_salesSmallImage];
//        [self.productImageView insertSubview:_salesSmallImage aboveSubview:productImageView_];

    }
    return _salesSmallImage;
}

- (UILabel *)bigbangNameLabel
{
    if (!_bigbangNameLabel) {
        _bigbangNameLabel = [[UILabel alloc] init];
        _bigbangNameLabel.backgroundColor = [UIColor clearColor];
        _bigbangNameLabel.textColor = [UIColor whiteColor];
        _bigbangNameLabel.font = [UIFont systemFontOfSize:13];
        _bigbangNameLabel.frame = CGRectMake(19.5, 2.8, 35, 35);
        //        _bigbangNameLabel.text = innerDto.bigBang;//@"热销";
        _bigbangNameLabel.transform = CGAffineTransformRotate(CGAffineTransformIdentity, M_PI_4);
        
        [self.salesSmallImage insertSubview:_bigbangNameLabel aboveSubview:_salesSmallImage];
    }
    return _bigbangNameLabel;
}

- (void)setItem:(DataProductBasic *)item withDto:(InnerProductDTO *)dto
{
    self.dataSource = item;
    self.innerDto = dto;
    
//    self.productImageView.imageURL = self.dataSource.productImageURL;
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize120x120];
    }
    
//    [self.salesSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_small_%d.png",[self.dataSource.promIcon intValue]]]];
    
//    NSLog(@"dwagvsx:%@",self.dataSource.promIcon);

    self.productNameLabel.text = self.dataSource.productName;
    
    self.productDescriptionLabel.text = self.dataSource.special;
    
    if ([self.dataSource.price floatValue] == 0) {
        
        if (self.innerDto.priceImageURL) {
            //显示价格图片
            self.priceHintLabel.hidden = NO;
            self.priceImageView.hidden = NO;
            self.priceImageView.imageURL = self.innerDto.priceImageURL;
            
        }
        else {
            self.priceHintLabel.hidden = YES;
            self.priceImageView.hidden = YES;
            self.priceLabel.text = L(@"saleOut");
        }
    }
    else
    {
        self.priceHintLabel.hidden = YES;
        self.priceImageView.hidden = YES;
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.dataSource.price floatValue]];
    }
    
    if (self.isShowEvaluation)
    {
        [self.evaluationView setStarsImages:self.dataSource.evaluation];
    }
    
    self.bigbangNameLabel.text = self.innerDto.bigBang;//@"热销";
    if ([self.innerDto.bigBang isMatchedByRegex:@"^(\\d{2}|[a-zA-Z]{2}|[\\u4e00-\\u9fa5])[\\u4e00-\\u9fa5]$"])
    {
        self.salesSmallImage.hidden = NO;
        
        [self.salesSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_small.png"]]];
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

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.separatorLine.frame = CGRectMake(0, self.contentView.bottom - 1, 320, 0.5);
}


#pragma mark -
#pragma mark view setters

- (UIImageView *)separatorLine
{
    if (!_separatorLine) 
    {
        _separatorLine = [[UIImageView alloc] init];
        _separatorLine.backgroundColor = [UIColor colorWithHexString:@"#DCDCDC"];
//        _separatorLine.image = [UIImage imageNamed:@"cellSeparatorLine.png"];

        [self.contentView addSubview:_separatorLine];
    }
    return _separatorLine;
}

- (EGOImageView *)productImageView
{
    if (!productImageView_) {
		
        CGRect productFrame =  CGRectMake(15, 10, 85, 85);
		productImageView_ = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0, 85, 85)];
        
		productImageView_.backgroundColor =[UIColor whiteColor];
        
        productImageView_.contentMode = UIViewContentModeScaleAspectFill;
        
        productImageView_.delegate = self;
        productImageView_.exDelegate = self;
        
//        productImageView_.layer.cornerRadius = 5;
        
//        productImageView_.layer.masksToBounds = YES;
        
        productImageView_.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        UIView *suppImageView = [[UIView alloc] initWithFrame:productFrame];
        suppImageView.backgroundColor = [UIColor whiteColor];
        
        suppImageView.layer.borderColor = [UIColor colorWithHexString:@"#DCDCDC"].CGColor;
        suppImageView.layer.borderWidth = 0.5f;
        
        //测试，设置view不响应，应该会提高点击cell时的响应速度，
        //此类里虽设置了delegate、exDelegate代理，实际上没有实现其方法，其它使用此类的地方，应该不会受到影响
        //bug:IPHONEII-6721
        //pre_ios2.4.4_联版集其中的模块指向商品集未一行一个小，快速点击图片无反应，必须慢一点
        suppImageView.userInteractionEnabled = NO;
        
        [self.contentView addSubview: suppImageView];
        
        [suppImageView addSubview:productImageView_];
        TT_RELEASE_SAFELY(suppImageView);
	}
	
	return productImageView_;
}

- (UILabel *)productNameLabel
{
    if (!productNameLabel_) {
        
		productNameLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(109, 10, 205, 33)];
		
		productNameLabel_.backgroundColor = [UIColor clearColor];
        
		productNameLabel_.font = [UIFont systemFontOfSize:12.f];//[UIFont boldSystemFontOfSize:13.f];
		
		productNameLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        productNameLabel_.lineBreakMode = NSLineBreakByWordWrapping;
        
        productNameLabel_.numberOfLines = 2;
        
        productNameLabel_.textColor = [UIColor darkTextColor];
		
		[self.contentView addSubview:productNameLabel_];
	}
	
	return productNameLabel_;
}

- (UILabel *)productDescriptionLabel
{
    if (!productDescriptionLabel_) {
        
		productDescriptionLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(109, 47,  150, 13)];
		
		productDescriptionLabel_.backgroundColor = [UIColor clearColor];
        
		productDescriptionLabel_.font = [UIFont systemFontOfSize:12.0];
        
        productDescriptionLabel_.textColor = [UIColor dark_Gray_Color];//RGBCOLOR(165, 163, 158);
		
//		productDescriptionLabel_.autoresizingMask = UIViewAutoresizingNone;
        
//        productDescriptionLabel_.numberOfLines = 2;
		
		[self.contentView addSubview:productDescriptionLabel_];
	}
	
	return productDescriptionLabel_;
}

- (EGOImageViewEx *)priceImageView {
    if (!_priceImageView) {
        _priceImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(129, 80-1, 70, 13)];
        
        _priceImageView.backgroundColor =[UIColor clearColor];
        
        _priceImageView.cacheOptions = (1 << 4);
        
        _priceImageView.contentMode = UIViewContentModeLeft;
        
        _priceImageView.userInteractionEnabled = NO;
        _priceImageView.hidden = YES;
        [self.contentView addSubview:_priceImageView];
    }
    return _priceImageView;
}

- (UILabel *)priceHintLabel {
    if (!_priceHintLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:18];
        
        _priceHintLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 75, 25, 23)];
        _priceHintLabel.text = @"￥";
//        _priceHintLabel.textAlignment =NSTextAlignmentRight;
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

- (UILabel *)priceLabel
{
    if (!priceLabel_) {
		
		UIFont *font = [UIFont boldSystemFontOfSize:12];
		
		priceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(109, 80, 150, 13)];
		
		priceLabel_.backgroundColor = [UIColor clearColor];
		priceLabel_.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);//RGBCOLOR(190, 3, 7);
		priceLabel_.font = font;
//        priceLabel_.shadowColor = [UIColor grayColor];
//		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
		priceLabel_.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:priceLabel_];
	}
    
	return priceLabel_;
}


- (EvaluationView *)evaluationView{
    
    if (!evaluationView_) {
        
        evaluationView_ = [[EvaluationView alloc] init];
        
        evaluationView_.backgroundColor = [UIColor clearColor];
        
        evaluationView_.frame = CGRectMake(200, 80, 70, 19);
        
        [self.contentView addSubview:evaluationView_];
    }
    return evaluationView_;
    
}



@end
