//
//  BMKPOILocationService.h
//  SuningEBuy
//
//  Created by XZoscar on 14-10-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NBDefineHeader.h"

@protocol BMKPOILocationServiceDelegate <NSObject>
@optional
- (void)delegate_BMKPOILocationServiceResponse:(NSArray *)resutArr
                                         error:(NSError *)error;
@end

@interface BMKPOILocationService : NSObject

@property (nonatomic,weak) id<BMKPOILocationServiceDelegate> delegate;

@property (nonatomic,assign) BOOL isLocationing; // 是否正在定位

- (void)startLocation;

- (void)stopLocation;

@end