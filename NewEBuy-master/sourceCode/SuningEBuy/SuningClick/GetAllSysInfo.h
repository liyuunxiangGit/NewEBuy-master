//
//  GetAllSysInfo.h
//  SuningEBuy
//
//  Created by xy ma on 11-12-27.
//  Copyright (c) 2011年 sn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InformetionCollectDTO.h"
#import "Preferences.h"
#import "AppDelegate.h"
#import "SaveSuningUUID.h"
#import <CommonCrypto/CommonDigest.h>
#include <unistd.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <string.h>

@interface GetAllSysInfo : NSOperation


-(void) saveSystemInfoDTO;

+ (NSString *) md5:(NSString *)str; 


@end
