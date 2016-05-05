//
//  NSString-NULL.m
//  WingLetter
//
//  Created by zhaojw on 10-9-23.
//  Copyright 2010 Wingletter. All rights reserved.
//

#import "NSString+NULL.h"


@implementation NSString (NSStringNULL)
- (id)initWithUTF8NULLString:(const char *)nullTerminatedCString{
 
	if(nullTerminatedCString==NULL)
		return nil;
	else{
		return [self initWithUTF8String:nullTerminatedCString];
	}
	
}
@end
