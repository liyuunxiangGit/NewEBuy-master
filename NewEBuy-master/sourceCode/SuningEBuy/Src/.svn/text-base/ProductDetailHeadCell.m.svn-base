//
//  ProductHeadImgCell.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductDetailHeadCell.h"
#import "NSAttributedString+Attributes.h"
#import "SNGraphics.h"

@implementation ProductDetailHeadCell

@synthesize item = _item;
//@synthesize pageControl = _pageControl;

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_ebuyPriceLab);
    TT_RELEASE_SAFELY(_realPriceLab);
    
    TT_RELEASE_SAFELY(_realPriceDesLab);
    TT_RELEASE_SAFELY(_ebuyPriceDesLab);
    
    TT_RELEASE_SAFELY(_collectBtn);
    
    TT_RELEASE_SAFELY(_backView);
    
    TT_RELEASE_SAFELY(_remaindNum);
    
    TT_RELEASE_SAFELY(_nameLab);
    
    TT_RELEASE_SAFELY(_sellPointLab);
    
    TT_RELEASE_SAFELY(_cuTitleAndSellPoint);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(UILabel *)nameLab{
    
    if (!_nameLab) {
        
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(160, 15, 140, 50)];
        
        _nameLab.font = [UIFont boldSystemFontOfSize:13];
        
        _nameLab.backgroundColor = [UIColor clearColor];
        
        _nameLab.numberOfLines = 0;
        
        _nameLab.hidden = YES;
        
        [self.contentView addSubview:_nameLab];
    }
    
    return _nameLab;
}

-(UILabel *)sellPointLab{
    
    if (!_sellPointLab) {
        
        _sellPointLab = [[UILabel alloc] initWithFrame:CGRectMake(204, 85, 100, 75)];
        
        _sellPointLab.font = [UIFont systemFontOfSize:12];
        
        _sellPointLab.backgroundColor = [UIColor clearColor];
        
        _sellPointLab.numberOfLines = 0;
        
        _sellPointLab.hidden = YES;
        
        _sellPointLab.textColor = [UIColor grayColor];
        [self.contentView addSubview:_sellPointLab];
    }
    
    return _sellPointLab;
}
-(UILabel *)remaindNum{
    
    if (!_remaindNum) {
        
        _remaindNum = [[UILabel alloc] initWithFrame:CGRectMake(180, 120, 100, 18)];
        _remaindNum.text = L(@"subCount");
        _remaindNum.backgroundColor = [UIColor clearColor];
        _remaindNum.font = [UIFont systemFontOfSize:12];
        _remaindNum.hidden = YES;
        
        [self.contentView addSubview:_remaindNum];
    }
    
    return _remaindNum;
}

- (UILabel *)ebuyPriceLab{
    
    if (!_ebuyPriceLab) {
        
        _ebuyPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(184, 10, 60, 18)];
        _ebuyPriceLab.text = L(@"Product_CankaoPrice");
        _ebuyPriceLab.backgroundColor = [UIColor clearColor];
        _ebuyPriceLab.font = [UIFont systemFontOfSize:12];
        _ebuyPriceLab.textColor = [UIColor colorWithRed:68.0/255 green:68.0/255 blue:68.0/255 alpha:1];
        
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
        _ebuyPriceDesLab.textAlignment = UITextAlignmentLeft;
        
        _ebuyPriceDesLab.frame = CGRectMake(200, 30, 80, 18);
        
        _ebuyPriceDesLab.adjustsFontSizeToFitWidth = YES;
        _ebuyPriceDesLab.font = [UIFont systemFontOfSize:15.0];
        _ebuyPriceDesLab.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1.0];
        _ebuyPriceDesLab.backgroundColor = [UIColor clearColor];
        _ebuyPriceDesLab.isWithStrikeThrough = YES;
        [self.contentView addSubview:_ebuyPriceDesLab];
    }
    return _ebuyPriceDesLab;
}

