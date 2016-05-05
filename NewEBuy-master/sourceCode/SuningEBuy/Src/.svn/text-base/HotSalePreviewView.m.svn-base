//
//  HotSalePreviewView.m
//  SuningEBuy
//
//  Created by robin wang on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HotSalePreviewView.h"
#import "HotSalePreviewDesView.h"
#import "HotSaleProductScrollView.h"

@interface HotSalePreviewView ()

@property (nonatomic, strong) HotSalePreviewDesView *previewDesView;
@property (nonatomic, strong) HotSaleProductScrollView *productScrollView;

@end


@implementation HotSalePreviewView

@synthesize hotSaleProductList = _hotSaleProductList;
@synthesize previewDesView = _previewDesView;
@synthesize productScrollView = _productScrollView;

- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    TT_RELEASE_SAFELY(_hotSaleProductList);
    
    TT_RELEASE_SAFELY(_previewDesView);
    TT_RELEASE_SAFELY(_productScrollView);
    
}


- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) 
    {
        
        self.backgroundColor = [UIColor clearColor];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHotSaleDataSource:) name:HOTSALE_LOADED_NOTIFICATION object:nil];
    }
    
    return self;
}

- (void)reloadHotSaleDataSource:(NSNotification *)notification
{
    self.hotSaleProductList = [notification object];
}

- (void)setHotSaleProductList:(NSArray *)hotSaleProductList
{
    if (hotSaleProductList != _hotSaleProductList) 
    {
        
        _hotSaleProductList = hotSaleProductList;
        

        // 刷新小图
        [self reloadHotSaleList:_hotSaleProductList];
        
        NSInteger count = [_hotSaleProductList count];
        if (count > 2) {
            HomeTopRecommendDTO *defaultHotSaleDto = [_hotSaleProductList objectAtIndex:2];
            
            [self reloadPreviewView:defaultHotSaleDto];
        }
        else if (count > 0)
        {
            HomeTopRecommendDTO *defaultHotSaleDto = [_hotSaleProductList objectAtIndex:count-1];
            
            [self reloadPreviewView:defaultHotSaleDto];
        }
        
    }
    
    [self.productScrollView correctImageOffsetWithScrollCenter];
}

// 刷新小图列表
- (void)reloadHotSaleList:(NSArray *)hotSaleList
{
    self.productScrollView.hotSaleProductList = _hotSaleProductList;
    
}

// 刷新预览大图
- (void)reloadPreviewView:(HomeTopRecommendDTO *)hotSaleItem
{
    self.previewDesView.hotSaleItem = hotSaleItem;
}

#pragma mark -
#pragma mark Delegate Method
- (void)hotSaleScrollView:(HotSaleProductScrollView *)scrollView didSelectedProduct:(HomeTopRecommendDTO *)hotSaleItem
{
    [self reloadPreviewView:hotSaleItem];
}

- (HotSalePreviewDesView *)previewDesView
{
    if (!_previewDesView) 
    {
        
        CGRect frame = self.bounds;
        
        frame.size.height = frame.size.height - 84;
        
        _previewDesView = [[HotSalePreviewDesView alloc] initWithFrame:frame];
        
        [self addSubview:_previewDesView];
        
    }
    
    return _previewDesView;
}

- (HotSaleProductScrollView *)productScrollView
{
    if (!_productScrollView) 
    {
        
        CGRect frame = CGRectMake(0, self.previewDesView.bottom, 320, 84);
        
        _productScrollView = [[HotSaleProductScrollView alloc] initWithFrame:frame];
        
        _productScrollView.delegate = self;
        
        [self addSubview:_productScrollView];
        
    }
    
    return _productScrollView;
}

@end
