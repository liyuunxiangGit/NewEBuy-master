//
//  NSDictionary+Additions.h
//  SuningEBuy
//
//  Created by Joe on 14-6-28.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(ValuePath)
- (NSInteger)intValue:(NSString*)path;
- (long)longValue:(NSString*)path;
- (float)floatValue:(NSString*)path;
- (NSString*)strValue:(NSString*)path;
- (NSInteger)intValue:(NSString*)path default:(NSInteger)defValue;
- (float)floatValue:(NSString*)path default:(float)defValue;
- (NSString*)strValue:(NSString*)path default:(NSString*)defValue;
-(NSArray *) arrayValue :(NSString *) path;
@end
