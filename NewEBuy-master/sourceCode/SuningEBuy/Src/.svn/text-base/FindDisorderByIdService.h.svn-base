//
//  FindDisorderByIdService.h
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@class FindDisorderByIdService;

@protocol FindDisorderByIdServiceDelegate <NSObject>

@optional

-(void)FindDisorderByIdHttpRequestCompleteWithService:(FindDisorderByIdService*)service 
                                            isSuccess:(BOOL)isSuccess;

@end

@interface FindDisorderByIdService : DataService
{
    HttpMessage   *_findDisorderByIdHttpMsg;
}

@property (nonatomic, strong) id<FindDisorderByIdServiceDelegate>   delegate;
@property (nonatomic, copy)   NSNumber                              *articleId;
@property (nonatomic, strong) NSMutableArray                        *imageArray;
@property (nonatomic, strong) NSMutableArray                        *ProductDisOrderReplyItem;
@property (nonatomic, strong) NSMutableArray                        *disProductDetailsItemList;

-(void)sendFindDisorderByIdHttpRequest:(NSNumber*)articleId;

@end
