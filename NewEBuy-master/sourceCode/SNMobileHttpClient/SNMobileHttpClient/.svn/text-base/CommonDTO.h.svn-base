//
//  CommonDTO.h
//  SNMobileHttpClient
//
//  Created by liukun on 14-5-6.
//  Copyright (c) 2014年 suning. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key);
extern NSNumber* EncodeNumberFromDic(NSDictionary *dic, NSString *key);
extern NSDictionary *EncodeDicFromDic(NSDictionary *dic, NSString *key);
extern NSArray      *EncodeArrayFromDic(NSDictionary *dic, NSString *key);
extern NSArray      *EncodeArrayFromDicUsingParseBlock(NSDictionary *dic, NSString *key, id(^parseBlock)(NSDictionary *innerDic));

@interface CommonDTO : NSObject

- (void)encodeFromDictionary:(NSDictionary *)dic;

+ (id)dtoFromDic:(NSDictionary *)dic;

@end
