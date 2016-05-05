//
//  productToolClass.c
//  SuningEBuy
//
//  Created by   on 11-10-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#include "productToolClass.h"



CGRect returnFrame(UIViewController *sourceViewController){
    CGRect frame = sourceViewController.view.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = sourceViewController.view.bounds.size.height - 92 ;
    return frame;
}

CGSize returnTextFrame(NSString *source,UIFont *font,NSInteger width,UILineBreakMode uilinkbreakmode){
    CGSize detailSize ;
    if (nil == source) {
        return detailSize;
    }else {
        detailSize = [source sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    }
    return detailSize;
}


NSString* returnRightString(NSString *source){
    NSString *retStr = source;
    if (retStr == nil || [retStr isEqual:[NSNull null]])
    {
        return @"";
    }
    retStr = [retStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    retStr = [retStr stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    retStr = [retStr stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"];
    retStr = [retStr stringByReplacingOccurrencesOfString:@"<br>" withString:@"\n"];
    retStr = [retStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    retStr = [retStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return retStr;
}

















