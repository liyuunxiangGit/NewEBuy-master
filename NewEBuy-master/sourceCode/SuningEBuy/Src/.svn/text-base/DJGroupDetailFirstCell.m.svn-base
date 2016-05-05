//
//  DJGroupDetailFirstCell.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "DJGroupDetailFirstCell.h"
#import "NSAttributedString+Attributes.h"
#import "MyPageControl.h"

#define kNormalFont  [UIFont systemFontOfSize:12.0]
#define kBigFont     [UIFont systemFontOfSize:15.0]

@interface DJGroupDetailFirstCell()
{
    DataProductBasic *productDto;
    DJGroupDetailDTO *detailDto;
}
@property (nonatomic, strong) MyPageControl  *pageControl;
@end

@implementation DJGroupDetailFirstCell

@synthesize detailImageView = _detailImageView;
@synthesize discountImgView = _discountImgView;
@synthesize discountLbl = _discountLbl;
@synthesize originPrice = _originPrice;
@synthesize strikeOriginPrice = _strikeOriginPrice;
@synthesize savePrice = _savePrice;
@synthesize nowPrice = _nowPrice;
@synthesize pageControl = _pageControl;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_detailImageView);
    TT_RELEASE_SAFELY(_discountImgView);
    TT_RELEASE_SAFELY(_discountLbl);
    TT_RELEASE_SAFELY(_originPrice);
    TT_RELEASE_SAFELY(_strikeOriginPrice);
    TT_RELEASE_SAFELY(_savePrice);
    TT_RELEASE_SAFELY(_nowPrice);
    TT_RELEASE_SAFELY(_pageControl);
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *backImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 302, 170)];
        backImgView.backgroundColor = [UIColor clearColor];
        backImgView.image = [UIImage imageNamed:@"product_Detai_back_all.png"];
        [backImgView setContentMode:UIViewContentModeScaleToFill];
        [self.contentView addSubview:backImgView];
        TT_RELEASE_SAFELY(backImgView);
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailImageView.frame = CGRectMake(1, 0.5, 173, 168);
    [self.detailImageView setRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft radius:5];
    self.discountImgView.frame = CGRectMake(113, 0, 62, 43);
    self.discountLbl.frame = CGRectMake(33, 0, 30, 20);
    
    CGSize originFrame = [self.originPrice.text sizeWithFont:kNormalFont];
    
    self.originPrice.frame = CGRectMake(190, 15, originFrame.width, 23);
    self.strikeOriginPrice.frame = CGRectMake(212, self.originPrice.top+15, 144, 23);
    self.savePrice.frame = CGRectMake(212, 75, 120, 23);
    self.savePriceLable.frame = CGRectMake(190, 52 , 144, 23);
    self.nowPrice.frame = CGRectMake(212, 125, 140, 23);
    self.nowPriceLable.frame = CGRectMake(self.originPrice.left, 100, 140, 23);
    [self addSubview:self.pageBgImageView];
}

- (void)setItem:(DataProductBasic *)productDetail detailDto:(DJGroupDetailDTO *)dto
{
    productDto = productDetail;
    detailDto = dto;
    
    [self.detailImageView setItem:productDto];
    
    
    if(dto.percentage.trim.length == 0)
    {
        self.discountLbl.alpha =0;
        self.discountImgView.alpha=0;
    }
    else{
        self.discountLbl.alpha =1;
        self.discountImgView.alpha=1;;
        self.discountLbl.text = [NSString stringWithFormat:@"%@%@",dto.percentage,L(@"DJGroup_Zhe")];
    }
    
    self.originPrice.text = L(@"DJGroup_OriginalPrice");
    self.strikeOriginPrice.text = [NSString stringWithFormat:@"￥%.2f",[dto.netPrice doubleValue]];
    self.nowPriceLable.text = L(@"DJGroup_CurrentPrice");
    self.savePriceLable.text =L(@"DJGroup_Save");
    
    NSString *savePriceStr = [NSString stringWithFormat:@"￥%.2f",[dto.adjustAmount doubleValue]];
    NSMutableAttributedString *savePriceAtt = [[NSMutableAttributedString alloc] initWithString:savePriceStr];
    [savePriceAtt setTextColor:[UIColor redColor] range:NSMakeRange(0, savePriceAtt.length )];
    [savePriceAtt setFont:kNormalFont];
    self.savePrice.attributedText = savePriceAtt;
    TT_RELEASE_SAFELY(savePriceAtt);
    
    NSString *nowPriceStr = [NSString stringWithFormat:@"￥%.2f",[dto.displayPrice doubleValue]];
    NSMutableAttributedString *nowPriceStrAtt = [[NSMutableAttributedString alloc] initWithString:nowPriceStr];
    
    [nowPriceStrAtt setTextColor:[UIColor redColor] range:NSMakeRange(0, nowPriceStrAtt.length)];
    [nowPriceStrAtt setFont:kBigFont];
    self.nowPrice.attributedText = nowPriceStrAtt;
    TT_RELEASE_SAFELY(nowPriceStrAtt);
    
    [self setNeedsLayout];
}

