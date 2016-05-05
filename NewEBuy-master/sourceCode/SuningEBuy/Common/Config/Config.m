//
//  Config.m
//  
//
//  Created by     on 2010-4-18
//  Email:   --- at--- gmail.com
//  MSN:     --- at--- tom.com
//  Web Home:       
//  Copyright 2010   .All rights reserved.
//


#import "NSString+SEL.h"

@implementation Config

@synthesize defaults;

@dynamic fontSize;
@dynamic fontColor;
@dynamic autoUpdate;
@dynamic logined;
@dynamic username;
@dynamic email;
@dynamic uid;
@dynamic userId;
@dynamic shoppingCartUserId;
@dynamic password;
@dynamic savePassword;
@dynamic isEfubaoActivate;
@dynamic isBindMobile;
@dynamic isEmailActivated;
@dynamic isSoundOn;
@dynamic isShackOn;
@dynamic isNoticeOn;
@dynamic isAutoLoginOn;
@dynamic promptTimes;

@dynamic latitude;
@dynamic longitude;

@dynamic phoneNumData;

@dynamic trafficMode;


@dynamic lastLoginTabIndex;

@dynamic ipAddress;

@dynamic isAMPM;

@dynamic serverURL;

@dynamic topBannerList;
@dynamic topAdList;
@dynamic topBookAdList;

@dynamic topSearchAdList; //add by wangjiaxing
@dynamic specialSubjectList; //add by wangjiaxing
@dynamic actList;

@dynamic centerBannerList;

@dynamic defaultProvince;

@dynamic defaultCity;

@dynamic defaultSection;

@dynamic deliveryCity;

@dynamic defaultAddressId;

@dynamic isTopBannerImageLoaded;
@dynamic isTopAdListImageLoaded;

@dynamic loginShoppingCartArr;
@dynamic unloginShoppingCartArr;
@dynamic efubaoInfoList;

@dynamic md5Timestring;
@dynamic pageKey;
@dynamic startTime;
@dynamic stopTime;

@dynamic todayDate;
@dynamic sendCount;

@dynamic checkUserLoginOrNot;

@dynamic getCodeList;

@dynamic payServiceList;

@dynamic payWaterList;

@dynamic payElectricList;

@dynamic payGasList;

@dynamic productTotalPrice;

@dynamic helperVersion;



@dynamic addressUpdateDttm;

@dynamic addressUpdateProvinceCodeLast;

@dynamic addressUpdateProvinceLast;

@dynamic cityUpdateInfo;

@dynamic payMobileNum;

@dynamic storeInfo;

@dynamic haveHandCheckVersion;
@dynamic pushMessageId;

@dynamic lotteryCatArray;
@dynamic allLotteryArray;

@dynamic gbHistoryArray;
@dynamic gbDefaultCityId;
@dynamic gbDefaultCityName;
@dynamic gbCityList;

@dynamic businessFromCity;
@dynamic businessToCity;
@dynamic isFirstUseAddress;
@dynamic imageQuailty;

@dynamic userContractMethod;
@dynamic userContractPhoneMethod;
@dynamic userContractType;

@dynamic locationCity;

@dynamic isRegist;
@dynamic advInfoList;
@dynamic nearByCityName;
@dynamic nearByCityId;
@dynamic loginHistoryList;
@dynamic dmIdHistoryDic;
@dynamic travelCityList;

@dynamic isFirstLocateCity;
@dynamic nearByUnLocate;

@dynamic isGPSCitySaved;
@dynamic gpsCityCode;

@dynamic phoneCategory;

@dynamic messageFilter;

@dynamic wegType;

@dynamic launchDms;



