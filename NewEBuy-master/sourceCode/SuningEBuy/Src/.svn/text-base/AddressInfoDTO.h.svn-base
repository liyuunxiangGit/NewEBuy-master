//
//  AddressInfoDTO.h
//  SuningEMall
//
//  Created by Wang Jia on 11-1-12.
//  Copyright 2011 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseHttpDTO.h"

typedef enum {
    NormalAddress,          //普通地址
    MainAddress,            //用户主地址
    EasilyBuyAddress,       //一键购地址
}AddressType;

@interface AddressInfoDTO : BaseHttpDTO <NSCopying, NSMutableCopying>{
	NSString *_addressNo;
	NSString *_province;
	NSString *_city;
	NSString *_district;
	NSString *_town;
	NSString *_provinceContent;
	NSString *_cityContent;
	NSString *_districtContent;
	NSString *_townContent;
	NSString *_addressContent;
	NSString *_recipient;
	NSString *_tel;
    
    AddressType _addressType;
}

@property (nonatomic, copy) NSString *addressNo;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *town;

@property (nonatomic, copy) NSString *provinceContent;
@property (nonatomic, copy) NSString *cityContent;
@property (nonatomic, copy) NSString *districtContent;
@property (nonatomic, copy) NSString *townContent;

@property (nonatomic, copy) NSString *addressContent;
@property (nonatomic, copy) NSString *recipient;
@property (nonatomic, copy) NSString *tel;

@property (nonatomic) BOOL preferFlag;    //是否是默认地址:100000000010，默认;其他为非默认

@property (nonatomic, assign) AddressType addressType;

//拷贝基本地址信息，不包括详细地址，收货人等字段
- (void)copySimpleAddressInfoFromAnotherAddress:(AddressInfoDTO *)address;

//检验有效字段是否与另一个dto完全相同，不检验addressNo
- (BOOL)isEqualToAddress:(AddressInfoDTO *)address;

//基本解析方法
- (void)encodeFromDictionary:(NSDictionary *)dic;

//用户最新使用地址信息的解析方法
- (void)encodeLastShipInfoFromDictionary:(NSDictionary *)dic;

//检验地址是否非法，过期，（地址信息中是否包括null,因地址主站更新导致的问题，需要添加该校验）
- (BOOL)isThrowNULLError;
@end
