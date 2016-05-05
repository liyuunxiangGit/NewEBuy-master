//
//  CouponService.h
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "SubmitLotteryDto.h"
#import "CouponModel.h"
#import "ConfirmBetInfoModel.h"
#import "LotteryDealsDto.h"

@class CouponService;

@protocol  CouponServiceDelegate<NSObject>

@optional
- (void)couponQueryFinished:(CouponService *)service withInfoArray:(NSArray *)infoArray;
- (void)couponUserQueryFinished:(CouponService *)service withUserInfo:(ConfirmBetInfoModel *)info;
- (void)couponCheckFinished:(CouponService *)service withInfoArray:(NSArray *)infoArray
                    errCode:(NSInteger)errCode
                     errStr:(NSString *)errStr;
- (void)goToPayUrl:(CouponService *)service payUrl:(NSString *)payUrl;
- (void)cancelCouponSuccess:(CouponService *)service success:(BOOL)success;

@end

@interface CouponService : DataService

@property (nonatomic, weak) id  <CouponServiceDelegate>delegate;

- (void)couponQueryWithSubmitLotteryDto:(SubmitLotteryDto *)lotteryDto;

- (void)fetchUserDetailInfo;

- (void)checkCouponWithSubmitLotteryDto:(SubmitLotteryDto *)lotteryDto couponCode:(NSString *)code;

- (void)payRemainMenoyWith:(LotteryDealsDto *)dealDto;

- (void)cancelCoupon:(LotteryDealsDto *)dealDto;

@end
