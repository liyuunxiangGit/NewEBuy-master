//
//  NSObject+JSON.h
//  SuningEBuy
//
//  Created by liukun on 14-5-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (JSON)

- (NSString *)JSONRepresentation;

@end


#pragma mark JSON Parsing

/// Adds JSON parsing methods to NSString
@interface NSString (JSON)

- (id)JSONValue2;

@end

/// Adds JSON parsing methods to NSData
@interface NSData (JSON)

- (id)JSONValue2;

@end
