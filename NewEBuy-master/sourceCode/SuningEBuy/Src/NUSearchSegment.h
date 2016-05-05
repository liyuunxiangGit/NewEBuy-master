//
//  NUSearchSegment.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-4-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NUSearchSegmentDelegate;

@interface NUSearchSegment : UIImageView
{
    @private
    NSInteger selectIndex_;
}

@property (nonatomic, assign) NSInteger selectIndex;

@property (nonatomic, strong) UIButton *leftButton;   //热门搜索按钮
@property (nonatomic, strong) UIButton *rightButton;  //最近搜索按钮
@property (nonatomic, strong) UIButton *middleButton; //最近浏览按钮 add by wangjiaxing 20130516
@property (nonatomic, strong) UIImageView   *lineView;

@property (nonatomic, weak) id<NUSearchSegmentDelegate> delegate;
- (void)refreshButtons;

@end


@protocol NUSearchSegmentDelegate <NSObject>

- (void)didSelectSegmentAtIndex:(NSInteger)index;

@end