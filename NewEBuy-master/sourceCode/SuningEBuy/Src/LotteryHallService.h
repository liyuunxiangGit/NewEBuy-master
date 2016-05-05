//
//  LotteryHallService.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@protocol LotteryHallDelegate <NSObject>

@optional

- (void) lotteryHallRequestCompletedWithResult:(NSMutableArray *)lotteryCatList 
                             andLotreryAllList:(NSMutableArray *)lotteryAllList
                                     isSuccess:(BOOL)isSuccess errorCode:(NSString *)errorCode;

@end

@interface LotteryHallService : DataService
{
    HttpMessage           *_lotteryHallHttpMsg;
    
    BOOL                  _isLoaded;
    
    NSMutableArray        *_lotteryCatArray;
    
    NSMutableArray        *_lotteryAllArray;
    
    id<LotteryHallDelegate> __weak _delegate;
}


@property (nonatomic,strong)HttpMessage       *lotteryHallHttpMsg;

@property (nonatomic,strong)NSMutableArray    *lotteryCatArray;

@property (nonatomic,strong)NSMutableArray    *lotteryAllArray;

@property (nonatomic, weak)id<LotteryHallDelegate> delegate;

- (void)sendLotteryHallInfoHttpRequest;

- (void)sortLotteryList;

@end
