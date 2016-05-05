//
//  InterestProductsView.h
//  SuningEBuy
//
//  Created by shasha on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NJPageScrollView.h"
#import "MyEbuyHotSalePage.h"

@protocol InterestProductsViewDelegate;

@interface InterestProductsView : UIView<MyEbuyHotSalePageDelegate,NJPageScrollViewDataSource,NJPageScrollViewDelegate>

@property (nonatomic,strong)  NJPageScrollView *scrollView;
@property (nonatomic,strong)  UIPageControl *pageControl;
@property (nonatomic,strong)  NSMutableArray *productList;
@property (nonatomic, weak) id  <InterestProductsViewDelegate>delegate;
@property (nonatomic, strong) UILabel  *infoLabel;


- (void)showIntrestedProductView:(NSMutableArray *)productList;

@end


@protocol InterestProductsViewDelegate <NSObject>

- (void)didSelectIntrestProduct:(DataProductBasic *)product;

@end