//
//  GBSearchFilterDTO.h
//  SuningEBuy
//
//  Created by xie wei on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  筛选条件 SearchFilterBean对象

#import <Foundation/Foundation.h>

@interface GBSearchFilterDTO : NSObject

@property (nonatomic, copy) NSString  *fieldName; //筛选项名称
@property (nonatomic, copy) NSMutableArray  *values; //头部节点信息
@property (nonatomic, copy) NSString  *sort; //排序方法

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
