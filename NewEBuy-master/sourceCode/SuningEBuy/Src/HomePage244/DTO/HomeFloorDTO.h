//
//  HomeFloorDTO.h
//  SuningEBuy
//
//  Created by zhangbeibei on 14-9-18.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  首页楼层DTO

#import <Foundation/Foundation.h>

@interface HomeFloorDTO : NSObject

//楼层序号
@property (nonatomic, copy) NSString    *orderNO;

//楼层名称(楼层的实际名称是其第一个模块名称)
@property (nonatomic, copy) NSString    *floorName;

//模板ID
@property (nonatomic, copy) NSString    *templateID;

//模块列表
@property (nonatomic, strong) NSMutableArray    *moduleList;
@end
