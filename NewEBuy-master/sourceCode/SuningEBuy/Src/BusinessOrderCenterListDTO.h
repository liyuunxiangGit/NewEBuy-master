//
//  BusinessOrderCenterListDTO.h
//  SuningEBuy
//
//  Created by robin wang on 7/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BusinessOrderCenterListDTO : NSObject
{

}

@property (nonatomic, copy) NSString *orderNO;

@property (nonatomic, copy) NSString *hotelName;

@property (nonatomic, copy) NSString *number;

@property (nonatomic, copy) NSString *totalPrice;

@property (nonatomic, copy) NSString *timer;

@property (nonatomic, copy) NSString *status;

@property (nonatomic, copy) NSString *orderUid;


- (void)encodeFromDictionary:(NSDictionary *)dic;
@end
