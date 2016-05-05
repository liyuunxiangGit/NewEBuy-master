//
//  LotteryHallViewController.h
//  SuningEBuy
//
//  Created by 漫 王 on 12-8-30.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"

#import "LotteryHallService.h"
#import "UserLoginService.h"
#import "PageRefreshTableViewController.h"


@interface LotteryHallViewController : PageRefreshTableViewController<LotteryHallDelegate,UserLoginServiceDelegate>
{
    NSMutableArray        *_lotteryCatArray;
    
    NSMutableArray        *_lotteryAllArray;
    
    LotteryHallService    *_service;
    
    NSString              *_systemDate;
    
    
    BOOL                isLoad;//是否加载过了 
    
    BOOL                isLoginOk;

}

@property (nonatomic, strong)NSMutableArray        *lotteryCatArray;

@property (nonatomic, strong)NSMutableArray        *lotteryAllArray;

@property (nonatomic, strong)LotteryHallService    *service;

@property (nonatomic, strong)NSString              *systemDate;

@property (nonatomic, assign)BOOL                  isLoaded; 

@property (nonatomic, strong) UserLoginService     *userOperation;

- (void)sortLotteryList;

- (BOOL)isOpenLottery;

@end
