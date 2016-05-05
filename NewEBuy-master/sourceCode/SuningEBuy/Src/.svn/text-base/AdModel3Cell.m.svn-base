//
//  AdModel3Cell.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "AdModel3Cell.h"
#import "ProductUtil.h"

#define ImageViewWidth 95
#define ImageViewHeight 88

#define ViewWidth  95
#define ViewHeight 130
#define ORDER_LIST_CELL_HEIGHT

#define lineWidth 85
#define lineHeight 0.5

@implementation AdModel3Cell

@synthesize  imageDidDelegate = imageDidDelegate_;

@synthesize leftLabel      = _leftLabel;
@synthesize rightLabel     = _rightLabel;
@synthesize centerLabel    = _centerLabel;

@synthesize leftImageView  = _leftImageView;
@synthesize rightImageView = _rightImageView;
@synthesize centerImageView = _centerImageView;

@synthesize leftPriceLabel = leftPriceLabel_;
@synthesize rightPriceLabel = rightPriceLabel_;
@synthesize centerPriceLabel = centerPriceLabel_;

@synthesize leftDto = leftDto_;
@synthesize rightDto = rightDto_;
@synthesize centerDto = centerDto_;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_leftLabel);
    TT_RELEASE_SAFELY(_rightLabel);
    TT_RELEASE_SAFELY(_centerLabel);
    
    TT_RELEASE_SAFELY(_leftImageView);
    TT_RELEASE_SAFELY(_rightImageView);
    TT_RELEASE_SAFELY(_centerImageView);
    
    TT_RELEASE_SAFELY(_leftBackImageView);
    TT_RELEASE_SAFELY(_rightBackImageView);
    TT_RELEASE_SAFELY(_centerBackImageView);
    
    TT_RELEASE_SAFELY(leftPriceLabel_);
    TT_RELEASE_SAFELY(rightPriceLabel_);
    TT_RELEASE_SAFELY(centerPriceLabel_);
    
    TT_RELEASE_SAFELY(leftDto_);
    TT_RELEASE_SAFELY(rightDto_);
    TT_RELEASE_SAFELY(centerDto_);
    
    TT_RELEASE_SAFELY(_leftSegmentLine);
    TT_RELEASE_SAFELY(_rightSegmentLine);
    TT_RELEASE_SAFELY(_centerSegmentLine);
    
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
	self = [super initWithReuseIdentifier:reuseIdentifier];
	if (self) {
        
        self.userInteractionEnabled = YES;
        
	}
	
	return self;
}

- (UIImageView *)leftSegmentLine
{
    if (!_leftSegmentLine) {
        _leftSegmentLine = [[UIImageView alloc] init];
        _leftSegmentLine.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
        [self.leftBackImageView addSubview:_leftSegmentLine];
    }
    return _leftSegmentLine;
}

- (UIImageView *) centerSegmentLine
{
    if (!_centerSegmentLine) {
        _centerSegmentLine = [[UIImageView alloc] init];
        _centerSegmentLine.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
        [self.centerBackImageView addSubview:_centerSegmentLine];
    }
    return _centerSegmentLine;
}

- (UIImageView *) rightSegmentLine
{
    if (!_rightSegmentLine) {
        _rightSegmentLine = [[UIImageView alloc] init];
        _rightSegmentLine.backgroundColor = [UIColor colorWithHexString:@"#E0E0E0"];
        [self.rightBackImageView addSubview:_rightSegmentLine];
    }
    return _rightSegmentLine;
}

- (UILabel *) leftLabel{
	
	if (!_leftLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:12];
		
		_leftLabel = [[UILabel alloc] init];
        
        _leftLabel.textAlignment = UITextAlignmentLeft;
		
		_leftLabel.backgroundColor = [UIColor clearColor];// RGBCOLOR(239, 239, 239);//RGBCOLOR(250, 231, 227);
        
        _leftLabel.textColor = [UIColor darkTextColor];
        
		_leftLabel.font = font;
		
		_leftLabel.autoresizingMask = UIViewAutoresizingNone;
        
//        _leftLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
//        _leftLabel.numberOfLines = 2;
        
        _leftLabel.shadowColor = [UIColor whiteColor];
        
        _leftLabel.shadowOffset = CGSizeMake(1, 1);
        
        //        [_leftLabel.layer setCornerRadius:6.0];
        //
        //        [_leftLabel.layer  setMasksToBounds:YES];
        
//		[self.leftBackImageViewLbl addSubview:_leftLabel];
        
        [self.leftBackImageView addSubview:_leftLabel];
	}
	
	return _leftLabel;
}


