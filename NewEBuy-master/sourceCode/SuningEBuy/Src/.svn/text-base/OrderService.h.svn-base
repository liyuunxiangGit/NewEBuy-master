//
//  LotteryOrderListService.h
//  SuningLottery
//
//  Created by MagicStudio on 12-7-30.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CommonViewController.h"
#import "LotteryDealsDto.h"
#import "LotteryDealsSerialNumberDto.h"

@protocol OrderServiceDelegate;

@interface OrderService : DataService
{
    HttpMessage                     *lotteryDealListMSG;
    HttpMessage                     *lotteryDealsSerialNumberListMSG;    
}

@property (nonatomic, weak)  id<OrderServiceDelegate>   delegate;
@property (nonatomic, strong)  NSMutableArray             *orderList;           //订单列表
@property (nonatomic, copy)    NSString                   *pageCount;           //页面计数

@property (nonatomic, copy)    NSString       *unLoginErrorCode;    //session失效

@property (nonatomic, assign)  NSInteger       totalPages;
@property (nonatomic, assign) BOOL isAddRightItem;


/*
 *发送代购彩票订单列表请求 （全部/中奖）
 *参数一个字典型参数
 */
-(void)sendLotteryDealListHttpRequest:(NSDictionary *) postDic;

/*
 *发送追号彩票订单列表请求 （全部/中奖）
 *参数一个字典型参数
 */
-(void)sendLotteryDealsSerialNumberListHttpRequest:(NSDictionary *)postDic;

@end

@protocol OrderServiceDelegate <NSObject>

@optional

- (void)lotteryDealListHttpComplete:(BOOL)isSuccess;

- (void)lotteryDealsSerialNumberListHttpComplete:(BOOL)isSuccess;

@end

