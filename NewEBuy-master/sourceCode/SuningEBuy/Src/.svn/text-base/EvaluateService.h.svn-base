//
//  NewEvaluateService.h
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-24.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@class EvaluateService;

@protocol EvaluateServiceDelegate <NSObject>

@optional

-(void)NewEvaluateHttpRequestCompletedWithService:(EvaluateService*)service 
                                        isSuccess:(BOOL)isSuccess 
                                     errorDescMsg:(NSString *)errorDescMsg;

@end

@interface EvaluateService : DataService
{
    HttpMessage       *_sendProductEvaluateMsg;
}

@property(nonatomic,weak)id<EvaluateServiceDelegate>delegate;
@property (nonatomic, strong)NSString *errorDescMsg;


- (void)sendProductEvaluateHttpRequest:(NSString *)productId 
                                rating:(NSString *)rating 
                              cityCode:(NSString *)cityCode 
                                 title:(NSString *)title 
                               content:(NSString *)content 
                                isBook:(BOOL)isBook;


@end
