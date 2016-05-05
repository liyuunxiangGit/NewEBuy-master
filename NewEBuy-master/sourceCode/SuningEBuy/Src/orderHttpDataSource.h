//
//  orderHttpDataSource.h
//  SuningEBuy
//
//  Created by zhaojw on 11-9-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import <Foundation/Foundation.h>
#import "MemberOrderCenterDTO.h"
#import "OrderStatInfo.h"
#import "MemberOrderNamesDTO.h"
#import "MemberOrderDetailsDTO.h"

@interface orderHttpDataSource : NSObject {
    
}

+(OrderStatInfo*)parseOrderInfo:(NSDictionary*)items;

+(NSMutableArray*)parseOrderList:(NSDictionary*)items;

+(NSMutableArray*)parseDetailOrderDTO:(NSDictionary*)items;

+(NSString*)getOrderTypeInfo:(NSString*)status;

+ (MemberOrderNamesDTO *)parseOrderNameDTO:(NSDictionary *)items;

//xmy
+(NSMutableArray*)parseDetailOrderCSDTO:(NSDictionary*)items;
+(NSString*)getOrderTypeInfo:(NSString*)detailSt WithOrderStatus:(NSString*)listSt;
+(NSMutableArray*)parseDetailHeadDTO:(NSDictionary*)items;

////货到付款订单
//- (BOOL)isCashOnDelivery:(NSString*)ormOrder WithOrderStatus:(NSString*)status;

//判断门店订单状态
+ (NSString*)setOrderStatus:(NSString*)status;

@end
