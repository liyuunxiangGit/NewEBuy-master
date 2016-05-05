//
//  QiangHeadCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-30.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "QiangHeadCell.h"
#import "ProductDetailViewController.h"
#import "UIView+RoundedCorners.h"
#import "ProductDetailService.h"
#import "SNGraphics.h"

@implementation QiangHeadCell

-(SNTouchView *)scrollTouch{
    
    
    if (!_scrollTouch) {
        
        _scrollTouch = [[SNTouchView alloc] init];
        _scrollTouch.frame = CGRectMake(0, 0, 320, self.height);
        _scrollTouch.backgroundColor = [UIColor clearColor];
        _scrollTouch.layer.cornerRadius = 5.0;
        [self.contentView addSubview:_scrollTouch];
    }
    
    return _scrollTouch;
}

- (NJPageScrollView *)scrollView
{
    if (nil == _scrollView)
    {
        _scrollView = [[NJPageScrollView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, 173, 168);
        _scrollView.backgroundColor = [UIColor clearColor];
        [_scrollView setRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft radius:5.];
        _scrollView.scrollView.clipsToBounds = YES;
        _scrollView.scrollView.showsVerticalScrollIndicator = NO;
		_scrollView.scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.dataSource = self;
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (MyPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[MyPageControl alloc] init];
        
        _pageControl.frame = CGRectMake(0, 0, 175, 20);
        
        _pageControl.imageNormal = [UIImage imageNamed:@"product_Image_NoSelectPoint.png"];
        
        _pageControl.imageSelected = [UIImage imageNamed:@"product_Image_SelectPoint.png"];
        
        _pageControl.maxPoint = 8;
        
//        [_pageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
        
        currentPageNumber = 0;
    }
    return _pageControl;
    
}

-(UILabel *)remaindNum{
    
    if (!_remaindNum) {
        
        _remaindNum = [[UILabel alloc] initWithFrame:CGRectMake(185, 130, 100, 18)];
        _remaindNum.text = L(@"subCount");
        _remaindNum.backgroundColor = [UIColor clearColor];
        _remaindNum.font = [UIFont systemFontOfSize:12];
        _remaindNum.textColor=[UIColor colorWithRGBHex:0x666668];
        [self.contentView addSubview:_remaindNum];
    }
    
    return _remaindNum;
}

- (UILabel *)ebuyPriceLab{
    
    if (!_ebuyPriceLab) {
        
        _ebuyPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(185, 12, 100, 18)];
        _ebuyPriceLab.text = [NSString stringWithFormat:@"%@:",L(@"yigouPrice")];
        _ebuyPriceLab.backgroundColor = [UIColor clearColor];
        _ebuyPriceLab.font = [UIFont systemFontOfSize:11];
        _ebuyPriceLab.textColor = [UIColor colorWithRGBHex:0x666668];
        
        [self.contentView addSubview:_ebuyPriceLab];
    }
    
    return _ebuyPriceLab;
}
- (StrikeThroughLabel *)ebuyPriceDesLab
{
    if ( !_ebuyPriceDesLab)
    {
        _ebuyPriceDesLab = [[StrikeThroughLabel alloc]init];
        
        _ebuyPriceDesLab.isWithStrikeThrough = NO;
        _ebuyPriceDesLab.textAlignment = UITextAlignmentCenter;
        
        _ebuyPriceDesLab.frame = CGRectMake(182, 36, 118, 18);
        
        _ebuyPriceDesLab.adjustsFontSizeToFitWidth = YES;
        _ebuyPriceDesLab.font = [UIFont systemFontOfSize:12.0];
        _ebuyPriceDesLab.textColor = [UIColor colorWithRGBHex:0x999999];
        _ebuyPriceDesLab.backgroundColor = [UIColor clearColor];
       // _ebuyPriceDesLab.textColor = [UIColor colorWithRed:176.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1.0];
        _ebuyPriceDesLab.isWithStrikeThrough = YES;
        [self.contentView addSubview:_ebuyPriceDesLab];
    }
    return _ebuyPriceDesLab;
}

