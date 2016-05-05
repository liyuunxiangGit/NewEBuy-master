//
//  CommandManage.h
//  SuningEBuy
//
//  Created by  liukun on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface CommandManage : NSObject

AS_SINGLETON(CommandManage);

@property (strong) NSMutableArray     *commandQueue;

+ (void)excuteCommand:(id<Command>)cmd observer:(id<CommandDelegate>)observer;
+ (void)excuteCommand:(id<Command>)cmd completeBlock:(CommandCallBackBlock)block;

+ (void)cancelCommand:(id<Command>)cmd;
+ (void)cancelCommandByClass:(Class)cls;
+ (void)cancelCommandByObserver:(id)observer;

+ (id)isExcuteingCommand:(Class)cls;

@end
