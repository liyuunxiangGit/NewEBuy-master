//
//  ServiceDetailDTO.m
//  SuningEMall
//
//  Created by wei xie on 12-9-7.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ServiceDetailDTO.h"


@implementation ServiceDetailDTO

@synthesize deliveryDate = _deliveryDate;
@synthesize deliverQuantity = _deliveryQuantity;
@synthesize deliveryAddress = _deliveryAddress;
@synthesize changeReturnDoc = _changeReturnDoc;
@synthesize deliveryItemList = _deliveryItemList;
@synthesize serviceTime = _serviceTime;
@synthesize serviceStatus = _serviceStatus;
@synthesize serviceOrderName = _serviceOrderName;
@synthesize workerTel = _workerTel;
@synthesize workerName = _workerName;
@synthesize serviceDate = _serviceDate;
@synthesize type = _type;
@synthesize deliveryType = _deliveryType;


- (void)encodeFromDictionary:(NSDictionary *)dic withType:(ServiceDetailInfoType)type
{
    if (dic == nil) {
        return;
    }
    
    self.type = type;
    
    if (type == ServiceDetailDeliveryInfo)
    {
        self.deliverQuantity = EncodeStringFromDic(dic, KHttpRequestDeliverQuantity);
        self.deliveryAddress = EncodeStringFromDic(dic, KHttpRequestDeliveryAddress);
        self.deliveryDate = EncodeStringFromDic(dic, KHttpRequestDeliveryDate);
        self.changeReturnDoc = EncodeStringFromDic(dic, KHttpRequestChangeReturnDoc);

        NSArray *serArray = EncodeArrayFromDic(dic, @"deliveryItemList");
        if (!IsArrEmpty(serArray)) {
            NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:[serArray count]];
            for (NSDictionary *dict in serArray)
            {
                ServiceDetailInfoDTO *detail = [[ServiceDetailInfoDTO alloc] init];
                [detail encodeFromDictionary:dict];
                [tempArray addObject:detail];
            }
            self.deliveryItemList = tempArray;
        }
        NSString *type = EncodeStringFromDic(dic, @"deliveryType");

        if ([type isEqualToString:@"ZOR"]) {
            self.deliveryType = L(@"DeliverState");
        }else if ([type isEqualToString:@"ZTEL"]){
            self.deliveryType = L(@"InstallState");
        }else if ([type isEqualToString:@"ZTEN"]){
            self.deliveryType = L(@"SSChangeState");
        }else if([type isEqualToString:@"ZRE"]){
            self.deliveryType = L(@"return order status");
        }else{
            self.deliveryType = L(@"DeliverState");
        }
    }
    else
    {
        self.serviceOrderName = EncodeStringFromDic(dic, KHttpRequestServiceOrderName);
        self.serviceStatus = EncodeStringFromDic(dic, KHttpRequestServiceStatus);
        self.serviceTime = EncodeStringFromDic(dic, KHttpRequestServiceTime);
        self.workerName = EncodeStringFromDic(dic, KHttpRequestWorkerName);
        self.workerTel = EncodeStringFromDic(dic, KHttpRequestWorkerTel);
        self.serviceDate = EncodeStringFromDic(dic, KHttpRequestServiceDate);
    }
}




@end
