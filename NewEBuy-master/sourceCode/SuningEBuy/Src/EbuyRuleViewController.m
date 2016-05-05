//
//  EbuyRuleViewController.m
//  SuningEBuy
//
//  Created by li xiaokai on 14-2-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "EbuyRuleViewController.h"

@interface EbuyRuleViewController ()

@property(nonatomic,strong)UITextView *ruleTextView;
@end

@implementation EbuyRuleViewController
- (id)init{
    
    self = [super init];
    
    if (self) {
        
       // self.title = L(@"internal rule");
        self.pageTitle = L(@"member_myEbuy_myIntegralRules");
        
    }
    
    return self;
}

- (void)loadView{
    
    [super loadView];
    
    
    NSError *error;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"IntenalRuleHelp" ofType:@"txt"];
    
	NSString *shellTitleText = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    
    self.ruleTextView.text = shellTitleText;
    
    [self.view addSubview:self.ruleTextView];
    
    self.hasSuspendButton = YES;
}

- (UITextView *)ruleTextView{
    
    if (_ruleTextView == nil) {
        
        CGRect frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 92);
        
        _ruleTextView = [[UITextView alloc] initWithFrame:frame];
        
        _ruleTextView.textColor = [UIColor dark_Gray_Color];
        
        _ruleTextView.backgroundColor = [UIColor clearColor];
        
        _ruleTextView.font = [UIFont boldSystemFontOfSize:13.0];
        
        _ruleTextView.userInteractionEnabled = YES;
        
        //[_ruleTextView setDelegate:self];
    }
    return _ruleTextView;
}
@end
