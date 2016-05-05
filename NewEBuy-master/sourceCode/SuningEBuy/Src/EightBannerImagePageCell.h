//
//  HomeRootTopScrollPageCell.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "NJPageScrollViewCell.h"


@class HomeTopScrollAdDTO;
@protocol EightBannerImagePageCellDelegate;

@interface EightBannerImagePageCell : NJPageScrollViewCell <EGOImageViewExDelegate>
{
    @private
    HomeTopScrollAdDTO   *_adDTO;
    id<EightBannerImagePageCellDelegate> __weak _delegate;
}

@property (nonatomic, weak) id<EightBannerImagePageCellDelegate> delegate;

- (void)setItem:(HomeTopScrollAdDTO *)ad;

@end


@protocol EightBannerImagePageCellDelegate <NSObject>

- (void)didSelectAd:(HomeTopScrollAdDTO *)ad;

@end