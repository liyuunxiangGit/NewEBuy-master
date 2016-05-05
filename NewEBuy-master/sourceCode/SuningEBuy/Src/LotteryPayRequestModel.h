//
//  LotteryPayRequestModel.h
//  SuningLottery
//
//  Created by jian  zhang on 12-7-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"
#import "SubmitLotteryDto.h"

@protocol LotteryPayRequestDelegate;

@interface LotteryPayRequestModel : DataService

@property (nonatomic, weak) id<LotteryPayRequestDelegate>   delegate;

@property (nonatomic, strong) NSDictionary                    *items;

@property (nonatomic, assign) BOOL  isSuccess;

- (void)beginFetchLotteryPayWithDto:(SubmitLotteryDto *)lotteryDto 
                          PassWord :(NSString *)psw;


@end

@protocol LotteryPayRequestDelegate <NSObject>

@required

- (void)lotteryPayRequestOK:(NSDictionary *)items;

@end
