//
//  InformationCollectDAO.h
//  SuningEBuy
//
//  Created by wangrui on 12/27/11.
//  Copyright (c) 2011 suning. All rights reserved.
//

#import "DAO.h"
#import "InformetionCollectDTO.h"

// 信息收集表
#define SystemInfoTbl       @"info_system"
#define IphoneUseTbl        @"info_useinfo"
#define ProductSearchTbl    @"info_search"
#define PageAccessingTbl    @"info_page"
#define SystemCrashDownTbl  @"info_crash"

@interface InformationCollectDAO : DAO


// Query Data
- (NSArray *)clientInformationsWithType:(ClientInfoMark)infoType;

// Insert Data
- (void)insertCollectedInfoWithType:(ClientInfoMark)infoType infoData:(InformetionCollectDTO *)infoDto;

// Clear Data
- (BOOL)clearCollectedInformationData;

- (BOOL)clearIphoneUseTblInformationData;
@end
