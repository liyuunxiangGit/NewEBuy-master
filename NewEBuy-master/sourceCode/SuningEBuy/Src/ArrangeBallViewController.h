//
//  ArrangeBallViewController.h
//  SuningLottery
//
//  Created by yangbo on 4/3/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrangeBallSelectView.h"
#import "LotterySelectTopView.h"
#import "ArrangeSelectBottomView.h"
#import "ArrangeListViewController.h"
#import "LotteryOrderListDTO.h"
#import "LotteryMotionControl.h"

@protocol ArrangeBallViewControllerDelegate <NSObject>

@optional

- (void)quitWithLastSelectionType:(LotterySelectionType)subType;

@end

@interface ArrangeBallViewController : CommonViewController <ArrangeSelectBottomViewDelegate,ArrangeBallSelectViewDelegate,ArrangeListViewControllerDelegate,UIAccelerometerDelegate>
{
    LotterySelectTopView        *_lotterySelectTopView;
    
    ArrangeBallSelectView       *_arrangeBallSelectView;
    
    ArrangeSelectBottomView     *_arrangeSelectBottomView;
        
    LotteryHallDto                *_lotteryHallDto;
    
    LotteryOrderListDTO          *_lotteryOrderListDto;
    
    NSInteger                       _index;
    
    BOOL                            _isFromOrder;

    id <ArrangeBallViewControllerDelegate> __weak _delegate;
}

@property (nonatomic, weak) id <ArrangeBallViewControllerDelegate> delegate;
/** motionControl */
@property (nonatomic, strong) LotteryMotionControl *motionControl;
//从彩票大厅进入 调用此方法
- (id)initWithLotteryType:(LotteryType)type subType:(LotterySelectionType)subType hallDTO:(LotteryHallDto *)dto isFromOrder:(BOOL)yesOrNo;

//从订单详情进入 调用此方法
- (id)initWithLotteryListDto:(LotteryOrderListDTO *)listDto index:(NSInteger)index hallDto:(LotteryHallDto *)dto isFromOrder:(BOOL)yesOrNo;
@end
