//
//  Command.m
//  SuningEBuy
//
//  Created by  liukun on 12-11-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "Command.h"
#import "CommandManage.h"

@implementation Command


- (void)dealloc
{
    [self cancel];
}

+ (id)command
{
    return [[self alloc] init];
}

- (void)execute
{
    // should throw an exception.
}

- (void)cancel
{
    self.delegate = nil;
    self.callBackBlock = nil;
}

- (void)done
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([_delegate respondsToSelector:@selector(commandDidFinish:)])
        {
            [_delegate commandDidFinish:self];
        }
        
        if (_callBackBlock)
        {
            _callBackBlock(self);
        }
        
        //防止循环引用造成内存泄露
        self.callBackBlock = nil;
        
        [[CommandManage sharedInstance].commandQueue removeObject:self];
    });

}

@end
