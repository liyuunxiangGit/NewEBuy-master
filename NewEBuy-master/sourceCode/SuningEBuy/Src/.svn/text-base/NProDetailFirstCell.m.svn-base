//
//  NProDetailFirstCell.m
//  SuningEBuy
//
//  Created by xmy on 18/12/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NProDetailFirstCell.h"
#import "ProductUtil.h"
#import "SNGraphics.h"

#define NKProductImagesHeight 164

@implementation NProDetailFirstCell


- (UIImageView*)backView
{
    if(!_backView)
    {
        _backView = [[UIImageView alloc] init];
        
        [_backView setImage:[UIImage imageNamed:@"yellowbackground.png"]];
        
        _backView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _backView;
}

- (UIImageView*)proNameBackView
{
    if(!_proNameBackView)
    {
        _proNameBackView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, 320, 39.5)];
        
        _proNameBackView.image = [UIImage imageWithColor:RGBACOLOR(0, 0, 0, 0.5)
                                                    size:_proNameBackView.bounds.size];
//        _proNameBackView.backgroundColor = RGBACOLOR(0, 0, 0, 0.5);//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//        _proNameBackView.alpha = 0.5;
        
//        [_proNameBackView setImage:[UIImage imageNamed:@"N_ProNameBack.png"]];
        
        _proNameBackView.userInteractionEnabled = YES;
        
    }
    
    return _proNameBackView;
}

- (void)setLblProtery:(UILabel*)lbl
{
    
    lbl.backgroundColor = [UIColor clearColor];
    
    lbl.font = [UIFont systemFontOfSize:12];
    
    lbl.textColor = [UIColor colorWithRGBHex:0x666666];
    
    lbl.textAlignment = UITextAlignmentLeft;
    
    lbl.numberOfLines = 2;
    
    lbl.hidden = NO;
    
}

- (UILabel*)productNameLbl
{
    if(!_productNameLbl)
    {
        _productNameLbl = [[UILabel alloc] init];
        
        [self setLblProtery:_productNameLbl];
        
        _productNameLbl.numberOfLines = 2;
        
        _productNameLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        
        _productNameLbl.textColor = [UIColor whiteColor];
        
        _productNameLbl.font = [UIFont systemFontOfSize:15];
        
    }
    
    return _productNameLbl;
}

- (UIButton *)collectBtn{
    
    if (!_collectBtn) {
        
        _collectBtn = [[UIButton alloc] init];
        
        [_collectBtn addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
        
        _collectBtn.hidden = YES;
        
        [_collectBtn setImage:[UIImage imageNamed:@"productDetail_unCollect.png"] forState:UIControlStateNormal];
    }
    
    return _collectBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        
        [_shareBtn addTarget:self action:@selector(Share:) forControlEvents:UIControlEventTouchUpInside];
        
        [_shareBtn setImage:[UIImage imageNamed:@"productDetail_wifi_share.png"] forState:UIControlStateNormal];
        
        [_shareBtn setImage:[UIImage imageNamed:@"productDetail_wifi_share_clicked.png"] forState:UIControlStateSelected];
    }
    return _shareBtn;
}

- (NDetailHeadProImages*)proImagesScroll
{
    if(!_proImagesScroll)
    {
        _proImagesScroll = [[NDetailHeadProImages alloc] initWithFrame:CGRectMake(0, -40, self.frame.size.width, self.frame.size.width)];
        
        _proImagesScroll.backgroundColor = [UIColor clearColor];
        
        _proImagesScroll.userInteractionEnabled = YES;     
    }
    
    return _proImagesScroll;
}


//- (UIButton *)collectBtn{
//    
//    if (!_collectBtn) {
//        
//        _collectBtn = [[UIButton alloc] init];
//        
//        [_collectBtn addTarget:self action:@selector(addToFavorite:) forControlEvents:UIControlEventTouchUpInside];
//        
//        [_collectBtn setBackgroundImage:[UIImage imageNamed:@"star_Store.png"] forState:UIControlStateNormal];                
//    }
//    
//    return _collectBtn;
//}

