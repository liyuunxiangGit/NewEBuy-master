//
//  UIWaitingView.m
//  PlaceApp
//
//  Created by 北京市海淀区 guosong on 12-8-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIWaitingView.h"
#import <QuartzCore/QuartzCore.h>

#define TAG_INDICATOR 100
#define TAG_LABEL     101

#define TAG_VIEW      102


#define TAG_INDICATOR_WIDTH    35
#define TAG_INDICATOR_HEIGHT   35


@implementation UIWaitingView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        UIView *viewBkg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [viewBkg setTag:TAG_VIEW];
        
        [viewBkg.layer setCornerRadius:3];
        [viewBkg.layer setMasksToBounds:YES];
        
        [viewBkg setBackgroundColor:[UIColor blackColor]];
        [viewBkg setAlpha:0.7f];
        
        [self addSubview:viewBkg];
        
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((frame.size.width - TAG_INDICATOR_WIDTH)/2,30,TAG_INDICATOR_WIDTH,TAG_INDICATOR_HEIGHT)];
		[indicator setTag:TAG_INDICATOR];
		[indicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhiteLarge];
		
		[self addSubview:indicator];
		
		

		UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,100,frame.size.width,16)];
        [label setTag:TAG_LABEL];

		[label setBackgroundColor:[UIColor clearColor]];
		[label setTextColor:[UIColor whiteColor]];
		[label setFont:[UIFont systemFontOfSize:16]];
		[label setTextAlignment:UITextAlignmentCenter];
         
		[self addSubview:label];
		
		self.hidden = YES;
    }
    
    return self;
}

- (void) startActivityLoading
{
	self.hidden = NO;
	UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self viewWithTag:TAG_INDICATOR];
	[indicator startAnimating];	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
	
}


- (void) endActivityLoading
{
	self.hidden = YES;
	UIActivityIndicatorView *indicator = (UIActivityIndicatorView *)[self viewWithTag:TAG_INDICATOR];
	[indicator stopAnimating];
	
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void) setTitle:(NSString*)strTitle
{
	UILabel *label = (UILabel *)[self viewWithTag:TAG_LABEL];
	[label setText:strTitle];	
}


@end
