//
//  FlightListHttpDataSource.m
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightListHttpDataSource.h"
#import "FlightInfoDTO.h"
#import "CompanyDTO.h"

@implementation FlightListHttpDataSource

+(NSMutableArray *)parseFlightList:(NSDictionary *)items{
    
    if (!items||(NSNull *)items == [NSNull null]) {
        
        return nil;
        
    }
    
    NSDictionary *listDic = [items objectForKey:@"flightInfo"];
         
    if (!IsNilOrNull(listDic)) {
        
        DLog(@"%d", [listDic count]);
        
    }else{
        
        return nil;
    
    }
    
    NSString *guid = [listDic objectForKey:@"guid"];
    
    NSArray *array = [listDic objectForKey:  @"flightList"];
    
    if (array != nil && [array count] > 0) {
        
        NSMutableArray *flightList = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in array ) {
            
            FlightInfoDTO *dto = [[FlightInfoDTO alloc] init];
            
            dto.guid = guid;
            
            [dto encodeFromDictionary:dic];
            
            [flightList addObject:dto];
            
            TT_RELEASE_SAFELY(dto);
            
        }
        
        if([flightList count]!=0){
			
		    return flightList;
		}
		else{
			
			
			return nil;
		}
        
    }
    
    return nil;
}

+(NSMutableArray *)parseCompanyList:(NSDictionary *)items{

    if (!items||(NSNull *)items == [NSNull null]) {
        
        return nil;
        
    }
    
    NSDictionary *listDic = [items objectForKey:@"flightInfo"];
    
    if (!IsNilOrNull(listDic)) {
        
        DLog(@"%d", [listDic count]);
        
    }else{
        
        return nil;
        
    }
    
   NSArray *companyArr = [listDic objectForKey:@"companyInfo"];
    
    if (IsNilOrNull(companyArr) || [companyArr count] == 0) {
        
        return nil;
        
    }
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in companyArr) {
        
        CompanyDTO *dto = [[CompanyDTO alloc] init];
        
        [dto  encodeFromDictionary:dic];
        
        [resultList addObject: dto];
        
        
    }
    
    if([resultList count]!=0){
        
        return resultList;
    }
    else{
        
        
        return nil;
    }

}

@end
