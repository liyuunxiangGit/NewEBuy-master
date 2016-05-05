//
//  ProductDisorderListService.h
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-25.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"

@class ProductDisorderListService;

@protocol ProductDisorderListDelegate <NSObject>

@optional

- (void)ProductDisorderListHttpRequestCompleteWithResult:(BOOL)isSuccess
                                                errorMsg:(NSString *)errorMsg
                                                pageInfo:(const SNPageInfo *)pageInfo
                                            disorderList:(NSArray *)list;

@end

@interface ProductDisorderListService : DataService
{
    HttpMessage        *_disorderListHttpMsg;
}

@property (nonatomic, weak) id<ProductDisorderListDelegate> delegate;


- (void)sendDisorderListHttpRequest:(NSString *)productId 
                        currentPage:(NSInteger)currentPage;
@end