- (UILabel *)cuTitleAndSellPoint
{
    if ( !_cuTitleAndSellPoint)
    {
        _cuTitleAndSellPoint = [[UILabel alloc]init];
        _cuTitleAndSellPoint.backgroundColor = [UIColor clearColor];
        _cuTitleAndSellPoint.font = [UIFont boldSystemFontOfSize:13];
        _cuTitleAndSellPoint.hidden = YES;
        [self.contentView addSubview:_cuTitleAndSellPoint];
    }
    return _cuTitleAndSellPoint;
}
- (MyPageControl *)pageCtr{
    
    if (!_pageCtr) {
        
        _pageCtr = [[MyPageControl alloc] init];
        
        _pageCtr.frame = CGRectMake(0, 1, 174, 20);
        
        _pageCtr.imageNormal = [UIImage imageNamed:@"product_Image_NoSelectPoint.png"];
        
        _pageCtr.imageSelected = [UIImage imageNamed:@"product_Image_SelectPoint.png"];
        
        _pageCtr.maxPoint = 8;
        
//        [_pageCtr addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
        
        currentPageNumber = 0;
    }
    return _pageCtr;
    
}

-(UIImageView*)pageBgImageView
{
    if (nil == _pageBgImageView)
    {
        _pageBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-0.9, 149, 175, 21)];
        _pageBgImageView.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage newImageFromResource:@"product_Image_backImage2.png"];
        [_pageBgImageView setImage:image];
       // _pageBgImageView.hidden =YES;
        
    }
    
    return _pageBgImageView;
}

- (UILabel *)realPriceLab{
    
    if (!_realPriceLab) {
        
        _realPriceLab = [[UILabel alloc] initWithFrame:CGRectMake(184, 45, 60, 18)];
        _realPriceLab.text = [NSString stringWithFormat:@"%@:",L(@"yigouPrice")];
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
        
        _realPriceDesLab.frame = CGRectMake(210, 65, 80, 18);
        
        _realPriceDesLab.adjustsFontSizeToFitWidth = YES;
        _realPriceDesLab.font = [UIFont systemFontOfSize:15.0];
        _realPriceDesLab.textColor =[UIColor colorWithRGBHex:0xff0000];// [UIColor colorWithRed:137.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1.0];
        _realPriceDesLab.backgroundColor = [UIColor clearColor];
        //   _realPriceDesLab.textColor = [UIColor colorWithRed:176.0/255.0 green:44.0/255.0 blue:44.0/255.0 alpha:1.0];
        [self.contentView addSubview:_realPriceDesLab];
    }
    return _realPriceDesLab;
}

