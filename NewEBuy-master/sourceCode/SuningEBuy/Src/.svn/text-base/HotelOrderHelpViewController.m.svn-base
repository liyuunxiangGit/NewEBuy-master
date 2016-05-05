//
//  HotelOrderHelpViewController.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-3.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "HotelOrderHelpViewController.h"

@implementation HotelOrderHelpViewController

@synthesize hotelOrderHelpInfoTextView = _hotelOrderHelpInfoTextView;

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"Suning_Hotel_Deal");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_business"),self.title];
        self.navigationItem.hidesBackButton = YES;
        
        self.bSupportPanUI = NO;
//        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] 
//                                       initWithTitle:L(@"Back")
//                                       style:UIBarButtonItemStylePlain
//                                       target:self
//                                       action:@selector(doBack)];        
//        
//        self.navigationItem.leftBarButtonItem = backButton;
//        
//        TT_RELEASE_SAFELY(backButton);
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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"hotelHelp" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.hotelOrderHelpInfoTextView.text = shellTitleText;
    
    [self.view addSubview:self.hotelOrderHelpInfoTextView];
    
}

- (UITextView *)hotelOrderHelpInfoTextView{
    
    if (_hotelOrderHelpInfoTextView == nil) {
        
        CGRect frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
        
        _hotelOrderHelpInfoTextView = [[UITextView alloc] initWithFrame:frame];
        
        _hotelOrderHelpInfoTextView.textColor = [UIColor blackColor];
        
        _hotelOrderHelpInfoTextView.backgroundColor = [UIColor clearColor];
        
        _hotelOrderHelpInfoTextView.font = [UIFont systemFontOfSize:15.0];
        
        _hotelOrderHelpInfoTextView.userInteractionEnabled = YES;
        
        [_hotelOrderHelpInfoTextView setDelegate:self];
    }
    return _hotelOrderHelpInfoTextView;
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
