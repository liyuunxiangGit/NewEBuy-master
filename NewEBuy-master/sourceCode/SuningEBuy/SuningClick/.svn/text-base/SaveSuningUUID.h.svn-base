//
//  SaveSuningUUID.h
//  SuningOfficeBI
//
//  Created by xy ma on 11-12-19.
//  Copyright (c) 2011年 sn. All rights reserved.
//
//可以如下方式调用
//SaveSuningUUID * temp =  [SaveSuningUUID shareInstance];
//
//NSString *iNeedUUID = [temp saveIdentifier:@"SuningOfficeBI20"];
//


#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface SaveSuningUUID : NSObject{
    
    NSString *_uuid;
}

@property (nonatomic, retain) NSString *uuid;

+(SaveSuningUUID *)shareInstance;

- (NSString *)saveIdentifier:(NSString *)appName;

- (NSString *)getSecureValueForKey:(NSString *)key;

- (BOOL)storeSecureValue:(NSString *)value forKey:(NSString *)key;

@end
