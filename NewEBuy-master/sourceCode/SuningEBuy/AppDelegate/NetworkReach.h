//
//  NetworkReach.h
//  Dtouching
//
//  Created by 刘坤 on 12-5-12.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@interface NetworkReach : NSObject

@property (nonatomic, readonly) BOOL isNetReachable;
@property (nonatomic, readonly) BOOL isHostReach;
@property (nonatomic, readonly) NSInteger reachableCount;
@property (nonatomic, strong) Reachability *hostReach;
//@property (nonatomic)   NSInteger reachableOfSN;//0:没有连接：1：wifi 2：非wifi连接

- (void)initNetwork;
- (void)showNetworkAlertMessage;

@end
