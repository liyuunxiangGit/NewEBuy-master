//
//  ShopSearchListCell.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ShopSearchListCell.h"
#define UPARROW_TOP 6
#define RIGHT_LABELS_TOP 18
@implementation ShopSearchListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




- (void)setItem:(ShopSearchListDTO *)item
{
    [self grayBack];
    [self sepLine1];
    [self sepLine2];
    [self sepLine3];
    [self upArrow1];
    [self upArrow2];
    [self upArrow3];
    
    NSString *str = item.shopName;
    CGSize sz = [str sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(200, 20) ];
    self.labelShopName.frame = CGRectMake(self.labelShopName.left, self.labelShopName.top, sz.width, 20);
    self.labelShopName.text = str;
    
    self.rightArrow.left = self.labelShopName.right + 5;
    
    self.descNumLabel.text = item.serviceScore;
    
    self.upArrow1.left = self.descNumLabel.right ;
    
    self.logisticsScore.text = item.logisticsScore;
    
    self.upArrow2.left = self.logisticsScore.right;
    
    self.productScore.text = item.productScore;
    
    self.upArrow3.left = self.productScore.right;
    
    self.descLabel.text = L(@"Service");
    
    self.logisticsLabel.text = L(@"Logistics");
    
    self.productLabel.text = L(@"Search_Goods");
    
    self.shopLogoView.imageURL = [NSURL URLWithString:item.logoUrl];
    
    self.supplySatisfyStar.text = L(@"Search_SellerSatisfaction");
    
    [self.starView setStarsImages:item.supplySatisfyStar];
    
    NSString *text = item.supplySatisfyStar;
    NSRange range = [text rangeOfString:@"_"];
    if (range.location != NSNotFound)
    {
        text = [text substringToIndex:range.location];
    }
    self.supplySatisfyStarScore.text = text;
    
    self.catalogLabel.text = [NSString stringWithFormat:@"%@ : %@", L(@"Search_MainCategory"),item.catalog];
    
    self.addressLabel.text = [NSString stringWithFormat:@"%@ : %@", L(@"Search_Location"),item.shopAddress];
}

#pragma mark - 控件
- (UIView *)grayBack
{
    if (!_grayBack)
    {
        _grayBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 35)];
        _grayBack.backgroundColor = RGBCOLOR(247, 247, 248);
        
        [self.contentView addSubview:_grayBack];
    }
    
    return _grayBack;
}

- (UIView *)sepLine1
{
    if (!_sepLine1)
    {
        _sepLine1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
        _sepLine1.backgroundColor = RGBCOLOR(220, 220, 220);
        
        [self.contentView addSubview:_sepLine1];
    }
    return _sepLine1;
}

- (UIView *)sepLine2
{
    if (!_sepLine2)
    {
        _sepLine2 = [[UIView alloc] initWithFrame:CGRectMake(0, 34.5, 320, 0.5)];
        _sepLine2.backgroundColor = RGBCOLOR(220, 220, 220);
        
        [self.contentView addSubview:_sepLine2];
    }
    return _sepLine2;
}

- (UIView *)sepLine3
{
    if (!_sepLine3)
    {
        _sepLine3 = [[UIView alloc] initWithFrame:CGRectMake(0, 114.5, 320, 0.5)];
        _sepLine3.backgroundColor = RGBCOLOR(220, 220, 220);
        
        [self.contentView addSubview:_sepLine3];
    }
    return _sepLine3;
}

-(UILabel *)labelShopName
{
    if (!_labelShopName)
    {
        _labelShopName = [[UILabel alloc] initWithFrame:CGRectMake(10, 7.5, 190, 20)];
        _labelShopName.backgroundColor = [UIColor clearColor];
        _labelShopName.font = [UIFont systemFontOfSize:14];
        _labelShopName.textColor = [UIColor blackColor];
        
        [self.contentView addSubview:_labelShopName];
    }
    
    return _labelShopName;
}

