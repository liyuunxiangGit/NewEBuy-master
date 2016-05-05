//
//  ScanHistoryProductCell.m
//  SuningEBuy
//
//  Created by 王家兴 on 13-5-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ScanHistoryProductCell.h"
#import "ProductUtil.h"

@interface ScanHistoryProductCell()

@property (nonatomic, strong) EGOImageView *productImageView;

@property (nonatomic, strong) UILabel *productNameLabel;

@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) DataProductBasic *dataSource;

@property (nonatomic, strong) UIImageView *separatorLine;

@end

/*--------------------------------------Cute split line-------------------------------------------*/

@implementation ScanHistoryProductCell

@synthesize productImageView = productImageView_;
@synthesize productNameLabel = productNameLabel_;
@synthesize priceLabel = priceLabel_;
@synthesize dataSource = dataSource_;
@synthesize separatorLine = _separatorLine;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
        
		self.contentView.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)dealloc
{
    TTVIEW_RELEASE_SAFELY(productImageView_);
    
    TTVIEW_RELEASE_SAFELY(productNameLabel_);
        
    TTVIEW_RELEASE_SAFELY(priceLabel_);
        
    TT_RELEASE_SAFELY(dataSource_);
    TT_RELEASE_SAFELY(_separatorLine);
    
}

- (void)setItem:(DataProductBasic *)item
{
    self.dataSource = item;
    
    //    self.productImageView.imageURL = self.dataSource.productImageURL;
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize160x160];
    }
    else{
        
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize100x100];
    }
    
    self.productNameLabel.text = self.dataSource.productName;
        
    if ([self.dataSource.price floatValue] == 0) {
        self.priceLabel.text = L(@"saleOut");
    }
    else
    {
        self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.dataSource.price floatValue]];
    }
    
    self.separatorLine.image = [UIImage imageNamed:@"line"];
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.backgroundColor = RGBCOLOR(239, 234, 216);
    
//    self.separatorLine.frame = CGRectMake(0, self.contentView.bottom-2, 320, 2);
}


#pragma mark -
#pragma mark view setters

- (UIImageView *)separatorLine
{
    if (!_separatorLine)
    {
        _separatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 79.5, 320, 0.5)];
        
//        [self.contentView addSubview:_separatorLine];
    }
    return _separatorLine;
}

- (EGOImageView *)productImageView
{
    if (!productImageView_) {
		
        CGRect productFrame =  CGRectMake(15, 8, 64, 64);
		productImageView_ = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
        
		productImageView_.backgroundColor =[UIColor clearColor];
        
        productImageView_.contentMode = UIViewContentModeScaleAspectFill;
        
        productImageView_.delegate = self;
        
        productImageView_.layer.borderWidth = 0.5;
        productImageView_.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        productImageView_.layer.masksToBounds = YES;
        
        productImageView_.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        UIView *suppImageView = [[UIView alloc] initWithFrame:productFrame];
        suppImageView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview: suppImageView];
        
        [suppImageView addSubview:productImageView_];
        TT_RELEASE_SAFELY(suppImageView);
	}
	
	return productImageView_;
}

- (UILabel *)productNameLabel
{
    if (!productNameLabel_) {
        
		productNameLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(89, 5, 290 - 94, 40)];
		
		productNameLabel_.backgroundColor = [UIColor clearColor];
        
		productNameLabel_.font = [UIFont systemFontOfSize:13.0];
		
		productNameLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        productNameLabel_.numberOfLines = 0;
		
        productNameLabel_.textColor=[UIColor colorWithRGBHex:0x313131];
        
		[self.contentView addSubview:productNameLabel_];
	}
	
	return productNameLabel_;
}

- (UILabel *)priceLabel
{
    if (!priceLabel_) {
		
		UIFont *font = [UIFont systemFontOfSize:13];
		
		priceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(94, 45, 150, 20)];
		
		priceLabel_.backgroundColor = [UIColor clearColor];
		priceLabel_.textColor = [UIColor colorWithRGBHex:0xFF4800];
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
        
        evaluationView_.frame = CGRectMake(200, 60, 70, 19);
        
        [self.contentView addSubview:evaluationView_];
    }
    return evaluationView_;
    
}


@end
