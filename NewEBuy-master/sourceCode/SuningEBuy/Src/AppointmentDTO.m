//
//  AppointmentDTO.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AppointmentDTO.h"

@implementation AppointmentDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.actionId = NotNilAndNull([dic objectForKey:@"actionId"])?[dic objectForKey:@"actionId"]:@"";
    self.productName = NotNilAndNull([dic objectForKey:@"productName"])?[dic objectForKey:@"productName"]:@"";
    self.personBuysLimit = NotNilAndNull([dic objectForKey:@"personBuysLimit"])?[dic objectForKey:@"personBuysLimit"]:@"";
    self.productPrice = NotNilAndNull([dic objectForKey:@"productPrice"])?[dic objectForKey:@"productPrice"]:@"";
    self.scheduleStarttime = NotNilAndNull([dic objectForKey:@"scheduleStarttime"])?[dic objectForKey:@"scheduleStarttime"]:@"";
    self.scheduleEndtime = NotNilAndNull([dic objectForKey:@"scheduleEndtime"])?[dic objectForKey:@"scheduleEndtime"]:@"";
    self.purchaseStarttime = NotNilAndNull([dic objectForKey:@"purchaseStarttime"])?[dic objectForKey:@"purchaseStarttime"]:@"";
    self.purchaseEndtime = NotNilAndNull([dic objectForKey:@"purchaseEndtime"])?[dic objectForKey:@"purchaseEndtime"]:@"";
    self.systemDatetime = NotNilAndNull([dic objectForKey:@"systemDatetime"])?[dic objectForKey:@"systemDatetime"]:@"";
    
//    self.scheduleStarttime = @"2014-08-22 10:33:15";
//    self.scheduleEndtime = @"2014-08-22 10:33:25";
//    self.systemDatetime = @"2014-08-22 10:33:05";
//    self.purchaseStarttime = @"2014-08-22 10:33:35";
//    self.purchaseEndtime = @"2014-08-23 10:33:45";

    NSString *status = NotNilAndNull([dic objectForKey:@"status"])?[dic objectForKey:@"status"]:@"";
//    status = @"1004";
    if ([status isEqualToString:@"1001"])
    {
        self.status = ReadyForAppointment;
    }
    else if ([status isEqualToString:@"1002"])
    {
        self.status = OnAppointment;
    }
    else if ([status isEqualToString:@"1003"])
    {
        self.status = ReadyForPurchase;
    }
    else if ([status isEqualToString:@"1004"])
    {
        self.status = OnPurchase;
    }
    else if ([status isEqualToString:@"1005"])
    {
        self.status = PurchaseTimeOver;
    }
    //预约时间状态
    [self checkState];
    
    self.scActionId = NotNilAndNull([dic objectForKey:@"scActionId"])?[dic objectForKey:@"scActionId"]:@"";
    self.scActionType = NotNilAndNull([dic objectForKey:@"scActionType"])?[dic objectForKey:@"scActionType"]:@"";
    self.scActionStarttime = NotNilAndNull([dic objectForKey:@"scActionStarttime"])?[dic objectForKey:@"scActionStarttime"]:@"";
    self.scActionEndtime = NotNilAndNull([dic objectForKey:@"scActionEndtime"])?[dic objectForKey:@"scActionEndtime"]:@"";
    self.scPurchaseStartime = NotNilAndNull([dic objectForKey:@"scScodePurchaseStarttime"])?[dic objectForKey:@"scScodePurchaseStarttime"]:@"";
    self.scPurchaseEndtime = NotNilAndNull([dic objectForKey:@"scSCodePurchaseEndtime"])?[dic objectForKey:@"scSCodePurchaseEndtime"]:@"";
    self.scScodePrice = NotNilAndNull([dic objectForKey:@"scScodePrice"])?[dic objectForKey:@"scScodePrice"]:@"";
    self.scStatus = NotNilAndNull([dic objectForKey:@"scStatus"])?[dic objectForKey:@"scStatus"]:@"";
    self.promotionLabel = NotNilAndNull([dic objectForKey:@"promotionLabel"])?[dic objectForKey:@"promotionLabel"]:@"";
    
