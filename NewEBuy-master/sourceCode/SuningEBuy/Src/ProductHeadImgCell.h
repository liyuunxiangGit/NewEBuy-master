//
//  ProductHeadImgCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "ProductImageCell.h"
#import "StrikeThroughLabel.h"
#import "OHAttributedLabel.h"
@interface ProductHeadImgCell : ProductImageCell<NJPageScrollViewDataSource,NJPageScrollViewDelegate>


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
@property (nonatomic,retain)UILabel *sellPoint;

@property (nonatomic,retain)MyPageControl *pageCtr;

-(void)refreshFrame;
@end
