//
//  FormattersValidators.m
//  SuningEBuy
//
//  Created by xie wei on 13-7-26.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FormattersValidators.h"
#import "RegexKitLite.h"

int sn_get_email_char_index (char ch);

int sn_get_email_char_index (char ch) {
    if ((ch >= '0'&& ch <= '9')||(ch >= 'a'&& ch <= 'z')||
        (ch >= 'A' && ch <= 'Z')|| ch == '_') {
        return 0;
    }
    if (ch == '@') {
        return 1;
    }
    if (ch == '.') {
        return 2;
    }
    return -1;
}

@implementation FormattersValidators

+ (BOOL)isValidEmail:(NSString*)value {
    static int state[5][3] = {
        {1, -1, -1},
        {1,  2, -1},
        {3, -1, -1},
        {3, -1, 4},
        {4, -1, -1}
    };
    BOOL valid = TRUE;
    const char *cvalue = [value UTF8String];
    int currentState = 0;
    int len = strlen(cvalue);
    int index;
    for (int i = 0; i < len && valid; i++) {
        index = sn_get_email_char_index(cvalue[i]);
        if (index < 0) {
            valid = FALSE;
        }
        else {
            currentState = state[currentState][index];
            if (currentState < 0) {
                valid = FALSE;
            }
        }
    }
    //end state is invalid
    if (currentState != 4) {
        valid = FALSE;
    }
    return valid;
}

+ (BOOL)isValidPhone:(NSString*)value
{
    if ([value isMatchedByRegex:@"^1\\d{10}$"])
    {
        return YES;
    }
    else
    {
        return NO;
    }
}


@end