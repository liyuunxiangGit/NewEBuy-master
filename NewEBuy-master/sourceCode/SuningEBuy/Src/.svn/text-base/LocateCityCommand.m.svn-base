//
//  LocateCityCommand.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-27.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "LocateCityCommand.h"
#import "AddressInfoDAO.h"

@implementation LocateCityCommand 

- (void)cancel
{
    [self stopUpdatingLocation];
    manager.delegate = nil;
    
    [geocoder cancelGeocode];
    
    [super cancel];
}

- (void)execute
{
    if (![CLLocationManager locationServicesEnabled])
    {
        self.responseStatus = LocateCityServiceUnable;
        SNLogInfo(@"位置服务不可用");
        
        if ([Config currentConfig].isFirstLocateCity.boolValue)
        {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                            message:L(@"Commands_PositionServiceNotWork")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"AlertIKnow")
                                                  otherButtonTitles:nil];
            [alert show];
            [Config currentConfig].isFirstLocateCity = @NO;
        }
        
        
        [self done];
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        self.responseStatus = LocateCityUserDenied;
        SNLogInfo(@"用户不允许使用位置");
        
        if ([Config currentConfig].isFirstLocateCity.boolValue)
        {
            BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"system-error")
                                                            message:L(@"Commands_PositionServiceNotWork")
                                                           delegate:nil
                                                  cancelButtonTitle:L(@"AlertIKnow")
                                                  otherButtonTitles:nil];
            [alert show];
            [Config currentConfig].isFirstLocateCity = @NO;
        }
        [self done];
    }
    else
    {
        [self startUpdatingLocation];
    }
    
}

- (void)startUpdatingLocation
{
    if (!manager)
    {
        manager = [[CLLocationManager alloc] init];
        manager.delegate = self;
    }
    if (IOS8_OR_LATER) {
        #if __IPHONE_8_0
        [manager requestWhenInUseAuthorization];
        #endif
    }
    
    [manager startUpdatingLocation];
    //time out
    [self performSelector:@selector(stopUpdatingLocation)
               withObject:nil
               afterDelay:self.timeOutDefault > 0 ? self.timeOutDefault : 60.0f];
}

- (void)stopUpdatingLocation
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(stopUpdatingLocation)
                                               object:nil];
    [manager stopUpdatingLocation];
}

#pragma mark -
#pragma mark delegate

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.coordinate = newLocation.coordinate;
    
    if (IOS5_OR_LATER)
    {
        if (!geocoder)
        {
            geocoder = [[CLGeocoder alloc] init];
        }
        
        [geocoder reverseGeocodeLocation:newLocation
                       completionHandler:^(NSArray *placemarks,NSError *error)
         {
             if (error && [placemarks count])
             {
                 self.responseStatus = LocateCityAddressFail;
             }
             else
             {
                 for(CLPlacemark *placemark in placemarks)
                 {
                     self.addressInfoDic = placemark.addressDictionary;
                     NSString *currentCity = [placemark.addressDictionary objectForKey:@"City"];
                     if (!currentCity.length) {
                         currentCity = [placemark.addressDictionary objectForKey:@"State"];
                     }
                     self.cityName = currentCity;
                     SNLogInfo(@"locate city is : %@", currentCity);
                     [[NSNotificationCenter defaultCenter] postNotificationName:LOCATE_FINISH_MESSAGE object:nil];
                     break;
                 }
             }
             
             [self done];
         }];
    }
    
    [self stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    SNLogError(@"location error : %@", [error localizedDescription]);
    
    [self stopUpdatingLocation];
    
    self.responseStatus = LocateCityFail;
    [self done];
}

#pragma mark -
#pragma mark mkGeocoder delegate

/* deprecated
- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFindPlacemark:(MKPlacemark *)placemark
{
    self.addressInfoDic = placemark.addressDictionary;
    NSString *currentCity = [placemark.addressDictionary objectForKey:@"City"];
    if (!currentCity.length) {
        currentCity = [placemark.addressDictionary objectForKey:@"State"];
    }
    self.cityName = currentCity;
    DLog(@"locate city is : %@", currentCity);
    [[NSNotificationCenter defaultCenter] postNotificationName:LOCATE_FINISH_MESSAGE object:nil];
    [self done];
}

- (void)reverseGeocoder:(MKReverseGeocoder *)geocoder didFailWithError:(NSError *)error
{
    self.responseStatus = LocateCityAddressFail;
    [self done];
}
 */

#pragma mark -
#pragma mark 工具方法

+ (void)saveCityToConfig:(NSString *)cityName
{
    [Config currentConfig].locationCity = cityName;
    
    if ([AddressInfoDAO isUpdateAddressOk])
    {
        [self doSaveCity:cityName];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(saveDefaultCity:)
                                                     name:ADDRESS_UPDATE_OK_MESSAGE
                                                   object:nil];
        
    }

}

+ (void)doSaveCity:(NSString *)cityName
{
    AddressInfoDAO *dao = [[AddressInfoDAO alloc] init];
    AddressInfoDTO *addressInfo = [dao getProvinceAndCityInfoLikeCityName:cityName];
    if (addressInfo.city.length)
    {
        BOOL isSaved = [Config currentConfig].isGPSCitySaved.boolValue;
        
        //保存到设置，只有第一次启动会保存
        if (!isSaved)
        {
            [Config currentConfig].defaultProvince = addressInfo.province;
            [Config currentConfig].defaultCity = addressInfo.city;
            //deviceToken收集发送
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DEFAULT_CITY_CHANGE_NOTIFICATION
                                                                object:nil];
            [Config currentConfig].isGPSCitySaved = @YES;
        }
        
        [Config currentConfig].gpsCityCode = addressInfo.city;
        
    }
}

+ (void)saveDefaultCity:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:ADDRESS_UPDATE_OK_MESSAGE
                                                  object:nil];
    
    [self doSaveCity:[Config currentConfig].locationCity];
}

@end
