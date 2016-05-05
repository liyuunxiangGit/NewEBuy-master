//
//  NProDetailRecommendCell.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-4-8.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NProDetailRecommendCell.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define ImageViewWidth 95
#define ImageViewHeight 88

#define ViewWidth  95
#define ViewHeight 130

@implementation NProDetailRecommendCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)separateLineImgView
{
    if (!_separateLineImgView) {
        _separateLineImgView = [[UIImageView alloc] init];
        _separateLineImgView.image = [UIImage imageNamed:@"line.png"];
        [self.contentView addSubview:_separateLineImgView];
    }
    return _separateLineImgView;
}

- (UILabel *) leftLabel{
	
	if (!_leftLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:12];
		
		_leftLabel = [[UILabel alloc] init];
        
        _leftLabel.textAlignment = UITextAlignmentLeft;
        
        _leftLabel.numberOfLines = 2;
		
		_leftLabel.backgroundColor = [UIColor clearColor];
        
        _leftLabel.textColor = [UIColor darkTextColor];
        
		_leftLabel.font = font;
		
		_leftLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _leftLabel.shadowColor = [UIColor whiteColor];
        
        _leftLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self.leftBackImageView addSubview:_leftLabel];
	}
	
	return _leftLabel;
}

- (UILabel *)leftPriceLabel{
    
    if (!_leftPriceLabel) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        _leftPriceLabel = [[UILabel alloc] init];
        
        _leftPriceLabel.textAlignment = UITextAlignmentLeft;
        
        _leftPriceLabel.backgroundColor = [UIColor clearColor];
        
        _leftPriceLabel.textColor = [UIColor orange_Red_Color];
        
        _leftPriceLabel.font = font;
        
        _leftPriceLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _leftPriceLabel.adjustsFontSizeToFitWidth = YES;
        
        _leftPriceLabel.shadowColor = [UIColor whiteColor];
        
        _leftPriceLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self.leftBackImageView addSubview:_leftPriceLabel];
    }
    
    return _leftPriceLabel;
    
}

- (UILabel *)centerLabel{
    if (!_centerLabel) {
        UIFont *font = [UIFont systemFontOfSize:12];
		
		_centerLabel = [[UILabel alloc] init];
        
        _centerLabel.textAlignment = UITextAlignmentLeft;
		
		_centerLabel.backgroundColor = [UIColor clearColor];
        
        _centerLabel.numberOfLines = 2;
        
        _centerLabel.textColor = [UIColor darkTextColor];
        
		_centerLabel.font = font;
		
		_centerLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _centerLabel.shadowColor = [UIColor whiteColor];
        
        _centerLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self.centerBackImageView addSubview:_centerLabel];
    }
    return _centerLabel;
}

- (UILabel *)centerPriceLabel{
    if (!_centerPriceLabel) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        _centerPriceLabel = [[UILabel alloc] init];
        
        _centerPriceLabel.textAlignment = UITextAlignmentLeft;
        
        _centerPriceLabel.backgroundColor = [UIColor clearColor];
        
        _centerPriceLabel.textColor = [UIColor orange_Red_Color];
        
        _centerPriceLabel.font = font;
        
        _centerPriceLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _centerPriceLabel.adjustsFontSizeToFitWidth = YES;
        
        _centerPriceLabel.shadowColor = [UIColor whiteColor];
        
        _centerPriceLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self.centerBackImageView addSubview:_centerPriceLabel];
    }
    return _centerPriceLabel;
}

- (UILabel *) rightLabel{
	
	if (!_rightLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:12];
		
		_rightLabel = [[UILabel alloc] init];
        
        _rightLabel.textAlignment = UITextAlignmentLeft;
		
		_rightLabel.backgroundColor = [UIColor clearColor];
        
        _rightLabel.numberOfLines = 2;
        
        _rightLabel.textColor = [UIColor darkTextColor];
        
		_rightLabel.font = font;
		
		_rightLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _rightLabel.shadowColor = [UIColor whiteColor];
        
        _rightLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self.rightBackImageView addSubview:_rightLabel];
		
	}
	
	return _rightLabel;
}

