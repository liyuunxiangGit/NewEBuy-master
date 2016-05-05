//
//  BigViewModelCellSubView.m
//  SuningEBuy
//
//  Created by chupeng on 14-8-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BigViewModelCellSubView.h"
#import "ProductUtil.h"
@implementation BigViewModelCellSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)setItem:(DataProductBasic *)item
{
    if (!item)
        return;
    self.dto = item;
    
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize400x400];
    }
    else{
        self.productImageView.imageURL = [ProductUtil getImageUrlWithProductCode:item.productCode size:ProductImageSize400x400];
    }
    
    [self priceLabel];
    self.productNameLabel.text = item.productName;
        //促销标签
    NSString *sscxkg = [SNSwitch getSearchPromotionValue];
    if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"2"])
    {
        [self refreshWithsscxkgOf2:item];
    }
    else if (NotNilAndNull(sscxkg) && [sscxkg isEqualToString:@"1"])
    {
        [self refreshWithsscxkgOf1:item];
    }
    else if ([sscxkg isEqualToString:@"0"] || IsNilOrNull(sscxkg))
    {
        self.priceImageView.hidden = NO;
        self.priceOfPromotionLabel.hidden = YES;
        
        self.qiangImgView.hidden = YES;
        self.tuanImgView.hidden = YES;
        self.quanImgView.hidden = YES;
        self.jiangImgView.hidden = YES;
    }
    
    //234大图模式暂时不上促销标签
    self.qiangImgView.hidden = YES;
    self.tuanImgView.hidden = YES;
    self.quanImgView.hidden = YES;
    self.jiangImgView.hidden = YES;
}


- (void)refreshWithsscxkgOf2:(DataProductBasic *)item
{
    self.priceImageView.hidden = YES;
    
    self.priceOfPromotionLabel.hidden = NO;
    self.priceLabel.textColor = RGBCOLOR(250, 86, 0);
    
    //促销价为0说明发生了错误，换为原来的价格图片
    if ([item.minPriceOfPromotion floatValue] == 0)
    {
        self.priceImageView.hidden = NO;
        self.priceOfPromotionLabel.hidden = YES;
        self.priceLabel.textColor = [UIColor colorWithRGBHex:0xDD0000];
    }
    self.priceOfPromotionLabel.text = item.minPriceOfPromotion;
    
    if (item.iSdaJuHui)
    {
        self.qiangImgView.hidden = YES;
        self.tuanImgView.hidden = YES;
        self.quanImgView.hidden = YES;
        self.jiangImgView.hidden = YES;
        self.dajuhuiImgView.hidden = NO;
    }
    else if (item.flagOfPromotionImgView > 0)
    {
        self.dajuhuiImgView.hidden = YES;
        
        BOOL bQiang = !(item.flagOfPromotionImgView & Qiang);
        self.qiangImgView.hidden = bQiang;
        
        BOOL bTuan = !(item.flagOfPromotionImgView & Tuan);
        self.tuanImgView.hidden = bTuan;
        
        BOOL bQuan = !(item.flagOfPromotionImgView & Quan);
        self.quanImgView.hidden = bQuan;
        
        BOOL bJiang = !(item.flagOfPromotionImgView & Jiang);
        self.jiangImgView.hidden = bJiang;
        
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:4];
        if (!bQiang)
        {
            [arr1 addObject:self.qiangImgView];
        }
        
        if (!bTuan)
        {
            [arr1 addObject:self.tuanImgView];
        }
        
        if (!bQuan)
        {
            [arr1 addObject:self.quanImgView];
        }
        
        if (!bJiang)
        {
            [arr1 addObject:self.jiangImgView];
        }
        
        NSArray *arr2 = [arr1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            UIView *v1 = (UIView *)obj1;
            UIView *v2 = (UIView *)obj2;
            
            if (v1.tag > v2.tag)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }];
        
        int x = 283;
        for (UIImageView *v in arr2) {
            v.frame = CGRectMake(x, 63, 20, 20);
            x -= 30;
            
            if (x < 193)
                break;
        }
    }
    else if (item.flagOfPromotionImgView == 0)
    {
        self.qiangImgView.hidden = YES;
        self.tuanImgView.hidden = YES;
        self.quanImgView.hidden = YES;
        self.jiangImgView.hidden = YES;
        self.dajuhuiImgView.hidden = YES;
    }
}


