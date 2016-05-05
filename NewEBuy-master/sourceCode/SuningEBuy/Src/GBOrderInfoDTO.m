//
//  GBOrderInfoDTO.m
//  SuningEBuy
//
//  Created by  liukun on 12-12-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "GBOrderInfoDTO.h"


@implementation GBOrderInfoDTO

@synthesize gbType = _gbType;
@synthesize createTime = _createTime;
@synthesize orderAmount = _orderAmount;
@synthesize orderStatus = _orderStatus;
@synthesize snProId = _snProId;
@synthesize saleCount = _saleCount;
@synthesize snProAmount = _snProAmount;
@synthesize snProName = _snProName;
@synthesize orderId = _orderId;
@synthesize canRefund = _canRefund;
@synthesize telephone = _telephone;
@synthesize userId = _userId;
@synthesize notice = _notice;
@synthesize voucherList = _voucherList;

@synthesize voucherType = _voucherType;
@synthesize voucherMap = _voucherMap;
@synthesize hotelId = _hotelId;
@synthesize hotelName = _hotelName;
@synthesize email = _email;
@synthesize service = _service;
@synthesize shopList= _shopList;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_createTime);
    TT_RELEASE_SAFELY(_orderAmount);
    TT_RELEASE_SAFELY(_snProId);
    TT_RELEASE_SAFELY(_saleCount);
    TT_RELEASE_SAFELY(_snProAmount);
    TT_RELEASE_SAFELY(_snProName);
    TT_RELEASE_SAFELY(_orderId);
    TT_RELEASE_SAFELY(_telephone);
    TT_RELEASE_SAFELY(_userId);
    TT_RELEASE_SAFELY(_notice);
    TT_RELEASE_SAFELY(_voucherList);
    TT_RELEASE_SAFELY(_voucherMap);
    TT_RELEASE_SAFELY(_hotelId);
    TT_RELEASE_SAFELY(_hotelName);
    TT_RELEASE_SAFELY(_email);
    TT_RELEASE_SAFELY(_service);
    TT_RELEASE_SAFELY(_shopList);
    TT_RELEASE_SAFELY(_imgUrlStr);
    
}

- (void)encodeOrderListFromDic:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    self.gbType = [EncodeStringFromDic(dic, @"tuanGouType") intValue];
//    if (!EncodeStringFromDic(dic, @"createTime")) {
//        NSDate *createDate = [NSDate dateFromString:EncodeStringFromDic(dic, @"createTime") withFormat:@"yyyy-MM-dd" ];
//        NSString *createDateSting = [NSDate stringFromDate:createDate withFormat:@"yyyy-MM-dd" ];
//        self.createTime = createDateSting;
//    }
    
    self.createTime = EncodeStringFromDic(dic, @"createTime");
    self.orderAmount = EncodeStringFromDic(dic, @"orderAmount");
    self.orderStatus = [EncodeStringFromDic(dic, @"status") intValue];
    self.snProId = EncodeStringFromDic(dic, @"snProId");
    self.saleCount = EncodeStringFromDic(dic, @"saleCount");
    self.snProAmount = EncodeStringFromDic(dic, @"snProAmount");
    self.snProName = EncodeStringFromDic(dic, @"snProName");
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.imgUrlStr = EncodeStringFromDic(dic, @"imgLUrl");
    self.statusName = EncodeStringFromDic(dic, @"statusName");
    self.spSrc = EncodeStringFromDic(dic, @"spSrc");
}

