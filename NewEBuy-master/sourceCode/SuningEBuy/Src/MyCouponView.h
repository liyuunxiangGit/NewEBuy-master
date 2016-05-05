//
//  MyCouponView.h
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kLeftButtonNomalImage       @"search_segment_left_nomal.png"
#define kLeftButtonHightlightImage  @"search_segment_left_hightlight.png"

#define kRightButtonNomalImage      @"search_segment_right_nomal.png"
#define kRightButtonHightlightImage @"search_segment_right_hightlight.png"

@interface MyCouponView : UIView


@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UILabel *desLabel;
@property (nonatomic,strong) UIView *loadMoreView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UISegmentedControl *segCate;
@end
