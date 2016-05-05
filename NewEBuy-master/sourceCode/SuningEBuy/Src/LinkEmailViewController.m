//
//  LinkEmailViewController.m
//  SuningEBuy
//
//  Created by wangrui on 2/13/12.
//  Copyright (c) 2012 suning. All rights reserved.
//
#import "RegexKitLite.h"
#import "LinkEmailViewController.h"

@implementation LinkEmailViewController

@synthesize userName = _userName;

@synthesize linkEmailBtn = _linkEmailBtn;
@synthesize emailTipLbl = _emailTipLbl;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_userName);
    
    TT_RELEASE_SAFELY(_linkEmailBtn);
    
    TT_RELEASE_SAFELY(_emailTipLbl);
    
}

- (id)init
{
    if (self = [super init]) 
    {
        self.title = L(@"Reset password");
        
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back") style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
		
		self.navigationItem.leftBarButtonItem = leftItem;
        
        TT_RELEASE_SAFELY(leftItem);
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    NSString *btnTitle = [NSString stringWithFormat:@"%@%@",L(@"Login"), self.emailURLFromUserName];
    
    [self.linkEmailBtn setTitle:btnTitle forState:UIControlStateNormal];
    
    NSString *prefix = L(@"We have sent an email to you");//我们已经发送一封确认信到您的邮箱 
    
    NSString *suffix = L(@"Please click the link to retrieve password");//请在您收到确认信后，点击信中链接找回密码
    
    NSString *tipTitle = [NSString stringWithFormat:@"%@ %@,%@",prefix, self.userName, suffix];
    self.emailTipLbl.text = tipTitle;
    
    [self.view addSubview:self.linkEmailBtn];
    
    [self.view addSubview:self.emailTipLbl];
}

#pragma mark -
#pragma mark UINavigation Item Action
- (void)backAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (NSString *)emailURLFromUserName
{
    
    NSString *siteURL = nil;
    
    NSString *sitePrefix = @"http://www.";
    
    NSString *regexString = @"@.+$";
    
    NSString *domainName = [self.userName stringByMatching:regexString];
    domainName = [domainName substringFromIndex:1];
    
    siteURL = [NSString stringWithFormat:@"%@%@",sitePrefix, domainName];
    
    return siteURL;
    
}

- (UIButton *)linkEmailBtn
{
    if (!_linkEmailBtn) 
    {
        _linkEmailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _linkEmailBtn.frame = CGRectMake(24, 120, 272, 42);
        
        [_linkEmailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_linkEmailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        
        [_linkEmailBtn setBackgroundImage:[UIImage imageNamed:@"gary_long_btn.png"] forState:UIControlStateNormal];
        
        [_linkEmailBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
        
        [_linkEmailBtn.titleLabel setTextAlignment:UITextAlignmentCenter];
        
        [_linkEmailBtn addTarget:self action:@selector(linkEmailAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _linkEmailBtn;
}

- (UILabel *)emailTipLbl
{
    if (!_emailTipLbl) 
    {
        _emailTipLbl = [[UILabel alloc]init];
		
		_emailTipLbl.frame = CGRectMake(23,self.linkEmailBtn.bottom + 10,274,60);
		
		_emailTipLbl.numberOfLines = 0;
		
		_emailTipLbl.font = [UIFont systemFontOfSize:14.0];
		
		_emailTipLbl.lineBreakMode = UILineBreakModeCharacterWrap;
		
		_emailTipLbl.textAlignment = UITextAlignmentLeft;
        
        _emailTipLbl.textColor = RGBCOLOR(57, 140, 177);
        
        _emailTipLbl.backgroundColor = [UIColor clearColor];
    }
    
    return _emailTipLbl;
}

- (void)linkEmailAction:(id)sender
{

    [self dismissModalViewControllerAnimated:YES];
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.userName,@"username",nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:POPUP_MESSAGE object:userInfo];

    NSURL *siteURL = [NSURL URLWithString:self.emailURLFromUserName];
    
    [[UIApplication sharedApplication] openURL:siteURL];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
