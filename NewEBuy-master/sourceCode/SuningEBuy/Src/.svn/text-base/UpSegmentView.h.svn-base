//
//  UpSegmentView.h
//  SuningEBuy
//
//  Created by xingxianping on 13-8-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UpSegmentDelegate;

@interface UpSegmentView : UIView

@property (nonatomic, strong) UIButton *leftButton;

@property (nonatomic, strong) UIButton *rightButton;

@property (nonatomic, strong) UIImageView *backgroundImage;

@property (nonatomic, weak) id<UpSegmentDelegate> delegate;

@property (nonatomic, strong) UILabel * desLabel;

@property (nonatomic, assign) NSInteger index;

- (void)refreshButtons;
@end

@protocol UpSegmentDelegate <NSObject>

- (void)buttonClickedAtIndex:(NSInteger )index;

@end