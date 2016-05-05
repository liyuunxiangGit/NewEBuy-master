//
//  AssociationWordDTO.h
//  SuningEBuy
//
//  Created by chupeng on 13-12-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  联想词dto

#import <Foundation/Foundation.h>

@interface AssociationWordDTO : NSObject
@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic, copy) NSString *dirId;   //类别id
@property (nonatomic, copy) NSString *dirName; //类别名
@property (nonatomic, copy) NSString *core;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, assign) BOOL   isType;   //是否是associateTypes解析来的分类信息

- (void)encodeFromTypesDictionary:(NSDictionary *)dic;
- (void)encodeFromWordsDictionary:(NSDictionary *)dic;
@end