- (UILabel *)realPriceLab{
    
    if (!_realPriceLab) {
        
        _realPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(185, 70, 100, 18)];
        _realPriceLab.text = [NSString stringWithFormat:@"%@:",L(@"discount")];
        _realPriceLab.backgroundColor = [UIColor clearColor];
        _realPriceLab.font = [UIFont systemFontOfSize:12];
        _realPriceLab.textColor = [UIColor colorWithRGBHex:0x444444];
        [self.contentView addSubview:_realPriceLab];
    }
    
    return _realPriceLab;
}
- (StrikeThroughLabel *)realPriceDesLab
{
    if ( !_realPriceDesLab)
    {
        _realPriceDesLab = [[StrikeThroughLabel alloc]init];
        // _realPriceDesLab.hidden = YES;
        _realPriceDesLab.isWithStrikeThrough = NO;
        _realPriceDesLab.textAlignment = UITextAlignmentLeft;
        
        _realPriceDesLab.frame = CGRectMake(182, 94, 118, 18);
        
        _realPriceDesLab.adjustsFontSizeToFitWidth = YES;
        _realPriceDesLab.textAlignment=UITextAlignmentCenter;
        _realPriceDesLab.font = [UIFont systemFontOfSize:15.0];
        _realPriceDesLab.textColor = [UIColor colorWithRGBHex:0xff0000];//[UIColor colorWithRed:137.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
        _realPriceDesLab.backgroundColor = [UIColor clearColor];
        //_realPriceDesLab.textColor = [UIColor colorWithRed:176.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1.0];
        [self.contentView addSubview:_realPriceDesLab];
    }
    return _realPriceDesLab;
}

-(UIImageView*)pageBgImageView
{
    if (nil == _pageBgImageView)
    {
        _pageBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-1, 148, 176, 22)];
        _pageBgImageView.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage newImageFromResource:@"product_Image_backImage2.png"];
        [_pageBgImageView setImage:image];
        // _pageBgImageView.hidden =YES;
        
    }
    
    return _pageBgImageView;
}
- (void)dealloc{
    
    
    TT_RELEASE_SAFELY(_productDTO);
    _scrollView.dataSource = nil;
    TT_RELEASE_SAFELY(_scrollView);
    TT_RELEASE_SAFELY(_pageControl);
    
    TT_RELEASE_SAFELY(_smallImageUrls);
    
    TT_RELEASE_SAFELY(_item);
    
    TT_RELEASE_SAFELY(_scrollTouch);
    
    TT_RELEASE_SAFELY(_ebuyPriceLab);
    TT_RELEASE_SAFELY(_realPriceLab);
    
    TT_RELEASE_SAFELY(_realPriceDesLab);
    TT_RELEASE_SAFELY(_ebuyPriceDesLab);
    
    
    
    TT_RELEASE_SAFELY(_remaindNum);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        
        self.size = CGSizeMake(300, 169);
        
        self.scrollTouch.receiver = self.scrollView.scrollView;
        self.scrollTouch.frame = CGRectMake(0, 0, 173, 168);;
        
        self.scrollTouch.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.scrollView];
        
        //pageControl
        self.scrollTouch.clipsToBounds = YES;
        
        [self.contentView addSubview:self.pageBgImageView];
        [self.pageBgImageView addSubview:self.pageControl];

        self.pageControl.currentPage = 0;
        
        self.scrollView.scrollView.clipsToBounds = YES;
  //      [self.contentView addSubview:self.pageControl];
        
    }
    return self;
}

