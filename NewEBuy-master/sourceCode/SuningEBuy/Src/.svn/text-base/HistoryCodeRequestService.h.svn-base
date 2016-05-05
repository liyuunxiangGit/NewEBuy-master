//
//  HistoryCodeRequestService.h
//  SuningLottery
//
//  Created by yang yulin on 13-4-16.
//  Copyright (c) 2013年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"

@protocol HistoryCodeRequestServiceDelegate;

@interface HistoryCodeRequestService : DataService
{
    HttpMessage      *_historyCodeMSG;
}
@property (nonatomic, weak) id<HistoryCodeRequestServiceDelegate> delegate;

@property (nonatomic, strong) NSString *lotteryId;        // 彩种ID

@property (nonatomic, strong) NSString *historyCodeErrorMsg;

@property (nonatomic, strong)  NSMutableArray *historyCodeList;      // 保存历史开奖号码

@property (nonatomic, copy)    NSString *errorCode;                  // 错误码

@property (nonatomic, copy)    NSString *errorDesc;                  // 错误信息

- (void)sendHistoryCodeRequest:(NSString *)lotteryId;

@end


@protocol HistoryCodeRequestServiceDelegate <NSObject>

- (void)historyCodeRequestServiceComplete:(HistoryCodeRequestService *)service isSuccess:(BOOL)isSuccess;

@end