- (UILabel *)leftPriceLabel{
    
    if (!leftPriceLabel_) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        leftPriceLabel_ = [[UILabel alloc] init];
        
        leftPriceLabel_.textAlignment = UITextAlignmentLeft;
        
        leftPriceLabel_.backgroundColor = [UIColor clearColor];//RGBCOLOR(239, 239, 239);//RGBCOLOR(250, 231, 227);
        
        leftPriceLabel_.textColor = [UIColor orange_Red_Color];
        
        leftPriceLabel_.font = font;
        
        leftPriceLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        leftPriceLabel_.adjustsFontSizeToFitWidth = YES;
        
        leftPriceLabel_.shadowColor = [UIColor whiteColor];
        
        leftPriceLabel_.shadowOffset = CGSizeMake(1, 1);
        
//        [leftPriceLabel_.layer setCornerRadius:6.0];
//        
//        [leftPriceLabel_.layer  setMasksToBounds:YES];
        
//        [self.leftBackImageViewLbl addSubview:leftPriceLabel_];
        
        [self.leftBackImageView addSubview:leftPriceLabel_];
    }
    
    return leftPriceLabel_;
    
}

- (UILabel *)centerLabel{
    if (!_centerLabel) {
        UIFont *font = [UIFont systemFontOfSize:12];
		
		_centerLabel = [[UILabel alloc] init];
        
        _centerLabel.textAlignment = UITextAlignmentLeft;
		
		_centerLabel.backgroundColor = [UIColor clearColor];//RGBCOLOR(239, 239, 239);//RGBCOLOR(250, 231, 227);
        
        _centerLabel.textColor = [UIColor darkTextColor];
        
		_centerLabel.font = font;
		
		_centerLabel.autoresizingMask = UIViewAutoresizingNone;
        
//        _centerLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
//        _centerLabel.numberOfLines = 2;
        
        _centerLabel.shadowColor = [UIColor whiteColor];
        
        _centerLabel.shadowOffset = CGSizeMake(1, 1);
        
        //        [_centerLabel.layer setCornerRadius:6.0];
        //
        //        [_centerLabel.layer  setMasksToBounds:YES];
        
//		[self.centerBackImageViewLbl addSubview:_centerLabel];
        
        [self.centerBackImageView addSubview:_centerLabel];
    }
    return _centerLabel;
}

- (UILabel *)centerPriceLabel{
    if (!centerPriceLabel_) {
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        centerPriceLabel_ = [[UILabel alloc] init];
        
        centerPriceLabel_.textAlignment = UITextAlignmentLeft;
        
        centerPriceLabel_.backgroundColor = [UIColor clearColor];//RGBCOLOR(239, 239, 239);//RGBCOLOR(250, 231, 227);
        
        centerPriceLabel_.textColor = [UIColor orange_Red_Color];
        
        centerPriceLabel_.font = font;
        
        centerPriceLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        centerPriceLabel_.adjustsFontSizeToFitWidth = YES;
        
        centerPriceLabel_.shadowColor = [UIColor whiteColor];
        
        centerPriceLabel_.shadowOffset = CGSizeMake(1, 1);
        
//        [centerPriceLabel_.layer setCornerRadius:6.0];
//        
//        [centerPriceLabel_.layer  setMasksToBounds:YES];
        
//        [self.centerBackImageViewLbl addSubview:centerPriceLabel_];
        
        [self.centerBackImageView addSubview:centerPriceLabel_];
    }
    return centerPriceLabel_;
}

