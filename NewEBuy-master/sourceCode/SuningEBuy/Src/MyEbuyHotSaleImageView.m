//
//  MyEbuyHotSaleImageView.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "MyEbuyHotSaleImageView.h"
#import "InnerProductDTO.h"
#import "DataProductBasic.h"
#import "ProductUtil.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>
@interface MyEbuyHotSaleImageView()

@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) EGOImageViewEx *imageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) NewInnerProductDTO *dataSource;

@end

/*********************************************************************/

@implementation MyEbuyHotSaleImageView

@synthesize backView = _backView;
@synthesize imageView = _imageView;
@synthesize nameLabel = _nameLabel;
@synthesize priceLabel = _priceLabel;

@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_backView);
    TT_RELEASE_SAFELY(_imageView);
    TT_RELEASE_SAFELY(_nameLabel);
    TT_RELEASE_SAFELY(_priceLabel);
    
    TT_RELEASE_SAFELY(_dataSource);
}



- (id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 82, 161);
    }
    return self;
}


- (void)setItem:(NewInnerProductDTO *)dto
{
    if (dto == nil) {
        return;
    }
    
    @autoreleasepool {
        self.dataSource = dto;
        
        
        NSURL *url = nil;//[ProductUtil imageUrl_ls1_ForProduct:self.dataSource.productCode];
        
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            
            url = [ProductUtil getImageUrlWithProductCode:self.dataSource.sugGoodsCode size:ProductImageSize200x200];
        }
        else{
            
            url = [ProductUtil getImageUrlWithProductCode:self.dataSource.sugGoodsCode size:ProductImageSize120x120];
        }
        
        self.imageView.imageURL = url;
        self.nameLabel.text = dto.sugGoodsName;
        NSString *priceStr = dto.price;
    
        double priceNum = [priceStr doubleValue];
        if (priceNum > 0)
            priceStr = [NSString stringWithFormat:@"¥ %0.2f",priceNum];
        else
            priceStr = L(@"saleOut");
        
        self.priceLabel.text = priceStr;
    }
}



#pragma mark -
#pragma mark views

- (UIView *)backView
{
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.frame = CGRectMake(0, 0, 85, 85);
//        [_backView.layer setShadowOffset:CGSizeMake(0.5, 0.5)];
//        [_backView.layer setShadowRadius:1.0];
        _backView.layer.backgroundColor = [UIColor clearColor].CGColor;
        _backView.layer.cornerRadius = 0;
        _backView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        _backView.layer.borderWidth = 0.5;
//        [_backView.layer setShadowColor:[UIColor blackColor].CGColor];
//        [_backView.layer setShadowOpacity:0.8];
    }
    return _backView;
}

- (EGOImageViewEx *)imageView
{
    if (!_imageView) {
        _imageView = [[EGOImageViewEx alloc] initWithFrame:CGRectMake(0, 0, 85, 85)];
        _imageView.userInteractionEnabled = YES;
        _imageView.exDelegate = self;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.backgroundColor = [UIColor whiteColor].CGColor;
//        _imageView.layer.borderWidth = 0;
//        [_imageView.layer setCornerRadius:8.0];
//        [_imageView.layer  setMasksToBounds:YES];
        _imageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        [self addSubview:self.backView];
        [self.backView addSubview:_imageView];
    }
    return _imageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,92,82, 27)];
        _nameLabel.backgroundColor =  [UIColor clearColor];
        _nameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        _nameLabel.font = [UIFont systemFontOfSize:12.0];
        _nameLabel.numberOfLines = 2;
        _nameLabel.textAlignment = UITextAlignmentCenter;
        [self addSubview:_nameLabel];
    }
    return _nameLabel;
}

- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 121, 82, 12)];
        _priceLabel.backgroundColor = [UIColor clearColor];
        _priceLabel.textAlignment = UITextAlignmentCenter;
        _priceLabel.textColor = [UIColor colorWithRGBHex:0xff4800];
        _priceLabel.font = [UIFont systemFontOfSize:12.0];
        [self addSubview:_priceLabel];
    }
    return _priceLabel;
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"81010%d",self.indexArray+1], nil]];
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectHotSaleProduct:)]) {
        DataProductBasic *product = [self.dataSource transformToProductDTO];
        
        [_delegate didSelectHotSaleProduct:product];
    }
}

@end
