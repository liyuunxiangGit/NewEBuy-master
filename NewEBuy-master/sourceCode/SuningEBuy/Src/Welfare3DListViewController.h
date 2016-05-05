//
//  Welfare3DListViewController.h
//  SuningLottery
//
//  Created by jian  zhang on 12-9-26.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "SubmitLotteryDto.h"
#import "LotteryHallDto.h"
#import "LotteryProtocolCell.h"
#import "Welfare3DListCell.h"
#import "LotteryListFootView.h"
#import "CouponService.h"

@protocol Welfare3DListViewControllerDelegate;



@interface Welfare3DListViewController : CommonViewController<LotteryListFootViewDelegate,LotteryProtocolCellDelegate,UINavigationBarDelegate,CouponServiceDelegate>{
    
    id<Welfare3DListViewControllerDelegate>   __weak delegate;
    
    BOOL                                    isShouldAlertMessage;//该标识位用于  当用户选择的注数过多时，删除时列表中的一项，不弹出提示框
    NSString                                *_titleString;
}

@property(nonatomic,assign) BOOL                isFromOrder;
@property(nonatomic,assign) BOOL                isFromLuck;
@property(nonatomic,assign) int                 selectBallType;

@property(nonatomic,strong) NSMutableArray      *lotteryList;
@property(nonatomic,strong) UIView              *headerView;
@property(nonatomic,strong) UILabel             *timesLbl;//展示期次
@property(nonatomic,copy)   NSString            *multiNo;    //倍数
@property(nonatomic,copy)   NSString            *totalLottery;//彩票总注数
@property(nonatomic,copy)   NSString            *totalMoney;    // 多倍彩票总金额
@property(nonatomic,copy)   NSString            *period;      //期数
@property(nonatomic,assign) BOOL                isBuyWin;     //中奖追号后是否

@property(nonatomic,weak) id<Welfare3DListViewControllerDelegate>delegate;
@property(nonatomic,strong) SubmitLotteryDto    *submitLotteryDto; 
@property(nonatomic,strong) LotteryHallDto      *lotteryHallDto; 
@property(nonatomic,assign) BOOL                isChecked;
@property(nonatomic,strong) UIView              *tableContainerView;
@property(nonatomic,strong) UINavigationBar     *navigationBar;
@property(nonatomic, strong)LotteryListFootView *footView;
@property(nonatomic,strong) CouponService       *couponService;


- (id)initWIthTitle:(NSString *)title andLotteryTimes:(NSString *)lotteryTimes andEndTime:(NSString *)endTime;

@end


@protocol Welfare3DListViewControllerDelegate <NSObject>
@optional
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