- (UILabel *) rightLabel{
	
	if (!_rightLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:12];
		
		_rightLabel = [[UILabel alloc] init];
        
        _rightLabel.textAlignment = UITextAlignmentLeft;
		
		_rightLabel.backgroundColor = [UIColor clearColor];//RGBCOLOR(239, 239, 239);//RGBCOLOR(250, 231, 227);
        
        _rightLabel.textColor = [UIColor darkTextColor];
        
		_rightLabel.font = font;
		
		_rightLabel.autoresizingMask = UIViewAutoresizingNone;
        
//        _rightLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
//        _rightLabel.numberOfLines = 2;
        
        _rightLabel.shadowColor = [UIColor whiteColor];
        
        _rightLabel.shadowOffset = CGSizeMake(1, 1);
        
        //        [_rightLabel.layer setCornerRadius:0.0];
        //
        //        [_rightLabel.layer  setMasksToBounds:YES];
        
//        [self.rightBackImageViewLbl addSubview:_rightLabel];
        
        [self.rightBackImageView addSubview:_rightLabel];
		
	}
	
	return _rightLabel;
}

- (UILabel *)rightPriceLabel{
    
    if (!rightPriceLabel_) {
        
        UIFont *font = [UIFont boldSystemFontOfSize:12];
        
        rightPriceLabel_ = [[UILabel alloc] init];
        
        rightPriceLabel_.textAlignment = UITextAlignmentLeft;
        
        rightPriceLabel_.backgroundColor = [UIColor clearColor];//RGBCOLOR(239, 239, 239);//RGBCOLOR(250, 231, 227);
        
        rightPriceLabel_.textColor = [UIColor orange_Red_Color];
        
        rightPriceLabel_.font = font;
        
        rightPriceLabel_.autoresizingMask = UIViewAutoresizingNone;
        
        rightPriceLabel_.adjustsFontSizeToFitWidth = YES;
        
        rightPriceLabel_.shadowColor = [UIColor whiteColor];
        
        rightPriceLabel_.shadowOffset = CGSizeMake(1, 1);
        
        //        [rightPriceLabel_.layer setCornerRadius:0.0];
        //
        //        [rightPriceLabel_.layer  setMasksToBounds:YES];
        
//        [self.rightBackImageViewLbl addSubview:rightPriceLabel_];
        
        [self.rightBackImageView addSubview:rightPriceLabel_];
    }
    
    return rightPriceLabel_;
}

- (EGOImageViewEx *)leftImageView{
	
	if (!_leftImageView) {
		
		_leftImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(10, 10, ImageViewWidth - 20, ImageViewHeight - 20)];
		
		_leftImageView.backgroundColor =[UIColor clearColor];
        
        _leftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _leftImageView.userInteractionEnabled = YES;
        
        _leftImageView.exDelegate = self;
        
        _leftImageView.tag = 0;
        
//        [_leftImageView.layer setCornerRadius:6.0];
//        
//        [_leftImageView.layer  setMasksToBounds:YES];
//        _leftImageView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
//        _leftImageView.layer.borderWidth = 0.5f;
        
        [self.leftBackImageView addSubview:_leftImageView];
        
	}
	
	return _leftImageView;
}

-(EGOImageViewEx *)centerImageView{
    if (!_centerImageView) {
        _centerImageView = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(10, 10, ImageViewWidth - 20, ImageViewHeight - 20)];
        
        _centerImageView.userInteractionEnabled = YES;
		
		_centerImageView.backgroundColor =[UIColor clearColor];
        
        _centerImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _centerImageView.exDelegate = self;
        
        _centerImageView.tag = 1;
        
//        [_centerImageView.layer setCornerRadius:6.0];
//        
//        [_centerImageView.layer  setMasksToBounds:YES];
        
//        _centerImageView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
//        _centerImageView.layer.borderWidth = 0.5f;
        
        
        [self.centerBackImageView addSubview:_centerImageView];
    }
    return _centerImageView;
}

