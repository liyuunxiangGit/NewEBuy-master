//
//  HotelOrderSubmitHttpRequest.h
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-4.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "SuningMainClick.h"


@protocol HotelOrderSubmitHttpRequestDelegate;


@interface HotelOrderSubmitHttpRequest : NSObject
{
    
    ASIFormDataRequest    *hotelOrderASIHTTPRequest;
}

@property (nonatomic, weak)  id<HotelOrderSubmitHttpRequestDelegate>  delegate;

- (void)hotelOrderSubmitHttpRequest:(NSMutableDictionary *)postDataDic;

- (void)httpRequestResult:(BOOL)successResult 
                errorCode:(NSString *)errorCode
                errorDesc:(NSString *)errorDesc;;

-(void)nextSectePayWay:(NSDictionary *)items;



@end

@protocol HotelOrderSubmitHttpRequestDelegate <NSObject>

@optional

- (void)httpRequestCompleted:(BOOL)successResult 
                   errorCode:(NSString *)errorCode
                   errorDesc:(NSString *)errorDesc;

@end

