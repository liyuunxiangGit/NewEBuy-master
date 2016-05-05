//
//  NewGetRedPackEntryViewController.h
//  SuningEBuy
//
//  Created by sn－wahaha on 14-9-22.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "SNShareKit.h"
#import "ChooseShareWayView.h"
#import "InvitationService.h"

@interface NewGetRedPackEntryViewController : CommonViewController<ChooseShareWayViewDelegate>

@property (nonatomic,strong)NSString *activeRule;
@property (nonatomic,strong)NSString *activeTitle;
@property (nonatomic,strong)NSString *activeUrl;
@property (nonatomic, strong) SNShareKit              *shareKit;
@property (nonatomic, strong) ChooseShareWayView    *chooseShareWayView; //分享方式
@property (nonatomic,strong)QueryRewardDTO *queryRewardDTO;

@end
