//
//  EightBannerView.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJPageScrollView.h"
#import "EightBannerImagePageCell.h"
#import "MyPageControl.h"
#import "HomePageControlView.h"

typedef enum {
    
    ScrollDragBegin     = 0,    // 拖动开始
    
    ScrollDragEnd               // 拖动结束
    
} ScrollDragState;

@protocol EightBannerImagePageCellClickDelegate; 

@interface EightBannerView : UIView <UIScrollViewDelegate>
{
    NSInteger                                 _currentPage;
    
    id<EightBannerImagePageCellClickDelegate> __weak _delegate;
    
    UIScrollView  *_scrollView;
    
    HomePageControlView     *_pageControl;
    
    NSMutableArray *_imagesArray;               // 存放所有需要滚动的图片 UIImage
    
    NSMutableArray *_curImages;          // 存放当前滚动的三张图
    
    int totalPage;
}

@property (nonatomic, weak) id<EightBannerImagePageCellClickDelegate> delegate;

@property (nonatomic, strong) UIScrollView  *scrollView;

@property (nonatomic, strong) HomePageControlView     *pageControl;

@property (nonatomic, strong) NSArray           *topBannerList;

@property (nonatomic, strong) NSMutableArray    *imagesArray;

@property (nonatomic, strong) NSMutableArray    *curImages;

@property (nonatomic, strong) EGOImageViewEx    *bgImageView;

- (void)updateTopBanner:(NSArray *)topBannerArray;

- (void)changePage:(id)sender;

@end


@protocol EightBannerImagePageCellClickDelegate <NSObject>

@optional

- (void)didClickAd:(HomeTopScrollAdDTO *)dto;

@optional
- (void)cycleScrollViewDelegate:(EightBannerView *)cycleScrollView didSelectImageView:(int)index;
@optional

- (void)cycleScrollViewDelegate:(EightBannerView *)cycleScrollView didScrollImageView:(int)index;

@optional
// 改变定时器状态
- (void)advertisementView:(EightBannerView *)advertisementView willChangeDragState:(ScrollDragState)dragState;
@end

