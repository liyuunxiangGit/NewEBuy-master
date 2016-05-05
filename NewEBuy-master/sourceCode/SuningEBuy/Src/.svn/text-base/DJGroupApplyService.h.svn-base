//
//  DJGroupApplyService.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-20.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DJGroupApplyDTO.h"

@protocol DJGroupApplyServiceDelegate;

@interface DJGroupApplyService : DataService{
    HttpMessage *__DJGroupApplyMsg;
}

@property (nonatomic, copy) NSString *result;
@property (nonatomic, weak) id<DJGroupApplyServiceDelegate> delegate;

- (void)beginSendDJGroupApplyRequest:(DJGroupApplyDTO *)dto;

@end

@protocol DJGroupApplyServiceDelegate <NSObject>

- (void)didSendDJGroupApplyRequestComplete:(DJGroupApplyService *)service  Result:(BOOL)isSuccess;

@end
