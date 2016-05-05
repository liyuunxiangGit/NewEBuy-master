//
//  SearchFilterDTO.h
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchFilterDTO : NSObject

@property (nonatomic, copy) NSString *filterKey;
@property (nonatomic, copy) NSString *filterName;
@property (nonatomic, copy) NSString *currentValue;
@property (nonatomic, copy) NSString *currentValueDesc;
@property (nonatomic, strong) NSArray *valueList;


- (void)encodeFromDictionary:(NSDictionary *)dic;


//设置选中某一筛选项
- (void)setSelectValueAtIndex:(NSUInteger)index;

//设置选中所有
- (void)setSelectAll;

@end