- (void)encodeOrderDetailFromDic:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    self.orderId = EncodeStringFromDic(dic, @"orderId");
    self.snProName = EncodeStringFromDic(dic, @"snProName");
    if (EncodeStringFromDic(dic, @"createTime")) {
        NSDate *createDate = [NSDate dateFromString:[EncodeStringFromDic(dic, @"createTime") substringToIndex:19]withFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *createDateSting = [NSDate stringFromDate:createDate withFormat:@"yyyy-MM-dd HH:mm:ss" ];
        self.createTime = createDateSting;
                                                        
    }
    self.statusName = EncodeStringFromDic(dic, @"statusName");
    self.imgUrlStr = EncodeStringFromDic(dic, @"imgSUrl");
    self.saleCount = EncodeStringFromDic(dic, @"saleCount");
    self.orderAmount = EncodeStringFromDic(dic, @"orderAmount");
    self.gbType = [EncodeStringFromDic(dic, @"tuanGouType") intValue];
    self.orderStatus = [EncodeStringFromDic(dic, @"status")intValue];
    self.telephone = EncodeStringFromDic(dic, @"telphone");
    self.userId = EncodeStringFromDic(dic, @"userId");
    self.snProId = EncodeStringFromDic(dic, @"snProId");
    self.hotelId  = EncodeStringFromDic(dic, @"hotelId");
    self.spSrc = EncodeStringFromDic(dic, @"spSrc");
    
    if(0 == self.gbType){
        
        self.notice = [NSString stringWithFormat:@"%@?snProId=%@",EncodeStringFromDic(dic, @"notice"),self.snProId];
    }
    else if(1 == self.gbType){
        
        self.notice = [NSString stringWithFormat:@"%@?snProId=%@",EncodeStringFromDic(dic, @"notice"),self.hotelId];
    }
 
    NSString *temp = EncodeStringFromDic(dic, @"refundType");
    if (0 != [temp length] && [temp isEqualToString:@"1"]) {
        self.canRefund = YES;
    }
    else{
        self.canRefund = NO;
    }
    temp = EncodeStringFromDic(dic, @"refundType");
    if (0 != [temp length] && [temp isEqualToString:@"1"]) {
        self.canExpireRefund = YES;
    }
    else{
        self.canExpireRefund = NO;
    }
    self.voucherType = [EncodeStringFromDic(dic, @"voucherType")integerValue];
    if ( self.voucherType != 2) {
    
        NSDictionary *data = [dic objectForKey:@"voucherList"];
        
        if (!_voucherList) {
            _voucherList = [[NSMutableArray alloc] init];
        }
        for (NSDictionary *dic_ in data) {
            GBVoucherSingleInfoDTO *dto = [[GBVoucherSingleInfoDTO alloc]init];
            dto.gbType = self.gbType;
            dto.voucherType = self.voucherType;
            dto.spSrc = self.spSrc;
            dto.canRefund = self.canRefund;
            [dto encodeFromDictionary:dic_];
           
            if (0 == self.gbType
                && 0 != dto.status
                && 1 != dto.status) {
                 //非酒店  状态为0，1不展示
                [_voucherList addObject:dto];
            }
            else if(1 == self.gbType
                    && 0 != dto.status){
                //酒店 状态为0 不展示
               [_voucherList addObject:dto]; 
            }
            
            TT_RELEASE_SAFELY(dto);
        }
    }
    else //if (self.voucherType  == 2)
    {
//        if (self.voucherType  == 2) {
            
        NSDictionary *data = [dic objectForKey:@"voucherMap"];
        
        if (!_voucherMap) {
            _voucherMap = [[GBVoucherDTO alloc] init];
        }
        _voucherMap.canRefund = self.canRefund;
        [_voucherMap encodeFromDictionary:data];
//        }
//        else
//        {
//            NSDictionary *data = [dic objectForKey:@"voucherList"];
//            
//            if (!_voucherList) {
//                _voucherList = [[NSMutableArray alloc] init];
//            }
//            
//            if (data) {
//                for (NSDictionary *dic_ in data) {
//                    GBVoucherSingleInfoDTO *dto = [[GBVoucherSingleInfoDTO alloc]init];
//                    dto.gbType = self.gbType;
//                    [dto encodeFromDictionary:dic_];
//                    
//                    [self.voucherList addObject:dto];
//                    TT_RELEASE_SAFELY(dto);
//                }
//            }
//        }
    }

    
    self.hotelName = EncodeStringFromDic(dic, @"hotelName");
    self.email = EncodeStringFromDic(dic, @"email");
    self.service = EncodeStringFromDic(dic, @"service");
    if (self.gbType == 1) {
        if (!_shopList) {
            _shopList = [[NSMutableArray alloc]init];
        }
        NSDictionary *data = [dic objectForKey:@"shopList"];
        for (NSDictionary *dic_ in data) {
            GBShopDTO *dto = [[GBShopDTO alloc]init];
            [dto encodeFromDictionary:dic_];
            [self.shopList addObject:dto];
            TT_RELEASE_SAFELY(dto);
        }
        
    }
    
    
}



@end
