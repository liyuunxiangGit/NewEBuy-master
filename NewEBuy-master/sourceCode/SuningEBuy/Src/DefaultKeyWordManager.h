//
//  DefaultKeyWordManager.h
//  SuningEBuy
//
//  Created by chupeng on 14-6-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotWordDTO : NSObject
@property (nonatomic, copy) NSString *hotwordsStr;
@property (nonatomic, copy) NSString *urlStr;
@end

@interface DefaultKeyWordManager : NSObject
+ (DefaultKeyWordManager *)defaultManager;
@property (nonatomic, strong) NSMutableArray *hotWordDtoList;

- (NSString *)randomSearchPlaceholder;
- (NSString *)findUrlWithWord:(NSString *)str;
@end
