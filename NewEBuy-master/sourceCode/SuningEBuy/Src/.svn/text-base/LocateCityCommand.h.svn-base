//
//  LocateCityCommand.h
//  SuningEBuy
//
//  Created by  liukun on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "Command.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

//returnCode 错误码
enum _SNLocateCityErrorCode {
    LocateCitySuccess = 0,    //定位成功
    LocateCityFail,           //定位失败
    LocateCityAddressFail,    //获取详细地址信息失败
    LocateCityServiceUnable,  //定位服务不可用
    LocateCityUserDenied,     //用户不允许定位
};

@interface LocateCityCommand : Command <CLLocationManagerDelegate>
{
    CLLocationManager *manager;
    CLGeocoder *geocoder;
}

//responses
@property (nonatomic, assign) NSInteger     responseStatus; //定位状态
@property (nonatomic, strong) NSDictionary *addressInfoDic; //地址信息dic
@property (nonatomic, copy)   NSString     *cityName;       //城市名称 如：“南京市”
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; //当前用户坐标
@property (nonatomic, assign) CGFloat     timeOutDefault;

//将定位到的城市保存到Config,需要手动调用
+ (void)saveCityToConfig:(NSString *)cityName;

@end
