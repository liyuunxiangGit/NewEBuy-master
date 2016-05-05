//
//  DJGroupDetailService.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJGroupDetailDTO.h"

@protocol DJGroupDetailServiceDelegate;

@interface DJGroupDetailService : DataService
{
    HttpMessage *__DJDetailMsg;
}

@property (nonatomic, strong) DJGroupDetailDTO *detailDto;
@property (nonatomic, weak) id<DJGroupDetailServiceDelegate> delegate;

- (void)beginSendDJListRequest:(NSString *)actId channelId:(NSString *)channelId;

@end

@protocol DJGroupDetailServiceDelegate <NSObject>

- (void)didSendDJDetailRequestComplete:(DJGroupDetailService *)service  Result:(BOOL)isSuccess;

@end
