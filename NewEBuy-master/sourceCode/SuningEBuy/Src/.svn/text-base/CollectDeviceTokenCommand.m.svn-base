
//
//  CollectDeviceTokenCommand.m
//  SuningEBuy
//
//  Created by  liukun on 13-5-3.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "CollectDeviceTokenCommand.h"
#import "PasswdUtil.h"
#import "OpenUDID.h"
#import "SNCache.h"
#import "AddressInfoDAO.h"
#import "PasswdUtil.h"

@implementation CollectDeviceTokenCommand

+ (void)initialize
{
    if (self == [CollectDeviceTokenCommand class])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(collectStart)
                                                     name:DEFAULT_CITY_CHANGE_NOTIFICATION
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(collectStart)
                                                     name:LOGIN_OK_MESSAGE
                                                   object:nil];
    }
}

+ (void)collectStart
{
    //登录完成收集token
    //deviceToken收集发送
    CollectDeviceTokenCommand *command = [CollectDeviceTokenCommand command];
    command.city = [Config currentConfig].defaultCity;
    
    [command execute];
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_deviceToken);
    TT_RELEASE_SAFELY(_city);
    TT_RELEASE_SAFELY(_userId);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.appId = SNRNSuningEBuy;
    }
    return self;
}

- (void)execute
{
    //先将数据缓存
    //self.deviceToken = [@"testdata" dataUsingEncoding:NSUTF8StringEncoding];
    if (self.deviceToken)
    {
        [[SNFileCache defaultCache] saveData:self.deviceToken
                                        forKey:kCCDeviceTokenCacheKey
                                      cacheAge:kSNCacheAgeForever];
    }
    else
    {
        self.deviceToken = [[SNFileCache defaultCache] dataForKey:kCCDeviceTokenCacheKey];
    }
    
    if (self.city.length == 0)
    {
        self.city = [Config currentConfig].defaultCity;
    }
    
    if (self.user)
    {
        NSData *userData = [self.user.custNum dataUsingEncoding:NSUTF8StringEncoding];
        [[SNFileCache defaultCache] saveData:userData
                                        forKey:kCCUserIdCacheKey
                                      cacheAge:kSNCacheAgeForever];
        self.userId = self.user.custNum;
    }
    else
    {
        NSData *userIdData = [[SNFileCache defaultCache] dataForKey:kCCUserIdCacheKey];
        self.userId = [[NSString alloc] initWithData:userIdData encoding:NSUTF8StringEncoding];
    }
    
    [self startCollect];
}

- (BOOL)deviceInfoIsChanged:(BOOL *)isFirstSave
{
    NSData *oldDeviceToken = [[SNFileCache defaultCache] dataForKey:kCCDeviceTokenSendCacheKey];
    NSData *oldCity = [[SNFileCache defaultCache] dataForKey:kCCCitySendCacheKey];
    NSData *oldUserId = [[SNFileCache defaultCache] dataForKey:kCCUserIdSendCacheKey];
    NSData *oldVersion = [[SNFileCache defaultCache] dataForKey:kCCSoftVersionSendCacheKey];
    NSData *oldAcceptType = [[SNFileCache defaultCache] dataForKey:kCCAcceptTypeSendCacheKey];
    
    if (oldDeviceToken) {
        *isFirstSave = NO;
    }else{
        *isFirstSave = YES;
    }

    BOOL isDeviceTokenChanged = YES;
    BOOL isCityChanged = YES;
    BOOL isUserChanged = YES;
    BOOL isVersionUpdated = YES;
    BOOL isAcceptTypeChanged = YES;
    
    if (oldDeviceToken && [self.deviceToken isEqualToData:oldDeviceToken])
    {
        isDeviceTokenChanged = NO;
    }
    
    NSData *cityData = [self.city dataUsingEncoding:NSUTF8StringEncoding];
    if (oldCity && [cityData isEqualToData:oldCity])
    {
        isCityChanged = NO;
    }
    
    NSData *userIdData = [self.userId dataUsingEncoding:NSUTF8StringEncoding];
    if (oldUserId && [oldUserId isEqualToData:userIdData])
    {
        isUserChanged = NO;
    }
    
    NSData *versionData = [[SystemInfo appVersion] dataUsingEncoding:NSUTF8StringEncoding];
    if (oldVersion && [oldVersion isEqualToData:versionData])
    {
        isVersionUpdated = NO;
    }
    
    NSData *acceptTypeData = [[[Config currentConfig].messageFilter stringValue] dataUsingEncoding:NSUTF8StringEncoding];
    if (oldAcceptType && [oldAcceptType isEqualToData:acceptTypeData])
    {
        isAcceptTypeChanged = NO;
    }
    
    return isDeviceTokenChanged || isCityChanged || isUserChanged || isVersionUpdated ||isAcceptTypeChanged;
}