- (UILabel *)leftHintLabel {
    if (!_leftHintLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        _leftHintLabel = [[UILabel alloc] init];
        _leftHintLabel.text = @"￥";
        _leftHintLabel.textAlignment =NSTextAlignmentRight;
        _leftHintLabel.backgroundColor = [UIColor clearColor];
        _leftHintLabel.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);//RGBCOLOR(190, 3, 7);
        _leftHintLabel.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
        //        _priceHintLabel.autoresizingMask = UIViewAutoresizingNone;
        _leftHintLabel.hidden = YES;
        [self.leftBackImageView addSubview:_leftHintLabel];
    }
    return _leftHintLabel;
}


- (UILabel *)centerHintLabel {
    if (!_centerHintLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        _centerHintLabel = [[UILabel alloc] init];
        _centerHintLabel.text = @"￥";
        _centerHintLabel.textAlignment =NSTextAlignmentRight;
        _centerHintLabel.backgroundColor = [UIColor clearColor];
        _centerHintLabel.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);//RGBCOLOR(190, 3, 7);
        _centerHintLabel.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
        //        _priceHintLabel.autoresizingMask = UIViewAutoresizingNone;
        _centerHintLabel.hidden = YES;
        [self.centerBackImageView addSubview:_centerHintLabel];
    }
    return _centerHintLabel;
}


- (UILabel *)rightHintLabel {
    if (!_rightHintLabel) {
        UIFont *font = [UIFont boldSystemFontOfSize:16];
        _rightHintLabel = [[UILabel alloc] init];
        _rightHintLabel.text = @"￥";
        _rightHintLabel.textAlignment =NSTextAlignmentRight;
        _rightHintLabel.backgroundColor = [UIColor clearColor];
        _rightHintLabel.textColor = [UIColor orange_Red_Color];// RGBCOLOR(219, 0, 0);//RGBCOLOR(190, 3, 7);
        _rightHintLabel.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
        //        _priceHintLabel.autoresizingMask = UIViewAutoresizingNone;
        _rightHintLabel.hidden = YES;
        [self.rightBackImageView addSubview:_rightHintLabel];
    }
    return _rightHintLabel;
}

- (EGOImageViewEx *)leftPriceImageView {
    if (!_leftPriceImageView) {
        _leftPriceImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(30, 5, 100, 8)];
        
        _leftPriceImageView.backgroundColor =[UIColor clearColor];
        
        _leftPriceImageView.cacheOptions = (1 << 4);
        
        _leftPriceImageView.contentMode = UIViewContentModeLeft;
        
        _leftPriceImageView.userInteractionEnabled = NO;
        _leftPriceImageView.hidden = YES;
        [self.leftBackImageView addSubview:_leftPriceImageView];
    }
    return _leftPriceImageView;
}


- (EGOImageViewEx *)centerPriceImageView {
    if (!_centerPriceImageView) {
        _centerPriceImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(30, 5, 100, 8)];
        
        _centerPriceImageView.backgroundColor =[UIColor clearColor];
        
        _centerPriceImageView.contentMode = UIViewContentModeLeft;
        
        _centerPriceImageView.cacheOptions = (1 << 4);
        
        _centerPriceImageView.userInteractionEnabled = NO;
        _centerPriceImageView.hidden = YES;
        [self.centerBackImageView addSubview:_centerPriceImageView];
    }
    return _centerPriceImageView;
}


- (EGOImageViewEx *)rightPriceImageView {
    if (!_rightPriceImageView) {
        _rightPriceImageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(30, 5, 100, 8)];
        
        _rightPriceImageView.backgroundColor =[UIColor clearColor];
        
        _rightPriceImageView.cacheOptions = (1 << 4);
        
        _rightPriceImageView.contentMode = UIViewContentModeLeft;
        
        _rightPriceImageView.userInteractionEnabled = NO;
        _rightPriceImageView.hidden = YES;
        [self.rightBackImageView addSubview:_rightPriceImageView];
    }
    return _rightPriceImageView;
}

