//
//  SugDirDTO.m
//  SuningEBuy
//
//  Created by chupeng on 14-7-21.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SugDirDTO.h"

@implementation SugDirDTO
- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (IsNilOrNull(dic))
        return;
    
    NSString *keyword = [dic strValue:@"keyword"];
    NSString *dirId = [dic strValue:@"dirId"];
    NSString *dirImage = [dic strValue:@"dirImage"];
    NSString *dirName = [dic strValue:@"dirName"];
    NSString *url = [dic strValue:@"url"];
    NSString *sort = [dic strValue:@"sort"];
    
    if (NotNilAndNull(keyword))
        self.keyword = keyword;
    
    if (NotNilAndNull(dirId))
        self.dirId = dirId;
    
    if (NotNilAndNull(dirImage))
        self.dirImage = dirImage;
    
    if (NotNilAndNull(dirName))
        self.dirName = dirName;
    
    if (NotNilAndNull(url))
        self.url = url;
    
    if (NotNilAndNull(sort))
        self.sort = sort;
}
@end
