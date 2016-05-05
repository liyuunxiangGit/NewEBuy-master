//
//  CommonDataTask.m
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import "CommonDataTask.h"

@implementation CommonDataTask

- (void)cancelTask
{
    if (httpOperation && (![httpOperation isCancelled] || ![httpOperation isFinished]))
    {
        [httpOperation cancel];
    }
    
    [super cancelTask];
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes
{
    self = [super init];
    if (self) {
        self.attributes = attributes;
    }
    return self;
}

@end
