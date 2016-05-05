//
//  SearchFilterDTO.m
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchFilterDTO.h"
#import "SearchFilterValueDTO.h"

#define kValueObserverKeyPath       @"checked"

@implementation SearchFilterDTO

@synthesize filterKey = _filterKey;
@synthesize filterName = _filterName;
@synthesize currentValue = _currentValue;
@synthesize currentValueDesc = _currentValueDesc;
@synthesize valueList = _valueList;

- (void)dealloc {
//    TT_RELEASE_SAFELY(_filterKey);
//    TT_RELEASE_SAFELY(_filterName);
//    TT_RELEASE_SAFELY(_currentValue);
//    TT_RELEASE_SAFELY(_currentValueDesc);
//    
//    if (_valueList) {
//        for (SearchFilterValueDTO *valueDTO in _valueList)
//        {
//            [valueDTO removeObserver:self forKeyPath:kValueObserverKeyPath context:nil];
//        }
//    }

    self.valueList = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)description
{
    NSString *strDes = [NSString stringWithFormat:@"FilterName = %@\n FilterKey = %@\n", self.filterName, self.filterKey];
    return strDes;
}

- (void)setValueList:(NSArray *)valueList
{
    if (valueList != _valueList) {
        
        if (_valueList && [_valueList count] > 0) {
            for (SearchFilterValueDTO *valueDTO in _valueList)
            {
                [valueDTO removeObserver:self forKeyPath:kValueObserverKeyPath];
            }
        }
        
        _valueList = valueList;
        
        if (_valueList) {
            for (SearchFilterValueDTO *valueDTO in _valueList)
            {
                if (valueDTO.checked) {
                    self.currentValue = valueDTO.value;
                    self.currentValueDesc = valueDTO.valueDesc;
                }
                [valueDTO addObserver:self
                           forKeyPath:kValueObserverKeyPath
                              options:NSKeyValueObservingOptionNew
                              context:nil];
            }
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath 
                      ofObject:(id)object 
                        change:(NSDictionary *)change 
                       context:(void *)context
{
    if ([keyPath isEqualToString:kValueObserverKeyPath] &&
        [object isKindOfClass:[SearchFilterValueDTO class]]) {
        
        BOOL isCheck = [[change objectForKey:@"new"] boolValue];
        if (isCheck) {
            SearchFilterValueDTO *valueDTO = (SearchFilterValueDTO *)object;
            self.currentValue = valueDTO.value;
            self.currentValueDesc = valueDTO.valueDesc;
            
            for (SearchFilterValueDTO *dtoT in _valueList)
            {
                if (dtoT != valueDTO && dtoT.checked) {
                    dtoT.checked = NO;
                }
            }
        }
        
    }
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    NSString *__fieldName = [dic objectForKey:@"fieldName"];
    if (NotNilAndNull(__fieldName))   self.filterKey = __fieldName;
    
    NSString *__fieldNameDesc = [dic objectForKey:@"fieldNameDesc"];
    if (NotNilAndNull(__fieldNameDesc))   self.filterName = __fieldNameDesc;
    
    NSArray *__values = [dic objectForKey:@"values"];
    if (NotNilAndNull(__values) && [__values count] > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[__values count]];
        for (NSDictionary *valueDic in __values)
        {
            SearchFilterValueDTO *dto = [[SearchFilterValueDTO alloc] init];
            [dto encodeFromDictionary:valueDic];
            
            if (dto.checked) {
                self.currentValue = dto.value;
                self.currentValueDesc = dto.valueDesc;
            }
            [array addObject:dto];
        }
        [self setValueList:array];
    }
}

- (void)setSelectAll
{
    self.currentValue = nil;
    self.currentValueDesc = nil;
    
    for (SearchFilterValueDTO *dto in self.valueList)
    {
        dto.checked = NO;
    }
}

- (void)setSelectValueAtIndex:(NSUInteger)index
{
    if (index < [_valueList count]) {
        SearchFilterValueDTO *dto = [self.valueList objectAtIndex:index];
        
        dto.checked = YES;
    }else{
        [self setSelectAll];
    }
    
}

@end
