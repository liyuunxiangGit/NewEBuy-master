//
//  FlightRoomInfoDTO.h
//  SuningEBuy
//
//  Created by shasha on 12-5-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FlightRoomInfoDTO : NSObject<NSCopying>
@property(nonatomic,copy)NSString *room;
@property(nonatomic,copy)NSString *sysPrice;
@property(nonatomic,copy)NSString *sysPriceC;
@property(nonatomic,copy)NSString *roomB;
@property(nonatomic,copy)NSString *sysBPrice;
@property(nonatomic,copy)NSString *sysBPriceC;
@property(nonatomic,copy)NSString *cliPrice;
@property(nonatomic,copy)NSString *cliPriceC;
@property(nonatomic,copy)NSString *last;
@property(nonatomic,copy)NSString *rule;
@property(nonatomic,copy)NSString *offRate;
@property(nonatomic,copy)NSString *offPrice;
@property(nonatomic,copy)NSString *retPrice;
@property(nonatomic,copy)NSString *price;
@property(nonatomic,copy)NSString *offPriceC;
@property(nonatomic,copy)NSString *retPriceC;
@property(nonatomic,copy)NSString *priceC;
@property(nonatomic,copy)NSString *index;

/*liukun add in 12-11-19*/
@property(nonatomic,copy)NSString *supplyId;
@property(nonatomic,copy)NSString *supplyPolicyId;
@property(nonatomic,copy)NSString *promotionOffParm;
@property(nonatomic,copy)NSString *promotionSupOffParm;
@property(nonatomic,copy)NSString *md5Str;


-(void)encodeFromDictionary:(NSDictionary *)dic;
@end