- (DJGroupDetailImageView *)detailImageView
{
    if(_detailImageView == nil){
        _detailImageView = [[DJGroupDetailImageView alloc]init];
       // [_detailImageView.layer setCornerRadius:6];
        [_detailImageView.layer setMasksToBounds:YES];
        _detailImageView.currentPageNumber = 0;
        //_detailImageView.backgroundColor=[UIColor blackColor];
        _detailImageView.pageControl = self.pageControl;
        [self.contentView addSubview:_detailImageView];
    }
    return _detailImageView;
}
-(UIImageView*)pageBgImageView
{
    if (nil == _pageBgImageView)
    {
        _pageBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 151, 175.5, 21)];
        _pageBgImageView.backgroundColor = [UIColor clearColor];
        UIImage *image = [UIImage newImageFromResource:@"product_Image_backImage2.png"];
        [_pageBgImageView setImage:image];
        // _pageBgImageView.hidden =YES;
        
        
    }
    
    return _pageBgImageView;
}
- (UIImageView *)discountImgView
{
    if (!_discountImgView) {
        _discountImgView = [[UIImageView alloc] init];
        _discountImgView.backgroundColor = [UIColor clearColor];
        _discountImgView.image = [UIImage imageNamed:@"DJ_Detail_Discount.png"];
        [_discountImgView setContentMode:UIViewContentModeScaleToFill];
        _discountImgView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.discountImgView];
    }
    return _discountImgView;
}

- (UILabel *)discountLbl
{
    if(_discountLbl == nil){
        _discountLbl = [[UILabel alloc]init];
        _discountLbl.textColor = [UIColor whiteColor];
        _discountLbl.backgroundColor = [UIColor clearColor];
        _discountLbl.font = kNormalFont;
        _discountLbl.textAlignment = UITextAlignmentLeft;
        _discountLbl.adjustsFontSizeToFitWidth = YES;
        [self.discountImgView addSubview:_discountLbl];
    }
    return _discountLbl;
}

- (UILabel *)originPrice
{
    if(_originPrice == nil){
        _originPrice = [[UILabel alloc]init];
        _originPrice.textColor = [UIColor darkGrayColor];
        _originPrice.backgroundColor = [UIColor clearColor];
        _originPrice.numberOfLines = 0;
        _originPrice.lineBreakMode = UILineBreakModeCharacterWrap;
        _originPrice.font = kNormalFont;
        _originPrice.textAlignment = UITextAlignmentLeft;
        _originPrice.shadowColor = [UIColor whiteColor];
        _originPrice.shadowOffset = CGSizeMake(1, 1);
        [self.contentView addSubview:_originPrice];
    }
    return _originPrice;
}

- (StrikeThroughLabel *)strikeOriginPrice
{
    if (!_strikeOriginPrice) {
        _strikeOriginPrice = [[StrikeThroughLabel alloc] init];
        _strikeOriginPrice.backgroundColor = [UIColor clearColor];
        _strikeOriginPrice.textColor = [UIColor grayColor];
        _strikeOriginPrice.textAlignment = UITextAlignmentLeft;
        _strikeOriginPrice.font = kNormalFont;
        _strikeOriginPrice.shadowColor = [UIColor whiteColor];
        _strikeOriginPrice.shadowOffset = CGSizeMake(1, 1);
        _strikeOriginPrice.isWithStrikeThrough = YES;
        [self.contentView addSubview:_strikeOriginPrice];
    }
    return _strikeOriginPrice;
}


- (OHAttributedLabel*)savePrice
{
    if(_savePrice == nil){
        _savePrice = [[OHAttributedLabel alloc]init];
        _savePrice.backgroundColor = [UIColor clearColor];
        _savePrice.font = [UIFont systemFontOfSize:17.0];
        _savePrice.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_savePrice];
    }
    return _savePrice;
}
- (OHAttributedLabel*)savePriceLable
{
    if(_savePriceLable == nil){
        _savePriceLable = [[OHAttributedLabel alloc]init];
        _savePriceLable.backgroundColor = [UIColor clearColor];
        _savePriceLable.font = [UIFont systemFontOfSize:12.0];
        _savePriceLable.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_savePriceLable];
    }
    return _savePriceLable;
}

- (OHAttributedLabel*)nowPrice
{
    if(_nowPrice == nil){
        _nowPrice = [[OHAttributedLabel alloc]init];
        _nowPrice.backgroundColor = [UIColor clearColor];
        _nowPrice.textColor = [UIColor blackColor];
        _nowPrice.font = kNormalFont;
        _nowPrice.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_nowPrice];
    }
    return _nowPrice;
}

- (OHAttributedLabel*)nowPriceLable
{
    if(_nowPriceLable == nil){
        _nowPriceLable = [[OHAttributedLabel alloc]init];
        _nowPriceLable.backgroundColor = [UIColor clearColor];
        _nowPriceLable.textColor = [UIColor blackColor];
        _nowPriceLable.font = kNormalFont;
        _nowPriceLable.textAlignment = UITextAlignmentLeft;
        [self.contentView addSubview:_nowPriceLable];
    }
    return _nowPriceLable;
}

- (MyPageControl *)pageControl{
    
    if (!_pageControl) {
        
        _pageControl = [[MyPageControl alloc] init];
        
        _pageControl.frame = CGRectMake(0, 0, 175, 20);
        
        _pageControl.imageNormal = [UIImage imageNamed:@"product_Image_NoSelectPoint.png"];
        
        _pageControl.imageSelected = [UIImage imageNamed:@"product_Image_SelectPoint.png"];
        
        _pageControl.maxPoint = 8;
        
        //        [_pageControl addTarget:self action:@selector(scrollToPage:) forControlEvents:UIControlEventValueChanged];
        
        [self.pageBgImageView addSubview:_pageControl];
    }
    return _pageControl;
}

@end
