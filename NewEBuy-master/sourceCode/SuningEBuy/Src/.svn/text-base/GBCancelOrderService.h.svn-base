//
//  GBCancelOrderService.h
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-15.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBBaseService.h"
@interface ReFundInfoDto :NSObject{
    
}


@property(nonatomic,strong)NSString *orderId;
@property(nonatomic,strong)NSString *tuanGouType;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSArray *orderItemIdArray;
@property(nonatomic,strong)NSString *vouncherType;
@property(nonatomic,strong)NSString *refundReason;
@property(nonatomic,strong)NSString *refundCount;
@property(nonatomic)NSInteger maxCount;

@property (nonatomic)float price;
@end


@class GBCancelOrderService;

@protocol GBCancelOrderDelegate <NSObject>

@optional

- (void)cancelOrder:(GBCancelOrderService *)service
               info:(NSDictionary *)dicinfo
             Result:(BOOL)isSuccess;
- (void)refund:(GBCancelOrderService *)service
               info:(NSDictionary *)dicinfo
             Result:(BOOL)isSuccess;
@end

@interface GBCancelOrderService : GBBaseService


@property(nonatomic,strong)HttpMessage     *cancelOrderHttpMsg;
@property(nonatomic,strong)HttpMessage     *refundHttpMsg;
@property(nonatomic,weak)id<GBCancelOrderDelegate> myDelagate;

-(void)beginCancelOrder:(NSString *)orderid
                isHotel:(NSString *)isHotel
                   user:(NSString *)userId;

-(void)beginRefund:(ReFundInfoDto*)dto;
@end