- (UIImageView *)rightArrow
{
    if (!_rightArrow)
    {
        _rightArrow = [[UIImageView alloc] initWithFrame:CGRectMake(0, (35 - 12) / 2.0 + 0.5, 7, 12)];
        _rightArrow.image = [UIImage imageNamed:@"shopSearch_rightArrow.png"];
        [self.contentView addSubview:_rightArrow];
    }
    
    return _rightArrow;
}


- (UIImageView *)upArrow1
{
    if (!_upArrow1)
    {
        _upArrow1 = [[UIImageView alloc] initWithFrame:CGRectMake(244, UPARROW_TOP, 5, 12)];
        _upArrow1.image = [UIImage imageNamed:@"shopSearch_upArrow.png"];
        [self.contentView addSubview:_upArrow1];
    }
    return _upArrow1;
}

- (UIImageView *)upArrow2
{
    if (!_upArrow2)
    {
        _upArrow2 = [[UIImageView alloc] initWithFrame:CGRectMake(273, UPARROW_TOP, 5, 12)];
        _upArrow2.image = [UIImage imageNamed:@"shopSearch_upArrow.png"];
        [self.contentView addSubview:_upArrow2];
    }
    
    return _upArrow2;
}

- (UIImageView *)upArrow3
{
    if (!_upArrow3)
    {
        _upArrow3 = [[UIImageView alloc] initWithFrame:CGRectMake(302, UPARROW_TOP, 5, 12)];
        _upArrow3.image = [UIImage imageNamed:@"shopSearch_upArrow.png"];
        [self.contentView addSubview:_upArrow3];
    }
    
    return _upArrow3;
}

- (UILabel *)descNumLabel
{
    if (!_descNumLabel)
    {
        _descNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, UPARROW_TOP, 15, 12)];
        _descNumLabel.backgroundColor = [UIColor clearColor];
        _descNumLabel.font = [UIFont systemFontOfSize:9];
        _descNumLabel.textColor = RGBCOLOR(250, 71, 5);
        
        [self.contentView addSubview:_descNumLabel];
    }
    
    return _descNumLabel;
}

- (UILabel *)logisticsScore
{
    if (!_logisticsScore)
    {
        _logisticsScore = [[UILabel alloc] initWithFrame:CGRectMake(255, UPARROW_TOP, 15, 12)];
        _logisticsScore.backgroundColor = [UIColor clearColor];
        _logisticsScore.font = [UIFont systemFontOfSize:9];
        _logisticsScore.textColor = RGBCOLOR(250, 71, 5);
        
        [self.contentView addSubview:_logisticsScore];
    }
    
    return _logisticsScore;
}


- (UILabel *)productScore
{
    if (!_productScore)
    {
        _productScore = [[UILabel alloc] initWithFrame:CGRectMake(280, UPARROW_TOP, 15, 12)];
        _productScore.backgroundColor = [UIColor clearColor];
        _productScore.font = [UIFont systemFontOfSize:9];
        _productScore.textColor = RGBCOLOR(250, 71, 5);
        
        [self.contentView addSubview:_productScore];
    }
    
    return _productScore;
}


- (UILabel *)descLabel
{
    if (!_descLabel)
    {
        _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(230, RIGHT_LABELS_TOP, 20, 12)];
        _descLabel.backgroundColor = [UIColor clearColor];
        _descLabel.font = [UIFont systemFontOfSize:9];
        _descLabel.textColor = RGBCOLOR(112, 112, 112);
        
        [self.contentView addSubview:_descLabel];
    }
    
    return _descLabel;
}

- (UILabel *)logisticsLabel
{
    if (!_logisticsLabel)
    {
        _logisticsLabel = [[UILabel alloc] initWithFrame:CGRectMake(255, RIGHT_LABELS_TOP, 20, 12)];
        _logisticsLabel.backgroundColor = [UIColor clearColor];
        _logisticsLabel.font = [UIFont systemFontOfSize:9];
        _logisticsLabel.textColor = RGBCOLOR(112, 112, 112);
        [self.contentView addSubview:_logisticsLabel];
    }
    
    return _logisticsLabel;
}

