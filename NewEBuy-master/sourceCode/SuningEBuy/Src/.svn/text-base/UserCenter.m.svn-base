//
//  UserCenter.m
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "UserCenter.h"
#import "RegistHandselCouponCommand.h"
#import "SFHFKeychainUtils.h"

@interface UserCenter()

@property (nonatomic, strong) UserLoginService *loginService;
@property (nonatomic, strong) NSString *regsitCouponUserId;

- (void)changeEfubaoStatus;

@end

/*********************************************************************/

@implementation UserCenter

@synthesize isLogined = _isLogined;
@synthesize userInfoDTO = _userInfoDTO;
@synthesize lastUserId = _lastUserId;
@synthesize userDiscountInfoDTO = _userDiscountInfoDTO;
@synthesize loginService = _loginService;
@synthesize efubaoStatus = _efubaoStatus;
@synthesize isNoticeOutDateCoupon = _isNoticeOutDateCoupon;
@synthesize isGetRedPack = _isGetRedPack;

- (void)dealloc {
    TT_RELEASE_SAFELY(_userInfoDTO);
    TT_RELEASE_SAFELY(_lastUserId);
    TT_RELEASE_SAFELY(_userDiscountInfoDTO);
    SERVICE_RELEASE_SAFELY(_loginService);
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        _isLogined = NO;
        _isNoticeOutDateCoupon = NO;
        _isGetRedPack = NO;
    }
    
    return self;
}


#pragma mark - UserInfo Methods
#pragma mark   用户信息模块

- (void)setUserInfoDTO:(UserInfoDTO *)userInfoDTO
{
    if (userInfoDTO != _userInfoDTO) {
        
        if (userInfoDTO) {
            _isLogined = YES;
        }else{
            _isLogined = NO;
            self.hasTrustLoginToEpp = NO;
            //self.lastUserId = _userInfoDTO.userId;
        }
        
        _userInfoDTO = userInfoDTO;
        _isNoticeOutDateCoupon = NO;
        
        [self doSendRegistCoupon];
    }
}


- (void)setUserDiscountInfoDTO:(UserDiscountInfoDTO *)userDiscountInfoDTO{
    
    if (_userDiscountInfoDTO != userDiscountInfoDTO) {
        
        TT_RELEASE_SAFELY(_userDiscountInfoDTO);
        
        _userDiscountInfoDTO = userDiscountInfoDTO;
    }
    
}

- (void)setCabInfo:(IPInfoDTO *)cabInfo
{
    if (_cabInfo != cabInfo) {
        TT_RELEASE_SAFELY(_cabInfo);
        _cabInfo = cabInfo;
    }
}

- (void)setImpInfo:(IPInfoDTO *)impInfo
{
    if (_impInfo != impInfo) {
        TT_RELEASE_SAFELY(_impInfo);
        _impInfo = impInfo;
    }
}

- (void)setOfsInfo:(IPInfoDTO *)ofsInfo
{
    if (_ofsInfo != ofsInfo) {
        TT_RELEASE_SAFELY(_ofsInfo);
        _ofsInfo = ofsInfo;
    }
}


#pragma mark - Efubao Methods
#pragma mark   易付宝模块相关代码
- (eEfubaoStatus)efubaoStatus{
    
    [self changeEfubaoStatus];
    
    return _efubaoStatus;
}

-(void)setEfubaoStatus:(eEfubaoStatus)efubaoStatus{
    
    if (_efubaoStatus != efubaoStatus) {
        
        _efubaoStatus = efubaoStatus;
        
        switch (efubaoStatus) {
            case eLoginByPhoneUnBound:{
                
                self.userInfoDTO.isBindMobile = @"0";
                self.userInfoDTO.eppStatuss = @"0";
            }
                
                break;
                
            case eLoginByPhoneActive:{
                
                self.userInfoDTO.isBindMobile = @"1";
                self.userInfoDTO.eppStatuss = @"1";
            }
                
                break;
                
            case eLoginByPhoneUnActive:{
                
                self.userInfoDTO.isBindMobile = @"1";
                self.userInfoDTO.eppStatuss = @"0";
            }
                
                break;
                
            case eLoginByEmailUnBound:{
                
                self.userInfoDTO.emailStatus = @"0";
                self.userInfoDTO.isBindMobile = @"0";
                self.userInfoDTO.eppStatuss = @"0";
                
            }
                break;
            case eLoginByEmailPhoneUnBound:{
                
                self.userInfoDTO.emailStatus = @"1";
                self.userInfoDTO.isBindMobile = @"0";
                self.userInfoDTO.eppStatuss = @"0";
            }
                break;
                
            case eLoginByEmailUnActive:{
                
                self.userInfoDTO.emailStatus = @"1";
                self.userInfoDTO.isBindMobile = @"1";
                self.userInfoDTO.eppStatuss = @"0";
            }
                break;
                
            case eLoginByEmailActive:{
                
                self.userInfoDTO.emailStatus = @"1";
                self.userInfoDTO.isBindMobile = @"1";
                self.userInfoDTO.eppStatuss = @"1";
                
            }
                break;
                
            default:{
                
                self.userInfoDTO.emailStatus = @"0";
                self.userInfoDTO.isBindMobile = @"0";
                self.userInfoDTO.eppStatuss = @"0";
                
            }
                break;
        }
        
    }
    
}

