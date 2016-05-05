//
//  InternalRuleViewController.m
//  SuningEBuy
//
//  Created by 王 漫 on 13-2-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "InternalRuleHelpViewController.h"


@implementation InternalRuleHelpViewController

@synthesize internalRuleTextView = _internalRuleTextView;

- (id)init{
    
    self = [super init];
    
    if (self) {
        
        self.title = L(@"internal rule");
        self.pageTitle = L(@"member_myEbuy_myIntegralRules");

    }
    
    return self;
}

- (void)loadView{
    
    [super loadView];
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IntenalRuleHelp" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.internalRuleTextView.text = shellTitleText;
    
    [self.view addSubview:self.internalRuleTextView];
}

- (UITextView *)internalRuleTextView{
    
    if (_internalRuleTextView == nil) {
        
        CGRect bound = [self visibleBoundsShowNav:YES showTabBar:NO];
        
        CGRect frame = CGRectMake(15, 0, 290, bound.size.height);
        
        _internalRuleTextView = [[UITextView alloc] initWithFrame:frame];
        
        _internalRuleTextView.textColor = [UIColor dark_Gray_Color];
        
        _internalRuleTextView.backgroundColor = [UIColor clearColor];
        
        _internalRuleTextView.font = [UIFont systemFontOfSize:15.0];
        
        _internalRuleTextView.userInteractionEnabled = YES;
        
        [_internalRuleTextView setDelegate:self];
    }
    return _internalRuleTextView;
}


#pragma mark -
#pragma mark Text View Delegate Methods

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    return NO;
}

@end
