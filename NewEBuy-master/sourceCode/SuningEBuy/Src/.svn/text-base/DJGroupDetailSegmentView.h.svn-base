//
//  DJGroupDetailSegmentView.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#define kSegmentHeight               31

#define kAppraisalCount              @"kkAppraisal"

#import <UIKit/UIKit.h>

@protocol DJGroupDetailSegmentViewDelegate;

@interface DJGroupDetailSegmentView : UIView
{
@private
    NSInteger selectIndex_;
}

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) UIButton *leftButton;   //基本信息按钮
@property (nonatomic, strong) UIButton *middleButton; //商品介绍
@property (nonatomic, strong) UIButton *rightButton;  //评价

@property (nonatomic, strong) UIImageView *segmentBackView;

@property (nonatomic, weak) id<DJGroupDetailSegmentViewDelegate> delegate;
- (void)refreshButtons;

- (void)changekAppCount:(NSString *)count;
@end


@protocol DJGroupDetailSegmentViewDelegate <NSObject>

- (void)didSelectSegmentAtIndex:(NSInteger)index;

@end
