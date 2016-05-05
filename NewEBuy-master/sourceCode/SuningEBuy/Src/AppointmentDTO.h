//
//  AppointmentDTO.h
//  SuningEBuy
//
//  Created by 孔斌 on 14-8-25.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "BaseHttpDTO.h"

typedef enum _AppointmentState{
    ReadyForAppointment,
    OnAppointment,
    WaitPurchase,
    ReadyForPurchase,
    OnPurchase,
    PurchaseTimeOver,
}AppointmentState;

typedef enum : NSUInteger {
    LoadingBuy,
    OnBuy,
    BuyOver,
} ScScodeState;

@interface AppointmentDTO : BaseHttpDTO

@property (nonatomic, strong) NSString *actionId ;          //活动ID
@property (nonatomic, strong) NSString *productName;        //商品名称
@property (nonatomic, strong) NSString *personBuysLimit;    //每人限购数量
@property (nonatomic, strong) NSString *productPrice;       //商品价格
@property (nonatomic, strong) NSString *scheduleStarttime;  //预约开始时间
@property (nonatomic, strong) NSString *scheduleEndtime;    //预约结束时间
@property (nonatomic, strong) NSString *purchaseStarttime;  //购买开始时间
@property (nonatomic, strong) NSString *purchaseEndtime;    //购买结束时间
@property (nonatomic, assign) AppointmentState  status;     //状态
@property (nonatomic, strong) NSString *systemDatetime;     // 当前时间 yyyy-MM-dd HH:mm:ss

@property (nonatomic, assign) NSTimeInterval scheduleStartTimeSeconds;
@property (nonatomic, assign) NSTimeInterval scheduleEndTimeSeconds;
@property (nonatomic, assign) NSTimeInterval startTimeSeconds;
@property (nonatomic, assign) NSTimeInterval endTimeSeconds;

#pragma mark -
#pragma mark  --------S码详情-------
@property (nonatomic, strong) NSString  *scActionId;        //s码活动id
@property (nonatomic, strong) NSString  *scActionType;      //活动类型[0-预约活动；3-预约商品S码活动；4-普通商品S码活动]
@property (nonatomic, strong) NSString  *scActionStarttime; //活动开始时间
@property (nonatomic, strong) NSString  *scActionEndtime;   //活动结束时间
@property (nonatomic, strong) NSString  *scPurchaseStartime;//S码购买开始时间
@property (nonatomic, strong) NSString  *scPurchaseEndtime; //S码购买截止时间
@property (nonatomic, strong) NSString  *scScodePrice;      //S码专享价
@property (nonatomic, strong) NSString  *scStatus;          //s码状态[0-等待购买；1-购买阶段；2-购买结束]
@property (nonatomic, strong) NSString  *promotionLabel;    //s码优惠描述
@property (nonatomic, assign) ScScodeState  scScodeStatus;  //状态

@property (nonatomic, assign) NSTimeInterval scStartTimeSeconds;
@property (nonatomic, assign) NSTimeInterval scEndTimeSeconds;


-(void)encodeFromDictionary:(NSDictionary *)dic;

@end
