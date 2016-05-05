//
//  EightBannerDataSource.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EightBannerDataSource.h"
#import "HomeTopScrollAdDTO.h"
#import "SearchAdDTO.h"
#define kResponseHomeTopScrollResource @"advertisements"

@implementation EightBannerDataSource

+ (NSMutableArray *)parseHomeTopScrollList:(NSDictionary*)items
{
    
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    NSArray *array = [items objectForKey:kResponseHomeTopScrollResource];
    
    if(array != nil && [array count] > 0){
        
        NSMutableArray *topArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in array){
            
            HomeTopScrollAdDTO *dto = [[HomeTopScrollAdDTO alloc] init];
            [dto encodeFromDictionary:dic];
            if ([dto.position intValue] <= 8)
            {
                [topArray addObject:dto];
            }
        }
        
        DLog(@"topArray count is %d",[topArray count]);
        
        return topArray;
        
    }else{
        
        return nil;
    }
}

+ (NSMutableArray *)parseSearchTopAd:(NSDictionary*)items
{
    
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    NSArray *array = [items objectForKey:kResponseHomeTopScrollResource];
    
    if(array != nil && [array count] > 0){
        
        NSMutableArray *topArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in array){
            
            SearchAdDTO *dto = [[SearchAdDTO alloc] init];
            [dto encodeFromDictionary:dic];
            if ([dto.position intValue] ==9) {
                
                [topArray addObject:dto];
                
            }
            else
            {
            }
        }
        
        DLog(@"topArray count is %d",[topArray count]);
        
        return topArray;
        
    }else{
        
        return nil;
    }
}
//从八连版数据中得到M2团购抢购区域 显示大聚会情况下的数据
+ (NSArray *)parseM2TuangouQiangGouAd:(NSDictionary*)items
{
    if(!items || (NSNull *)items == [NSNull null]){
        return nil;
    }
    NSArray *array = [items objectForKey:kResponseHomeTopScrollResource];
    if(array != nil && [array count] > 0){
        NSMutableArray *topArray = [[NSMutableArray alloc] init];
        for(NSDictionary *dic in array){
            SearchAdDTO *dto = [[SearchAdDTO alloc] init];
            [dto encodeFromDictionary:dic];
            //大聚会数据在10，11位
            if ([dto.position intValue] == 10 || [dto.position intValue] == 11) {
                [topArray addObject:dto];
            }
        }
        DLog(@"topArray count is %d",[topArray count]);
        return topArray;
    }else{
        return nil;
    }
}

+ (NSArray *)parseAllAdList:(NSDictionary *)items
{
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    NSArray *array = [items objectForKey:kResponseHomeTopScrollResource];
    
    if(array != nil && [array count] > 0){
        
        NSMutableArray *topArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in array){
            
            HomeTopScrollAdDTO *dto = [[HomeTopScrollAdDTO alloc] init];
            [dto encodeFromDictionary:dic];
            [topArray addObject:dto];
        }
        
        DLog(@"topArray count is %d",[topArray count]);
        
        return topArray;
        
    }else{
        
        return nil;
    }

}

@end