- (UILabel *)rightPriceLabel{
    
    if (!_rightPriceLabel) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        _rightPriceLabel = [[UILabel alloc] init];
        
        _rightPriceLabel.textAlignment = UITextAlignmentLeft;
        
        _rightPriceLabel.backgroundColor = [UIColor clearColor];
        
        _rightPriceLabel.textColor = [UIColor orange_Red_Color];
        
        _rightPriceLabel.font = font;
        
        _rightPriceLabel.autoresizingMask = UIViewAutoresizingNone;
        
        _rightPriceLabel.adjustsFontSizeToFitWidth = YES;
        
        _rightPriceLabel.shadowColor = [UIColor whiteColor];
        
        _rightPriceLabel.shadowOffset = CGSizeMake(1, 1);
        
        [self.rightBackImageView addSubview:_rightPriceLabel];
    }
    
    return _rightPriceLabel;
}

- (EGOImageViewEx *)leftImageView{
	
	if (!_leftImageView) {
		
		_leftImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(5, 2, ImageViewWidth - 10, ImageViewHeight - 10)];
		
		_leftImageView.backgroundColor =[UIColor clearColor];
        
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _leftImageView.userInteractionEnabled = YES;
        
        _leftImageView.exDelegate = self;
        
        _leftImageView.tag = 0;
        
        _leftImageView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        
        _leftImageView.layer.borderWidth = 0.5f;
        
        [self.leftBackImageView addSubview:_leftImageView];
        
	}
	
	return _leftImageView;
}

-(EGOImageViewEx *)centerImageView{
    if (!_centerImageView) {
        _centerImageView = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(5, 2, ImageViewWidth - 10, ImageViewHeight - 10)];
        
        _centerImageView.userInteractionEnabled = YES;
		
		_centerImageView.backgroundColor =[UIColor clearColor];
        
        _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _centerImageView.exDelegate = self;
        
        _centerImageView.tag = 1;
        
        _centerImageView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        
        _centerImageView.layer.borderWidth = 0.5f;
        
        [self.centerBackImageView addSubview:_centerImageView];
    }
    return _centerImageView;
}

- (EGOImageViewEx *) rightImageView{
	
	if (!_rightImageView) {
		
		_rightImageView = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(5, 2, ImageViewWidth - 10, ImageViewHeight - 10)];
        
        _rightImageView.userInteractionEnabled = YES;
		
		_rightImageView.backgroundColor =[UIColor clearColor];
        
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _rightImageView.exDelegate = self;
        
        _rightImageView.tag = 2;
        
        _rightImageView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        
        _rightImageView.layer.borderWidth = 0.5f;
        
        [self.rightBackImageView addSubview:_rightImageView];
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
        
        _leftBackImageView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_leftBackImageView];
    }
    
    return _leftBackImageView;
}



- (UIImageView*)centerBackImageView
{
    if(_centerBackImageView == nil)
    {
        _centerBackImageView = [[UIImageView alloc] init];
        
        _centerBackImageView.frame = CGRectMake(112, 10, ViewWidth, ViewHeight);
        
        _centerBackImageView.userInteractionEnabled = YES;
        
        _centerBackImageView.backgroundColor = [UIColor whiteColor];
        
        
        
        
        [self.contentView addSubview:_leftBackImageView];
    }
    
    return _centerBackImageView;
}

- (UIImageView*)rightBackImageView
{
    if(_rightBackImageView == nil)
    {
        _rightBackImageView = [[UIImageView alloc] init];
        
        _rightBackImageView.frame = CGRectMake(215, 10, ViewWidth, ViewHeight);
        
        _rightBackImageView.userInteractionEnabled = YES;
        
        _rightBackImageView.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:_rightBackImageView];
    }
    
    return _rightBackImageView;
}



+ (CGFloat) height:(RecommendListDTO *)item{
	
	if (!item) {
		
		return ViewHeight;
	}
	
	return  ViewHeight;
}


