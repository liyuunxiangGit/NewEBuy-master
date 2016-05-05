//
//  FormattersValidators.h
//  SuningEBuy
//
//  Created by xie wei on 13-7-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FormattersValidators : NSObject

+ (BOOL)isValidEmail:(NSString*)value;
+ (BOOL)isValidPhone:(NSString*)value;

@end
