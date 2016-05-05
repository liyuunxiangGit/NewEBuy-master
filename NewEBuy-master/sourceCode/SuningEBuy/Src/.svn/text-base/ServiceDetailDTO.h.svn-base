//
//  ServiceDetailDTO.h
//  SuningEMall
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"
#import "ServiceDetailInfoDTO.h"

typedef enum {
    ServiceDetailDeliveryInfo,
    ServiceDetailInstallInfo
}ServiceDetailInfoType;

@interface ServiceDetailDTO : BaseHttpDTO {
    //送货
    NSString            *_deliveryQuantity;
    NSString            *_deliveryAddress;
    NSString            *_deliveryDate;
    NSString            *_deliveryType;
    NSString            *_changeReturnDoc;
    NSArray             *_deliveryItemList;
    //送货详情
    
    //安装
    NSString            *_serviceOrderName;
    NSString            *_serviceStatus;
    NSString            *_serviceTime;
    NSString            *_workerName;
    NSString            *_workerTel;
    NSString            *_serviceDate;
    
    ServiceDetailInfoType   _type;
}

@property(nonatomic,copy)  NSString            *deliverQuantity;
@property(nonatomic,copy)  NSString            *deliveryAddress;
@property(nonatomic,copy)  NSString            *deliveryDate;
@property(nonatomic,copy)  NSString            *changeReturnDoc;
@property(nonatomic,strong) NSArray            *deliveryItemList;

@property(nonatomic,copy)  NSString            *serviceOrderName;
@property(nonatomic,copy)  NSString            *serviceStatus;
@property(nonatomic,copy)  NSString            *serviceTime;
@property(nonatomic,copy)  NSString            *workerName;
@property(nonatomic,copy)  NSString            *workerTel;
@property(nonatomic,copy)  NSString            *serviceDate;

@property(nonatomic,assign)  ServiceDetailInfoType type;
@property(nonatomic,copy)  NSString            *deliveryType;

- (void)encodeFromDictionary:(NSDictionary *)dic withType:(ServiceDetailInfoType)type;

@end
