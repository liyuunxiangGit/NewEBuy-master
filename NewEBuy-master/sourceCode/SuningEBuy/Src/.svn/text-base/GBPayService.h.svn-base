//
//  GBPayService.h
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GBBaseService.h"
#import "GBSubmitDTO.h"
#import "GBSubmitBackDTO.h"
#import "GBEfubaoDTO.h"

@protocol GBPayServiceDelegate;

@interface GBPayService : GBBaseService
{
    HttpMessage                     *getReferOrderHttpMsg;
    HttpMessage                     *payByEppChannelHttpMsg;
    HttpMessage                     *payByMobileChannelHttpMsg;
}

@property (nonatomic, weak) id<GBPayServiceDelegate>      delegate;
@property (nonatomic, strong) GBEfubaoDTO                   *efubaoDto;

- (void)beginGetReferOrder:(NSString *)snProId
                 saleCount:(NSString *)saleCount
                 telePhone:(NSString *)telephone
                 groupType:(NSString *)type;

- (void)beginPayByEppChannel:(GBSubmitDTO *)dto;

- (void)beginPayByMobileChannel:(GBSubmitDTO *)dto;

@end


@protocol GBPayServiceDelegate <NSObject>

@optional

- (void)getReferOrderComplete:(GBPayService *)service
                       Result:(BOOL)isSuccess
                      orderId:(GBSubmitBackDTO *)backDto;


- (void)payByEppChannelComplete:(GBPayService *)service
                         Result:(BOOL)isSuccess;

- (void)payByMobileComplete:(GBPayService *)service
                     Result:(BOOL)isSuccess
                    withXml:(NSString *)xml;


@end