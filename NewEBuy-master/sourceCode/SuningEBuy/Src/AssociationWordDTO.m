//
//  AssociationWordDTO.m
//  SuningEBuy
//
//  Created by chupeng on 13-12-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AssociationWordDTO.h"

@implementation AssociationWordDTO

- (void)encodeFromTypesDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    self.isType = YES;
    NSString *keyword  = [dic objectForKey:@"keyword"];
    NSNumber *dirId    = [dic objectForKey:@"dirId"];
    NSString *dirName  = [dic objectForKey:@"dirName"];
    NSString *core     = [dic objectForKey:@"core"];
    NSNumber *sort     = [dic objectForKey:@"sort"];
    
    if (NotNilAndNull(keyword))
        self.keyWord = keyword;
    if (NotNilAndNull(dirId))
        self.dirId = [dirId stringValue];
    if (NotNilAndNull(dirName))
        self.dirName = dirName;
    if (NotNilAndNull(core))
        self.core = core;
    if (NotNilAndNull(sort))
        self.sort = [sort stringValue];
}

- (void)encodeFromWordsDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic)) {
        return;
    }
    self.isType = NO;
    NSString *keyword  = [dic objectForKey:@"keyword"];
    NSString *core     = [dic objectForKey:@"core"];
    if (NotNilAndNull(keyword))
        self.keyWord = keyword;
    if (NotNilAndNull(core))
        self.core = core;
}
@end
