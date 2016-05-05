//
//  FlightListHttpDataSource.h
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightListHttpDataSource : NSObject

+ (NSMutableArray *)parseFlightList:(NSDictionary*)items;
+(NSMutableArray *)parseCompanyList:(NSDictionary *)items;
@end