- (void)setItem:(DataProductBasic *)aItem
{    
    _item = aItem;
    
    self.productDTO = _item;
    
    //获取小图url列表
    NSArray *smallImages = nil;//[ProductUtil getSmallImageUrlList:_item];
    if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
        //清晰
        
        smallImages = [ProductUtil getImageUrlListWithProduct:_item size:ProductImageSize400x400];
    }
    else{
        //一般
        
        smallImages = [ProductUtil getImageUrlListWithProduct:_item size:ProductImageSize200x200];
        
    }
    self.smallImageUrls = smallImages;
    
    //绘制图片
    [self.scrollView reloadData];
    
    //设置pageControl的页数
    self.pageControl.numberOfPages = [smallImages count];
    self.pageControl.currentPage = currentPageNumber;
    
    //suning价格
    NSString *priceString = @"¥  ";
    
    NSNumber *price1 = self.item.suningPrice;

    if([price1 doubleValue] > 0)
    {
        priceString = [price1 formatPriceString];
        self.ebuyPriceDesLab.text = priceString;
        
        self.ebuyPriceDesLab.hidden = NO;
        self.ebuyPriceLab.hidden = NO;
        
    }
    else{
        
        self.ebuyPriceDesLab.hidden = YES;
        self.ebuyPriceLab.hidden = YES;
    }
    
    //直降价格
    NSString *realPrice = @"¥  ";
    NSNumber *price2 = self.item.qianggouPrice;
    
    if([price2 doubleValue] > 0)
    {
        realPrice = [price2 formatPriceString];
        self.realPriceDesLab.text = realPrice;
        
        self.realPriceLab.hidden = NO;
        self.realPriceDesLab.hidden = NO;
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -
#pragma mark scroll view data source

- (NSInteger)numberOfPagesInPageScrollView:(NJPageScrollView *)pageScrollView
{
    return [self.smallImageUrls count];
}

- (NJPageScrollViewCell *)pageScrollView:(NJPageScrollView *)pageScrollView cellForPage:(NSInteger)page
{

    static NSString *pageIndentifier = @"pageIndentifier";
    ProductDetailImageViewCell *pageCell = (ProductDetailImageViewCell *)[pageScrollView dequeueReusablePageWithIdentifier:pageIndentifier];
    if (pageCell == nil)
    {
        pageCell = [[ProductDetailImageViewCell alloc] initWithReuseIdentifier:pageIndentifier];
        pageCell.frame = self.scrollView.bounds;
        
        //修复循环引用
        __weak QiangHeadCell *weakSelf = self;
        [pageCell setTouchedBlock:^{
            [weakSelf imageTouched];
        }];
    }
    
    NSURL *url = [self.smallImageUrls objectAtIndex:page];
    [pageCell setImageUrl:url powerFlag:self.item.powerFlgOrAmt atIndex:page];
    
    pageCell.contentView.frame = CGRectMake(0, 0, 173, 168);
    pageCell.imageView.frame = CGRectMake(0, 0, 173, 168);
    pageCell.powerFlagImageView.frame = CGRectMake(176, 0, 26, 36);
    return pageCell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = 173;
    
    CGFloat content =  scrollView.contentOffset.x - currentPageNumber * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
        
        self.pageControl.currentPage = page;
        
        if (currentPageNumber != page)
        {
            currentPageNumber = page;
            
            if ([self.smallImageUrls count] > currentPageNumber+2) {
                NSURL *url = [self.smallImageUrls objectAtIndex:currentPageNumber+2];
                SNImageCachePreloadImages(@[url]);
            }
        }
    }
    
}

- (void)imageTouched
{
    if ([_delegate respondsToSelector:@selector(didTouchImageAtIndex:withSmallImages:andBigImages:)])
    {
        NSArray *bigImages = nil;//[ProductUtil getBigImageUrlList:self.item];
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]
            && !self.item.isABook) {
            
            bigImages = [ProductUtil getImageUrlListWithProduct:self.item
                                                           size:ProductImageSize800x800];
            
        }
        else{
            bigImages = [ProductUtil getImageUrlListWithProduct:self.item
                                                           size:ProductImageSize400x400];
        }
        
        [_delegate didTouchImageAtIndex:currentPageNumber
                        withSmallImages:self.smallImageUrls
                           andBigImages:bigImages];
    }
}

+ (CGFloat)height
{
    return 168;
}
@end
