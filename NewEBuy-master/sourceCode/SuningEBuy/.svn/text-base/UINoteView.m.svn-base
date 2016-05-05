//
//  UINoteView.m
//  PlaceApp
//
//  Created by 北京市海淀区 guosong on 12-8-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UINoteView.h"
#import <QuartzCore/QuartzCore.h>

#define TAG_IMAGEVIE_BKG  201
#define TAG_LABEL         202
#define TAG_IMAGEVIEW     203


#define LABEL_WIDTH  140


#define VIEW_WIDTH     160
#define VIEW_HEIGHT    160

#define IMAGEVIEW_BKG_WIDTH   160
#define IMAGEVIEW_BKG_HEIGHT  160


#define IMAGEVIEW_WIDTH   67
#define IMAGEVIEW_HEIGHT  56

@implementation UINoteView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self setBackgroundColor:[UIColor clearColor]];
        
        // 背景图片
        UIImageView *imageviewBkg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, IMAGEVIEW_BKG_WIDTH, IMAGEVIEW_BKG_HEIGHT)];
        [imageviewBkg setTag:TAG_IMAGEVIE_BKG];
        [imageviewBkg setBackgroundColor:[UIColor blackColor]];
        
        [imageviewBkg.layer setCornerRadius:3];
        [imageviewBkg.layer setMasksToBounds:YES];		
        
        [self addSubview:imageviewBkg];
        
        
        // 图片
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake((VIEW_WIDTH - IMAGEVIEW_WIDTH)/2, 30, IMAGEVIEW_WIDTH, IMAGEVIEW_HEIGHT)];
        [imageview setTag:TAG_IMAGEVIEW];
        
        [imageview setImage:[UIImage imageNamed:@"netError.png"]];
        
        [self addSubview:imageview];
        
        
        // 提示文字
        UILabel *label = [[UILabel alloc]init];
        [label setTag:TAG_LABEL];
        
        [label setNumberOfLines:0];
        [label setLineBreakMode:UILineBreakModeClip];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont systemFontOfSize:15]];
        
        [self addSubview:label];
        
        self.hidden = YES;     

    }
    return self;
}


- (void)showNoteView {
    
	[self setHidden:NO];
	
	UIImageView *imagviewBkg = (UIImageView *)[self viewWithTag:TAG_IMAGEVIE_BKG];
	[imagviewBkg setAlpha:0.6f];
	
	UILabel *labelNote = (UILabel *)[self viewWithTag:TAG_LABEL];
	[labelNote setAlpha:1];
	[self setContentMode:UIViewContentModeBottom];
    
	
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
    [UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(hidenView)];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:3.0f];
	[UIView setAnimationRepeatAutoreverses:NO];
	
	
	[imagviewBkg setAlpha:0];
	[labelNote setAlpha:0];
	
	[UIView commitAnimations];
    
}


- (CGSize)setNoteText:(NSString*) aText {
	
	if (aText == nil || [aText length] <= 0) {
		return CGSizeMake(0, 0);
	}
	
    
	UILabel *labelNote = (UILabel *)[self viewWithTag:TAG_LABEL];
	[labelNote setText:aText];
	
	CGSize szNoteText = [labelNote.text sizeWithFont:labelNote.font
                                   constrainedToSize:CGSizeMake(LABEL_WIDTH, MAXFLOAT)
                                       lineBreakMode:UILineBreakModeClip];
	[labelNote setFrame:CGRectMake((self.frame.size.width - szNoteText.width)/2, 105, szNoteText.width, szNoteText.height)];
	
    /*
	UIImageView *imageviewBkg = (UIImageView *)[self viewWithTag:TAG_IMAGEVIE_BKG];
	CGRect imageviewFrame = [imageviewBkg frame];
    imageviewFrame.origin.x = (self.frame.size.width - szNoteText.width)/2 - 10;
	imageviewFrame.size.width = szNoteText.width + 20;
	imageviewFrame.size.height = szNoteText.height + 10;
	[imageviewBkg setFrame:imageviewFrame];
	
    */
	return szNoteText;
	
	
}


- (void)hidenView {
    
    [self setHidden:YES];
}



@end
