//
//  StoreInfoDto.m
//  SuningEBuy
//
//  Created by wangrui on 12/15/11.
//  Copyright (c) 2011 suning. All rights reserved.
//

#import "StoreInfoDto.h"
#import "SettlementConstant.h"

#define kProvinceIdKey          @"provinceId"
#define kProvinceNameKey        @"provinceName"
#define kCityIdKey              @"cityId"
#define kCityNameKey            @"cityName"
#define kDistrictIdKey          @"districtId"
#define kDistrictNameKey        @"districtName"
#define kReceiptNameKey         @"receiptName"
#define kReceiptPhoneKey        @"receiptPhone"
#define kStoreAddressKey        @"storeAddress"
#define kStoreNameKey           @"storeName"
#define kStoreCodeKey           @"storeCode"

@implementation StoreInfoDto
@synthesize provinceId = _provinceId;
@synthesize provinceName = _provinceName;
@synthesize cityId = _cityId;
@synthesize cityName = _cityName;
@synthesize districtId = _districtId;
@synthesize districtName = _districtName;
@synthesize receiptName = _receiptName;
@synthesize receiptPhone = _receiptPhone;
@synthesize storeAddress = _storeAddress;
@synthesize storeName = _storeName;
@synthesize storeCode = _storeCode;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_provinceId);
    
    TT_RELEASE_SAFELY(_provinceName);
    
    TT_RELEASE_SAFELY(_cityId);
    
    TT_RELEASE_SAFELY(_cityName);
    
    TT_RELEASE_SAFELY(_districtId);
    
    TT_RELEASE_SAFELY(_districtName);

    TT_RELEASE_SAFELY(_receiptName);
    
    TT_RELEASE_SAFELY(_receiptPhone);
            
    TT_RELEASE_SAFELY(_storeAddress);
    
    TT_RELEASE_SAFELY(_storeName);
    
    TT_RELEASE_SAFELY(_storeCode);
    
}

- (id)init
{
    self = [super init];
    
    if (self) 
    {
        
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    StoreInfoDto *storeInfoCopy = nil;
    
    storeInfoCopy = [[[self class] allocWithZone:zone] init];
    
    storeInfoCopy->_provinceId = [self.provinceId mutableCopy];
    
    storeInfoCopy->_provinceName = [self.provinceName mutableCopy];
    
    storeInfoCopy->_cityId = [self.cityId mutableCopy];
    
    storeInfoCopy->_cityName = [self.cityName mutableCopy];
    
    storeInfoCopy->_districtId = [self.districtId mutableCopy];
        
    storeInfoCopy->_districtName = [self.districtName mutableCopy];
    
    storeInfoCopy->_receiptName = [self.receiptName mutableCopy];
    
    storeInfoCopy->_receiptPhone = [self.receiptPhone mutableCopy];
            
    storeInfoCopy->_storeAddress = [self.storeAddress mutableCopy];
    
    storeInfoCopy->_storeName = [self.storeName mutableCopy];
    
    storeInfoCopy->_storeCode = [self.storeCode mutableCopy];
    
    return storeInfoCopy;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_provinceId forKey:kProvinceIdKey];
    [aCoder encodeObject:_provinceName forKey:kProvinceNameKey];
    [aCoder encodeObject:_cityId forKey:kCityIdKey];
    [aCoder encodeObject:_cityName forKey:kCityNameKey];
    [aCoder encodeObject:_districtId forKey:kDistrictIdKey];
    [aCoder encodeObject:_districtName forKey:kDistrictNameKey];
    [aCoder encodeObject:_receiptName forKey:kReceiptNameKey];
    [aCoder encodeObject:_receiptPhone forKey:kReceiptPhoneKey];
    [aCoder encodeObject:_storeAddress forKey:kStoreAddressKey];
    [aCoder encodeObject:_storeName forKey:kStoreNameKey];
    [aCoder encodeObject:_storeCode forKey:kStoreCodeKey];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        self.provinceId = [aDecoder decodeObjectForKey:kProvinceIdKey];
        self.provinceName = [aDecoder decodeObjectForKey:kProvinceNameKey];
        self.cityId = [aDecoder decodeObjectForKey:kCityIdKey];
        self.cityName = [aDecoder decodeObjectForKey:kCityNameKey];
        self.districtId = [aDecoder decodeObjectForKey:kDistrictIdKey];
        self.districtName = [aDecoder decodeObjectForKey:kDistrictNameKey];
        self.receiptName = [aDecoder decodeObjectForKey:kReceiptNameKey];
        self.receiptPhone = [aDecoder decodeObjectForKey:kReceiptPhoneKey];
        self.storeAddress = [aDecoder decodeObjectForKey:kStoreAddressKey];
        self.storeName = [aDecoder decodeObjectForKey:kStoreNameKey];
        self.storeCode = [aDecoder decodeObjectForKey:kStoreCodeKey];
    }
    return self;
}

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
	NSString *shopName = [dic objectForKey:kShopInfoShopName];
    
	if (shopName && ![shopName isEmptyOrWhitespace])
    {
        NSArray *shopNameAndAddress = [shopName componentsSeparatedByString:@" "];
        
        if (shopNameAndAddress && [shopNameAndAddress count] > 1)
        {
            self.storeName = [shopNameAndAddress objectAtIndex:0];            
            
            self.storeAddress = [[[shopNameAndAddress objectAtIndex:1] componentsSeparatedByString:@"-"] objectAtIndex:0];
        }
        
	}
    
    self.storeCode = [dic objectForKey:kShopInfoShopCode];

}

