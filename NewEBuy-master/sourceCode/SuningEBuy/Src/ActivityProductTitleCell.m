//
//  ActivityProductTitleCell.m
//  SuningEBuy
//
//  Created by shasha on 12-4-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ActivityProductTitleCell.h"

@implementation ActivityProductTitleCell
@synthesize backView = _backView;
@synthesize purchaseType = _purchaseType;
@synthesize isEnable = _isEnable;
@synthesize leftTopImageView = _leftTopImageView;
@synthesize descLabel = _descLabel;

- (void)dealloc {
    TT_RELEASE_SAFELY(_backView);
    TT_RELEASE_SAFELY(_leftTopImageView);
    TT_RELEASE_SAFELY(_descLabel);
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.clipsToBounds = YES;
        _isEnable = NO;
    }
    return self;
}

- (void)setItem:(DataProductBasic *)productDetail
{
    if (self.productDetailDTO != productDetail) {
        
        self.productDetailDTO = productDetail;
                
        self.productNameLabel.text = self.productDetailDTO.productName;
        
        self.descLabel.text = self.productDetailDTO.special;
        
        if (self.purchaseType == GroupPurchase) {
            
            if (self.isEnable) {
                self.leftTopImageView.image = [UIImage imageNamed: @"product_gp_leftTop.png"];
            }else{
                
                self.leftTopImageView.image = [UIImage imageNamed:@"product_gb_leftTop_disable.png"];
            }
            
        }else if (self.purchaseType == PanicPurchase) {
            if (self.isEnable) {
                self.leftTopImageView.image =  [UIImage imageNamed:@"product_qb_leftTop.png"];
            }else{
                
                self.leftTopImageView.image = [UIImage imageNamed:@"product_qb_leftTop_disable.png"];
            }
            
        }
        
        [self setNeedsLayout];
    }
    
}

- (UIImageView *)leftTopImageView
{
    if (!_leftTopImageView) {
        _leftTopImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_leftTopImageView];
    }
    return _leftTopImageView;
}


-(UIView *)backView{

    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(8, 0, 304, 0);
        _backView.layer.backgroundColor = [UIColor whiteColor].CGColor;
        [_backView.layer setCornerRadius:5.0];
//        [_backView.layer setShadowRadius:2.0];
//        [_backView.layer setShadowOffset:CGSizeMake(0, 0)];
//        [_backView.layer setShadowColor:[UIColor blackColor].CGColor];
//        [_backView.layer setShadowOpacity:0.5];
        _backView.layer.borderWidth = 0.5;
        _backView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self.contentView insertSubview:_backView atIndex:0];
        
    }

    return _backView;
}

- (void)layoutSubviews
{    
    [super layoutSubviews];
        
    CGSize nameSize = [self.productDetailDTO.productName sizeWithFont:[UIFont boldSystemFontOfSize:15.0]
                                                    constrainedToSize:CGSizeMake(225, 200)
                                                        lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize descSize = [self.productDetailDTO.special sizeWithFont:[UIFont boldSystemFontOfSize:12.0] constrainedToSize:CGSizeMake(225, 200) lineBreakMode:UILineBreakModeCharacterWrap];
    
    self.backView.frame = CGRectMake(7, 10, 306,  17+nameSize.height+descSize.height+15+8);
    
    if (self.backView.height < 70) {
        
        self.backView.frame = CGRectMake(7, 10, 306, 70);
    }
    
    self.leftTopImageView.frame = CGRectMake(3, 6, 70, 70);
    
    self.productNameLabel.frame = CGRectMake(62, 16, 225, nameSize.height);
    
    self.descLabel.frame = CGRectMake(62, self.productNameLabel.bottom+5, 225, descSize.height);
    
}


+ (CGFloat)height:(DataProductBasic *)productDetail{

    if (productDetail == nil)
    {
        return 0.0;
    }
    
    CGSize nameSize = [productDetail.productName sizeWithFont:[UIFont boldSystemFontOfSize:15.0] constrainedToSize:CGSizeMake(225, 200) lineBreakMode:UILineBreakModeCharacterWrap];
    
    CGSize descSize = [productDetail.special sizeWithFont:[UIFont boldSystemFontOfSize:12.0] constrainedToSize:CGSizeMake(225, 200) lineBreakMode:UILineBreakModeCharacterWrap];
    
    return nameSize.height + descSize.height + 17+15;
}

- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [[UILabel alloc] init];
        
        _descLabel.backgroundColor = [UIColor clearColor];
        
        _descLabel.font = [UIFont boldSystemFontOfSize:12.0];
        
        _descLabel.textColor = RGBCOLOR(111, 111, 111);
        
        _descLabel.numberOfLines = 0;
        
        _descLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        
        [self.contentView addSubview:_descLabel];
    }
    return _descLabel;
}

@end
