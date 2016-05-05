//
//  BoardingPersionListViewController.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardingInfoDTO.h"
#import "BoardingPersonCell.h"
#import "BoardingPersonDetailViewController.h"
#import "FlightInfoDTO.h"
#import "BoardingService.h"

@protocol BoardingPersionListViewControllerDelegate;


@interface BoardingPersionListViewController : CommonViewController<BoardingPersionCellDelegate,BoardingPersonDetailViewControllerDelegate
    ,BoardingDelegate>


@property (nonatomic, assign) BOOL            isLoaded;    //是否已经加载了联系人

@property (nonatomic,strong) NSMutableArray *personList;//请求获取的登机人列表，且不得超过9人

@property (nonatomic,strong) NSMutableArray *userChoosePersonList;//选中的登机人列表，传回到提交订单页面

@property (nonatomic,strong) FlightInfoDTO  *flightInfoDto;//主要从该对象中获取登机时间

@property (nonatomic,strong) BoardingService *boardingService;

@property (nonatomic,strong) id<BoardingPersionListViewControllerDelegate>  delegate;

//进入添加登机人信息页面
- (void)goToAddPersonPage;

-(void)filterSelectedBoarding:(NSMutableArray *)boardingList;

@end


@protocol BoardingPersionListViewControllerDelegate <NSObject>
//点击登机人列表到确定按钮后，该代理方法被执行，并将list传回给遵循该协议到类
-(void)returnUserChoosePersonList:(NSMutableArray *)list;
@end