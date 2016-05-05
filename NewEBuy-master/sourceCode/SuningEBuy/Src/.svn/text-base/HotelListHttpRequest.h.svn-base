//
//  HotelListHttpRequest.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-3.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "HotelListDTO.h"

@protocol HotelListHttpRequestDelegate;

@interface HotelListHttpRequest : NSObject
{
    ASIFormDataRequest      *searchHotelASIHTTPRequest;
    
}

@property (nonatomic, strong)  id<HotelListHttpRequestDelegate>  delegate;


- (void)searchHotelHttpRequest:(NSMutableDictionary *)postDataDic;

- (void)httpRequestResult:(NSArray *)list 
                pageCount:(NSString *)pageCount
               withResult:(NSString *)successResult 
                errorDesc:(NSString *)errorDesc;;

@end


@protocol HotelListHttpRequestDelegate <NSObject>

@optional

- (void)httpRequestCompleted:(NSArray *)list 
                   pageCount:(NSString *)pageCount
                  withResult:(NSString *)successResult 
                   errorDesc:(NSString *)errorDesc;



@end

