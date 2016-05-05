//
//  DJGroupListDTO.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  单价团列表输出参数

#import <Foundation/Foundation.h>

@interface DJGroupListDTO : NSObject

@property (nonatomic, copy) NSString  *curPage;
@property (nonatomic, copy) NSString  *rowsPerPage;
@property (nonatomic, copy) NSString  *maxRowCount;
@property (nonatomic, copy) NSString  *maxPage;
@property (nonatomic, copy) NSArray *groupBuyList;

- (void)encodeFromDictionary:(NSDictionary *)dic;

@end
