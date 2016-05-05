//
//  NSNumber+Additions.m
//  SuningEBuy
//
//  Created by  liukun on 13-8-22.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "NSNumber+Additions.h"

@implementation NSNumber (Additions)

- (NSString *)formatPriceString
{
    CFLocaleRef currentLocale = CFLocaleCopyCurrent();
    CFNumberFormatterRef formatter = CFNumberFormatterCreate(NULL, currentLocale, kCFNumberFormatterDecimalStyle);
    
    CFNumberFormatterSetFormat(formatter, CFSTR("￥###,###,###,###,###,##0.00"));
    double price = [self doubleValue];
    CFNumberRef priceNumber = CFNumberCreate(NULL, kCFNumberDoubleType, &price);
    CFStringRef string = CFNumberFormatterCreateStringWithNumber(NULL, formatter, priceNumber);
    
    CFRelease(currentLocale);
    CFRelease(formatter);
    CFRelease(priceNumber);
   
    return (__bridge_transfer NSString *)string;
}

@end