- (UIButton *)collectBtn{
    
    if (!_collectBtn) {
        
        _collectBtn = [[UIButton alloc] initWithFrame:CGRectMake(215, 110, 40, 40)];
        //[_collectBtn setTitle:@"收藏" forState:UIControlStateNormal];
        
        [_collectBtn addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"star_Store.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_collectBtn];
    }
    
    return _collectBtn;
}

-(UIImageView *)backView{
    
    
    if (!_backView) {
        
        _backView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yellowbackground.png"]];
        //back.frame = CGRectMake(10, 5, 300, cell.frame.size.height-10);
        [self.contentView addSubview:_backView];
    }
    
    return _backView;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backView.frame = CGRectMake(10, 5, 300, self.frame.size.height-10);
        
        [self.contentView sendSubviewToBack:self.backView];
        self.size = CGSizeMake(140, 140);
        
        self.scrollTouch.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.scrollView];
        
        self.scrollTouch.receiver = self.scrollView.scrollView;
        self.scrollTouch.frame = CGRectMake(0, 0, 173, 169);
//        [self.contentView bringSubviewToFront:self.scrollTouch];
        
        //pageControl
        self.scrollTouch.clipsToBounds = YES;
        [self.contentView addSubview:self.pageBgImageView];
        [self.pageBgImageView addSubview:self.pageCtr];
        
        self.pageCtr.currentPage = 0;
        
        
    }
    return self;
}
-(void)initFrame{
    
    
    self.scrollView.frame = CGRectMake(0, 0, 173, 169);
    [self.scrollView setRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft radius:5.];
    self.scrollView.clipsToBounds = YES;
    self.ebuyPriceDesLab.frame = CGRectMake(200, 30, 120, 18);
    self.realPriceLab.frame = CGRectMake(184, 55, 60, 18);
    self.realPriceLab.textAlignment = UITextAlignmentLeft;
    self.realPriceDesLab.frame = CGRectMake(200, 75, 100, 18);
    self.realPriceDesLab.textAlignment = UITextAlignmentLeft;
    
    
    
    if ([self isProductEnabled]) {
        
        self.sellPointLab.hidden = YES;
        
        self.ebuyPriceLab.hidden = NO;
        self.ebuyPriceDesLab.hidden = NO;
        self.realPriceDesLab.hidden = NO;
        self.realPriceLab.hidden = NO;
    }
    else{
        
        self.sellPointLab.frame = CGRectMake(185, 25, 110, 75);
        
        if (2 == self.type) {
            
            self.sellPointLab.hidden = YES;
        }
        else{
            self.sellPointLab.hidden = NO;
        }
        
        self.ebuyPriceLab.hidden = YES;
        self.ebuyPriceDesLab.hidden = YES;
        self.realPriceDesLab.hidden = YES;
        self.realPriceLab.hidden = YES;
    }
}
-(void)refreshFrame{
    
    self.scrollView.frame = CGRectMake(0, 0, 173, 169);
    self.scrollView.scrollView.clipsToBounds = YES;
    self.scrollTouch.frame = CGRectMake(10, 10, 150, 150);
    
    
    self.sellPointLab.frame = CGRectMake(185, 85, 110, 75);
    
    self.realPriceDesLab.frame = CGRectMake(200, 75, 80, 18);
    
    self.realPriceLab.frame = CGRectMake(184, 55, 60, 18);
    
    self.ebuyPriceLab.frame = CGRectMake(184, 10, 60, 18);
    self.ebuyPriceDesLab.frame = CGRectMake(200, 30, 80, 18);
    self.ebuyPriceLab.hidden = YES;
    self.ebuyPriceDesLab.hidden = YES;
    
    self.nameLab.hidden = NO;
    self.sellPointLab.hidden = NO;
    
    self.collectBtn.hidden = YES;
    
    self.realPriceDesLab.hidden = NO;
    self.realPriceLab.hidden = NO;
    
    self.nameLab.hidden = YES;
    self.sellPointLab.hidden = YES;
    self.cuTitleAndSellPoint.hidden = NO;
    
    
    NSString *str = nil;[NSString stringWithFormat:@"%@ %@",self.productDTO.productName,self.productDTO.special];
    
    if ([self isProductEnabled]) {
        
        str = [NSString stringWithFormat:@"%@ %@",self.productDTO.productName,self.productDTO.special];
    }
    else{
        
        
        self.realPriceDesLab.hidden = YES;
        self.realPriceLab.hidden = YES;
        str = [NSString stringWithFormat:@"%@ \n\n%@",self.productDTO.productName,L(@"Sorry, Not enough stock")];
        
    }
    UIFont *couendFont = [UIFont systemFontOfSize:13];
    CGSize labelsize = [str sizeWithFont:couendFont constrainedToSize:CGSizeMake(140, 1000) lineBreakMode:UILineBreakModeTailTruncation];
    float height = labelsize.height;
    if (height > 90) {
        
        height = 90;
    }
    
    //   NSMutableAttributedString *timeContentAtt = [[NSMutableAttributedString alloc] initWithString:str];
    //
    //    [timeContentAtt setTextColor:[UIColor grayColor]];
    //    [timeContentAtt setFont:[UIFont systemFontOfSize:13]];
    //
    //    [timeContentAtt setTextColor:[UIColor blackColor] range:[str rangeOfString:self.productDTO.productName]];
    //    [timeContentAtt setFont:[UIFont boldSystemFontOfSize:14]range:[str rangeOfString:self.productDTO.productName]];
    //    TT_RELEASE_SAFELY(timeContentAtt);
    
    self.cuTitleAndSellPoint.text = str;
    
    self.cuTitleAndSellPoint.numberOfLines = 0;
    self.cuTitleAndSellPoint.lineBreakMode = NSLineBreakByTruncatingTail;
    self.cuTitleAndSellPoint.frame = CGRectMake(160, 25+(90-height)/2, 140, height);
    
    self.realPriceDesLab.frame = CGRectMake(210, 115, 80, 18);
    
    self.realPriceLab.frame = CGRectMake(215, 115, 60, 18);
    
}

