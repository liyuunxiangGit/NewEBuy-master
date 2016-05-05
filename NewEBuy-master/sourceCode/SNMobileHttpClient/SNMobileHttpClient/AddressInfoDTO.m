//
//  AddressInfoDTO.m
//  SuningEMall
//
//  Created by Wang Jia on 11-1-12.
//  Copyright 2011 IBM. All rights reserved.
//

#import "AddressInfoDTO.h"

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
    
    self.addressNo = EncodeStringFromDic(dic, @"addressNo").trim;
	self.province = EncodeStringFromDic(dic, @"province").trim;
    self.provinceContent = EncodeStringFromDic(dic, @"provinceName").trim;
    self.city = EncodeStringFromDic(dic, @"city").trim;
    self.cityContent = EncodeStringFromDic(dic, @"cityName").trim;
    self.district = EncodeStringFromDic(dic, @"district").trim;
    self.districtContent = EncodeStringFromDic(dic, @"districtName").trim;
    self.town = EncodeStringFromDic(dic, @"town").trim;
    self.townContent = EncodeStringFromDic(dic, @"townName").trim;
    self.addressContent = EncodeStringFromDic(dic, @"addressContent").trim;
    self.recipient = EncodeStringFromDic(dic, @"recipient").trim;
    self.tel = EncodeStringFromDic(dic, @"tel").trim;
    self.addressType = [EncodeStringFromDic(dic, @"usedByEasilyBuy") isEqualToString:@"1"]?EasilyBuyAddress:NormalAddress;
}

- (void)encodeLastShipInfoFromDictionary:(NSDictionary *)dic
{
    if (dic == nil) {
        return;
    }
    
    self.province = EncodeStringFromDic(dic, @"provinceId");
    self.provinceContent = EncodeStringFromDic(dic, @"provinceName");
    if (!self.provinceContent.trim.length) {
        self.provinceContent = @"null";
    }
    
    self.city = EncodeStringFromDic(dic, @"cityId");
    self.cityContent = EncodeStringFromDic(dic, @"cityName");
    if (!self.cityContent.trim.length) {
        self.cityContent = @"null";
    }
    
    self.district = EncodeStringFromDic(dic, @"district");
    self.districtContent = EncodeStringFromDic(dic, @"districtName");
    if (!self.districtContent.trim.length) {
        self.districtContent = @"null";
    }
    
    self.town = EncodeStringFromDic(dic, @"town");
    self.townContent = EncodeStringFromDic(dic, @"townName");
    if (!self.townContent.trim.length) {
        self.townContent = @"null";
    }
    
    self.addressContent = EncodeStringFromDic(dic, @"detail");
    self.addressNo = EncodeStringFromDic(dic, @"addressId");
    self.recipient = EncodeStringFromDic(dic, @"name");
    self.tel = EncodeStringFromDic(dic, @"cellphone");
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