- (UILabel *)productLabel
{
    if (!_productLabel)
    {
        _productLabel = [[UILabel alloc] initWithFrame:CGRectMake(280, RIGHT_LABELS_TOP, 20, 12)];
        _productLabel.backgroundColor = [UIColor clearColor];
        _productLabel.font = [UIFont systemFontOfSize:9];
        _productLabel.textColor = RGBCOLOR(112, 112, 112);
        
        [self.contentView addSubview:_productLabel];
    }
    
    return _productLabel;
}

- (EGOImageView *)shopLogoView
{
    if (!_shopLogoView)
    {
        CGRect productFrame =  CGRectMake(10, 45, 55, 55);
        _shopLogoView = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 55, 55)];
        _shopLogoView.backgroundColor = [UIColor whiteColor];
        _shopLogoView.contentMode = UIViewContentModeScaleAspectFit;
        _shopLogoView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        UIView *suppImageView = [[UIView alloc] initWithFrame:productFrame];
        suppImageView.backgroundColor = [UIColor clearColor];
        suppImageView.layer.borderWidth = 0.5;
        suppImageView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        
        [suppImageView addSubview:_shopLogoView];
        [self.contentView addSubview:suppImageView];
    }
    return _shopLogoView;
}

- (UILabel *)supplySatisfyStar
{
    if (!_supplySatisfyStar)
    {
        _supplySatisfyStar = [[UILabel alloc] initWithFrame:CGRectMake(self.shopLogoView.right + 20, 45, 80, 13)];
        _supplySatisfyStar.backgroundColor = [UIColor clearColor];
        _supplySatisfyStar.font = [UIFont systemFontOfSize:13];
        _supplySatisfyStar.textColor = RGBCOLOR(110, 110, 110);
        
        [self.contentView addSubview:_supplySatisfyStar];
    }
    
    return _supplySatisfyStar;
}

- (EvaluationView *)starView
{
    if (!_starView)
    {
        _starView = [[EvaluationView alloc] initWithFrame:CGRectMake(self.supplySatisfyStar.right + 5, 45, 84, 30)];
        _starView.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:_starView];
    }
    
    return _starView;
}

- (UILabel *)supplySatisfyStarScore
{
    if (!_supplySatisfyStarScore)
    {
        _supplySatisfyStarScore = [[UILabel alloc] initWithFrame:CGRectMake(self.starView.right + 5, 45, 40, 12)];
        _supplySatisfyStarScore.backgroundColor = [UIColor clearColor];
        _supplySatisfyStarScore.font = [UIFont systemFontOfSize:10];
        _supplySatisfyStarScore.textColor = RGBCOLOR(112, 112, 112);
        
        [self.contentView addSubview:_supplySatisfyStarScore];
    }
    
    return _supplySatisfyStarScore;
}

- (UILabel *)catalogLabel
{
    if (!_catalogLabel)
    {
        _catalogLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shopLogoView.right + 20, 65, 220, 13)];
        _catalogLabel.backgroundColor = [UIColor clearColor];
        _catalogLabel.font = [UIFont systemFontOfSize:13];
        _catalogLabel.textColor = RGBCOLOR(110, 110, 110);
        
        [self.contentView addSubview:_catalogLabel];
    }
    
    return _catalogLabel;
}


- (UILabel *)addressLabel
{
    if (!_addressLabel)
    {
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.shopLogoView.right + 20, 85, 220, 13)];
        _addressLabel.backgroundColor = [UIColor clearColor];
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.textColor = RGBCOLOR(110, 110, 110);
        
        [self.contentView addSubview:_addressLabel];
    }
    
    return _addressLabel;
}

@end
