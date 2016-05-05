//
//  SevenLeListViewController.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-8.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "LotteryListFootView.h"
#include "SubmitLotteryDto.h"
#import "LotteryHallDto.h"
#import "LotteryProtocolCell.h"
#import "CouponService.h"

@protocol SevenLeListViewControllerDelegate;



@interface SevenLeListViewController : CommonViewController<LotteryListFootViewDelegate,LotteryProtocolCellDelegate,UINavigationBarDelegate,CouponServiceDelegate>{
    
    id<SevenLeListViewControllerDelegate>   __weak delegate;
    
    BOOL                                    isShouldAlertMessage;//该标识位用于  当用户选择的注数过多时，删除时列表中的一项，不弹出提示框
    
    int                     _multiple;              //倍数
    
    int                     _periods;               //追号期数
    
    BOOL                    _isStopBuyWhenWin;      //中奖后是否停止追号
    
    int                     _listNumber;           //单倍投注列表总注数
    
    int                     _totalListNumber;        //多倍多期投注的总注数
    
    int                    _buyMoney;             //投注多倍多期彩票总金额
    
    NSString                *_titleString;
    
}

@property(nonatomic,assign) BOOL                isFromOrder;
@property(nonatomic,assign) BOOL                isFromLuck;
@property(nonatomic,assign) BOOL                isStopBuyWhenWin; //中奖后是否停止追号

@property(nonatomic,strong) NSMutableArray      *lotteryList;
@property(nonatomic,strong) UIView              *headerView;
@property(nonatomic,strong) UILabel             *timesLbl;//展示期次
@property(nonatomic,strong) LotteryListFootView     *footView;
@property (nonatomic,assign) int               multiple;
@property (nonatomic,assign) int               periods;;
@property(nonatomic,weak) id<SevenLeListViewControllerDelegate>delegate;
@property(nonatomic,strong) SubmitLotteryDto    *submitLotteryDto;
@property(nonatomic,strong) LotteryHallDto      *lotteryHallDto;
@property(nonatomic,assign) BOOL                isChecked;
@property(nonatomic,strong) UIView              *tableContainerView;
@property(nonatomic,strong) UINavigationBar     *navigationBar;
@property(nonatomic,strong) CouponService       *couponService;



- (id)initWIthTitle:(NSString *)title andLotteryTimes:(NSString *)lotteryTimes andEndTime:(NSString *)endTime;

@end


@protocol SevenLeListViewControllerDelegate <NSObject>
@optional
//编辑一行
-(void)returnUserEditLotteryCell:(NSMutableArray *)array andIndex:(NSInteger)index andMultiNo:(int)multiNo periods:(int)periods  andOnlyCouldChooseMoney:(CGFloat)money;
//删除一行
-(void)returnUserDeleteLotteryCell:(NSMutableArray *)array andMultiNo:(int)multiNo periods:(int)periods
           andOnlyCouldChooseMoney:(CGFloat)money;
//手选一注
-(void)returnUserAddLotteryCell:(NSMutableArray *)array andMultiNo:(int)multiNo periods:(int)periods
        andOnlyCouldChooseMoney:(CGFloat)money;
//刷新选球页面的倍数
-(void)returnUserChooseMulitNo:(int)multiNo;
//刷新选球页面的期数
- (void)returnUserChoosePeriods:(int)periods;
//刷新选球页面的单倍单期投注注数
- (void)returnUserChooseListNumber:(int)listNumber;

@end
