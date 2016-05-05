//
//  NewProductDetailHeadCell.h
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-8-30.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProductImageCell.h"
#import "StrikeThroughLabel.h"
#import "OHAttributedLabel.h"
#import "CSProductDetailHeadCell.h"

@class NewProductDetailHeadCell;

@protocol NewProductDetailHeadCellDelegate <NSObject>

- (void)activetyBtnAction;

@end

@interface NewProductDetailHeadCell : ProductImageCell<NJPageScrollViewDataSource,NJPageScrollViewDelegate>

@property (nonatomic,assign)id<NewProductDetailHeadCellDelegate>activityDelegate;

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
//@property (nonatomic,retain) UIImageView *activetypoint;

@property (nonatomic,retain) CSProductDetailHeadCell *CSCell;

//xmy
@property (nonatomic,retain)UILabel *deliveryLbl;//运费

@property (nonatomic,retain)UILabel *deliveryFeeLbl;

@property (nonatomic,retain)UIButton *activetyImageV;//抢购或团购

@property (nonatomic,retain)UILabel *activetyPriceLbl;

-(void)refreshFrame;
@end

