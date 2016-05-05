//
//  LottertSelectViewController.h
//  SuningEBuy
//
//  Created by shasha on 12-6-28.
//  Copyright (c) 2012年 warmshare_shasha@sina.com. All rights reserved.
//

#import "LotterySelectBallView.h"
#import "LotteryHallDto.h"
#import "LotterySelectBottomView.h"
#import "LotteryListViewController.h"



@interface LottertSelectViewController :CommonViewController<LotterySelectBallViewDelegate,LotterySelectBottomViewDelegate,LotteryListViewControllerDelegate,UIAccelerometerDelegate>
{
    int                     _listNumber;           //单倍投注列表总注数
}

@property(nonatomic,strong)LotteryHallDto         *lotteryHallDTO;

@property(nonatomic,strong)NSMutableArray         *submitList;

//结果列表
@property(nonatomic,strong)NSMutableArray         *lotteryList;

@property(nonatomic,assign)BOOL                    isFromOrder;

@property(nonatomic,assign) int                    multiNo;//投注倍数

@property(nonatomic,assign) int                    periods;//追号期数

@property(nonatomic,copy)NSString                  *leftBetNo;//当前投注的总金额。


@end
