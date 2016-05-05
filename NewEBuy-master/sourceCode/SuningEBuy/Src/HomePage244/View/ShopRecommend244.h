//
//  ShopRecommend244.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-17.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  首页楼层里的店铺推荐楼层

#import <UIKit/UIKit.h>
#import "HomeFloorDTO.h"
#import "HomeModuleDTO.h"
#import "HomeFloorTableViewCell.h"
@interface ShopRecommend244 : UIView <UIScrollViewDelegate, EGOImageViewExDelegate>{
    
    UIScrollView        *shopScrollView;
    UIPageControl       *shopPageControl;
}

@property (nonatomic, strong) UILabel *titleName;
@property (nonatomic, strong) UIButton *moreButton;
@property (nonatomic, strong) UIView *labelBackgroundView;
@property (nonatomic, strong) HomeFloorDTO *floorDTO;
@property (nonatomic, assign) id<HomeFloorTableViewCellDelegate> delegate;


- (void)updateViewWithFloorDTO:(HomeFloorDTO *)dto;

@end
