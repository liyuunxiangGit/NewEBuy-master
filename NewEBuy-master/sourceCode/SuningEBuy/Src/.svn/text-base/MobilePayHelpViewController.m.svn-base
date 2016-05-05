//
//  MobilePayHelpViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-15.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "MobilePayHelpViewController.h"

@implementation MobilePayHelpViewController

@synthesize payHelpInfoTextView = _payHelpInfoTextView;


- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"MobileRecharge help");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"finance_mobileCharge_mobileChargeHelp"),self.title];

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"payMobile" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.payHelpInfoTextView.text = shellTitleText;
    
    [self.view addSubview:self.payHelpInfoTextView];
    
}

- (UITextView *)payHelpInfoTextView{
    
    if (_payHelpInfoTextView == nil) {
        
        CGRect frame = [self visibleBoundsShowNav:NO showTabBar:YES];
        
        _payHelpInfoTextView = [[UITextView alloc] initWithFrame:frame];
        
        _payHelpInfoTextView.textColor = [UIColor blackColor];
        
        _payHelpInfoTextView.backgroundColor = [UIColor clearColor];
        
        _payHelpInfoTextView.font = [UIFont systemFontOfSize:15.0];
        
        _payHelpInfoTextView.userInteractionEnabled = YES;
        
        [_payHelpInfoTextView setDelegate:self];
    }
    return _payHelpInfoTextView;
}

-(void)doBack{
	
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
