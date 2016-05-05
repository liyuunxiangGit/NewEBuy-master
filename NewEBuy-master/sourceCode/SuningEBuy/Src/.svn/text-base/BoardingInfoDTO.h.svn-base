//
//  BoardingInfoDTO.h
//  SuningEBuy
//
//  Created by lanfeng on 12-5-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseHttpDTO.h"

@interface BoardingInfoDTO : BaseHttpDTO

//登机人id，唯一标识登机人
@property (nonatomic,copy) NSString *travellerId;
//用户id，即易购客户端的id
@property (nonatomic,copy) NSString *usersId;
//旅客类型，1标识成人，2标识儿童
@property (nonatomic,copy) NSString *travellerType;
//旅客姓名
@property (nonatomic,copy) NSString *firstName;
//通常为空
@property (nonatomic,copy) NSString *lastName;
//证件类型
@property (nonatomic,copy) NSString *cardType;
//证件号码
@property (nonatomic,copy) NSString *idCode;
//生日，儿童必须字段，成人无需生日
@property (nonatomic,copy) NSString *birthday;
//手机号码
@property (nonatomic,copy) NSString *mobile;


-(void)encodeFromDictionary:(NSDictionary *)dic;
@end
