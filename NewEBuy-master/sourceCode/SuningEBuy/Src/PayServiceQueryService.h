//
//  PayServiceQueryService.h
//  SuningEBuy
//
//  Created by 谢 伟 on 12-10-10.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataService.h"

@protocol PayServiceQueryServiceDelegate;

@interface PayServiceQueryService : DataService
{
    HttpMessage                         *paymentQueryHttpMsg;
    
    BOOL                                _isEmptyHistory;
    
    NSMutableArray                      *_itemLists;
    
    id<PayServiceQueryServiceDelegate>  __weak _delegate;
}

@property (nonatomic, assign) BOOL  isEmptyHistory;
@property (nonatomic, strong) NSMutableArray *itemLists;
@property (nonatomic, weak) id<PayServiceQueryServiceDelegate> delegate;

- (void)beginGetFeeListWithTypeCode:(NSString *)typeCode;

@end


@protocol PayServiceQueryServiceDelegate <NSObject>

@optional

- (void)getFeeListCompleteWithService:(PayServiceQueryService *)service
                               Result:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg;
@end