- (EGOImageViewEx *) rightImageView{
	
	if (!_rightImageView) {
		
		_rightImageView = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(10, 10, ImageViewWidth - 20, ImageViewHeight - 20)];
        
        _rightImageView.userInteractionEnabled = YES;
		
		_rightImageView.backgroundColor =[UIColor clearColor];
        
        _rightImageView.contentMode = UIViewContentModeScaleAspectFit;
                
        _rightImageView.exDelegate = self;
        
        _rightImageView.tag = 2;
        
//        [_rightImageView.layer setCornerRadius:6.0];
//        
//        [_rightImageView.layer  setMasksToBounds:YES];
        
//        _rightImageView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
//        _rightImageView.layer.borderWidth = 0.5f;
        
        [self.rightBackImageView addSubview:_rightImageView];
	}
    
	return _rightImageView;
}

//- (UIImageView*)leftBackImageViewLbl
//{
//    if(_leftBackImageViewLbl == nil)
//    {
//        _leftBackImageViewLbl = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"bangdan_back_btn.png"]];
//        
//        _leftBackImageViewLbl.frame = CGRectMake(6, 6, ViewWidth, ViewHeight);
//        
//        _leftBackImageViewLbl.userInteractionEnabled = YES;
//        
//        _leftBackImageViewLbl.backgroundColor = RGBCOLOR(239, 239, 239);
//        
//        [_leftBackImageViewLbl.layer setCornerRadius:6.0];
//        
//        [_leftBackImageViewLbl.layer  setMasksToBounds:YES];
//        
//        
//        [self.leftBackImageView addSubview:_leftBackImageViewLbl];
//    }
//    
//    return _leftBackImageViewLbl;
//}
//
//- (UIImageView*)centerBackImageViewLbl
//{
//    if(_centerBackImageViewLbl == nil)
//    {
//        _centerBackImageViewLbl = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"bangdan_back_btn.png"]];
//        
//        _centerBackImageViewLbl.frame = CGRectMake(6, 6, ViewWidth, ViewHeight);
//        
//        _centerBackImageViewLbl.userInteractionEnabled = YES;
//        
//        _centerBackImageViewLbl.backgroundColor = RGBCOLOR(239, 239, 239);
//        
//        [_centerBackImageViewLbl.layer setCornerRadius:6.0];
//        
//        [_centerBackImageViewLbl.layer  setMasksToBounds:YES];
//        
//        
//        [self.centerBackImageView addSubview:_centerBackImageViewLbl];
//    }
//    
//    return _centerBackImageViewLbl;
//}
//
//- (UIImageView*)rightBackImageViewLbl
//{
//    if(_rightBackImageViewLbl == nil)
//    {
//        _rightBackImageViewLbl = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"bangdan_back_btn.png"]];
//        
//        _rightBackImageViewLbl.frame = CGRectMake(6, 6, ViewWidth, ViewHeight);
//        
//        _rightBackImageViewLbl.userInteractionEnabled = YES;
//        
//        _rightBackImageViewLbl.backgroundColor = RGBCOLOR(239, 239, 239);
//        
//        [_rightBackImageViewLbl.layer setCornerRadius:6.0];
//        
//        [_rightBackImageViewLbl.layer  setMasksToBounds:YES];
//        
//        [self.rightBackImageView addSubview:_rightBackImageViewLbl];
//    }
//    
//    return _rightBackImageViewLbl;
//}

- (UIImageView*)leftBackImageView
{
    if(_leftBackImageView == nil)
    {
        _leftBackImageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"bangdan_back_btn.png"]];
        
        _leftBackImageView.frame = CGRectMake(10, 10, ViewWidth, ViewHeight);
        
        _leftBackImageView.userInteractionEnabled = YES;
        
        _leftBackImageView.backgroundColor = [UIColor whiteColor];
        
//        [_leftBackImageView.layer setCornerRadius:6.0];
//        
//        [_leftBackImageView.layer  setMasksToBounds:YES];
        
        _leftBackImageView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
        _leftBackImageView.layer.borderWidth = 0.5f;

        
        [self.contentView addSubview:_leftBackImageView];
    }
    
    return _leftBackImageView;
}



