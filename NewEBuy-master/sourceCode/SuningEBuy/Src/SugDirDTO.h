//
//  SugDirDTO.h
//  SuningEBuy
//
//  Created by chupeng on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  常用分类dto

#import <Foundation/Foundation.h>

@interface SugDirDTO : NSObject
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, copy) NSString *dirId;
@property (nonatomic, copy) NSString *dirImage;
@property (nonatomic, copy) NSString *dirName;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *sort;

- (void)encodeFromDictionary:(NSDictionary *)dic;
@end