-(id) init {
	
    if(!(self = [super init]))
        return self;
	
    self.defaults = [NSUserDefaults standardUserDefaults];
	
    [self.defaults registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys:
                                     
                                     
                                     [NSNumber numberWithLong:16],          dFontSize,
                                     @"",                                   dFontColor,
                                     [NSNumber numberWithBool:       YES],  dAutoUpdate,
                                     [NSNumber numberWithBool:       NO],   dLogined,
                                     @"",                                   dUsername,
                                     @"",                                   dEmail,						  
                                     
                                     [NSNumber numberWithInt:-1],            dUID,
                                     @"",                                    dUserId,
                                     @"",                                    dShoppingCartUserId,
                                     @"",                                    dPassword,
                                     
                                     [NSNumber numberWithBool:       YES],   dSavePassword,
                                     [NSNumber numberWithBool:       YES],   dSoundOn,
                                     [NSNumber numberWithBool:       NO], dIsEfubaoActivate  ,
                                     [NSNumber numberWithBool:       NO], dIsBindMobile  ,
                                     [NSNumber numberWithBool:       NO], dIsEmailActivated  ,
                                     [NSNumber numberWithBool:       NO],   dShackOn,
                                     [NSNumber numberWithBool:       YES],   dNoticeOn,
                                     [NSNumber numberWithBool:       NO],    dIsAutoLoginOn,
                                     [NSNumber numberWithInt:0],             dPromptTimes,
                                     [NSNumber numberWithFloat:0],           dLatitude,
                                     [NSNumber numberWithFloat:0],           dLongitude,						  
                                     [NSNumber numberWithFloat:0],           dIsTopBannerImageLoaded,	
                                     [NSNumber numberWithFloat:0],           dIsTopAdListImageLoaded,
                                     
                                     
                                     @"",                                    dTrafficMode,		
                                     
                                     
                                     [NSNumber numberWithInt:   0],          dLastLoginTabIndex,
                                     
                                     @"",                                    dIpAddress,	
                                     
                                     
                                     [NSNumber numberWithBool:        NO],   dIsAMPM,	
                                     
                                     @"",                                    dServerURL,
                                     [NSArray arrayWithArray:nil],           dTopBannerList,
                                     [NSArray arrayWithArray:nil],           dTopAdList,
                                     [NSArray arrayWithArray:nil],           dTopBookAdList,
                                     [NSArray arrayWithArray:nil],           dTopSearchAdList,
                                     [NSArray arrayWithArray:nil],           dSpecialSubjectList,
                                     [NSArray arrayWithArray:nil],           dm2DaJuHuiList,
                                     [NSArray arrayWithArray:nil],           dActList,
                                     [NSArray arrayWithArray:nil],           dCenterBannerList,
                                     
                                     @"100",                                  dDefaultProvince,
                                     @"9173",                                 dDefaultCity,
//                                     @"10",                                  dDefaultProvince,
//                                     @"9017",                                 dDefaultCity,

                                     @"11365",                                 dDefaultSection,
                                     
                                     @"",                                      dDeliveryCity,
                                     
                                     @"",                                     dDefaultAddressId,
                                     [NSMutableArray arrayWithArray:nil],            dLoginShoppingCartArr,
                                     [NSMutableArray arrayWithArray:nil],            dUnloginShoppingCartArr,
                                     [NSArray arrayWithArray:nil],            dEfubaoInfoList,
                                     
                                     @"",                                     dMd5Timestring,
                                     [NSNumber numberWithInt:0],              dPageKey,
                                     
                                     @"",                                     dStartTime,
                                     @"",                                     dStopTime,
                                     
                                     @"",                                     dTodayDate,
                                     [NSNumber numberWithInt:0],              dSendCount,
                                     [NSNumber numberWithBool:        NO],    dCheckUserLoginOrNot,
                                     [NSMutableArray arrayWithArray:nil],     dGetCodeList,
                                     [NSMutableArray arrayWithArray:nil],     dPayServiceList,
                                     [NSMutableArray arrayWithArray:nil],     dPayWaterList,
                                     [NSMutableArray arrayWithArray:nil],     dPayElectricList,
                                     [NSMutableArray arrayWithArray:nil],     dpayGasList,
                                     [NSMutableArray arrayWithArray:nil],     dPhoneNumData,
                                     @"",                                     dProductTotalPrice,
                                     @"",
                                         dHelperVersion,
                                     [NSNumber numberWithDouble:0],           dAddressUpdateDttm,
                                     [NSNumber numberWithDouble:0],           dAddressUpdateProvinceLast,
                                     [NSNumber numberWithDouble:0],           dAddressUpdateProvinceCodeLast,

                                     
                                     [NSDictionary dictionary],               dCityUpdateInfo,
                                     @"",                                      dpayMobileNum,
                                     [NSData data],                           dStoreInfo,
                                     @"noCheck",                                      dHaveHandCheckVersion,
                                     @"",
                                     dPushMessageId,
                                     [NSMutableArray arrayWithArray:nil],     dLotteryCatArray,
                                     [NSMutableArray arrayWithArray:nil],     dAllLotteryArray,
                                     [NSMutableArray arrayWithArray:nil],     dGbHistoryArray,
                                     @"",
                                     dGbDefaultCityId,
                                     @"",
                                     dGbDefaultCityName,
                                     [NSMutableDictionary dictionaryWithCapacity:2],               dGbCityList,
                                     @"北京",dbusinessFromCity,@"上海",dbusinessToCity,
                                     @"0",                           dIsFirstUseAddress,
                                     [NSNumber numberWithInt:0],             dImageQuailty,
                                     [NSNumber numberWithInt:0],             dMessageFilter,
                                     
                                     @"",                             dUserContractMethod,
                                     @"",                             dUserContractPhoneMethod,
                                     @"",                             dUserContractType,
                                     @"南京市",                             dLocationCity,
                                     @"0",    dIsRegist,
                                     [NSMutableArray arrayWithArray:nil],     dAdvInfoList,
                                     @"南京市",                                dNearByCityName,
                                     @"9173",                                 dNearByCityId,
                                     [NSMutableArray arrayWithCapacity:5],      dLoginHistoryList,
                                     [NSMutableArray arrayWithCapacity:3],     dTravelCityList,
                                     @YES,                  @"isFirstLocateCity",
                                     @YES,                  dNearByUnLocate,
                                     
                                     @NO,                   @"isGPSCitySaved",
                                     @"",                   @"gpsCityCode",
                                     
                                     @"",                    dPhoneCategory,
                                     [NSMutableDictionary dictionary],     dDmIdHistoryDic,
                                     [NSNumber numberWithInt:0],
                                      dSearchType,
                                     
                                     [NSNumber numberWithInt:0],
                                     dWegType,
                                     
                                     [NSMutableArray array],dWaterAccounts,
                                     [NSMutableArray array],dElectricityAccounts,
                                     [NSMutableArray array],dGasAccounts,
                                     
                                     [NSMutableArray array],dlaunchDms,
                                     nil]];
    
    
	return self;
}

