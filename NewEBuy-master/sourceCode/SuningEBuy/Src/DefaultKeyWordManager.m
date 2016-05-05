//
//  DefaultKeyWordManager.m
//  SuningEBuy
//
//  Created by chupeng on 14-6-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DefaultKeyWordManager.h"


@implementation HotWordDTO

@end

@implementation DefaultKeyWordManager
+ (DefaultKeyWordManager *)defaultManager
{
    static DefaultKeyWordManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil)
            manager = [[DefaultKeyWordManager alloc] init];
    });
    return manager;
}

- (NSString *)randomSearchPlaceholder
{
    return L(@"Search_SearchGoodAndStore");
    if (self.hotWordDtoList.count > 0 && self.hotWordDtoList)
    {
//        int i = arc4random() % self.hotWordDtoList.count;
//        
//        if (i >= 0 && i < self.hotWordDtoList.count)
//        {
            HotWordDTO *dto = [self.hotWordDtoList objectAtIndex:0];
            return dto.hotwordsStr;
//        }
    }
    
    return nil;
}

- (NSString *)findUrlWithWord:(NSString *)str
{
    if (self.hotWordDtoList.count > 0 && self.hotWordDtoList)
    {
        for (HotWordDTO *dto in self.hotWordDtoList) {
            if ([dto.hotwordsStr isEqualToString:str])
                return dto.urlStr;
        }
    }
    
    return nil;
}
@end
