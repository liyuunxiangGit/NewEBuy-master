//
//  LotteryOrderDetailViewController.h
//  SuningEBuy
//
//  Created by david on 12-7-3.
//  Copyright (c) 2012年 sn. All rights reserved.
//

#import "CommonViewController.h"
#import "LotteryOrderDetailDto.h"
#import "LotteryOrderDetailService.h"
#import "ArrangeListViewController.h"
#import "SevenStarsListViewController.h"
#import "PageRefreshTableViewController.h"
#import "LotteryHallService.h"
#import "CouponService.h"

@interface LotteryOrderDetailViewController : PageRefreshTableViewController<LotteryOrderDetailServiceDelegate,LotteryHallDelegate,ArrangeListViewControllerDelegate,CouponServiceDelegate>{
    
    LotteryOrderDetailService         *_orderService;
    
    BOOL                            _isCustomLotteryList;            //YES 购彩订单  NO 追号订单
    
}

@property (nonatomic, strong) LotteryHallService                *lotteryHallService;
@property (nonatomic ,strong) CouponService    *couponService;

//dto: 追号订单DTO：FollowPerodDetailDto 或 代购订单DTO：TradeOrderDetailDto
- (id)initWithListDto:(id)dto isCustomLotteryList:(BOOL)yesOrNo;

//projid : 游戏编号  gid : 方案编号
- (id)initWithProjId:(NSString *)projid gid:(NSString *)gid isCustomLotteryList:(BOOL)yesOrNo;

@end
