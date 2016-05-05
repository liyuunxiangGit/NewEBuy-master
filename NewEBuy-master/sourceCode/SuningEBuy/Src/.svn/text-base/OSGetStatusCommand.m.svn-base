//
//  OSGetStatusCommand.m
//  SuningEBuy
//
//  Created by  liukun on 13-12-21.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OSGetStatusCommand.h"

@implementation OSGetStatusCommand

- (id)init
{
    self = [super init];
    if (self) {
        _onlineStatus = -2;
    }
    return self;
}

//inits
- (id)initAsB2CShop:(NSString *)b2cGroupId productName:(NSString *)productName productCode:(NSString *)productCode //商家
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CShop;
        self.b2cGroupId = b2cGroupId;
        self.productName = productName;
        self.productCode = productCode;
    }
    
    return self;
}

- (id)initAsAShop:(NSString *)b2cGroupId GroupMember:(NSString *)groupMember ClassCode:(NSString *)classCode productName:(NSString *)productName productCode:(NSString *)productCode
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CShopA;
        self.groupMember = groupMember;
        self.classCode = classCode;
        self.b2cGroupId = b2cGroupId;
        self.productName = productName;
        self.productCode = productCode;
    }
    
    return self;
}

- (id)initAsB2COrderDetailWithOrderNo:(NSString *)orderNo //订单详情
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2COrderDetail;
        self.gId = kOSGIDOrderCenter;
        self.orderNo = orderNo;
    }
    
    return self;
}

- (id)initAsB2CDeliveryInstallWithOrderNo:(NSString *)orderNo
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CDeliveryInstall;
        self.gId = kOSGIDDeliveryInstall;
        self.orderNo = orderNo;
    }
    
    return self;
}

- (id)initASB2CFeedBackWithOrderNo:(NSString *)orderNo
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CFeedBack;
        self.gId = kOSGIDFeedBack;
        self.orderNo = orderNo;
    }
    
    return self;
}


- (id)initAsB2CReturnOrderWithOrderNo:(NSString *)orderNo //退货
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeB2CReturnGoods;
        self.gId = kOSGIDReturnGoods;
        self.orderNo = orderNo;
    }
    
    return self;
}

- (id)initAsCShop:(NSString *)shopCode ProductName:(NSString *)productName ProductCode:(NSString *)productCode OrderNo:(NSString *)orderNo
{
    self = [self init];
    
    if (self)
    {
        self.chatType = OSChatTypeCShop;
        self.shopCode = shopCode;
        self.productName = productName;
        self.productCode = productCode;
        self.orderNo = orderNo;
    }
    
    return self;
}

- (id)initWithDataProduct:(DataProductBasic *)product
{
    self = [self init];
    
    if (self)
    {
        if (product.isCShop)
        {
            self.chatType = OSChatTypeCShop;
            self.shopCode = product.shopCode;
            self.productName = product.productName;
            self.productCode = product.productCode;
        }
        else
        {
            self.b2cGroupId = product.thirdCategoryId;
            self.groupMember = product.vendorCode;
            self.classCode = product.catentryIds;
            
            if (self.groupMember.length)
            {
                self.chatType = OSChatTypeB2CShopA;
            }
            else
            {
                self.chatType = OSChatTypeB2CShop;
            }
        }
    }
    
    return self;
}

#pragma mark ----------------------------- lifecycle

- (void)cancel
{
    SERVICE_RELEASE_SAFELY(_service);
}

- (void)execute
{
    //#####  去除状态检查，默认是否展示从开关中决定  #####
    if ([SNSwitch isOpenOnlineService])
    {
        _onlineStatus = 1;
    }
    else
    {
        _onlineStatus = -1;
    }
    [self done];
    return;
    //#####  去除状态检查，默认是否展示从开关中决定  #####
    
    _service = [[OSChatService alloc] init];
    _service.delegate = self;
    
    if (self.chatType == OSChatTypeCShop)
    {
        [_service requestGetCStatus:self.shopCode];//1. 获取客服状态（商家）

    }
    else
    {
        [_service requestGetB2CStatus:self.b2cGroupId
                                  gId:self.gId
                          GroupMember:self.groupMember
                            ClassCode:self.classCode];//11.获取客服状态（B2C或供应商）
    }
}

- (void)osService:(OSChatService *)service getB2CStatusComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        self.shopType = service.shopType;
        if (service.code == -1)
        {
            self.onlineStatus = -1;
        }
        else if (service.code == 1)
        {
            self.onlineStatus = 1;
        }
        else
        {
            self.onlineStatus = 0;
        }
    }
    else
    {
        self.onlineStatus = -3;
    }
    
    [self done];
}

- (void)osService:(OSChatService *)service getCStatusComplete:(BOOL)isSuccess
{
    if (isSuccess)
    {
        self.shopType = service.shopType;
        if (service.code == -1)
        {
            self.onlineStatus = -1;
        }
        else if (service.code == 1)
        {
            self.onlineStatus = 1;
        }
        else
        {
            self.onlineStatus = 0;
        }
    }
    else
    {
        self.onlineStatus = -3;
    }
    
    [self done];
}


+ (OSShowStatus)getShowStatusFromStatus:(int)status
                               ShopType:(SNShopType)shopType
                              IsPreSale:(BOOL)isPreSale
{
    if (shopType == SNShopTypeC)
    {
        if (status == 1) {
            return OSShowStatusOnline;
        }else if (status == 0){
            return OSShowStatusLeaveMessage;
        }else{
            return OSShowStatusNone;
        }
    }
    else if (shopType == SNShopTypeB2CA)
    {
        if (isPreSale)
        {
            if (status == 1) {
                return OSShowStatusOnline;
            }else if (status == 0){
                return OSShowStatusLeaveMessage;
            }else{
                return OSShowStatusNone;
            }
        }
        else
        {
            if (status == 1) {
                return OSShowStatusOnline;
            }else if (status == 0){
                return OSShowStatusOffline;
            }else{
                return OSShowStatusNone;
            }
        }        
    }
    else    //自营
    {
        if (status == 1) {
            return OSShowStatusOnline;
        }else if (status == 0){
            return OSShowStatusOffline;
        }else{
            return OSShowStatusNone;
        }
    }
}
@end