-(void) dealloc {
    self.nearByUnLocate = nil;
    self.travelCityList = nil;
    self.nearByCityName = nil;
    self.nearByCityId = nil;
	self.fontSize = nil;
	self.fontColor = nil;
	self.autoUpdate = nil;
    self.defaults = nil;
    self.logined = nil;
	self.username = nil;
	self.email   = nil;
	self.uid = nil;
	self.userId = nil;
    self.shoppingCartUserId = nil;
	self.password = nil;
	self.savePassword = nil;
    self.isEfubaoActivate = nil;
    self.isBindMobile = nil;
    self.isEmailActivated = nil;
	self.isSoundOn = nil;
    self.isShackOn = nil;
    self.isNoticeOn = nil;  
	self.isAutoLoginOn = nil; 
    self.promptTimes = nil;
	
	self.latitude = nil; 
	self.longitude = nil; 
    
	self.phoneNumData = nil;
    
	self.trafficMode = nil;
    
	self.lastLoginTabIndex = nil;
    
	self.ipAddress = nil;    
	
	self.isAMPM = nil;
	
	self.serverURL = nil;
    
    self.topBannerList = nil;
    
    self.topAdList = nil;
    
    self.topBookAdList = nil;
	
    self.topSearchAdList = nil; //add by wangjiaxing
    
    self.specialSubjectList = nil; //add by wangjiaxing
    
    self.m2DaJuHuiList = nil;
    
    self.actList = nil;
    
    self.centerBannerList = nil;
    
    self.isTopBannerImageLoaded = nil;
    
    self.isTopAdListImageLoaded = nil;
    
    self.defaultProvince = nil;
    
    self.defaultCity = nil;
    
    self.defaultSection = nil;
    
    self.deliveryCity = nil;
    
    self.defaultAddressId = nil;
    
    self.loginShoppingCartArr = nil;
    self.unloginShoppingCartArr = nil;
    self.efubaoInfoList  = nil;
    
    self.pageKey=nil;
    self.md5Timestring=nil;
    self.startTime=nil;
    self.stopTime = nil;
    
    self.todayDate = nil;
    self.sendCount = nil;
	
    self.checkUserLoginOrNot = nil;
    
    self.getCodeList = nil;
    self.payServiceList = nil;
    
    self.payWaterList = nil;
    self.payElectricList = nil;
    self.payGasList = nil;
    
    self.productTotalPrice = nil;
    
    
    self.helperVersion = nil;
    self.pushMessageId = nil;
    
    self.addressUpdateDttm = nil;
    self.addressUpdateProvinceLast = nil;
    self.addressUpdateProvinceCodeLast = nil;
    self.cityUpdateInfo = nil;
    self.payMobileNum = nil;
    self.storeInfo = nil;
    
    self.lotteryCatArray = nil;
    self.allLotteryArray = nil;
    
    self.gbHistoryArray = nil;
    
    self.gbDefaultCityId = nil;
    self.gbDefaultCityName = nil;
    self.gbCityList = nil;
    self.isFirstUseAddress = nil;
    
    self.imageQuailty = nil;
    
    self.messageFilter = nil;
    
    self.userContractMethod = nil;
    self.userContractPhoneMethod = nil;
    self.userContractType = nil;
    
    self.locationCity = nil;
    
    self.isRegist = nil;
    
    self.advInfoList = nil;
    self.loginHistoryList = nil;
    self.isFirstLocateCity = nil;
    
    self.phoneCategory = nil;
    
    self.dmIdHistoryDic = nil;
    
    self.wegType  = nil;
    self.waterAccounts = nil;
    self.electricityAccounts = nil;
    self.gasAccounts = nil;
    
    self.launchDms = nil;
}



