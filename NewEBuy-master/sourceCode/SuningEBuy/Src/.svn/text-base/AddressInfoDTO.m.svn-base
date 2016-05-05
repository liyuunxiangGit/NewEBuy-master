//
//  AddressInfoDTO.m
//  SuningEMall
//
//  Created by Wang Jia on 11-1-12.
//  Copyright 2011 IBM. All rights reserved.
//

#import "AddressInfoDTO.h"
#import "AppConstant.h"

@implementation AddressInfoDTO

@synthesize addressNo = _addressNo;
@synthesize province = _province;
@synthesize city = _city;
@synthesize district = _district;
@synthesize town = _town;
@synthesize addressContent = _addressContent;
@synthesize recipient = _recipient;
@synthesize tel = _tel;

@synthesize provinceContent = _provinceContent;
@synthesize cityContent = _cityContent;
@synthesize districtContent = _districtContent;
@synthesize townContent = _townContent;

@synthesize addressType = _addressType;

- (void)encodeFromDictionary:(NSDictionary *)dic{
    
	if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.addressNo = EncodeStringFromDic(dic, @"addressNo").trim;
    self.province = EncodeStringFromDic(dic, @"province").trim;
    self.provinceContent = EncodeStringFromDic(dic, @"provinceName");
    self.city = EncodeStringFromDic(dic, @"city").trim;
    self.cityContent = EncodeStringFromDic(dic, @"cityName");
    self.district = EncodeStringFromDic(dic, @"district").trim;
    self.districtContent = EncodeStringFromDic(dic, @"districtName");
    self.town = EncodeStringFromDic(dic, @"town").trim;
    self.townContent = EncodeStringFromDic(dic, @"townName");
    self.addressContent = EncodeStringFromDic(dic, @"addressContent");
    self.recipient = EncodeStringFromDic(dic, @"recipient");
    self.tel = EncodeStringFromDic(dic, @"tel");
    self.addressType = [EncodeStringFromDic(dic, @"usedByEasilyBuy") isEqualToString:@"1"]?EasilyBuyAddress:NormalAddress;
    self.preferFlag = [EncodeStringFromDic(dic, @"preferFlag") isEqualToString:@"100000000010"] ? YES : NO;
}

- (void)encodeLastShipInfoFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *__provinceId = EncodeStringFromDic(dic, @"provinceId");
    self.province = __provinceId;
    
    NSString *__provinceName = EncodeStringFromDic(dic, @"provinceName");
    if (__provinceName.length) {
        self.provinceContent = __provinceName;
    }else{
        self.provinceContent = @"null";
    }
    
    NSString *__cityId = EncodeStringFromDic(dic, @"cityId");
    self.city = __cityId;
    
    NSString *__cityName = EncodeStringFromDic(dic, @"cityName");
    if (__cityName.length) {
        self.cityContent = __cityName;
    }else{
        self.cityContent = @"null";
    }
    
    NSString *__districtId = EncodeStringFromDic(dic, @"districtId");
    self.district = __districtId;
    
    NSString *__districtName = EncodeStringFromDic(dic, @"districtName");
    if (__districtName.length) {
        self.districtContent = __districtName;
    }else{
        self.districtContent = @"null";
    }
    
    NSString *__townId = EncodeStringFromDic(dic, @"townId");
    self.town = __townId;
    
    NSString *__townName = EncodeStringFromDic(dic, @"townName");
    if (__townName.length) {
        self.townContent = __townName;
    }else{
        self.townContent = @"null";
    }
    
    NSString *__detail =EncodeStringFromDic(dic, @"detail");
    self.addressContent = __detail;
    
    NSString *__addressId = EncodeStringFromDic(dic, @"addressId");
    self.addressNo = __addressId;
    
    NSString *__name = EncodeStringFromDic(dic, @"name");
    self.recipient = __name;
    
    NSString *__cellphone = EncodeStringFromDic(dic, @"cellphone");
    self.tel = __cellphone;
    
    self.addressType = NormalAddress;
}


- (void)copySimpleAddressInfoFromAnotherAddress:(AddressInfoDTO *)address
{
    if (address == nil) {
        return;
    }
    self.province = address.province;
    self.provinceContent = address.provinceContent;
    self.city = address.city;
    self.cityContent = address.cityContent;
    self.district = address.district;
    self.districtContent = address.districtContent;
    self.town = address.town;
    self.townContent = address.townContent;
//    self.preferFlag = address.preferFlag;
}

- (BOOL)isEqualToAddress:(AddressInfoDTO *)address
{
    if (![_province isEqualToString:address.province])  return NO;
    if (![_city isEqualToString:address.city])  return NO;
    if (![_district isEqualToString:address.district])  return NO;
    if (![_town isEqualToString:address.town])  return NO;
    if (![_addressContent isEqualToString:address.addressContent])  return NO;
    if (![_recipient isEqualToString:address.recipient])  return NO;
    if (![_tel isEqualToString:address.tel])  return NO;
    if (_preferFlag != address.preferFlag)  return NO;
    return YES;
}

- (id)copyWithZone:(NSZone *)zone
{
    AddressInfoDTO *copy = [[[self class] allocWithZone:zone] init];    
    copy.addressNo = self.addressNo;
    copy.province = self.province;
    copy.city = self.city;
    copy.district = self.district;
    copy.town = self.town;
    copy.provinceContent = self.provinceContent;
    copy.cityContent = self.cityContent;
    copy.districtContent = self.districtContent;
    copy.townContent = self.townContent;
    copy.addressContent = self.addressContent;
    copy.recipient = self.recipient;
    copy.tel = self.tel;
    copy.addressType = self.addressType;
    copy.preferFlag = self.preferFlag;
    return copy;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    return [self copyWithZone:zone];
}

- (BOOL)isThrowNULLError
{
    if ([self.provinceContent rangeOfString:@"null"].location != NSNotFound) {
        return YES;
    }
    if ([self.cityContent rangeOfString:@"null"].location != NSNotFound) {
        return YES;
    }
    if ([self.districtContent rangeOfString:@"null"].location != NSNotFound) {
        return YES;
    }
    if ([self.townContent rangeOfString:@"null"].location != NSNotFound) {
        return YES;
    }
    return NO;
}

@end