- (BOOL)isProductEnabled
{
    /*
     * liukun modify  12-12-06  如果商品价格小于等于0，默认也是不可买的
     */
    //    if ([self.productDTO.hasStorage isEqualToString:@"Y"] &&
    //        ![self.productDTO.cityCode isEqualToString:@""] &&
    //        [self.productDTO.suningPrice doubleValue] > 0)
    //    {
    //        return YES;
    //    }
    //    else
    //    {
    //        return NO;
    //    }
    
    if ([self.productDTO.suningPrice doubleValue] > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
- (void)setItem:(DataProductBasic *)aItem
{
    _item = aItem;
    
    self.productDTO = _item;
    
    [self initFrame];
    
    if ([aItem.bookmarkFlag isEqualToString:@"1"]) {
        [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"product_Collect_YellowStar.png"] forState:UIControlStateNormal];
    }else{
        [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"product_Collect_GrayStar.png"] forState:UIControlStateNormal];
    }
    
    self.nameLab.text = _item.productName;
    
    if ([self isProductEnabled]) {
        
        self.sellPointLab.text = _item.special;
    }
    else{
        
        self.sellPointLab.text = L(@"Sorry, Not enough stock");
        
    }
    
    
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
    
    //设置pageControl的页数
    self.pageCtr.numberOfPages = [smallImages count];
    self.pageCtr.currentPage = currentPageNumber;
    
    //绘制图片
    [self.scrollView reloadData];
    
    
    //suning价格
    NSString *priceString = @"¥  ";
    
    NSNumber *price1 = nil;
    
    if (2 != self.type) {
        
        price1 = self.item.marketPrice;
    }
    else{
        
        price1 = self.item.suningPrice;
    }
    
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
        
        if (1 == self.type) {
            
            self.realPriceDesLab.frame = CGRectMake(194, 55, 100, 18);
            self.realPriceDesLab.textAlignment = UITextAlignmentLeft;
            
            self.realPriceLab.frame = CGRectMake(184, 20, 100, 18);
            self.realPriceLab.textAlignment = UITextAlignmentLeft;
        }
    }
    
    //直降价格
    NSString *realPrice = @"¥  ";
    NSNumber *price2 = nil;
    
    if (2 != self.type) {
        
        price2 = self.item.suningPrice;
    }
    else{
        
        price2 = self.item.qianggouPrice;
    }
    if([price2 doubleValue] > 0)
    {
        realPrice = [price2 formatPriceString];
        self.realPriceDesLab.text = realPrice;
        self.realPriceDesLab.hidden = NO;
        self.realPriceLab.hidden = NO;
    }
    else{
        self.realPriceDesLab.hidden = YES;
        self.realPriceLab.hidden = YES;
    }
}

- (NJPageScrollViewCell *)pageScrollView:(NJPageScrollView *)pageScrollView cellForPage:(NSInteger)page
{
    ProductDetailImageViewCell *cell = (ProductDetailImageViewCell *)[super pageScrollView:pageScrollView cellForPage:page];
    cell.contentView.frame = CGRectMake(0, 0, 173, 169);
    cell.imageView.frame = CGRectMake(0, -1, 173, 169);
    cell.powerFlagImageView.frame = CGRectMake(143, 0, 30, 30);
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat pageWidth = 173;
    
    CGFloat content =  scrollView.contentOffset.x - currentPageNumber * pageWidth;
    
    if ((content / pageWidth == (int)(content / pageWidth)) && content != 0)
    {
        int page = scrollView.contentOffset.x / pageWidth;
        
        self.pageCtr.currentPage = page;
        
        if (currentPageNumber != page)
        {
            currentPageNumber = page;
            
            if ([self.smallImageUrls count] > currentPageNumber+2)
            {
                NSURL *url = [self.smallImageUrls objectAtIndex:currentPageNumber+2];
                SNImageCachePreloadImages(@[url]);
            }
        }
    }
    
}


- (void)addToFavorite:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addToFavorite)]) {
        [self.delegate addToFavorite];
    }
}
@end
