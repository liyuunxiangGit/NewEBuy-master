//
//  GBDetailTipsViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-2-25.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBDetailTipsViewController.h"

@interface GBDetailTipsViewController ()

@end

@implementation GBDetailTipsViewController

@synthesize groupTipsTextView             = _groupTipsTextView;

- (void)dealloc
{
    TT_RELEASE_SAFELY(_groupTipsTextView);
}

- (id)init{
    
    self = [super init];
    
    if (self)
    {
        self.title = L(@"GB_Kindly_Reminder");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"groupBuyTips" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.groupTipsTextView.text = shellTitleText;
    
    [self.view addSubview:self.groupTipsTextView];

}

- (UITextView *)groupTipsTextView{
    
    if (_groupTipsTextView == nil) {
        
        CGRect frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 44);
        
        _groupTipsTextView = [[UITextView alloc] initWithFrame:frame];
        
        _groupTipsTextView.textColor = [UIColor blackColor];
        
        _groupTipsTextView.backgroundColor = [UIColor clearColor];
        
        _groupTipsTextView.font = [UIFont systemFontOfSize:15.0];
        
        _groupTipsTextView.userInteractionEnabled = YES;
        
        [_groupTipsTextView setDelegate:self];
    }
    return _groupTipsTextView;
}

-(void)doBack{
	
//	[UIView beginAnimations:@"preferenceSettingsAnimations" context:nil];
//	
//	[UIView setAnimationDuration:0.8];
//	
//	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
//	
//	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
	
	[self.navigationController popViewControllerAnimated:YES];
	
//	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Text View Delegate Methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    return NO;
}

@end
