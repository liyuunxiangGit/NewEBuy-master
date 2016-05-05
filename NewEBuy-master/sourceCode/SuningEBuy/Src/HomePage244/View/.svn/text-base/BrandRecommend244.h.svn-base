//
//  BrandRecommend244.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  品牌推荐楼层对应的view

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "HomeModuleDTO.h"
#import "HomeFloorTableViewCell.h"

@interface BrandRecommend244 : UIView <UIScrollViewDelegate, EGOImageViewExDelegate>{

    UIScrollView        *brandScrollView;
    UIPageControl       *pageControl;
}


@property (nonatomic, strong) UILabel             *titleLabel;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIView *titleBackgourdView;
@property (nonatomic, strong) HomeFloorDTO *floorDTO;
@property (nonatomic, assign) id<HomeFloorTableViewCellDelegate> delegate;

- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;
@end
