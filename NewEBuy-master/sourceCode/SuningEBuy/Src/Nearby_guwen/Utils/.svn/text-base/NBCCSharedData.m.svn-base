//
//  NBCCSharedData.m
//  SuningEBuy
//
//  Created by suning on 14-9-23.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NBCCSharedData.h"
#import "UserCenter.h"

@implementation NBCCSharedData

+ (NBCCSharedData *)shared {
    static dispatch_once_t once;
    static NBCCSharedData *obj = nil;
    dispatch_once(&once, ^{
        obj = [[NBCCSharedData alloc] init];
    });
    return obj;
}

- (id)init {
    if (self = [super init]) {
        //32.0909430000,118.8988720000
        //_coordinate = CLLocationCoordinate2DMake(32.0909430000,118.8988720000);
        _coordinate = CLLocationCoordinate2DMake(32.044038,118.792141);
    }
    return self;
}

+ (BOOL)isAppLogined {
    return ([UserCenter defaultCenter].isLogined);
}

+ (NSString *)userId {
    NSString *loginId = [UserCenter defaultCenter].userInfoDTO.custNum;
    return (nil == loginId) ? @"" :loginId;
    //return @"6001137563";
}

//“pos”://位置数据
//“{
//    “userLocation”:[118.111,32.222] //用户经纬度
//    “point”:[118.111,32.222]，//发布内容选择的位置纬度
//    “pointName”， //发布内容选择的位置名称
//    "prov":"省份",//非必填
//    "city":"城市",//非必填
//    "area":"区县",//非必填
//    “distance”,10000//距离
//}”

+ (NSDictionary *)postion { // todo
    
    CLLocationCoordinate2D loc = [NBCCSharedData shared].coordinate;
    
    NSArray *pp = @[@(loc.longitude),@(loc.latitude)];
    NSDictionary *pos = @{@"userLocation":pp,
                          @"point":pp,
                          @"pointName":L(@"SuningHeadQuarters"),
                          @"prov":L(@"JiangsuProvince"),
                          @"city":L(@"NanjingCity"),
                          @"area":L(@"XuanwuArea"),
                          @"distance":@(10000)};
    return pos;
}

+ (NSDictionary *)fixedPostion {
    CLLocationCoordinate2D loc = [NBCCSharedData shared].coordinate;
    
    NSDictionary *info = [NBCCSharedData shared].addressDictionary;
    NSString *prov = EncodeStringFromDic(info, @"State");
    NSString *city = EncodeStringFromDic(info, @"City");
    NSString *area = EncodeStringFromDic(info, @"SubLocality");
    
    NSArray *pp = @[@(loc.longitude),@(loc.latitude)];
    NSDictionary *pos = @{@"userLocation":pp,
                          @"distance":@(10000),
                          @"prov":((nil==prov)?@"":prov),
                          @"city":((nil==city)?@"":city),
                          @"area":((nil==area)?@"":area)};
    return pos;
}

//u
//{
//    "id": "aa232",
//    "nick": "枪枪成2",
//    "sex": "1",
//    "faceUrl": "http://www.suning.com/avatar/100301.jpg
//}

+ (NSDictionary *)userInfo { // todo
    
    UserInfoDTO *bean = [UserCenter defaultCenter].userInfoDTO;
    NSString *uId     = bean.custNum;//bean.userId;
    NSString *uNick   = (nil==bean.nickName)?(bean.userName):(bean.nickName);
    uNick = ((nil == uNick)?bean.userId:uNick);
    NSString *uSex    = bean.sex;
    if (nil != uSex
        && [uSex isEqualToString:@"M"]) {
        uSex = @"1";
    }
    
    return @{@"id":((nil!=uId)?uId:@"")/*@"6001137563"*/,
             @"nick":(nil!=uNick)?uNick:@"",
             @"sex":(nil!=uSex)?uSex:@"",
             @"faceUrl":@""};
}

@end
