//
//  HotSaleProductScrollView.h
//  SuningEBuy
//
//  Created by robin wang on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeTopRecommendDTO.h"

@protocol HotSaleProductDelegate;

@interface HotSaleProductScrollView : UIImageView <UIScrollViewDelegate>


@property (nonatomic, strong) NSArray        *hotSaleProductList;

@property (nonatomic, weak) id<HotSaleProductDelegate>   delegate;

- (void)correctImageOffsetWithScrollCenter;

@end


@protocol HotSaleProductDelegate <NSObject>

@required

- (void)hotSaleScrollView:(HotSaleProductScrollView *)scrollView didSelectedProduct:(HomeTopRecommendDTO *)hotSaleItem;

@end