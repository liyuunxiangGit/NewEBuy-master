//
//  SevenStarsListViewController.h
//  SuningLottery
//
//  Created by lyywhg on 13-4-8.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallSelectConstant.h"
#import "LotteryHallDto.h"
#import "LotteryDataModel.h"
#import "SubmitLotteryDto.h"
#import "CommonViewController.h"
#import "LotteryProtocolCell.h"
#import "SevenStarsListCell.h"
#import "LotteryListFootView.h"
#import "LotteryOrderDetailViewController.h"
#import "LotteryProtocolViewController.h"
#import "LotteryPayPageViewController.h"
#import "CouponService.h"

@protocol SevenStarsListViewControllerDelegate;
@interface SevenStarsListViewController : CommonViewController<LotteryProtocolCellDelegate,LotteryListFootViewDelegate,CouponServiceDelegate>


@property (nonatomic, strong)    NSMutableArray      *lotteryList;
@property (nonatomic, strong)    LotteryHallDto      *lotteryhallDto;
@property (nonatomic, strong)    SubmitLotteryDto    *submitLotteryDto;
@property (nonatomic, strong)    UIView              *topView;
@property (nonatomic, strong)    LotteryListFootView *listFootView;
@property (nonatomic, strong)    UILabel             *endline;
@property (nonatomic, strong)    UIView              *tableContainerView;
@property (nonatomic, copy)      NSString            *multiNo;
@property (nonatomic, copy)      NSString            *totalLottery;     //彩票总数  不包含倍数、期数乘积
@property (nonatomic, copy)      NSString            *totalMoney;      //总钱数
@property (nonatomic, copy)      NSString            *periods;         //期数
@property (nonatomic, assign)      BOOL              isBuyWhenWin;    //是否继续跟期 在选中之后
@property (nonatomic, assign)      BOOL              isChecked;       //是否同意协议
@property (nonatomic, assign)      BOOL              isFromOrder;     //是否从详情界面来
@property(nonatomic,strong) CouponService       *couponService;
@property (nonatomic , strong) NSMutableArray *ballInfoArray;

@property (nonatomic, weak)    id<SevenStarsListViewControllerDelegate> delegate;

- (id)initWithLotteryTimes:(NSString *)lotteryTimes andEndTime:(NSString *)endTime;
- (void)decodeSubmitCodes:(NSString *) codes;
@end

@protocol SevenStarsListViewControllerDelegate <NSObject>

//刷新选球页面的倍数
-(void)returnUserChooseMulitNo:(NSString *)multiNo andPeriods:(NSString *) period;
 
//增加一注一注   isauto:yes 表示机选  no表示手选
-(void)returnUserAddLotteryCell:(NSMutableArray *)array andMultiNo:(NSString *)multiNo andPeriods:(NSString *) period
andOnlyCouldChooseMoney:(CGFloat)money isAuto:(BOOL) isAuto;

//删除一行
-(void)returnUserDeleteLotteryCell:(NSMutableArray *)array andMultiNo:(NSString *)multiNo andPeriods:(NSString *) period
           andOnlyCouldChooseMoney:(CGFloat)money;

//编辑一行
-(void)returnUserEditLotteryCell:(NSMutableArray *)array andIndex:(NSInteger)index andMultiNo:(NSString *)multiNo andPeriods:(NSString *) period
         andOnlyCouldChooseMoney:(CGFloat)money;
@end
