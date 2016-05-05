//
//  DJGroupListService.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  单价团列表

#import <Foundation/Foundation.h>
#import "DJGroupListInputDTO.h"
#import "DJGroupListDTO.h"

@protocol DJListServiceDelegate;

@interface DJGroupListService : DataService{
    HttpMessage *__DJListMsg;
}

@property (nonatomic, strong) NSArray     *groupListArray;
@property (nonatomic, weak) id<DJListServiceDelegate> delegate;
@property (nonatomic, strong) NSString *netWorkErro;
@property (nonatomic, assign) NSInteger pageCount;

- (void)beginSendDJListRequest:(DJGroupListInputDTO *)dto;

@end

@protocol DJListServiceDelegate <NSObject>

- (void)didSendDJListRequestComplete:(DJGroupListService *)service  Result:(BOOL)isSuccess;

@end