- (void)startCollect
{
    //deviceToken和city必传
    if (self.deviceToken.length == 0 || self.city.length == 0)
    {
        return;
    }
    
    //与上次发送未改动，则不收集
    BOOL isFirstSave = YES;
    if (![self deviceInfoIsChanged:&isFirstSave])
    {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @autoreleasepool {
            
           NSString *urlstr = [NSString stringWithFormat:@"%@/%@",
                               kMobileHostAddress, @"addToken.do"];
           //NSString *urlstr = [NSString stringWithFormat:@"%@/%@",
                                //@"http://10.19.112.33:8080/mms", @"addToken.do"];
            
            NSURL *url = [NSURL URLWithString:urlstr];
            ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
            [request setTimeOutSeconds:30];
            [request setShouldContinueWhenAppEntersBackground:YES];
            
            NSString *tokenStr = [PasswdUtil hexStringForData:self.deviceToken];
            
            tokenStr = [PasswdUtil encryptString:tokenStr
                                          forKey:kCollectTokenParamEncodeKey
                                            salt:kCollectTokenParamEncodeSalt];
            
            [request setPostValue:self.city forKey:@"cityId"];
            [request setPostValue:@"" forKey:@"address"];
            [request setPostValue:@(self.appId) forKey:@"appId"];
            [request setPostValue:[SystemInfo appVersion] forKey:@"appVersion"];
            [request setPostValue:[self deviceType] forKey:@"deviceType"];
            [request setPostValue:[self email] forKey:@"email"];
            [request setPostValue:[SystemInfo osVersion] forKey:@"osVersion"];
            [request setPostValue:self.user.phoneNo forKey:@"phone"];
            [request setPostValue:@"1" forKey:@"platform"];
            [request setPostValue:self.user.internalNum forKey:@"pointBalance"];
            [request setPostValue:[[Config currentConfig].messageFilter stringValue] forKey:@"acceptType"];
            
            NSString *sex = self.user.sex;
            if (sex.trim.length == 0) {
                sex = @"M";
            }
            [request setPostValue:sex forKey:@"sex"];
            [request setPostValue:tokenStr forKey:@"token"];
            [request setPostValue:[OpenUDID value] forKey:@"uniqueMark"];
            [request setPostValue:self.userId forKey:@"userId"];
            [request setPostValue:self.user.userName forKey:@"userName"];
            [request setPostValue:self.user.yifubaoBalance forKey:@"yfbBalance"];
            
            //0代表新增， 1代表修改
            [request setPostValue:isFirstSave?@"0":@"1" forKey:@"saveFlag"];
            
            [request startSynchronous];
            
            if (request.error == nil && request.responseStatusCode == 200)
            {
                //发送成功后，保存信息
                NSData *cityData = [self.city dataUsingEncoding:NSUTF8StringEncoding];
                NSData *userData = [self.userId dataUsingEncoding:NSUTF8StringEncoding];
                NSData *versionData = [[SystemInfo appVersion] dataUsingEncoding:NSUTF8StringEncoding];
                NSData *acceptType = [[[Config currentConfig].messageFilter stringValue] dataUsingEncoding:NSUTF8StringEncoding];

                [[SNFileCache defaultCache] saveData:self.deviceToken
                                                forKey:kCCDeviceTokenSendCacheKey
                                              cacheAge:kSNCacheAgeForever];
                [[SNFileCache defaultCache] saveData:cityData
                                                forKey:kCCCitySendCacheKey
                                              cacheAge:kSNCacheAgeForever];
                
                [[SNFileCache defaultCache] saveData:userData
                                                forKey:kCCUserIdSendCacheKey
                                              cacheAge:kSNCacheAgeForever];
                [[SNFileCache defaultCache] saveData:versionData
                                                forKey:kCCSoftVersionSendCacheKey
                                              cacheAge:kSNCacheAgeForever];
                [[SNFileCache defaultCache] saveData:acceptType
                                              forKey:kCCAcceptTypeSendCacheKey
                                            cacheAge:kSNCacheAgeForever];
                
            }
        }
    });
}

- (NSString *)deviceType
{
    NSString *platform = [SystemInfo platform];
    if ([platform hasPrefix:@"iPhone"])
    {
        return @"1";
    }
    else if ([platform hasPrefix:@"iPad"])
    {
        return @"2";
    }
    else if ([platform hasPrefix:@"iPod"])
    {
        return @"3";
    }
    return @"1";
}

- (NSString *)email
{
    if ([self.user.logonId rangeOfString:@"@"].location != NSNotFound)
    {
        return self.user.logonId;
    }
    return @"";
}

@end
