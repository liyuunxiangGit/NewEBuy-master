//
//  InnerAdHTTPDataSource.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InnerAdDTO.h"
#import "InnerProductDTO.h"
#import "HomeTopScrollAdDTO.h"

@interface InnerAdHTTPDataSource : NSObject

+ (NSMutableArray *)parseInnerAdList:(NSDictionary*)items;
+ (NSMutableArray *)parseInnerProductList:(NSDictionary*)items;
+ (NSMutableArray *)parseInnerProductBaseList:(NSDictionary *)items;
//+ (NSMutableArray *)parseInnerFloorList:(NSDictionary*)items;//楼层


@end
