//
//  SegmentedView.h
//  SuningEBuy
//
//  Created by xingxianping on 13-8-23.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentBtnClickedDelegate;

@interface SegmentedView : UIView

@property (nonatomic,weak) id<SegmentBtnClickedDelegate> delegate;

@property (nonatomic,strong) UIButton *leftBtn;

@property (nonatomic,strong) UIButton *middleBtn;

@property (nonatomic,strong) UIButton *rightBtn;

@property (nonatomic,assign) NSInteger selectNum;

-(void)selectLeftBtn;

@end

@protocol SegmentBtnClickedDelegate <NSObject>

- (void)requestWithSegmentBtnClicked:(NSInteger) state;

@end