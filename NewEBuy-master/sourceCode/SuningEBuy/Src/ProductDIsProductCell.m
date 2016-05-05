//
//  ProductDIsProductCell.m
//  SuningEBuy
//
//  Created by xy ma on 12-2-28.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "ProductDIsProductCell.h"
#import "ProductUtil.h"

@implementation ProductDIsProductCell

@synthesize productImageView = productImageView_;
@synthesize productDescriptionLabel = productDescriptionLabel_;
@synthesize productNameLabel = productNameLabel_;
@synthesize priceLabel = priceLabel_;
@synthesize evaluationView = evaluationView_;
@synthesize dataSource = dataSource_;
@synthesize isShowEvaluation = _isShowEvaluation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) 
    {
        self.isShowEvaluation = YES;
        
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
    
    TTVIEW_RELEASE_SAFELY(productDescriptionLabel_);
    
    TTVIEW_RELEASE_SAFELY(priceLabel_);
    
    TT_RELEASE_SAFELY(evaluationView_);
    
    TT_RELEASE_SAFELY(dataSource_);
    
}

- (void)setItem:(DataProductBasic *)item
{
    self.dataSource = item;
    
    self.productImageView.imageURL = self.dataSource.productImageURL;
    
    self.productNameLabel.text = self.dataSource.productName;
    
    self.productDescriptionLabel.text = self.dataSource.special;
    
    self.priceLabel.text = [NSString stringWithFormat:@"￥%.2f", [self.dataSource.price floatValue]];    
    
    if (self.isShowEvaluation)
    {
        [self.evaluationView setStarsImages:self.dataSource.evaluation];
    }
}

#pragma mark -
#pragma mark view setters

- (EGOImageView *)productImageView
{
    if (!productImageView_) {
		
		productImageView_ = [[EGOImageView alloc] initWithFrame:CGRectMake(6, 8, 64, 64)];
		
		productImageView_.backgroundColor =[UIColor whiteColor];
        
        productImageView_.contentMode = UIViewContentModeScaleAspectFill;
        
        productImageView_.delegate = self;
        
        productImageView_.layer.borderWidth = 0.5;
        
        productImageView_.layer.cornerRadius = 5;
        
        productImageView_.layer.masksToBounds = YES;
        
        productImageView_.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        productImageView_.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        [self.contentView addSubview:productImageView_];
	}
	
	return productImageView_;
}

- (UILabel *)productNameLabel
{
    if (!productNameLabel_) {
        
		productNameLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(80, 5, 220, 20)];
		
		productNameLabel_.backgroundColor = [UIColor clearColor];
        
		productNameLabel_.font = [UIFont boldSystemFontOfSize:14.0];
		
		productNameLabel_.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:productNameLabel_];
	}
	
	return productNameLabel_;
}

- (UILabel *)productDescriptionLabel
{
    if (!productDescriptionLabel_) {
        
		productDescriptionLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(80, 25,  190, 30)];
		
		productDescriptionLabel_.backgroundColor = [UIColor clearColor];
        
		productDescriptionLabel_.font = [UIFont systemFontOfSize:12.0];
        
        productDescriptionLabel_.textColor = [UIColor darkGrayColor];
		
		productDescriptionLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        productDescriptionLabel_.numberOfLines = 2;
		
		[self.contentView addSubview:productDescriptionLabel_];
	}
	
	return productDescriptionLabel_;
}

- (UILabel *)priceLabel
{
    if (!priceLabel_) {
		
		UIFont *font = [UIFont systemFontOfSize:17];
		
		priceLabel_ = [[UILabel alloc] initWithFrame:CGRectMake(80, 55, 150, 20)];
		
		priceLabel_.backgroundColor = [UIColor clearColor];
		priceLabel_.textColor = RGBCOLOR(176, 44, 44);
		priceLabel_.font = font;
        priceLabel_.shadowColor = [UIColor grayColor];
		priceLabel_.shadowOffset =CGSizeMake(0.8,0.8);
		priceLabel_.autoresizingMask = UIViewAutoresizingNone;
		
		[self.contentView addSubview:priceLabel_];
	}
    
	return priceLabel_;
}


- (EvaluationView *)evaluationView{
    
    if (!evaluationView_) {
        
        evaluationView_ = [[EvaluationView alloc] init];
        
        evaluationView_.backgroundColor = [UIColor clearColor];
        
        evaluationView_.frame = CGRectMake(190, 60, 70, 19);
        
        [self.contentView addSubview:evaluationView_];
    }
    return evaluationView_;
    
}


@end