- (UIImageView*)centerBackImageView
{
    if(_centerBackImageView == nil)
    {
        _centerBackImageView = [[UIImageView alloc] init];//WithImage:[UIImage imageNamed:@"bangdan_back_btn.png"]];
        
        _centerBackImageView.frame = CGRectMake(113, 10, ViewWidth, ViewHeight);
        
        _centerBackImageView.userInteractionEnabled = YES;
        
        _centerBackImageView.backgroundColor = [UIColor whiteColor];
        
//        [_centerBackImageView.layer setCornerRadius:6.0];
//        
//        [_centerBackImageView.layer  setMasksToBounds:YES];
        
        _centerBackImageView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
        _centerBackImageView.layer.borderWidth = 0.5f;

        
        [self.contentView addSubview:_leftBackImageView];
    }
    
    return _centerBackImageView;
}

- (UIImageView*)rightBackImageView
{
    if(_rightBackImageView == nil)
    {
        _rightBackImageView = [[UIImageView alloc] init];//[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bangdan_back_btn.png"]];
        
        _rightBackImageView.frame = CGRectMake(215, 10, ViewWidth, ViewHeight);
        
        _rightBackImageView.userInteractionEnabled = YES;
        
        _rightBackImageView.backgroundColor = [UIColor whiteColor];
        
//        [_rightBackImageView.layer setCornerRadius:6.0];
//        
//        [_rightBackImageView.layer  setMasksToBounds:YES];
        
        _rightBackImageView.layer.borderColor = [UIColor colorWithHexString:@"#E0E0E0"].CGColor;
        
        _rightBackImageView.layer.borderWidth = 0.5f;

        
        [self.contentView addSubview:_rightBackImageView];
    }
    
    return _rightBackImageView;
}



+ (CGFloat) height:(InnerProductDTO *)item{
	
	if (!item) {
		
		return ViewHeight;
	}
	
	return  ViewHeight;
}


