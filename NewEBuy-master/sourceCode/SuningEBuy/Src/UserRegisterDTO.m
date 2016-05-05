//
//  UserRegisterDTO.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-4-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UserRegisterDTO.h"

@implementation UserRegisterDTO

@synthesize registerId                  = _registerId;
@synthesize registerPassword            = _registerPassword;
@synthesize registerPasswordVerify      = _registerPasswordVerify;
@synthesize vcodeimg2                   = _vcodeimg2;
@synthesize actionType                  = _actionType;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_actionType);
    TT_RELEASE_SAFELY(_registerPasswordVerify);
    TT_RELEASE_SAFELY(_registerPassword);
    TT_RELEASE_SAFELY(_registerId);
    TT_RELEASE_SAFELY(_vcodeimg2);
    
}


- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
}



@end
