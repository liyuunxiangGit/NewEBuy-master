//
//  FlightFilter.m
//  SuningEBuy
//
//  Created by shasha on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlightFilter.h"
#import "FlightInfoDTO.h"
#import "ChooseDate.h"
#import "FlightRoomInfoDTO.h"


@implementation FlightFilter

+ (NSArray *)companyFilter:(NSArray *)FlightList byCompany:(NSString *)companyId;
 {
     if (IsNilOrNull(companyId)) {
         
         return nil;
     }

     NSMutableArray *resultList = [[NSMutableArray alloc] init];
     
     @autoreleasepool {
         for (FlightInfoDTO *dto in FlightList) {
             
             NSString *FLCompanyId = [dto.company replacedWhiteSpacsByString:@""];
             
             if ([companyId isEqualToString:FLCompanyId]) {
                 
                 [resultList addObject:dto];
                 
             }else{
                 
                 continue;
             }
             
         }
     } 
     
     return resultList;
}

+ (NSArray *)TimeEarliToLate:(NSArray *)FlightList{
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    @autoreleasepool {
        
        for (FlightInfoDTO *FlDTO in FlightList) {
                       
            if ([resultList count] == 0) {
                
                [resultList addObject:FlDTO];
                
            }else{
            
                int i = 0;

                for (FlightInfoDTO *RsDTO in resultList) {
                    
                    NSString *rsStartTime = RsDTO.fTime;
                    
                    NSString *LfStartTime = FlDTO.fTime;
                    
                    if ([FlightFilter isRsEarlier:rsStartTime thanFl:LfStartTime] == YES) {
                        
                        if(i == [resultList count]-1){
                            
                            [resultList addObject:FlDTO];
                            
                            i++;

                            break;
                        
                        }else{
                            
                            i++;
                            
                            continue;

                        }
                        
                        
                    }else{
                        
                        [resultList insertObject:FlDTO  atIndex:i];
                        
                        break;
                        
                    }
                    
                }
                
            }
        }
    } 
    
    return resultList;
}
    
+ (BOOL)isRsEarlier:(NSString *)RsStartTimeStr thanFl:(NSString *)FlStartTimeStr{
    NSDate *RsStartTime = [ChooseDate dateFromString:RsStartTimeStr withFormatString:@"HH:mm"];
    NSDate *FlStartTime = [ChooseDate dateFromString:FlStartTimeStr withFormatString:@"HH:mm"];
    if ([RsStartTime isEqualToDate:FlStartTime]) {
        return YES;
    }
    NSDate *earlierDate = [RsStartTime earlierDate:FlStartTime];
    if ([earlierDate isEqualToDate:RsStartTime]) {
        
        return YES;
        
    }else{
    
        return NO;
    }
    
}

+ (BOOL)isRsEarlierByString:(NSString *)RsStartTimeStr thanFl:(NSString *)FlStartTimeStr{
    
    NSArray *rsTime = [RsStartTimeStr componentsSeparatedByString:@":"];
    NSArray *flTime = [FlStartTimeStr componentsSeparatedByString:@":"];
    
    for (int i = 0; i < 2; i++) {
        
        NSString *rs = [rsTime objectAtIndex:i];
        NSString *fl = [flTime objectAtIndex:i];
        
        if ([rs intValue] == [fl intValue]) {
            if (i == 1) {
                
                return YES;
                
            }
            
            continue;
        }
        
        if ([rs intValue] < [fl intValue]) {
            
            return YES;
            
        }else{
        
            return NO;
        }
        
    }
    
    return NO;
     
}
 
+ (NSArray *)PriceHighToLow:(NSArray *)FlightList{
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    @autoreleasepool {
        
        for (FlightInfoDTO *FlDTO in FlightList) {
            
            if ([resultList count] == 0) {
                
                [resultList addObject:FlDTO];
                
            }else{
                
                int i = 0;
                
                for (FlightInfoDTO *RsDTO in resultList) {
                    
                    int rsPrice = [RsDTO.minPrice intValue];
                    
                    int LfPrice = [FlDTO.minPrice intValue];
                    
                    if (rsPrice < LfPrice) {
                        
                        if(i == [resultList count]-1){
                            
                            [resultList addObject:FlDTO];
                            
                            i++;
                            
                            break;
                            
                        }else{
                            
                            i++;
                            
                            continue;
                            
                        }
                        
                        
                    }else{
                        
                        [resultList insertObject:FlDTO  atIndex:i];
                        
                        break;
                        
                    }
                    
                }
                
            }
        }
    } 
    
    return resultList;
}


+ (NSArray *)TimeEarliToLateByString:(NSArray *)FlightList{
    
    NSMutableArray *resultList = [[NSMutableArray alloc] init];
    
    @autoreleasepool {
        
        for (FlightInfoDTO *FlDTO in FlightList) {
            
            if ([resultList count] == 0) {
                
                [resultList addObject:FlDTO];
                
            }else{
                
                int i = 0;
                
                for (FlightInfoDTO *RsDTO in resultList) {
                    
                    NSString *rsStartTime = RsDTO.fTime;
                    
                    NSString *LfStartTime = FlDTO.fTime;
                    
                    if ([FlightFilter isRsEarlierByString:rsStartTime thanFl:LfStartTime] == YES) {
                        
                        if(i == [resultList count]-1){
                            
                            [resultList addObject:FlDTO];
                            
                            i++;
                            
                            break;
                            
                        }else{
                            
                            i++;
                            
                            continue;
                            
                        }
                        
                        
                    }else{
                        
                        [resultList insertObject:FlDTO  atIndex:i];
                        
                        break;
                        
                    }
                    
                }
                
            }
        }
    } 
    
    return resultList;
}


@end
