//
//  DMOrderService.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-5-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//
#import "DataService.h"
#import "DMOrderDTO.h"

#undef DM_DEBUG
#define DM_DEBUG 0

@class DMOrderService;

@protocol  DMOrderServiceDelegate<NSObject>

@optional
- (void)service:(DMOrderService *)service result:(DMOrderResultDTO*)dto;

@end

@interface DMOrderService : DataService{

    
    HttpMessage *DMHttpMsg;
}

@property (nonatomic,weak) id <DMOrderServiceDelegate> delegate;

-(void)getDMOrderRequest:(DMOrderDTO *)dmDto;

-(void)getDMArrayRequest:(NSString*)cityId;
@end