- (void)setItem:(InnerProductDTO *)aLeftDto
     centerItem:(InnerProductDTO *)aCenterDto
      rightItem:(InnerProductDTO *)aRightDto
        withTag:(NSInteger)index
{
    self.leftDto = aLeftDto;
    self.leftImageView.userInteractionEnabled = YES;
    //    [self.salesLeftSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_small_%d.png",[self.leftDto.promIcon intValue]]]];
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.leftImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.leftDto.productCode size:ProductImageSize200x200];
    }
    else{
        
        self.leftImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.leftDto.productCode size:ProductImageSize120x120];
    }
    
    self.leftLabel.text = self.leftDto.productName;
    double price = [self.leftDto.productPrice doubleValue];
    if (price <= 0) {
        if (self.leftDto.priceImageURL) {
            self.leftHintLabel.hidden = NO;
            self.leftPriceImageView.hidden = NO;
            self.leftPriceImageView.imageURL = self.leftDto.priceImageURL;
        }
        else {
            self.leftHintLabel.hidden = YES;
            self.leftPriceImageView.hidden = YES;
            self.leftPriceLabel.text = L(@"saleOut");
        }

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
        //        self.centerImageView.imageURL = [NSURL URLWithString: self.centerDto.productImageURL];
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.centerImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.centerDto.productCode size:ProductImageSize200x200];
        }
        else{
            
            self.centerImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.centerDto.productCode size:ProductImageSize120x120];
        }
        self.centerLabel.text = self.centerDto.productName;
        
        price = [self.centerDto.productPrice doubleValue];
        if (price <= 0) {
            if (self.centerDto.priceImageURL) {
                self.centerHintLabel.hidden = NO;
                self.centerPriceImageView.hidden = NO;
                self.centerPriceImageView.imageURL = self.centerDto.priceImageURL;
            }
            else {
                self.centerHintLabel.hidden = YES;
                self.centerPriceImageView.hidden = YES;
                self.centerPriceLabel.text = L(@"saleOut");
            }

        }else{
            NSString *centerPrice = [NSString stringWithFormat:@"￥%.2f",
                                     [self.centerDto.productPrice doubleValue]];
            
            self.centerPriceLabel.text = centerPrice;
        }
        
    }
    
    self.rightDto = aRightDto;
    
    //    [self.salesRightSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_small_%d.png",[self.rightDto.promIcon intValue]]]];
    if (aRightDto == nil) {
        
        [self.rightBackImageView removeFromSuperview];
        
    }else{
        
        [self.contentView addSubview:self.rightBackImageView];
        self.rightImageView.userInteractionEnabled = YES;
        //        self.rightImageView.imageURL = [NSURL URLWithString: self.rightDto.productImageURL];
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.rightImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.rightDto.productCode size:ProductImageSize200x200];
        }
        else{
            
            self.rightImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.rightDto.productCode size:ProductImageSize120x120];
        }
        self.rightLabel.text = self.rightDto.productName;
        
        price = [self.rightDto.productPrice doubleValue];
        if (price <= 0) {
            if (self.rightDto.priceImageURL) {
                self.rightHintLabel.hidden = NO;
                self.rightPriceImageView.hidden = NO;
                self.rightPriceImageView.imageURL = self.rightDto.priceImageURL;
            }
            else {
                self.rightHintLabel.hidden = YES;
                self.rightPriceImageView.hidden = YES;
                self.rightPriceLabel.text = L(@"saleOut");
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
    
    if (self.centerPriceImageView.hidden == NO) {
        self.centerPriceImageView.imageURL = [ProductUtil minPriceImageOfProductId:self.centerDto.productId productCode:self.centerDto.productCode city:[Config currentConfig].defaultCity shopCode:self.centerDto.vendorCode];
    }
}


- (void)leftDto:(SNActivityProductDTO*)leftDto centerItem:(SNActivityProductDTO*)centerDto rightItem:(SNActivityProductDTO*)rightDto withTag:(NSInteger)index
{
    self.leftActivityProductDto = leftDto;
    self.leftImageView.userInteractionEnabled = YES;
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        self.leftImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.leftActivityProductDto.partNumber
                                                                         size:ProductImageSize200x200];
    }
    else{
        
        self.leftImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.leftActivityProductDto.partNumber
                                                                         size:ProductImageSize120x120];
    }

    self.leftLabel.text = self.leftActivityProductDto.productName;
    double price = [self.leftActivityProductDto.productPrice doubleValue];
    if (price <= 0) {
        self.leftPriceLabel.text = L(@"saleOut");
    }else{
        NSString *leftPrice = [NSString stringWithFormat:@"￥%.2f",price];
        self.leftPriceLabel.text = leftPrice;
    }
    
    self.centerActivityProductDto = centerDto;
    
    
    if (centerDto == nil) {
        
        [self.centerBackImageView removeFromSuperview];
        
    }else{
        [self.contentView addSubview:self.centerBackImageView];
        self.centerImageView.userInteractionEnabled = YES;
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.centerImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.centerActivityProductDto.partNumber
                                                                             size:ProductImageSize200x200];
        }
        else{
            
            self.centerImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.centerActivityProductDto.partNumber
                                                                             size:ProductImageSize120x120];
        }
        self.centerLabel.text = self.centerActivityProductDto.productName;
        
        price = [self.centerActivityProductDto.productPrice doubleValue];
        if (price <= 0) {
            self.centerPriceLabel.text = L(@"saleOut");
        }else{
            NSString *centerPrice = [NSString stringWithFormat:@"￥%.2f",
                                     [self.centerActivityProductDto.productPrice doubleValue]];
            
            self.centerPriceLabel.text = centerPrice;
        }
        
    }
    
    self.rightActivityProductDto = rightDto;
   // [self.salesRightSmallImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"sales_small_%d.png",[self.rightDto.promIcon intValue]]]];
    
    
    if (rightDto == nil) {
        
        [self.rightBackImageView removeFromSuperview];
        
    }else{
        
        [self.contentView addSubview:self.rightBackImageView];
        self.rightImageView.userInteractionEnabled = YES;
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            self.rightImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.rightActivityProductDto.partNumber
                                                                               size:ProductImageSize200x200];
        }
        else{
            
            self.rightImageView.imageURL = [ProductUtil getImageUrlWithProductCode:self.rightActivityProductDto.partNumber
                                                                               size:ProductImageSize120x120];
        }
        self.rightLabel.text = self.rightActivityProductDto.productName;
        
        price = [self.rightActivityProductDto.productPrice doubleValue];
        if (price <= 0) {
            self.rightPriceLabel.text = L(@"saleOut");
        }else{
            NSString *rightPrice = [NSString stringWithFormat:@"￥%.2f",
                                    [self.rightActivityProductDto.productPrice doubleValue]];
            
            self.rightPriceLabel.text = rightPrice;
        }
        
        
    }
    
    [self setNeedsLayout];
}

