//
//  HotSaleProductScrollView.m
//  SuningEBuy
//
//  Created by robin wang on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "HotSaleProductScrollView.h"
#import "ProductUtil.h"

#define ProductImageWidth    66
#define ProductImageHeight   66
#define ProductImageSpace    9

#define ScrollSubViewOffset  100

@interface HotSaleProductScrollView ()

@property (nonatomic, strong) UIScrollView *hotSaleScrollView;

- (void)loadProductImageList;

@end

@implementation HotSaleProductScrollView

@synthesize hotSaleScrollView = _hotSaleScrollView;
@synthesize hotSaleProductList = _hotSaleProductList;
@synthesize delegate = _delegate;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_hotSaleScrollView);
    TT_RELEASE_SAFELY(_hotSaleProductList);
    
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.image = [UIImage imageNamed:@"hotSaleSmallImgBg.png"];
        
        self.userInteractionEnabled = YES;
    }
    
    return self;
}

- (void)setHotSaleProductList:(NSArray *)hotSaleProductList
{
    if (hotSaleProductList != _hotSaleProductList) 
    {
        
        _hotSaleProductList = hotSaleProductList;
        
        if (_hotSaleProductList && [_hotSaleProductList count] > 0) 
        {
                    
            [self loadProductImageList];
            
        }
        
        
    }
}

- (void)loadProductImageList
{
    
    [self.hotSaleScrollView removeAllSubviews];
    
    NSInteger count = [_hotSaleProductList count];
    
    self.hotSaleScrollView.contentOffset = CGPointMake(149, 0);
    
    self.hotSaleScrollView.contentSize = CGSizeMake((ProductImageWidth + ProductImageSpace) * count - ProductImageSpace + (self.width - ProductImageWidth), ProductImageHeight);

    
    //CGRect frame = CGRectZero;
    HomeTopRecommendDTO *productDto = nil;
    
    for (int i = 0; i < count; i++)
    {
        
        productDto = [self.hotSaleProductList objectAtIndex:i];
        
        CGRect frame = CGRectMake(5 + (self.width - ProductImageWidth) / 2 + (ProductImageWidth + ProductImageSpace) * i, 0, ProductImageWidth, ProductImageHeight);
        
        EGOImageView *productImageView = [[EGOImageView alloc] initWithFrame:frame];
        productImageView.backgroundColor = [UIColor clearColor];
        productImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        productImageView.layer.borderWidth = 0;
        productImageView.layer.cornerRadius = 8.0;
        productImageView.layer.masksToBounds = YES;
        productImageView.layer.shadowRadius = 5;
        productImageView.layer.shadowOffset = CGSizeMake(-0.25, 0.2);
        productImageView.layer.shadowColor = [UIColor blackColor].CGColor;
        productImageView.layer.shadowOpacity = 0.6;
        
        productImageView.tag = ScrollSubViewOffset + i;
        productImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:productDto.productCode size:ProductImageSize200x200];
        
        [self.hotSaleScrollView addSubview:productImageView];
        TT_RELEASE_SAFELY(productImageView);
        
        //frame = CGRectZero;
        productDto = nil;
        
    }
}


- (UIScrollView *)hotSaleScrollView
{
    if (!_hotSaleScrollView) 
    {
        
        CGRect frame = CGRectMake(0, 9, 320, ProductImageHeight);
        
        _hotSaleScrollView = [[UIScrollView alloc] initWithFrame:frame];
        
        _hotSaleScrollView.backgroundColor = [UIColor clearColor];
        
        _hotSaleScrollView.showsHorizontalScrollIndicator = NO;
        
        _hotSaleScrollView.delegate = self;
        
        [self addSubview:_hotSaleScrollView];
    }
    
    return _hotSaleScrollView;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (!decelerate) 
    {
        [self correctImageOffsetWithScrollCenter];
    }
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    [self correctImageOffsetWithScrollCenter];
}

- (void)correctImageOffsetWithScrollCenter;
{
    NSArray *imageViewList = [self.hotSaleScrollView subviews];
    
    NSInteger count = [imageViewList count];
    
    CGFloat imageCenterSpace = 0.0f;
    CGFloat minSpace = self.hotSaleScrollView.contentSize.width;
    NSUInteger minSpaceIndex = 0;
    
    for (int i = 0; i < count; i++) 
    {
        
        CGFloat relativeSpace = 0.0;
        
        EGOImageView *subImageView = (EGOImageView *)[self.hotSaleScrollView viewWithTag:ScrollSubViewOffset + i];
        
        relativeSpace = 160 - (subImageView.centerX - self.hotSaleScrollView.contentOffset.x);
        
        if (fabs(relativeSpace) < minSpace)
        {
            
            imageCenterSpace = relativeSpace;
            
            minSpace = fabs(imageCenterSpace);
            
            minSpaceIndex = i;
        }
        
        if (minSpace == 0)
        {
            break;
        }
    }
    
    self.hotSaleScrollView.contentOffset = CGPointMake(self.hotSaleScrollView.contentOffset.x - imageCenterSpace - 5, 0);
    
    if ([self.delegate respondsToSelector:@selector(hotSaleScrollView:didSelectedProduct:)]) 
    {
        if (minSpaceIndex >= [self.hotSaleProductList count]) {
            return;
        }
        [self.delegate hotSaleScrollView:self didSelectedProduct:[self.hotSaleProductList objectAtIndex:minSpaceIndex]];
    }
}

@end
