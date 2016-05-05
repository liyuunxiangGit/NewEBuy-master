//
//  KCOpenUDID.m
//  SuningEBuy
//
//  Created by leo on 14-3-26.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "KCOpenUDID.h"
#define keychainidentifier @"SuningEBuy"
@implementation KCOpenUDID

+ (NSString*) value {
    return [self valuewithKeychain];
}

+ (NSString*)valuewithKeychain{
    NSString* openUDID = nil;
    KeychainItemWrapper *keyChain = [[KeychainItemWrapper alloc] initWithIdentifier:keychainidentifier                                                                    accessGroup:nil];
    id keychaindata = [keyChain objectForKey:(__bridge id)kSecAttrAccount];
    NSString *str = (NSString *)keychaindata;
    if (str.length==0) {
        openUDID = [super value];
        [keyChain setObject:openUDID forKey:(__bridge id)kSecAttrAccount];
        str=openUDID;
    }
    return str;
}

@end
