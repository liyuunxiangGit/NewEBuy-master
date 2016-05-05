//
//  SNABContact.m
//  SuningEBuy
//
//  Created by snping on 14-9-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SNABContact.h"

@implementation SNABContact

- (void) dealloc
{
	if (record) CFRelease(record);
}

- (id) initWithRecord: (ABRecordRef) aRecord
{
	if (self = [super init])
    {
      if (record) CFRelease(record);
        record = CFRetain(aRecord);
    }
	return self;
}

+ (id) contactWithRecord: (ABRecordRef) person
{
	return [[SNABContact alloc] initWithRecord:person];
}

- (NSString *) compositeName
{
	NSString *string =(NSString *)CFBridgingRelease(ABRecordCopyCompositeName(record));
	return string;
}

- (NSArray *) phoneArray
{
    NSArray *array = [self arrayForProperty:kABPersonPhoneProperty];
    if (!array.count) {
        return [NSArray array];
    }
    
    NSMutableArray *muArray = [NSMutableArray arrayWithCapacity:1];
    for (NSString *number in array) {
        NSString *phoneStr = [number stringByReplacingOccurrencesOfString:@"-" withString:@""];
        phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(" withString:@""];
        phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@")" withString:@""];
        phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@" " withString:@""];

        [muArray addObject:phoneStr];
    }
    return [NSArray arrayWithArray:muArray];
}

- (NSString *) phonenumbers
{
    return [self.phoneArray componentsJoinedByString:@"#"];
}

- (NSArray *) arrayForProperty: (ABPropertyID) anID
{
	CFTypeRef theProperty = ABRecordCopyValue(record, anID);
	NSArray *items = (NSArray *)CFBridgingRelease(ABMultiValueCopyArrayOfAllValues(theProperty));
	return items;
}

@end
