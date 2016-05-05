//
//  TopRecommentCell.m
//  SuningEBuy
//
//  Created by cw on 12-4-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TopRecommentCell.h"
#import "ProductUtil.h"

@interface TopRecommentCell ()



@end

@implementation TopRecommentCell

@synthesize leftProductNameLbl = _leftProductNameLbl;
@synthesize leftPriceLbl = _leftPriceLbl;
@synthesize rightProductNameLbl = _rightProductNameLbl;
@synthesize rightPriceLbl = _rightPriceLbl;
@synthesize leftDTO = _leftDTO;
@synthesize rightDTO = _rightDTO;

@synthesize leftImage = _leftImage;
@synthesize rightImage = _rightImage;


- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    
    if (self = [super initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:reuseIdentifier]) {
		
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.autoresizesSubviews = YES;
		
		self.contentView.backgroundColor = [UIColor clearColor];
        
        self.userInteractionEnabled = YES;
		
	}
	return self;
}

- (void)dealloc{
    
    TT_RELEASE_SAFELY(_leftProductNameLbl);
    TT_RELEASE_SAFELY(_leftPriceLbl);
    TT_RELEASE_SAFELY(_rightProductNameLbl);
    TT_RELEASE_SAFELY(_rightPriceLbl);
    TT_RELEASE_SAFELY(_leftDTO);
    TT_RELEASE_SAFELY(_rightDTO);

    TT_RELEASE_SAFELY(_leftImage);
    TT_RELEASE_SAFELY(_rightImage);
    
}

-(void) setItem:(HomeTopRecommendDTO *)leftDto rightItem:(HomeTopRecommendDTO *)rightDto{
    
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
                self.leftPriceLbl.text = [NSString stringWithFormat:@"￥ %.2f", priceNum];
            }else{
                self.leftPriceLbl.text = L(@"saleOut");
            }
        }
    }
    
    /*
     modified by Shasha at 2012-5-22
        增加了当返回的列表数量为单数的时候的展示。
     
     */
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
                    self.rightPriceLbl.text = [NSString stringWithFormat:@"￥ %.2f", priceNum];
                }else{
                    self.rightPriceLbl.text = L(@"saleOut");
                }
            }
        }
        
        
    }else{
    //如果是单数，那么把最后的一个位置置空。
        
        TT_RELEASE_SAFELY(_rightDTO);    

        [self.rightImage removeFromSuperview];
        
        [self.rightPriceLbl removeFromSuperview];
        
        [self.rightProductNameLbl removeFromSuperview];
        
    }

}

-(void)loadLeftOrRightItem:(HomeTopRecommendDTO *)dto isLeft:(BOOL)isLeft
{
//    NSURL *productURL = [ProductUtil imageUrl_ls1_ForProduct:dto.productCode];

    NSURL *productURL = nil;
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        
        productURL = [ProductUtil getImageUrlWithProductCode:dto.productCode
                                                        size:ProductImageSize400x400];
    }
    else{
        
        productURL = [ProductUtil getImageUrlWithProductCode:dto.productCode
                                                        size:ProductImageSize160x160];
    }
    
    if (isLeft) 
    {
        
        self.leftImage.imageURL = productURL;
        
    }
    else
    {
        self.rightImage.imageURL = productURL;
        
    }
    
}

- (EGOImageViewEx *)leftImage
{
    if (_leftImage == nil)
    {
        _leftImage = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(7, 10, 146, 146)];
        _leftImage.userInteractionEnabled = YES;
        _leftImage.exDelegate = self;
        _leftImage.contentMode = UIViewContentModeScaleAspectFit;
        
        _leftImage.layer.masksToBounds = NO;
        _leftImage.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        _leftImage.layer.shadowRadius = 1.0;
        _leftImage.layer.shadowColor = [UIColor blackColor].CGColor;
        _leftImage.layer.shadowOpacity = 0.8;
        
        _leftImage.layer.borderWidth = 0;
        _leftImage.layer.cornerRadius = 8.0;
        _leftImage.layer.backgroundColor = [UIColor whiteColor].CGColor;
        
        _leftImage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];

        _leftImage.tag = 0;
        
        [self.contentView addSubview:_leftImage];
    }
    
    return _leftImage;

}

