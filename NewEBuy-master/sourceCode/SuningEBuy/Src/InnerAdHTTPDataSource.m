//
//  InnerAdHTTPDataSource.m
//  SuningEBuy
//
//  Created by wei xie on 12-8-21.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "InnerAdHTTPDataSource.h"

#define kResponseInnerAdResource         @"innerAdvertise"
#define kResponseInnerProductResource    @"innerProduct"


@implementation InnerAdHTTPDataSource

+ (NSMutableArray *)parseInnerAdList:(NSDictionary*)items{
    
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    NSArray *array = [items objectForKey:kResponseInnerAdResource];
    
    if(array != nil && [array count] > 0){
        
        NSMutableArray *topArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in array){
            
            InnerAdDTO *dto = [[InnerAdDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [topArray addObject:dto];
            
        }
        
        DLog(@"innerAdArray count is %d",[topArray count]);
        
        return topArray;
        
    }else{
        
        return nil;
    }
}

+ (NSMutableArray *)parseInnerProductBaseList:(NSDictionary *)items
{
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    NSArray *array = [items objectForKey:@"advFloorList"];
    
    if(array != nil && [array count] > 0){
        
        NSMutableArray *topArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in array){
            
            InnerProductBaseDTO *dto = [[InnerProductBaseDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [topArray addObject:dto];
            
            
        }
        
        DLog(@"innerProductArray count is %d",[topArray count]);
        
        return topArray;
        
    }else{
        
        return nil;
    }
}

+ (NSMutableArray *)parseInnerProductList:(NSDictionary*)items{
    
    if(!items || (NSNull *)items == [NSNull null]){
        
        return nil;
    }
    
    NSArray *array = [items objectForKey:kResponseInnerProductResource];
    
    if(array != nil && [array count] > 0){
        
        NSMutableArray *topArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dic in array){
            
            InnerProductDTO *dto = [[InnerProductDTO alloc] init];
            
            [dto encodeFromDictionary:dic];
            
            [topArray addObject:dto];
            
            
        }
        
        DLog(@"innerProductArray count is %d",[topArray count]);
        
        return topArray;
        
    }else{
        
        return nil;
    }
}


@end