- (void)refreshWithsscxkgOf1:(DataProductBasic *)item
{
    self.priceImageView.hidden = YES;
    self.priceOfPromotionLabel.hidden = NO;
    self.priceLabel.textColor = RGBCOLOR(250, 86, 0);
    
    //促销价为0说明发生了错误，换为原来的价格图片
    if ([item.minPriceOfPromotion floatValue] == 0)
    {
        self.priceImageView.hidden = NO;
        self.priceOfPromotionLabel.hidden = YES;
        self.priceLabel.textColor = [UIColor colorWithRGBHex:0xDD0000];
    }
    self.priceOfPromotionLabel.text = item.minPriceOfPromotion;
    
    if (item.flagOfPromotionImgView > 0)
    {
        BOOL bQiang = !(item.flagOfPromotionImgView & Qiang);
        self.qiangImgView.hidden = bQiang;
        
        BOOL bTuan = !(item.flagOfPromotionImgView & Tuan);
        self.tuanImgView.hidden = bTuan;
        
        BOOL bQuan = !(item.flagOfPromotionImgView & Quan);
        self.quanImgView.hidden = bQuan;
        
        BOOL bJiang = !(item.flagOfPromotionImgView & Jiang);
        self.jiangImgView.hidden = bJiang;
        
        NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:4];
        if (!bQiang)
        {
            [arr1 addObject:self.qiangImgView];
        }
        
        if (!bTuan)
        {
            [arr1 addObject:self.tuanImgView];
        }
        
        if (!bQuan)
        {
            [arr1 addObject:self.quanImgView];
        }
        
        if (!bJiang)
        {
            [arr1 addObject:self.jiangImgView];
        }
        
        NSArray *arr2 = [arr1 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            UIView *v1 = (UIView *)obj1;
            UIView *v2 = (UIView *)obj2;
            
            if (v1.tag > v2.tag)
                return NSOrderedAscending;
            else
                return NSOrderedDescending;
        }];
        
        int x = 283;
        for (UIImageView *v in arr2) {
            v.frame = CGRectMake(x, 63, 20, 20);
            x -= 30;
            
            if (x < 193)
                break;
        }
    }
    else
    {
        self.qiangImgView.hidden = YES;
        self.tuanImgView.hidden = YES;
        self.quanImgView.hidden = YES;
        self.jiangImgView.hidden = YES;
    }
}

#pragma mark - 控件

- (EGOImageView *)productImageView
{
    if (!_productImageView) {
		
        CGRect productFrame =  CGRectMake(0, 15, 145, 145);
		_productImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(0, 0, 145, 145)];
        
		_productImageView.backgroundColor =[UIColor whiteColor];
        
        _productImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        _productImageView.placeholderImage = [UIImage imageNamed:kProductImageViewDefultImage];
        
        UIView *suppImageView = [[UIView alloc] initWithFrame:productFrame];
        suppImageView.backgroundColor = [UIColor clearColor];
        suppImageView.layer.borderWidth = 0.5;
        suppImageView.layer.borderColor = [UIColor colorWithRGBHex:0xdcdcdc].CGColor;
        
        [self addSubview: suppImageView];
        
        [suppImageView addSubview:_productImageView];
        
//        TT_RELEASE_SAFELY(suppImageView);
	}
	
	return _productImageView;
}


- (UILabel *)productNameLabel
{
    if (!_productNameLabel) {
		_productNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(2, 168, 135, 40)];
		_productNameLabel.backgroundColor = [UIColor clearColor];
		_productNameLabel.font = [UIFont systemFontOfSize:15.0];
		_productNameLabel.autoresizingMask = UIViewAutoresizingNone;
        _productNameLabel.textColor = [UIColor colorWithRGBHex:0x313131];
        _productNameLabel.numberOfLines = 2;
        _productNameLabel.textAlignment = NSTextAlignmentLeft;
		[self addSubview:_productNameLabel];
	}
	return _productNameLabel;
}


