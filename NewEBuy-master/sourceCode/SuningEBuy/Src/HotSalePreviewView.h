//
//  HotSalePreviewView.h
//  SuningEBuy
//
//  Created by robin wang on 4/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeTopRecommendDTO.h"
#import "HotSaleProductScrollView.h"

@interface HotSalePreviewView : UIView <HotSaleProductDelegate>


@property (nonatomic, strong) NSArray        *hotSaleProductList;

- (void)reloadHotSaleList:(NSArray *)hotSaleList;

- (void)reloadPreviewView:(HomeTopRecommendDTO *)hotSaleItem;

@end
