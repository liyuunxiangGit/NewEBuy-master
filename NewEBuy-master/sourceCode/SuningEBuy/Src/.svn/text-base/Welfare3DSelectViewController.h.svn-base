//
//  Welfare3DSelectViewController.h
//  SuningLottery
//
//  Created by jian  zhang on 12-9-24.
//  Copyright (c) 2012年 suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BallSelectConstant.h"
#import "Welfare3DTypeSelectView.h"
#import "Welfare3DBottomView.h"
#import "LotterySelectTopView.h"
#import "LotteryHallDto.h"
#import "Welfare3DBallChooseView.h"
#import "Welfare3DListViewController.h"
#import "LotteryMotionControl.h"

@interface Welfare3DSelectViewController : CommonViewController<Welfare3DTypeSelectViewDelegate,Welfare3DBottomViewDelegate,Welfare3DBallChooseViewDelegate,Welfare3DListViewControllerDelegate>{
    
}

@property (nonatomic, strong) Welfare3DTypeSelectView    *welfare3DTypeSelectView;

@property (nonatomic, strong) LotteryHallDto             *lotteryHallDTO;

@property (nonatomic, strong) NSMutableArray             *lotteryList;

@property (nonatomic, strong) NSMutableArray             *welfare3DArray;

//@property (nonatomic, retain) NSMutableDictionary        *numberBufferDic;//缓存字典

@property (nonatomic, strong) NSString                   *multiNo;

@property (nonatomic, strong) NSString                   *period;

@property(nonatomic,assign)   BOOL                    isFromOrder;

@property (nonatomic, strong)  LotteryMotionControl        *motionControl;

@end

