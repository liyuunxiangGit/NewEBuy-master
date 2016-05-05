//
//  CommonDataTask.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-4.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <BBTask.h>
#import "SNHttpConfig.h"
#import "SNHttpClient.h"

#undef DataTaskLoad
#define DataTaskLoad(_observer, _cls, _instance, _attributes) \
({ \
if (![_instance excutingOrSuccessed]) \
{ \
    _instance = [[_cls alloc] initWithAttributes:_attributes]; \
    _instance.delegate = _observer; \
    _instance.executeNewest = YES; \
    [_instance beginTask]; \
} \
})

#undef DataTaskRefresh
#define DataTaskRefresh(_observer, _cls, _instance, _attributes) \
({ \
if (![_instance isExecuting]) \
{ \
_instance = [[_cls alloc] initWithAttributes:_attributes]; \
_instance.delegate = _observer; \
_instance.executeNewest = YES; \
[_instance beginTask]; \
} \
})

@interface CommonDataTask : BBTask
{
    @protected
    NSOperation         *httpOperation;
}

- (instancetype)initWithAttributes:(NSDictionary *)attributes;

@end
