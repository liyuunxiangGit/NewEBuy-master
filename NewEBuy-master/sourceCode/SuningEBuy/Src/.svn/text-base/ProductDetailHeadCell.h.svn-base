//
//  ProductDetailHeadCell.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-8-30.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductImageCell.h"
#import "StrikeThroughLabel.h"
#import "OHAttributedLabel.h"
@interface ProductDetailHeadCell : ProductImageCell<NJPageScrollViewDataSource,NJPageScrollViewDelegate>


@property (nonatomic,retain)UILabel *ebuyPriceLab;

@property (nonatomic,retain)StrikeThroughLabel *ebuyPriceDesLab;

@property (nonatomic,retain)UILabel *realPriceLab;

@property (nonatomic,retain)StrikeThroughLabel *realPriceDesLab;

@property (nonatomic,retain)UIButton *collectBtn;

@property (nonatomic,retain)UIImageView *backView;


@property (nonatomic,retain)UILabel *remaindNum;

@property (nonatomic)NSInteger type;  //1,普通 2，抢购

@property (nonatomic,retain)UILabel *nameLab;

@property (nonatomic,retain)UILabel *sellPointLab;

@property (nonatomic,retain)UILabel *cuTitleAndSellPoint;

@property (nonatomic,retain)MyPageControl *pageCtr;

@property (nonatomic,retain) UIImageView *pageBgImageView;

-(void)refreshFrame;
@end