+(Config *) currentConfig {
    
    static Config *instance;
	
    if(!instance)
		
        instance = [[Config alloc] init];
    
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
	
    
    
    if ([NSStringFromSelector(aSelector) hasPrefix:@"set"]){
		
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
	}
    //DLog(@"methodSignatureForSelector 2\n");
    return [NSMethodSignature signatureWithObjCTypes:"@@:"];
}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    NSString *selector = NSStringFromSelector(anInvocation.selector);
    if ([selector hasPrefix:@"set"]) {
        NSRange firstChar, rest;
        firstChar.location  = 3;
        firstChar.length    = 1;
        rest.location       = 4;
        rest.length         = selector.length - 5;
        
        selector = [NSString stringWithFormat:@"%@%@",
                    [[selector substringWithRange:firstChar] lowercaseString],
                    [selector substringWithRange:rest]];
        
        __unsafe_unretained id value;
        [anInvocation getArgument:&value atIndex:2];
		
		//DLog(@"forwardInvocation 1\n");
        
        if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]])
        {
            [self.defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:value] forKey:selector];
        }
        else
        {
            [self.defaults setObject:value forKey:selector];
        }
        
    }
    
    else {
		//DLog(@"forwardInvocation 2\n");
        id value = [self.defaults objectForKey:selector];
        
        if ([value isKindOfClass:[NSData class]]) 
        {
            void *cfValue = (__bridge void *)[NSKeyedUnarchiver unarchiveObjectWithData:value];
            [anInvocation setReturnValue:&cfValue];
        }
        else
        {
            [anInvocation setReturnValue:&value];
        }
                
    }
}



@end