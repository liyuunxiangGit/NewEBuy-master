//
//  EightBannerView244.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//   八连版视图，支持2-8张图片连续滚动显示

#import <UIKit/UIKit.h>
#import "PageControlView244.h"
#import "SNUIImageView.h"
#import "UIImageView+WebCache.h"
#import "HOmefloorDTO.h"
#import "HomeModuleDTO.h"

@protocol EightBannerViewDelegate <NSObject>

//- (void)eightBannerSelectedIndex:(int)selectIndex;

- (void)eightBannerSelectedDTO:(HomeModuleDTO *)moduleDTO;

@end

@interface EightBannerView244 : UIView <UIScrollViewDelegate>{
    
    UIScrollView    *imageScrollView;
    
    //dto数据源
    NSMutableArray         *dtoArray;
    
    NSTimer         *imageScrollTimer;
    
    //当前
    int             selectedImageIndex;
    
    //scroll需要展示的3个dto
    NSMutableArray         *scrollDataArray;
    
    //此楼层在首页中得楼层顺序
    NSString  *floorOrderNO;
}


//@property (nonatomic, strong) PageControlView244     *pageControlView;
@property (nonatomic, assign) id <EightBannerViewDelegate>  delegate;
@property (nonatomic, strong) UIPageControl     *pageControl;


/**
 *  依据数据源，更新界面
 *
 *  @param array dto数组
 */
- (void)updateViewWithDTO:(HomeFloorDTO *)dto;

- (void)invalidTimer;
@end
