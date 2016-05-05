//
//  SearchCateDTO.m
//  SuningEBuy
//
//  Created by  on 12-10-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "SearchCateDTO.h"

@implementation SearchCateDTO

@synthesize cateId = _cateId;
@synthesize cateName = _cateName;
@synthesize count = _count;
@synthesize superCateId = _superCateId;
@synthesize subCateList = _subCateList;

- (void)dealloc {
    TT_RELEASE_SAFELY(_cateId);
    TT_RELEASE_SAFELY(_cateName);
    TT_RELEASE_SAFELY(_count);
    TT_RELEASE_SAFELY(_superCateId);
    TT_RELEASE_SAFELY(_subCateList);
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    
    NSString *__id = [dic strValue:@"id"];
    NSString *__parentId = [dic strValue:@"parentId"];
    NSString *__name = [dic strValue:@"name"];
    NSString *__productCount = [dic strValue:@"productCount"];
    NSArray *__children = [dic arrayValue:@"children"];
    if (NotNilAndNull(__id))   self.cateId = __id;
    if (NotNilAndNull(__parentId))   self.superCateId = __parentId;
    if (NotNilAndNull(__name))   self.cateName = __name;
    if (NotNilAndNull(__productCount))   self.count = __productCount ;
    if (NotNilAndNull(__children) && [__children count] > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:[__children count]];
        for (NSDictionary *subDic in __children)
        {
            SearchCateDTO *subDTO = [[SearchCateDTO alloc] init];
            [subDTO encodeFromDictionary:subDic];
            [array addObject:subDTO];
        }
        self.subCateList = array;
    }
}

@end
