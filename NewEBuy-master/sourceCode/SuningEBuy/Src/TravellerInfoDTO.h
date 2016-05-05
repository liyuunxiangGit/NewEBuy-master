//
//  TravellerInfoDTO.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-5-15.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TravellerInfoDTO : NSObject


//-------------------------------------------------------
//乘客信息
//-------------------------------------------------------

/*乘客id*/
@property (nonatomic, copy) NSString *travellerId;

/*用户id*/
@property (nonatomic, copy) NSString *userId;

/*乘客类型：成人，小孩*/
@property (nonatomic, copy) NSString *travellerType;

/*乘客姓名*/
@property (nonatomic, copy) NSString *firstName;

/*证件类型*/
@property (nonatomic, copy) NSString *cardType;

/*证件号码*/
@property (nonatomic, copy) NSString *idCode;


- (void)encodeFromDictionary:(NSDictionary *)dic;
@end