- (EGOImageView *)priceImageView
{
    if (!_priceImageView)
    {
		_priceImageView = [[EGOImageView alloc] initWithFrame:CGRectMake(15, 216, 100, 12)];
		_priceImageView.backgroundColor = [UIColor clearColor];
        _priceImageView.contentMode = UIViewContentModeLeft;
        _priceImageView.placeholderImage = nil;
        _priceImageView.refreshCached = YES;
		[self addSubview:_priceImageView];
	}
	return _priceImageView;
}


- (UILabel *)priceOfPromotionLabel
{
    if (!_priceOfPromotionLabel)
    {
        _priceOfPromotionLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 216, 100, 12)];
        _priceOfPromotionLabel.backgroundColor = [UIColor clearColor];
        _priceOfPromotionLabel.textAlignment = NSTextAlignmentLeft;
        _priceOfPromotionLabel.textColor = RGBCOLOR(250, 86, 0);
        _priceOfPromotionLabel.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:_priceOfPromotionLabel];
    }
    
    return _priceOfPromotionLabel;
}


- (UILabel *)priceLabel
{
    if (!_priceLabel) {
		
		UIFont *font = [UIFont systemFontOfSize:16];
		
		_priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 217, 12, 14)];
		
		_priceLabel.backgroundColor = [UIColor clearColor];
		_priceLabel.textColor = [UIColor colorWithRGBHex:0xDD0000];
		_priceLabel.font = font;
        //        priceLabel_.shadowColor = [UIColor grayColor];
        //		priceLabel_.shadowOffset =CGSizeMake(0.6,0.6);
		_priceLabel.autoresizingMask = UIViewAutoresizingNone;
		_priceLabel.text = @"￥";
		[self addSubview:_priceLabel];
	}
    
	return _priceLabel;
}

#pragma mark - 促销标签
- (UIImageView *)qiangImgView
{
    if (!_qiangImgView)
    {
        _qiangImgView = [[UIImageView alloc] initWithFrame:CGRectMake(193, 63, 20, 20)];
        _qiangImgView.image = [UIImage imageNamed:@"Search_Qiang.png"];
        _qiangImgView.hidden = YES;
        _qiangImgView.tag = 1000;
        [self addSubview:_qiangImgView];
    }
    
    return _qiangImgView;
}

- (UIImageView *)tuanImgView
{
    if (!_tuanImgView)
    {
        _tuanImgView = [[UIImageView alloc] initWithFrame:CGRectMake(223, 63, 20, 20)];
        _tuanImgView.image = [UIImage imageNamed:@"Search_Tuan.png"];
        _tuanImgView.hidden = YES;
        _tuanImgView.tag = 1001;
        [self addSubview:_tuanImgView];
    }
    return _tuanImgView;
}

- (UIImageView *)quanImgView
{
    if (!_quanImgView)
    {
        _quanImgView = [[UIImageView alloc] initWithFrame:CGRectMake(253, 63, 20, 20)];
        _quanImgView.image = [UIImage imageNamed:@"Search_Quan.png"];
        _quanImgView.hidden = YES;
        _quanImgView.tag = 1002;
        [self addSubview:_quanImgView];
    }
    return _quanImgView;
}

- (UIImageView *)jiangImgView
{
    if (!_jiangImgView)
    {
        _jiangImgView = [[UIImageView alloc] initWithFrame:CGRectMake(283, 63, 20, 20)];
        _jiangImgView.image = [UIImage imageNamed:@"Search_Jiang.png"];
        _jiangImgView.hidden = YES;
        _jiangImgView.tag = 1003;
        [self addSubview:_jiangImgView];
    }
    return _jiangImgView;
}

- (UIImageView *)dajuhuiImgView
{
    if (!_dajuhuiImgView)
    {
        _dajuhuiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(283, 63, 20, 20)];
        _dajuhuiImgView.image = [UIImage imageNamed:@"search_bigparty.png"];
        _dajuhuiImgView.hidden = YES;
        _dajuhuiImgView.tag = 1004;
        
        [self addSubview:_dajuhuiImgView];
    }
    
    return _dajuhuiImgView;
}


@end
