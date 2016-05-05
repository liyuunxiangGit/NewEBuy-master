//
//  GBHeadNodeDTO.h
//  SuningEBuy
//
//  Created by xie wei on 13-6-13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  HeadNode对象

#import <Foundation/Foundation.h>

@interface GBHeadNodeDTO : NSObject

@property (nonatomic, copy) NSString  *name; //筛选项名称
@property (nonatomic, copy) NSString  *idNode; //节点ID
@property (nonatomic, copy) NSString  *pinyin; //拼音首字母
@property (nonatomic, copy) NSString  *count; //数量
@property (nonatomic, copy) NSMutableArray *children; //子节点信息
@property (nonatomic, copy) NSString  *fatherId; //父节点ID
@property (nonatomic, copy) NSString  *level; //所处级次

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
