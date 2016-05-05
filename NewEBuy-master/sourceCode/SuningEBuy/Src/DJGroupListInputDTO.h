//
//  DJGroupListInputDTO.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//  单价团列表输入参数

#import <Foundation/Foundation.h>

@interface DJGroupListInputDTO : NSObject

@property (nonatomic, copy) NSString  *storeId;
@property (nonatomic, copy) NSString  *pageType;
@property (nonatomic, copy) NSString  *channel;
@property (nonatomic, copy) NSString  *numLimit;
@property (nonatomic, copy) NSString  *cityId;
@property (nonatomic, copy) NSString  *isPage;
@property (nonatomic, copy) NSString  *myChannelOnly;
@property (nonatomic, copy) NSString  *currentPage;
@property (nonatomic, copy) NSString  *pageSize;
@property (nonatomic, copy) NSString  *displayArea;

@end
