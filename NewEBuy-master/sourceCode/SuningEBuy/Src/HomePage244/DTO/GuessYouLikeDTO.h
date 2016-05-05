//
//  GuessYouLikeDTO.h
//  SuningEBuy
//
//  Created by GUO on 14-10-27.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GuessYouLikeDTO : NSObject

//返回码:01正确，，02系统内部异常， 03是算法异常但人工干预有数据
@property (nonatomic,strong) NSString      *retCode;
//场景ID
@property (nonatomic,strong) NSString      *sceneId;
//城市ID
@property (nonatomic,strong) NSString      *cityId;
//数据列表
@property (nonatomic,strong) NSMutableArray    *dataArray;

@end
