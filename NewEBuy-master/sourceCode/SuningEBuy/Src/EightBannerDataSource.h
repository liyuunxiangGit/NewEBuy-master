//
//  EightBannerDataSource.h
//  SuningEBuy
//
//  Created by wei xie on 12-8-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EightBannerDataSource : NSObject

+ (NSMutableArray *)parseHomeTopScrollList:(NSDictionary*)items;

+ (NSMutableArray *)parseSearchTopAd:(NSDictionary*)items; //add by wangjiaxing
+ (NSArray *)parseM2TuangouQiangGouAd:(NSDictionary*)items;

+ (NSArray *)parseAllAdList:(NSDictionary *)items;
@end
