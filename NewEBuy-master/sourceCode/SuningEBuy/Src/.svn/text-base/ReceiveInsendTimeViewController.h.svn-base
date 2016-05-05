//
//  ReceiveInsendTimeViewController.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "InsendTimeDTO.h"
#import "PayFlowService.h"

@class ReceiveInfoViewController;

@interface ReceiveInsendTimeViewController : CommonViewController

@property (nonatomic, assign)   InsendTimeType  insendTimeType;

@property (nonatomic, assign)   ShipMode        shipMode;

@property (nonatomic, strong)   NSArray         *mergeList;

@property (nonatomic, strong)   InsendTimeDTO   *insendTimeDto;

@property (nonatomic, strong)   ReceiveInfoViewController *obj;

//送货时间
@property (nonatomic, strong) NSMutableDictionary   *insendTimeDic;

//合并送货时间
@property (nonatomic, strong) NSMutableDictionary   *togetherInsendDic;

//拆分送货时间
@property (nonatomic, strong) NSMutableDictionary   *splitInsendDic;

@property (nonatomic, strong) NSString      *changeDateStr;
@property (nonatomic, strong) NSString      *changeTimeStr;

- (id)initWith:(ReceiveInfoViewController *)object withType:(InsendTimeType)type withDto:(InsendTimeDTO *)dto;

@end
