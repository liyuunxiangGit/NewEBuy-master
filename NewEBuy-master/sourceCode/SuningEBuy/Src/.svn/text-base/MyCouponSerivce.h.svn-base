//
//  MyCouponSerivce.h
//  SuningEBuy
//
//  Created by 正来 崔 on 12-9-11.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@class MyCouponSerivce;

@protocol MyCouponServiceDelegate <NSObject>

@optional
- (void)myCouponHttpRequestCompletedWithService:(MyCouponSerivce *)service
                                       isSucess:(BOOL)isSucess
                                      errorCode:(NSString *)errorCode;
- (void)myExCouponHttpRequestCompletedWithService:(MyCouponSerivce *)service 
                                         isSucess:(BOOL)isSucess 
                                        errorCode:(NSString *)errorCode;

@end

@interface MyCouponSerivce : DataService
{
    HttpMessage      *_myCouponMsg;
    HttpMessage      *_myExCouponMsg;
    NSInteger        _state;
}

@property(nonatomic,weak)id<MyCouponServiceDelegate> delegate;

@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) int totalPage;
@property (nonatomic, strong) NSArray *ticketDataList;
@property (nonatomic, copy) NSString *totalAmount;

- (void)sendMyCouponHttpRequest:(NSInteger)currentPage state:(NSInteger)state;
- (void)parseTicketData:(NSDictionary *)items;

-(void)sendExMyCouponHttpRequest:(NSInteger)currentPage;
- (void)parseMyExCouponData:(NSDictionary *)items;
-(void)getMyExCouponFinish:(BOOL)isSuccess;

@end
