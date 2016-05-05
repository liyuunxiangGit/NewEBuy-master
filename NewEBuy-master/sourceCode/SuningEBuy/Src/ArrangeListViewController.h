//
//  ArrangeListViewController.h
//  SuningLottery
//
//  Created by yangbo on 4/7/13.
//  Copyright (c) 2013 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallNumberDTO.h"
#import "SubmitLotteryDto.h"
#import "LotteryListFootView.h"
#import "LotteryHallDto.h"
#import "LotteryProtocolCell.h"
#import "LotteryOrderListDTO.h"
#import "CouponService.h"

@class ArrangeListViewController;

@protocol  ArrangeListViewControllerDelegate<NSObject>

@optional
/*
 修改某个投注方案
 index : 修改的投注方案在array中的index
 array : 当前的所有投注方案
 multiple:投注倍数
 */
- (void)arrangeListViewController:(ArrangeListViewController *)controller
        changedBallNumberDtoIndex:(int)index
           andLotteryOrderListDto:(LotteryOrderListDTO *)dto;

//点击手选一注按钮
- (void)goToSelectNewNumberWithArrangeListViewController:(ArrangeListViewController *)controller
                                    andLotteryOrderListDto:(LotteryOrderListDTO *)dto;

@required
//点击返回按钮
- (void)goBackWithArrangeListViewController:(ArrangeListViewController *)controller
                     andLotteryOrderListDto:(LotteryOrderListDTO *)dto;

@end

@interface ArrangeListViewController : CommonViewController <LotteryListFootViewDelegate,LotteryProtocolCellDelegate,CouponServiceDelegate>
{
    SubmitLotteryDto        *_submitLotteryDto;
    
    LotteryListFootView     *_lotteryFootView;
    
    LotteryOrderListDTO     *_lottertOrderListDto;
    
    LotteryHallDto          *_hallDto;
    
    BOOL                    _isChecked;             //是否勾选 已阅读并同意代购协议按钮 默认YES
    
    BOOL                    _isFromOrder;
    
    LotterySelectionType  _lastSelectionType;   //上次选号的玩法类型
    
    id <ArrangeListViewControllerDelegate>  __weak _delegate;
}
@property (nonatomic, weak) id <ArrangeListViewControllerDelegate> delegate;
@property (nonatomic, strong) LotteryOrderListDTO   *lottertOrderListDto;
@property (nonatomic, strong) LotteryHallDto *hallDto;
@property (nonatomic         ) LotterySelectionType lastSelectionType;
@property (nonatomic, strong) SubmitLotteryDto *submitLotteryDto;
@property(nonatomic,strong) CouponService       *couponService;

- (id)initWithLotteryHallDto:(LotteryHallDto *)lotteryHallDto andLotteryOrderListDto:(LotteryOrderListDTO *)dto isFromOrder:(BOOL)yesOrNo;

@end