- (void)changeEfubaoStatus{
    
    if (!_isLogined) {
        
        _efubaoStatus = eUserUnLogin;
        
    }else{
        
        //判定手机登录还是邮箱登录
        NSString *logonName = self.userInfoDTO.logonId;
        
        NSRange range = [logonName rangeOfString:@"@"];
        
        if (range.location == NSNotFound) {
            
            if ([self.userInfoDTO.isBindMobile boolValue] == YES) {
                
                if ([self.userInfoDTO.eppStatuss boolValue]==YES) {
                    
                    _efubaoStatus = eLoginByPhoneActive;
                    
                }else{
                    
                    _efubaoStatus = eLoginByPhoneUnActive;
                    
                }
                
            }else{
                
                _efubaoStatus = eLoginByPhoneUnBound;
            }
            
            
        }else{
            
            if ([self.userInfoDTO.emailStatus boolValue] == YES) {
                
                if ([self.userInfoDTO.isBindMobile boolValue]==YES) {
                    
                    if ([self.userInfoDTO.eppStatuss boolValue]==YES) {
                        
                        _efubaoStatus = eLoginByEmailActive;
                    }else{
                        
                        
                        _efubaoStatus = eLoginByEmailUnActive;
                    }
                    
                    
                }else{
                    // edited by gjf
                    if ([self.userInfoDTO.eppStatuss boolValue]==YES) {
                        
                        _efubaoStatus = eLoginByEmailActive;
                    }else{
                        _efubaoStatus = eLoginByEmailPhoneUnBound;
                    }
                    
                }
                
            }else{
                
                _efubaoStatus = eLoginByEmailUnBound;
                
            }
        }
    }
}

- (AddressInfoDTO *)defaultAddressInfo
{
    if (!_isLogined) {
        return nil;
    }else{
        NSArray *addressList = [[self userInfoDTO] addressArray];
        
        if (addressList && [addressList count] > 0) {
            AddressInfoDTO *resultDTO = nil;
            NSString *defaultAddressNo = [Config currentConfig].defaultAddressId;
            for (AddressInfoDTO *dto in addressList){
                if ([dto.addressNo isEqualToString:defaultAddressNo]) {
                    resultDTO = dto;
                    break;
                }
            }
            
            if (resultDTO == nil) {
                resultDTO = [addressList objectAtIndex:0];
            }
            
            return resultDTO;
            
        }else{
            return nil;
        }
    }
}

- (AddressInfoDTO *)getAddressInfoByCity:(NSString *)cityCode
{
    if (!_isLogined) {
        return nil;
    }else{
        NSArray *addressList = [[self userInfoDTO] addressArray];        
        if (addressList && [addressList count] > 0) {
            AddressInfoDTO *resultDTO = nil;
            for (AddressInfoDTO *dto in addressList){
                if ([dto.city isEqualToString:cityCode]) {
                    resultDTO = dto;
                    break;
                }
            }
            return resultDTO;
        }else{
            return nil;
        }
    }
}

- (void)clearUserInfo{
    
    self.userInfoDTO = nil;
    self.userDiscountInfoDTO = nil;
    //    self.token = @"";
    //    self.ofsInfo = nil;
    //    self.cabInfo = nil;
    self.userType = @"";
    
    //清cookie
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
                        cookies];
    for (NSHTTPCookie *cookie in cookies)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

- (void)markAsLogout
{
    [self clearUserInfo];
    [[NSNotificationCenter defaultCenter] postNotificationName:LOGOUT_OK_NOTIFICATION
                                                        object:nil
                                                      userInfo:nil];
}

#pragma mark Singleton methods
#pragma mark 单例方法

static UserCenter *defaultUserCenter = nil;

+ (UserCenter *)defaultCenter
{
    @synchronized(self){
        if (defaultUserCenter == nil) {
            defaultUserCenter = [[UserCenter alloc] init];
        }
    }
    return defaultUserCenter;
}


/**
 * 记录需要注册送券的账号
 */
- (void)sendCouponAfterRegistForUser:(NSString *)userId
{
    self.regsitCouponUserId = userId;
    
    if (self.isLogined)
    {
        [self doSendRegistCoupon];
    }
}

- (void)doSendRegistCoupon
{
    if ([self.regsitCouponUserId isEqualToString:self.userInfoDTO.userId])
    {
        RegistHandselCouponCommand *manage =
        [[RegistHandselCouponCommand alloc] initWithUserId:self.regsitCouponUserId];
        [CommandManage excuteCommand:manage completeBlock:nil];
        
        self.regsitCouponUserId = nil;
    }
//    if ([self.regsitCouponUserId isEqualToString:[SFHFKeychainUtils getPasswordForUsername:kSuningLoginUserNameKey
//                                                                            andServiceName:kSNKeychainServiceNameSuffix
//                                                                                     error:nil]])
//    {
//        RegistHandselCouponCommand *manage =
//        [[RegistHandselCouponCommand alloc] initWithUserId:self.regsitCouponUserId];
//        [CommandManage excuteCommand:manage completeBlock:nil];
//        
//        self.regsitCouponUserId = nil;
//    }

}

@end
