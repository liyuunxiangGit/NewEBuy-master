//
//  ConfirmBetInfoAndCouponViewController.h
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "SubmitLotteryDto.h"
#import "CouponService.h"
#import "CouponInfoCell.h"

@interface ConfirmBetInfoAndCouponViewController : PageRefreshTableViewController <CouponServiceDelegate,CouponInfoCellDelegate>
@property (nonatomic ,strong) SubmitLotteryDto *submitDto;
@property (nonatomic ,strong) ConfirmBetInfoModel *betInfo;
@property (nonatomic ,strong) CouponService    *couponService;
@property (nonatomic ,strong) NSArray          *couponInfoArray;
@property (nonatomic ,strong) NSArray          *useCouponArray;
@property (nonatomic ,strong) NSDictionary     *userInfoDic;
@property (nonatomic , copy) NSString          *checkCouponCode;
@property (nonatomic ,strong) NSMutableArray   *ballInfoArray;
@end