- (UIImageView*)qiangOrTuanImageView
{
    if(!_qiangOrTuanImageView)
    {
        _qiangOrTuanImageView = [[UIImageView alloc] init];
        
        _qiangOrTuanImageView.backgroundColor = [UIColor clearColor];
        
        _qiangOrTuanImageView.frame = CGRectMake(0, 0, 40, 40);
    }
    
    return _qiangOrTuanImageView;
    
}

- (UIButton*)activetyImageV
{
    if(!_activetyImageV)
    {
        _activetyImageV = [[UIButton alloc] init];
        
        _activetyImageV.backgroundColor = [UIColor clearColor];
        
        _activetyImageV.frame = CGRectMake(0, 10, 280, 20);
        [_activetyImageV addTarget:self action:@selector(activetyBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _activetyImageV.backgroundColor = [UIColor colorWithRGBHex:0xFF3300];
        
        _activetyImageV.alpha = 0.8;
        
        UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gotoqianggou.png"]];
        
        view.frame = CGRectMake(275, 15, 7, 12);
        
        [self addSubview:_activetyImageV];
        
        [_activetyImageV addSubview:view];
    }
    
    return _activetyImageV;
}

- (UILabel*)activetyPriceLbl
{
    if(!_activetyPriceLbl)
    {
        _activetyPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(36, 0, 200, 39.5)];
        
        _activetyPriceLbl.textAlignment = UITextAlignmentLeft;
        
        _activetyPriceLbl.textColor = [UIColor colorWithRGBHex:0xFFFFFF];
        
        _activetyPriceLbl.backgroundColor = [UIColor clearColor];
        
        _activetyPriceLbl.font = [UIFont systemFontOfSize:18];
        
        [self.activetyImageV addSubview:_activetyPriceLbl];
    }
    
    return _activetyPriceLbl;
}



//设置商品图片的位置
- (void)setProductImages:(DataProductBasic*)dto
{
    
    self.proImagesScroll.frame = CGRectMake(0, -40, self.frame.size.width, self.frame.size.width);
    self.proImagesScroll.layer.masksToBounds = YES;
    [self.proImagesScroll setRoundedCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft radius:5.];
    self.proImagesScroll.clipsToBounds = YES;
    
    //获取小图url列表
    NSArray *imageArr = [[NSArray alloc] init];
    
    if(dto.isABook == YES)
    {
//        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
//            //清晰
//            
            imageArr = [ProductUtil getImageUrlListWithProduct:dto size:ProductImageSize400x400];
//        }
//        else{
            //一般
            
//            imageArr = [ProductUtil getImageUrlListWithProduct:dto size:ProductImageSize200x200];
        
//        }
    }
    else
    {
        if ([[AppDelegate currentAppDelegate] isHeightQuailtyImg]) {
            //清晰
            
            imageArr = [ProductUtil getImageUrlListWithProduct:dto size:ProductImageSize800x800];
        }
        else{
            //一般
            
            imageArr = [ProductUtil getImageUrlListWithProduct:dto size:ProductImageSize400x400];
            
        }
    }
    
    
    
    [self.proImagesScroll setNDetailHeadImagesArr:imageArr];
    
    self.proImagesScroll.item = dto;
   
    //绘制图片
    [self.proImagesScroll reloadData];
    [self.proImagesScroll.pageScroll reloadData];

    
}

- (void)setNProDetailFirstCell:(DataProductBasic *)dto
               WithCollectFlag:(NSString *)collectFlag
                      WithType:(ProductDeatailType)type
{
//    if (dto == nil || dto == self.nDto)
//    {
//        if(collectFlag == self.collectFlag)
//        {
//            return;
//        }
//        else
//        {
//            if ([collectFlag isEqualToString:@"1"]) {
//                [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"N_CollectYellow.png"] forState:UIControlStateNormal];
//            }else{
//                [self.collectBtn setBackgroundImage:[UIImage imageNamed:@"N_CollectGray.png"] forState:UIControlStateNormal];
//            }
//        }
//    }
    
    [self.contentView addSubview:self.proNameBackView];
    
    [self.contentView addSubview:self.productNameLbl];
    
    [self.contentView addSubview:self.collectBtn];
    
//    [self.contentView addSubview:self.shareBtn];
    
    self.productNameLbl.text = dto.productName;
    
    self.proNameBackView.frame = CGRectMake(0, 191, 320, 49.5);
    
    self.productNameLbl.frame = CGRectMake(10, 195, 262, 35);
    
    self.collectBtn.frame = CGRectMake(272, 190, 50, 50);
    
//    self.shareBtn.frame = CGRectMake(272, 190, 50, 50);
    
    if ([collectFlag isEqualToString:@"1"]) {
        [self.collectBtn setImage:[UIImage imageNamed:@"productDetail_hasCollect.png"] forState:UIControlStateNormal];
    }else{
        [self.collectBtn setImage:[UIImage imageNamed:@"productDetail_unCollect.png"] forState:UIControlStateNormal];
    }
    
    if(type == NormalProduct)
    {
        
        self.productNameLbl.frame = CGRectMake(10, 195, 262, 40);
    }
    else
    {
        
        self.productNameLbl.frame = CGRectMake(10, 195, 290, 40);
        
    }
    
    self.nDto = dto;
    
    self.collectFlag = collectFlag;

    [self.contentView addSubview:self.proImagesScroll];
    
    [self setProductImages:dto];
   
    [self addSubview:self.qiangOrTuanImageView];
    if(type == PurchuseProduct)
    {//抢购
        self.qiangOrTuanImageView.hidden = YES;

        self.qiangOrTuanImageView.image = [UIImage imageNamed:@"productDetail_headQiangGou.png"];
    }
    else if(type == GroupProduct)
    {//团购
        self.qiangOrTuanImageView.hidden = YES;
        
        self.qiangOrTuanImageView.image = [UIImage imageNamed:@"productDetail_headTuanGou.png"];

    }
    else if (type == BigSaleProduct)
    {
        self.qiangOrTuanImageView.hidden = YES;
        
        self.qiangOrTuanImageView.image = [UIImage imageNamed:@"shopcart_bazaar.png"];
    }
    else
    {//普通
        self.qiangOrTuanImageView.hidden = YES;
    }
    
//    self.proNameBackView.userInteractionEnabled = YES;
    [self.contentView bringSubviewToFront:self.proNameBackView];
    [self.contentView bringSubviewToFront:self.productNameLbl];
    [self.contentView bringSubviewToFront:self.collectBtn];
    [self.contentView bringSubviewToFront:self.shareBtn];
}

- (CGFloat)setNProDetailFirstCellHeight:(DataProductBasic*)dataDto WithMore:(BOOL)isMore
{
    if(isMore == YES)
    {
        return self.frame.size.width;
    }
    else
    {
        return 165;
        
    }
}


+ (CGFloat)NProDetailFirstCellHeight:(DataProductBasic*)dataDto WithMore:(BOOL)isMore
{
    return [[NProDetailFirstCell alloc] setNProDetailFirstCellHeight:dataDto WithMore:isMore];
}

//- (void)addToFavorite:(id)sender
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(addToFavorite)]) {
//        
//        [self.delegate addToFavorite];
//    }
//}

- (void)touchImages
{
    [self.delegate touchImages];
}

- (void)addToFavorite:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(addToFavorite)]) {
        
        [self.delegate addToFavorite];
    }
}

- (void)Share:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(gotoShare)]) {
        [self.delegate gotoShare];
    }
}

@end
