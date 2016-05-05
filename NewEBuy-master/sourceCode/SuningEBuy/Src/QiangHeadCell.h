//
//  QiangHeadCell.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-7-30.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataProductBasic.h"

#import "MyPageControl.h"
#import "ProductCommandDelegate.h"
#import "NJPageScrollView.h"
#import "NJPageScrollViewCell.h"
#import "SNTouchView.h"
#import "ProductUtil.h"
#import "StrikeThroughLabel.h"
#import "ProductImageCell.h"


@interface QiangHeadCell : UITableViewCell<NJPageScrollViewDataSource,NJPageScrollViewDelegate>
{
    NSInteger currentPageNumber;
}

@property (nonatomic, assign) id <ProductCommandDelegate> delegate;

@property (nonatomic, retain) DataProductBasic *item;

@property (nonatomic, retain) DataProductBasic *productDTO;

@property (nonatomic, retain) NJPageScrollView *scrollView;
@property (nonatomic, retain) MyPageControl  *pageControl;

@property (nonatomic, retain) NSArray *smallImageUrls;

@property (nonatomic, retain) SNTouchView *scrollTouch;


@property (nonatomic,retain)UILabel *ebuyPriceLab;

@property (nonatomic,retain)StrikeThroughLabel *ebuyPriceDesLab;

@property (nonatomic,retain)UILabel *realPriceLab;

@property (nonatomic,retain)StrikeThroughLabel *realPriceDesLab;

@property (nonatomic,retain) UIImageView *pageBgImageView;

@property (nonatomic,retain)UILabel *remaindNum;


+ (CGFloat)height;
- (void)imageTouched;
@end
