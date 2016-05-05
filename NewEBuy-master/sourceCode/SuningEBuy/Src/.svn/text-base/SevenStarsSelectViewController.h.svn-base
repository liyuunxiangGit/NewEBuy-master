//
//  SevenStarsSelectViewController.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-3.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import "CommonViewController.h"
#import "LotteryHallDto.h"
#import "LotteryRuleViewController.h"
#import "SevenStarsListViewController.h"
#import "LotterySelectTopView.h"
#import "SevenStarsChooseView.h"
#import "SevenStarsBottomView.h"
#import "LotteryMotionControl.h"

@interface SevenStarsSelectViewController : CommonViewController<SevenStarsListViewControllerDelegate,SevenStarsChooseViewDelegate,SevenStarsBottomViewDelegate>
{
    LotterySelectTopView     *topInfoView_;
     
    SevenStarsChooseView     *ballChooseSheet_;
    
    SevenStarsBottomView     *bottomOperationView_;
    
    NSInteger                 shakeTimes_;           //摇晃次数
    
    BOOL                      isEditing_;             //是否是编辑状态
    
    NSInteger                 editIndex_;             //投注号码编号
}
@property (nonatomic, strong)            LotteryHallDto                  *lotteryHallDto;
@property (nonatomic, strong)            NSMutableArray         *selectionSheetArray;
@property (nonatomic, strong)            LotterySelectTopView            *topInfoView;
@property (nonatomic, strong)            SevenStarsChooseView   *ballChooseSheet;
@property (nonatomic, strong)            SevenStarsBottomView   *bottomOperationView;
@property (nonatomic, strong)            LotteryMotionControl        *motionControl;
@property (nonatomic, assign)            BOOL                   isFromOrder;
@end
