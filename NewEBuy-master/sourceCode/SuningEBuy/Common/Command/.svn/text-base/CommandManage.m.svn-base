//
//  CommandManage.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CommandManage.h"

@implementation CommandManage

DEF_SINGLETON(CommandManage);

- (id)init
{
    self = [super init];
    if (self) {
        self.commandQueue = [NSMutableArray array];
    }
    return self;
}

+ (void)excuteCommand:(id<Command>)cmd observer:(id<CommandDelegate>)observer
{
    if (cmd && ![self isExcuteingCommand:[cmd class]])
    {
        [[CommandManage sharedInstance] excuteCommand:cmd observer:observer];
    }
}

- (void)excuteCommand:(id<Command>)cmd observer:(id<CommandDelegate>)observer
{
    [self.commandQueue addObject:cmd];
    cmd.delegate = observer;
    [cmd execute];
}

+ (void)excuteCommand:(id<Command>)cmd completeBlock:(CommandCallBackBlock)block
{
    if (cmd && ![self isExcuteingCommand:[cmd class]])
    {
        [[CommandManage sharedInstance] excuteCommand:cmd completeBlock:block];
    }
}

- (void)excuteCommand:(id<Command>)cmd completeBlock:(CommandCallBackBlock)block
{
    [self.commandQueue addObject:cmd];
    cmd.callBackBlock = block;
    [cmd execute];
}


+ (void)cancelCommand:(id<Command>)cmd
{
    if (cmd) {
        [cmd cancel];
        [[CommandManage sharedInstance].commandQueue removeObject:cmd];
    }
}

+ (void)cancelCommandByClass:(Class)cls
{
    NSArray *tempArr = [NSArray arrayWithArray:[CommandManage sharedInstance].commandQueue];
    for (id<Command> cmd in tempArr)
    {
        if ([cmd isKindOfClass:cls])
        {
            [cmd cancel];
            [[CommandManage sharedInstance].commandQueue removeObject:cmd];
        }
    }
}

+ (void)cancelCommandByObserver:(id)observer
{
    if (!observer)
    {
        return;
    }
    
    NSArray *tempArr = [NSArray arrayWithArray:[CommandManage sharedInstance].commandQueue];
    for (id<Command> cmd in tempArr)
    {
        if (cmd.delegate == observer)
        {
            [cmd cancel];
            [[CommandManage sharedInstance].commandQueue removeObject:cmd];
        }
    }
}

+ (id)isExcuteingCommand:(Class)cls
{
    NSArray *tempArr = [NSArray arrayWithArray:[CommandManage sharedInstance].commandQueue];
    for (id cmd in tempArr)
    {
        if ([cmd isKindOfClass:cls]) {
            return cmd;
        }
    }
    return nil;
}

@end
