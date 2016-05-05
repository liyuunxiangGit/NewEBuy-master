//
//  SevenLeSelectViewController.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-4.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LotteryHallDto.h"
#import "BallSelectConstant.h"
#import "SevenLeTopView.h"
#import "SevenLeSelectBallView.h"
#import "SevenLeBottomView.h"
#import "SevenLeListViewController.h"
#import "LotteryMotionControl.h"

@interface SevenLeSelectViewController : CommonViewController<SevenLeSelectBallViewDelegate,SevenLeBottomViewDelegate,SevenLeListViewControllerDelegate,SevenLeListViewControllerDelegate,UIAccelerometerDelegate>
{
    NSInteger    maxBallCount_;
    
    NSInteger    minBallCount_;
    
    NSInteger    totalBallCount_;
    
    BOOL         isEditing_;
    
    BOOL         isFromList_;
    
    NSInteger    editIndex_;
    
    int                     _listNumber;           //单倍投注列表总注数
    
}

@property (nonatomic, strong)   LotteryHallDto        *lotteryHallDto;
@property (nonatomic, strong)   SevenLeTopView        *topView;
@property (nonatomic, strong)   SevenLeSelectBallView *selectBallView;
@property (nonatomic, strong)   SevenLeBottomView     *bottomView;
@property (nonatomic, strong)    NSMutableArray       *submitList;

//投注结果列表
@property (nonatomic, strong)NSMutableArray           *lotteryList;

@property (nonatomic, assign)BOOL                     isFromOrder;

@property (nonatomic, assign) int                        multiNo;//投注倍数
 
@property (nonatomic, assign) int                     periods;

@property (nonatomic, copy)NSString                   *leftBetNo;//当前投注的总金额。
//选中的球列表
@property (nonatomic, strong)NSMutableArray           *ballArray;

/** motion */
@property (nonatomic, strong) LotteryMotionControl *motionControl;
@end