- (void)layoutSubviews{
	
    [super layoutSubviews];
    
//    self.leftBackImageViewLbl.frame = CGRectMake(0, self.leftImageView.bottom, ViewWidth ,ViewHeight - ImageViewHeight);
//    self.centerBackImageViewLbl.frame = CGRectMake(0, self.centerImageView.bottom, ViewWidth ,ViewHeight - ImageViewHeight);
//    self.rightBackImageViewLbl.frame = CGRectMake(0, self.rightImageView.bottom, ViewWidth ,ViewHeight - ImageViewHeight);
    
    self.leftLabel.frame = CGRectMake(5, self.leftImageView.bottom + 16, ViewWidth - 10 ,14);
    self.leftPriceLabel.frame = CGRectMake(5, self.leftLabel.bottom + 5, ViewWidth - 10 ,12);
    self.leftHintLabel.frame = CGRectMake(5, self.leftLabel.bottom + 5, 15 ,12);
    self.leftPriceImageView.frame = CGRectMake(self.leftHintLabel.right+2, self.leftLabel.bottom + 5, 60, 8);
    
    self.centerLabel.frame = CGRectMake(5, self.centerImageView.bottom + 16, ViewWidth - 10 ,14);
    self.centerPriceLabel.frame = CGRectMake(5, self.centerLabel.bottom + 5, ViewWidth - 10 ,12);
    self.centerHintLabel.frame = CGRectMake(5, self.centerLabel.bottom + 5, 15 , 12);
    self.centerPriceImageView.frame = CGRectMake(self.centerHintLabel.right+2, self.centerLabel.bottom + 5, 60, 8);
    
    self.rightLabel.frame = CGRectMake(5, self.rightImageView.bottom + 16, ViewWidth - 10 ,14);
    self.rightPriceLabel.frame = CGRectMake(5, self.rightLabel.bottom + 5, ViewWidth - 10 ,12);
    self.rightHintLabel.frame = CGRectMake(5, self.rightLabel.bottom + 5, 15, 12);
    self.rightPriceImageView.frame = CGRectMake(self.rightHintLabel.right+2, self.rightLabel.bottom + 5, 60, 8);
    
    self.leftSegmentLine.frame = CGRectMake(5, 88, lineWidth, lineHeight);
    self.centerSegmentLine.frame = CGRectMake(5, 88, lineWidth, lineHeight);
    self.rightSegmentLine.frame = CGRectMake(5, 88, lineWidth, lineHeight);
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    NSInteger viewTag = imageViewEx.tag;
    
    DataProductBasic *productDto = nil;
    
    if (!IsStrEmpty(self.leftDto.productId)) {
        if (viewTag == 0)
        {
            productDto = self.leftDto.transformToProductDTO;
        }
        else if (viewTag == 1)
        {
            productDto = self.centerDto.transformToProductDTO;
        }
        else if(viewTag == 2)
        {
            productDto = self.rightDto.transformToProductDTO;
        }
    }else{
        if (viewTag == 0)
        {
            productDto = self.leftActivityProductDto.transformToProductDTO;
        }
        else if (viewTag == 1)
        {
            productDto = self.centerActivityProductDto.transformToProductDTO;
        }
        else if(viewTag == 2)
        {
            productDto = self.rightActivityProductDto.transformToProductDTO;
        }
    }
    
    if ([self.imageDidDelegate conformsToProtocol:@protocol(Model3Delegate)])
    {
        if ([self.imageDidDelegate respondsToSelector:@selector(cellImageDidClicked:)])
        {
            [self.imageDidDelegate cellImageDidClicked:productDto];
        }
    }
    
    TT_RELEASE_SAFELY(productDto);
    
}

@end
