//
//  LotteryPayRequestService.h
//  SuningEBuy
//
//  Created by cui zl on 13-6-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LotteryPayRequestService;

@protocol LotteryPayRequestServiceDelegate <NSObject>

-(void)getLotteryPayCompletionWithResult:(BOOL)isSussecc
                                 Service:(LotteryPayRequestService*)service;


@end

@interface LotteryPayRequestService : DataService
{
    HttpMessage  *lotteryPayHttpMsg;
    HttpMessage  *balanceCheckHttpMsg;
}

@property (nonatomic, weak) id<LotteryPayRequestServiceDelegate>     delegate;

@property (nonatomic, strong) NSDictionary   *items;

@property (nonatomic, copy) NSString *lotteryPayErrorMsg;

@property (nonatomic, copy) NSString   *unLoginErrorCode;     //session失效返回

- (void)beginLotteryPay:(NSDictionary *)postDic;

@end
