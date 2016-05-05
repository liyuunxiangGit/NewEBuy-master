//
//  NSObject+WBUtil.m
//  WiressSDKDemo
//
//  Created by wang ying on 12-8-13.
//  Copyright (c) 2012年 bysft. All rights reserved.
//

#import "NSObject+WBUtil.h"

@implementation NSObject (WBUtil)

@end

#pragma mark - NSString (NSString_Encoding)

@implementation NSString (NSString_Encoding)


- (NSString *)URLEncodedString
{
	return [self URLEncoding];
}

//- (NSString *)URLEncodedStringWithCFStringEncoding:(CFStringEncoding)encoding
//{
//	return [(NSString *) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)[[self mutableCopy] autorelease], NULL, CFSTR("￼!*'();:@&=+$,/?%#[]"), encoding) autorelease];
//}

@end