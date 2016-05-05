//
//  HotSalePreviewDesView.m
//  SuningEBuy
//
//  Created by robin wang on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataProductBasic.h"
#import "HotSalePreviewDesView.h"
#import "ProductUtil.h"

@interface HotSalePreviewDesView ()

@property (nonatomic, strong) EGOImageViewEx *previewImageView;

@property (nonatomic, strong) UILabel         *hotSaleProductNameLbl;

@property (nonatomic, strong) UILabel         *hotSaleEbuyPriceLbl;

@property (nonatomic, strong) UILabel         *hotSaleProductPriceLbl;


@end

@implementation HotSalePreviewDesView

@synthesize previewImageView = _previewImageView;
@synthesize hotSaleProductNameLbl = _hotSaleProductNameLbl;
@synthesize hotSaleEbuyPriceLbl = _hotSaleEbuyPriceLbl;
@synthesize hotSaleProductPriceLbl = _hotSaleProductPriceLbl;

@synthesize hotSaleItem = _hotSaleItem;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_previewImageView);
    TT_RELEASE_SAFELY(_hotSaleProductNameLbl);
    TT_RELEASE_SAFELY(_hotSaleEbuyPriceLbl);
    TT_RELEASE_SAFELY(_hotSaleProductPriceLbl);
    
    TT_RELEASE_SAFELY(_hotSaleItem);
    
}

- (id)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) 
    {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)setHotSaleItem:(HomeTopRecommendDTO *)hotSaleItem
{
    if (hotSaleItem != _hotSaleItem) 
    {
        
        _hotSaleItem = hotSaleItem;
        
        if ([SystemInfo is_iPhone_5]) {
            self.previewImageView.center = self.center;
        }
        self.previewImageView.imageURL = [ProductUtil getImageUrlWithProductCode:_hotSaleItem.productCode size:ProductImageSize200x200];
        
        self.hotSaleProductNameLbl.text = _hotSaleItem.productName;
        self.hotSaleEbuyPriceLbl.text = L(@"eBuy price");

        if (!_hotSaleItem.productPrice || [_hotSaleItem.productPrice isEmptyOrWhitespace]) 
        {
            self.hotSaleProductPriceLbl.text = L(@"saleOut");
        }
        else
        {
            
            double priceNum = [_hotSaleItem.productPrice doubleValue];
            
            if (priceNum > 0) {
                self.hotSaleProductPriceLbl.text = [NSString stringWithFormat:@"￥ %.2f", priceNum];
            }else{
                self.hotSaleProductPriceLbl.text = L(@"saleOut");
            }
        }
        
    }
    
}

- (EGOImageViewEx *)previewImageView
{
    if (!_previewImageView)
    {
        CGRect frame;
        if ([SystemInfo is_iPhone_5]) {
            frame = CGRectMake(20, 10, 280, 280);
        }else{
            frame = CGRectMake(45, 10, 229, 229);
        }
        
        _previewImageView = [[EGOImageViewEx alloc] initWithFrame:frame];
        
        _previewImageView.backgroundColor = [UIColor clearColor];
        
        _previewImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _previewImageView.layer.borderWidth = 0;
        _previewImageView.layer.cornerRadius = 8.0;
        _previewImageView.layer.masksToBounds = YES;
        _previewImageView.layer.shadowRadius = 1.0;
        _previewImageView.layer.shadowOffset = CGSizeMake(0.5, 0.5);
        _previewImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        _previewImageView.layer.shadowOpacity = 0.8;
        
        _previewImageView.exDelegate = self;
        
        _previewImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        _previewImageView.userInteractionEnabled = YES;
        
        [self addSubview:_previewImageView];
    }
    
    return _previewImageView;
}

- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{

    DataProductBasic *hotSaleProduct = [[DataProductBasic alloc] init];
    
    hotSaleProduct.productId = self.hotSaleItem.productId;
    hotSaleProduct.productCode = self.hotSaleItem.productCode;
    hotSaleProduct.productName = self.hotSaleItem.productName;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:HOTSALE_TO_PRODUCTDETAIL_NOTIFICATION object:hotSaleProduct];
    
    TT_RELEASE_SAFELY(hotSaleProduct);
}

- (UILabel *)hotSaleProductNameLbl
{
    if (!_hotSaleProductNameLbl) 
    {
        UIFont *font = [UIFont systemFontOfSize:12];

        CGRect frame = CGRectMake(0, self.previewImageView.bottom + 7, 320, font.lineHeight);
        
        _hotSaleProductNameLbl = [[UILabel alloc] initWithFrame:frame];
        
        _hotSaleProductNameLbl.backgroundColor = [UIColor clearColor];
        
        _hotSaleProductNameLbl.textColor = [UIColor blackColor];
        
        _hotSaleProductNameLbl.textAlignment = UITextAlignmentCenter;
        
        _hotSaleProductNameLbl.numberOfLines = 1;
        
        _hotSaleProductNameLbl.lineBreakMode = UILineBreakModeTailTruncation;
        
        _hotSaleProductNameLbl.font = font;
        
        [self addSubview:_hotSaleProductNameLbl];
    }
    
    return _hotSaleProductNameLbl;
}

- (UILabel *)hotSaleEbuyPriceLbl
{
    if (!_hotSaleEbuyPriceLbl) 
    {
        UIFont *font = [UIFont systemFontOfSize:15];
        
        CGRect frame = CGRectMake(0, self.hotSaleProductNameLbl.bottom, 160, font.lineHeight);
        
        _hotSaleEbuyPriceLbl = [[UILabel alloc] initWithFrame:frame];
        
        _hotSaleEbuyPriceLbl.backgroundColor = [UIColor clearColor];
        
        _hotSaleEbuyPriceLbl.textColor = [UIColor blackColor];
        
        _hotSaleEbuyPriceLbl.textAlignment = UITextAlignmentRight;
        
        _hotSaleEbuyPriceLbl.font = font;
        
        [self addSubview:_hotSaleEbuyPriceLbl];
    }
    
    return _hotSaleEbuyPriceLbl;
}

- (UILabel *)hotSaleProductPriceLbl
{
    if (!_hotSaleProductPriceLbl) 
    {
        UIFont *font = [UIFont systemFontOfSize:15];
        
        CGRect frame = CGRectMake(self.hotSaleEbuyPriceLbl.right, self.hotSaleProductNameLbl.bottom, 160, font.lineHeight);
        
        _hotSaleProductPriceLbl = [[UILabel alloc] initWithFrame:frame];
        
        _hotSaleProductPriceLbl.backgroundColor = [UIColor clearColor];
        
        _hotSaleProductPriceLbl.textColor = RGBCOLOR(204, 0, 0);
        
        _hotSaleProductPriceLbl.textAlignment = UITextAlignmentLeft;
        
        _hotSaleProductPriceLbl.font = font;
        
        [self addSubview:_hotSaleProductPriceLbl];
    }
    
    return _hotSaleProductPriceLbl;
}

@end