- (void)encodeLastPickUpInfoFromDictionary:(NSDictionary *)dic
{
    NSString *__provinceId = [dic objectForKey:@"provinceId"];
    if (NotNilAndNull(__provinceId))   self.provinceId = __provinceId;
    
    NSString *__provinceName = [dic objectForKey:@"provinceName"];
    if (NotNilAndNull(__provinceName))   self.provinceName = __provinceName;
    
    NSString *__cityId = [dic objectForKey:@"cityId"];
    if (NotNilAndNull(__cityId))   self.cityId = __cityId;
    
    NSString *__cityName = [dic objectForKey:@"cityName"];
    if (NotNilAndNull(__cityName))   self.cityName = __cityName;
    
    NSString *__districtId = [dic objectForKey:@"districtId"];
    if (NotNilAndNull(__districtId))   self.districtId = __districtId;
    
    NSString *__districtName = [dic objectForKey:@"districtName"];
    if (NotNilAndNull(__districtName))   self.districtName = __districtName;
    
    NSString *__siteCode = [dic objectForKey:@"siteCode"];
    if (NotNilAndNull(__siteCode))   self.storeCode = __siteCode;
    
    
    NSString *__siteName = [dic objectForKey:@"siteName"];
    if (NotNilAndNull(__siteName) && ![__siteName isEmptyOrWhitespace]) {
        //根据lastPickUpInfoDTO.siteName 内容解析出店面名称和地址
        NSArray *shopNameAndAddress = [__siteName componentsSeparatedByString:@" "];
        
        if (shopNameAndAddress && [shopNameAndAddress count] > 1)
        {
            self.storeName = [shopNameAndAddress objectAtIndex:0];            
            self.storeAddress = [[[shopNameAndAddress objectAtIndex:1] 
                                  componentsSeparatedByString:@"-"] objectAtIndex:0];
        }
    }
    NSString *_name=[dic objectForKey:@"name"];
    if (NotNilAndNull(_name)) {
        self.receiptName = _name;
    }
    
    NSString *__cellphone = [dic objectForKey:@"cellphone"];
    if (NotNilAndNull(__cellphone))   self.receiptPhone = __cellphone;
    
    
    //先只使用手机号，故不使用电话号
    //NSString *__telephone = [dic objectForKey:@"telephone"];
    
}

@end