- (void)setItem:(RecommendListDTO *)aLeftDto
     centerItem:(RecommendListDTO *)aCenterDto
      rightItem:(RecommendListDTO *)aRightDto
        withTag:(NSInteger)index
{
    self.leftDto = aLeftDto;
    self.leftImageView.userInteractionEnabled = YES;
    
    self.leftImageView.imageURL = self.leftDto.productUrl;
    
    self.leftLabel.text = self.leftDto.sugGoodsName;
    double price = [self.leftDto.price doubleValue];
    if (price <= 0) {
        self.leftPriceLabel.text = L(@"saleOut");
    }else{
        NSString *leftPrice = [NSString stringWithFormat:@"￥%.2f",price];
        self.leftPriceLabel.text = leftPrice;
    }
    self.centerDto = aCenterDto;
    
    if (aCenterDto == nil) {
        
        [self.centerBackImageView removeFromSuperview];
        
    }else{
        [self.contentView addSubview:self.centerBackImageView];
        self.centerImageView.userInteractionEnabled = YES;

        self.centerImageView.imageURL = self.centerDto.productUrl;
        self.centerLabel.text = self.centerDto.sugGoodsName;
        
        price = [self.centerDto.price doubleValue];
        if (price <= 0) {
            self.centerPriceLabel.text = L(@"saleOut");
        }else{
            NSString *centerPrice = [NSString stringWithFormat:@"￥%.2f", price];
            
            self.centerPriceLabel.text = centerPrice;
        }
        
    }
    
    self.rightDto = aRightDto;
    
    if (aRightDto == nil) {
        
        [self.rightBackImageView removeFromSuperview];
        
    }else{
        
        [self.contentView addSubview:self.rightBackImageView];
        self.rightImageView.userInteractionEnabled = YES;

        self.rightImageView.imageURL = self.rightDto.productUrl;
        self.rightLabel.text = self.rightDto.sugGoodsName;
        
        price = [self.rightDto.price doubleValue];
        if (price <= 0) {
            self.rightPriceLabel.text = L(@"saleOut");
        }else{
            NSString *rightPrice = [NSString stringWithFormat:@"￥%.2f", price];
            
            self.rightPriceLabel.text = rightPrice;
        }
        
        
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
	
    [super layoutSubviews];
    
//    self.separateLineImgView.frame = CGRectMake(15, 156.5, 305, 0.5);
    
    self.leftLabel.frame = CGRectMake(5, self.leftImageView.bottom + 10, ViewWidth - 10 ,30);
    self.leftPriceLabel.frame = CGRectMake(5, self.leftLabel.bottom + 5, ViewWidth - 10 ,12);
    
    self.centerLabel.frame = CGRectMake(5, self.centerImageView.bottom + 10, ViewWidth - 10 ,30);
    self.centerPriceLabel.frame = CGRectMake(5, self.centerLabel.bottom + 5, ViewWidth - 10 ,12);
    
    self.rightLabel.frame = CGRectMake(5, self.rightImageView.bottom + 10, ViewWidth - 10 ,30);
    self.rightPriceLabel.frame = CGRectMake(5, self.rightLabel.bottom + 5, ViewWidth - 10 ,12);
    
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"121310"], nil]];
    NSInteger viewTag = imageViewEx.tag;
    
    DataProductBasic *productDto = nil;
    RecommendListDTO *tempRecommendListDTO = nil;
    if (viewTag == 0)
    {
        productDto = self.leftDto.transformToProductDTO;
        tempRecommendListDTO = self.leftDto;
    }
    else if (viewTag == 1)
    {
        productDto = self.centerDto.transformToProductDTO;
        tempRecommendListDTO = self.centerDto;
    }
    else if(viewTag == 2)
    {
        productDto = self.rightDto.transformToProductDTO;
        tempRecommendListDTO = self.rightDto;
    }

    if ([self.delegate conformsToProtocol:@protocol(NProDetailRecoCellDelegate)])
    {
        if ([self.delegate respondsToSelector:@selector(cellImageDidClicked:RecommendListDTO:)])
        {
            [self.delegate cellImageDidClicked:productDto RecommendListDTO:tempRecommendListDTO];
        }
    }
    
    TT_RELEASE_SAFELY(productDto);
    
}


@end
