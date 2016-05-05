//
//  InformationTransmitHttp.h
//  SuningEBuy
//
//  Created by wangrui on 12/28/11.
//  Copyright (c) 2011 suning. All rights reserved.
//

#import "InformetionCollectDTO.h"
#import "InformationCollectDAO.h"
#import <Foundation/Foundation.h>

#define kInfoDataType          @"dataType"
#define kInfoDataValue         @"dataValue"

@interface InformationCollectService : NSOperation
{
    InformationCollectDAO   *_informationDao;

}

@property (nonatomic,strong)NSMutableDictionary    *appStartInfoDic;

@property (nonatomic,copy)NSString                 *systemInfoStr;

@property (nonatomic,strong)NSDictionary           *collectDataDic;

#pragma mark -
#pragma mark Data Query
- (NSArray *)informationFromTableType:(ClientInfoMark)infoType;

- (NSURL *)remoteInterfaceWithType:(ClientInfoMark)infoType;

- (NSString *)userInfoStrWithDic:(NSDictionary *)dataDic;

#pragma mark -
#pragma mark Data Save
- (void)saveCollectedDataWithDic:(NSDictionary *)dataDic;

#pragma mark -
#pragma mark Data Transfer
- (void)sendDataHttpRequest;

- (NSString *)generateAppsDataWithDic:(NSDictionary *)dataDic;

@end
