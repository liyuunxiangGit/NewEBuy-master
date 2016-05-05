//
//  MyEbuyHotSalePage.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NJPageScrollViewCell.h"

@protocol MyEbuyHotSalePageDelegate;
@class DataProductBasic;

@interface MyEbuyHotSalePage : NJPageScrollViewCell
{
    NSArray *_hotSaleList;
    
    NSRange _range;
}

@property (nonatomic, weak) id<MyEbuyHotSalePageDelegate> delegate;

- (void)setItem:(NSArray *)itemList range:(NSRange)range;

@end


@protocol MyEbuyHotSalePageDelegate <NSObject>

- (void)didSelectHotSaleProduct:(DataProductBasic *)product;

@end