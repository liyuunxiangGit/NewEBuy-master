//
//  PayServiceHelpViewController.m
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PayServiceHelpViewController.h"

@implementation PayServiceHelpViewController

@synthesize payHelpInfoTextView = _payHelpInfoTextView;

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"PayService help");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"finance_wegCharce_wegHelp"),self.title];

        self.navigationItem.hidesBackButton = YES;
        
        self.bSupportPanUI = NO;
    }
    
    return self;
}

- (void)backForePage
{
    [self doBack];
}

- (void)loadView{
    
    [super loadView];
        
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"payServiceHelp" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.payHelpInfoTextView.text = shellTitleText;
    
    [self.view addSubview:self.payHelpInfoTextView];
}

- (UITextView *)payHelpInfoTextView{
    
    if (_payHelpInfoTextView == nil) {
        
        CGRect frame = [self visibleBoundsShowNav:NO showTabBar:YES];
        
        _payHelpInfoTextView = [[UITextView alloc] initWithFrame:frame];
        
        _payHelpInfoTextView.textColor = [UIColor dark_Gray_Color];
        
        _payHelpInfoTextView.backgroundColor = [UIColor clearColor];
        
        _payHelpInfoTextView.font = [UIFont systemFontOfSize:15.0];
        
        _payHelpInfoTextView.userInteractionEnabled = YES;
        
        [_payHelpInfoTextView setDelegate:self];
    }
    return _payHelpInfoTextView;
}

- (void)doBack{
	
	[UIView beginAnimations:@"preferenceSettingsAnimations" context:nil];
	
	[UIView setAnimationDuration:0.8];
	
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	
	[UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
	
	[self.navigationController popViewControllerAnimated:YES];
	
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Text View Delegate Methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    return NO;
}



@end