-(EGOImageViewEx *)rightImage
{
    if (_rightImage == nil) 
    {
        _rightImage = [[EGOImageViewEx alloc]initWithFrame:CGRectMake(167, 10, 146, 146)];
        _rightImage.userInteractionEnabled = YES;
        _rightImage.exDelegate = self;
        
        _rightImage.contentMode = UIViewContentModeScaleAspectFit;
        
        _rightImage.layer.masksToBounds = NO;
        _rightImage.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        _rightImage.layer.shadowRadius = 1.0;
        _rightImage.layer.shadowColor = [UIColor blackColor].CGColor;
        _rightImage.layer.shadowOpacity = 0.8;
        
        _rightImage.layer.borderWidth = 0;
        _rightImage.layer.cornerRadius = 8.0;
        _rightImage.layer.backgroundColor = [UIColor whiteColor].CGColor;
        
        _rightImage.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        _rightImage.tag = 1;
        
        [self.contentView addSubview:_rightImage];
    }
    return _rightImage;
    
}


-(UILabel *)leftProductNameLbl{
    if (_leftProductNameLbl == nil) {
        _leftProductNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(7, 160, 146, 35)];
        _leftProductNameLbl.backgroundColor =  [UIColor clearColor];
        _leftProductNameLbl.textColor = [UIColor blackColor];
        _leftProductNameLbl.font = [UIFont systemFontOfSize:14.0];
        _leftProductNameLbl.numberOfLines = 2;
        _leftProductNameLbl.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:_leftProductNameLbl];
        
    }
    return _leftProductNameLbl;

}

-(UILabel *)leftPriceLbl{
    if (_leftPriceLbl == nil) {
        _leftPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(7, 195, 146, 15)];
        _leftPriceLbl.backgroundColor = [UIColor clearColor];
        _leftPriceLbl.textAlignment = UITextAlignmentCenter;
        _leftPriceLbl.textColor = [UIColor colorWithRed:204/255.0 green:0 blue:0 alpha:1.0];
        _leftPriceLbl.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_leftPriceLbl];

    }
    return _leftPriceLbl;
}

-(UILabel *)rightProductNameLbl{
    if (_rightProductNameLbl == nil) {
        _rightProductNameLbl = [[UILabel alloc]initWithFrame:CGRectMake(167, 160, 146, 35)];
        _rightProductNameLbl.backgroundColor =  [UIColor clearColor];
        _rightProductNameLbl.textColor = [UIColor blackColor];
        _rightProductNameLbl.font = [UIFont systemFontOfSize:14.0];
        _rightProductNameLbl.numberOfLines = 2;
        _rightProductNameLbl.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:_rightProductNameLbl];
        
    }
    return _rightProductNameLbl;
    
}

-(UILabel *)rightPriceLbl{
    if (_rightPriceLbl == nil) {
        _rightPriceLbl = [[UILabel alloc]initWithFrame:CGRectMake(167, 195, 146, 15)];
        _rightPriceLbl.backgroundColor = [UIColor clearColor];
        _rightPriceLbl.textAlignment = UITextAlignmentCenter;
        _rightPriceLbl.textColor = [UIColor colorWithRed:204/255.0 green:0 blue:0 alpha:1.0];
        _rightPriceLbl.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_rightPriceLbl];
        
    }
    return _rightPriceLbl;
}

-(void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    
    DLog(@"The current image is %d  here ", imageViewEx.tag);
    NSInteger index = imageViewEx.tag;
    DataProductBasic *tempDto = [[DataProductBasic alloc] init];
    if (index%2 == 0)
    {
        
        tempDto.productCode =self.leftDTO.productCode;
        tempDto.productName = self.leftDTO.productName;
        tempDto.productId = self.leftDTO.productId;
        
    }
    else
    {
        
        tempDto.productCode =self.rightDTO.productCode;
        tempDto.productName = self.rightDTO.productName;
        tempDto.productId = self.rightDTO.productId;
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION object:tempDto];
    
    TT_RELEASE_SAFELY(tempDto);
    
}




@end