//    self.scStatus = @"0";
//    self.scPurchaseStartime = @"2014-08-22 10:33:35";
//    self.scPurchaseEndtime = @"2014-08-23 10:33:45";
//    self.scScodePrice = @"100.00";
    
    if ([self.scStatus isEqualToString:@"0"]) {
        self.scScodeStatus = LoadingBuy;
    }else if ([self.scStatus isEqualToString:@"1"])
    {
        self.scScodeStatus = OnBuy;
    }else
    {
        self.scScodeStatus = BuyOver;
    }
    //S码时间状态
    [self checkScState];
}

- (void)checkState
{
    if (!IsStrEmpty(self.scheduleStarttime) && !IsStrEmpty(self.systemDatetime) && !IsStrEmpty(self.scheduleEndtime))
    {
        NSString *dateFormat            = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStartTimeTemp     = [self.scheduleStarttime substringToIndex:19];
        NSString *dateCurrentTimeTemp   = [self.systemDatetime substringToIndex:19];
        NSString *dateEndTimeTemp       = [self.scheduleEndtime substringToIndex:19];
        
        NSDate *dateStartTime           = [NSDate dateFromString:dateStartTimeTemp withFormat:dateFormat];
        NSDate *serverTime              = [NSDate dateFromString:dateCurrentTimeTemp withFormat:dateFormat];
        NSDate *dateEndTime             = [NSDate dateFromString:dateEndTimeTemp withFormat:dateFormat];
        
        self.scheduleStartTimeSeconds   = [dateStartTime timeIntervalSinceDate:serverTime];
        self.scheduleEndTimeSeconds     = [dateEndTime timeIntervalSinceDate:serverTime];
    }
    
    if (!IsStrEmpty(self.purchaseStarttime) && !IsStrEmpty(self.systemDatetime) && !IsStrEmpty(self.purchaseEndtime))
    {
        NSString *dateFormat            = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStartTimeTemp     = [self.purchaseStarttime substringToIndex:19];
        NSString *dateCurrentTimeTemp   = [self.systemDatetime substringToIndex:19];
        NSString *dateEndTimeTemp       = [self.purchaseEndtime substringToIndex:19];
        
        NSDate *dateStartTime           = [NSDate dateFromString:dateStartTimeTemp withFormat:dateFormat];
        NSDate *serverTime              = [NSDate dateFromString:dateCurrentTimeTemp withFormat:dateFormat];
        NSDate *dateEndTime             = [NSDate dateFromString:dateEndTimeTemp withFormat:dateFormat];
        
        self.startTimeSeconds           = [dateStartTime timeIntervalSinceDate:serverTime];
        self.endTimeSeconds             = [dateEndTime timeIntervalSinceDate:serverTime];
    }
    else
    {
        if (self.status == ReadyForPurchase) {
            self.status = WaitPurchase;
        }
    }
}

- (void)checkScState
{
    if (!IsStrEmpty(self.scPurchaseStartime) && !IsStrEmpty(self.systemDatetime) && !IsStrEmpty(self.scPurchaseEndtime))
    {
        NSString *dateFormat            = @"yyyy-MM-dd HH:mm:ss";
        NSString *dateStartTimeTemp     = [self.scPurchaseStartime substringToIndex:19];
        NSString *dateCurrentTimeTemp   = [self.systemDatetime substringToIndex:19];
        NSString *dateEndTimeTemp       = [self.scPurchaseEndtime substringToIndex:19];
        
        NSDate *dateStartTime           = [NSDate dateFromString:dateStartTimeTemp withFormat:dateFormat];
        NSDate *serverTime              = [NSDate dateFromString:dateCurrentTimeTemp withFormat:dateFormat];
        NSDate *dateEndTime             = [NSDate dateFromString:dateEndTimeTemp withFormat:dateFormat];
        
        self.scStartTimeSeconds   = [dateStartTime timeIntervalSinceDate:serverTime];
        self.scEndTimeSeconds     = [dateEndTime timeIntervalSinceDate:serverTime];
    }
}

- (void)setStatus:(AppointmentState)status
{
    if (_status != status) {
        
        _status = status;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"AppointmentStateDidChangeNotification" object:nil userInfo:@{@"appointmentDTO": self}];
    }
}

@end
