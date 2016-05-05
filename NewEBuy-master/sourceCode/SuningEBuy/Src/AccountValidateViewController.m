//
//  AccountValidateViewController.m
//  SuningEBuy
//
//  Created by wangrui on 2/11/12.
//  Copyright (c) 2012 suning. All rights reserved.
//
#import "LinkEmailViewController.h"
#import "AuthManagerNavViewController.h"
#import "AccountValidateViewController.h"
#import "RetrievePasswordViewController.h"

@interface AccountValidateViewController (Private)

- (BOOL) validateMobileNum:(NSString *)mobileNum;

- (BOOL) validateEmailName:(NSString *)emailName;

@end

@implementation AccountValidateViewController

@synthesize mode = _mode;
@synthesize mobileOrEmailFld = _mobileOrEmailFld;
@synthesize mobileOrEmailLbl = _mobileOrEmailLbl;

@synthesize service = _service;

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_mobileOrEmailFld);
    
    TT_RELEASE_SAFELY(_mobileOrEmailLbl);
    
    SERVICE_RELEASE_SAFELY(_service);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


- (id)init
{
    if (self = [super init]) 
    {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:L(@"Back") style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
		
		self.navigationItem.leftBarButtonItem = leftItem;
        
        TT_RELEASE_SAFELY(leftItem);
        
        
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] 
                                      
                                      initWithTitle:L(@"Next Step") style:UIBarButtonItemStylePlain target:self action:@selector(nextAction:)];
		
		self.navigationItem.rightBarButtonItem = rightItem;
        
        
        TT_RELEASE_SAFELY(rightItem);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popupCurrentViewController:) name:POPUP_MESSAGE object:nil];
        
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    if (self.mode == MobileMode) 
    {
        self.title = L(@"Validate mobile number");
    }
    else if (self.mode == EmailMode)
    {
        self.title = L(@"Validate email");
    }
    
    self.groupTableView.frame = self.view.frame;
    
    self.groupTableView.scrollEnabled = NO;
    
    [self.view addSubview:self.groupTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.mobileOrEmailFld becomeFirstResponder];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    
    if (isPopup) 
    {
        [self dismissModalViewControllerAnimated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.mobileOrEmailFld resignFirstResponder];
}

- (void)popupCurrentViewController:(NSNotification *)notification
{
    
    isPopup = YES;
}

#pragma mark -
#pragma mark Send Http Request

- (UserRetrieveService *)service
{
    if (!_service) {
        _service = [[UserRetrieveService alloc] init];
        _service.delegate = self;
    }
    return _service;
}

- (void)sendValidateUserHttpRequest
{
    [self displayOverFlowActivityView:L(@"Sending...") yOffset:-80.0f];
    
    [self.service accountValidateWithLogonId:self.mobileOrEmailFld.text retrieveMode:self.mode];
    
}

- (void)accountValidateCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView]; 
    if (isSuccess) {
        if (self.mode == MobileMode) 
        {
            
            RetrievePasswordViewController *retrievePasswordViewController = [[RetrievePasswordViewController alloc] init]; 
            retrievePasswordViewController.userName = self.mobileOrEmailFld.text;
            AuthManagerNavViewController *retrievePasswordNav = [[AuthManagerNavViewController alloc] initWithRootViewController:retrievePasswordViewController];
            TT_RELEASE_SAFELY(retrievePasswordViewController);
            
            [self presentModalViewController:retrievePasswordNav animated:YES];
            TT_RELEASE_SAFELY(retrievePasswordNav);            
        }
        else if (self.mode == EmailMode)
        {
            LinkEmailViewController *linkEmailViewController = [[LinkEmailViewController alloc] init];
            linkEmailViewController.userName = self.mobileOrEmailFld.text;
            AuthManagerNavViewController *linkEmailNav = [[AuthManagerNavViewController alloc] initWithRootViewController:linkEmailViewController];
            TT_RELEASE_SAFELY(linkEmailViewController);
            
            [self presentModalViewController:linkEmailNav animated:YES];
            TT_RELEASE_SAFELY(linkEmailNav);
        }
    }else{
        [self presentSheet:errorMsg posY:30];
    }
}

- (void)requestUserFail:(ASIFormDataRequest *)request
{
	DLog(@"requestUserFail from server  String=%@\n",[request responseString]);
	
	[self removeOverFlowActivityView];
    
}

#pragma mark -
#pragma mark UINavigation Item Action
- (void)backAction:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)nextAction:(id)sender
{
    
    //    RetrievePasswordViewController *retrievePasswordViewController = [[RetrievePasswordViewController alloc] init]; 
    //    retrievePasswordViewController.userName = self.mobileOrEmailFld.text;
    //    AuthManagerNavViewController *retrievePasswordNav = [[AuthManagerNavViewController alloc] initWithRootViewController:retrievePasswordViewController];
    //    TT_RELEASE_SAFELY(retrievePasswordViewController);
    //
    //    [self presentModalViewController:retrievePasswordNav animated:YES];
    //    TT_RELEASE_SAFELY(retrievePasswordNav);
    //    
    //    LinkEmailViewController *linkEmailViewController = [[LinkEmailViewController alloc] init];
    //    linkEmailViewController.userName = self.mobileOrEmailFld.text;
    //    AuthManagerNavViewController *linkEmailNav = [[AuthManagerNavViewController alloc] initWithRootViewController:linkEmailViewController];
    //    TT_RELEASE_SAFELY(linkEmailViewController);
    //    
    //    [self presentModalViewController:linkEmailNav animated:YES];
    //    TT_RELEASE_SAFELY(linkEmailNav);
    //    
    //    return;
    
    
    NSString *errMessage = nil;
	
    if (!self.mobileOrEmailFld.text || [self.mobileOrEmailFld.text isEmptyOrWhitespace])
    {
        
        self.mobileOrEmailFld.text = @"";
        
		errMessage = kLoginStatusMessageRequireRegisterId;
		
		[self presentSheet:errMessage posY:80];
		
        return;
	}
    
	
	if (![self validateUsername:self.mobileOrEmailFld.text]) 
    {
        
        return;
	}
    
    [self sendValidateUserHttpRequest];
}

- (BOOL)validateUsername:(NSString *)userName
{
    
    BOOL isOk = NO;
    
    NSString *errMessage = nil;
    
    if (self.mode == MobileMode) 
    {
        isOk = [self validateMobileNum:userName];
        
        if (!isOk) 
        {
            errMessage = L(@"Please input phone number 11");
            
            [self presentSheet:errMessage posY:80];
        }
        
    }
    else if (self.mode == EmailMode)
    {
        isOk = [self validateEmailName:userName];
        
        if (!isOk) 
        {
            errMessage = L(@"Please input correct email");
            
            [self presentSheet:errMessage posY:80];
        }
    }
    
    return isOk;
}

- (BOOL)validateMobileNum:(NSString *)mobileNum
{
    NSString *mobileNumRegex = @"1[0-9]{10,10}"; 
    
    NSPredicate *mobileNumTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNumRegex]; 
	
    return [mobileNumTest evaluateWithObject:mobileNum];
    
}

- (BOOL)validateEmailName:(NSString *)emailName
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
	
    return [emailTest evaluateWithObject:emailName];
}

- (UITextField *)mobileOrEmailFld
{
    if (!_mobileOrEmailFld) 
    {
        _mobileOrEmailFld = [[UITextField alloc] initWithFrame:CGRectMake(75, 5, 220, 34)];
		
		_mobileOrEmailFld.delegate = self;
        
        _mobileOrEmailFld.font = [UIFont systemFontOfSize:14.0];
		
		_mobileOrEmailFld.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		
		_mobileOrEmailFld.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _mobileOrEmailFld.autocapitalizationType = UITextAutocapitalizationTypeNone;
        
        _mobileOrEmailFld.enablesReturnKeyAutomatically = YES;
        
        if (self.mode == MobileMode) 
        {
            _mobileOrEmailFld.placeholder = L(@"Regestered mobile");
            
            _mobileOrEmailFld.keyboardType = UIKeyboardTypePhonePad;
        }
        else if (self.mode == EmailMode)
        {
            _mobileOrEmailFld.placeholder = L(@"Regestered email");
            
            _mobileOrEmailFld.keyboardType = UIKeyboardTypeEmailAddress;
            
            _mobileOrEmailFld.returnKeyType = UIReturnKeyNext;
        }
		
    }
    
    return _mobileOrEmailFld;
}

- (UILabel *)mobileOrEmailLbl
{
    if (!_mobileOrEmailLbl) 
    {
        _mobileOrEmailLbl = [[UILabel alloc]init];
		
		_mobileOrEmailLbl.frame = CGRectMake(10,5,60,34);
		
		_mobileOrEmailLbl.numberOfLines = 0;
		
		_mobileOrEmailLbl.font = [UIFont systemFontOfSize:14.0];
		
		_mobileOrEmailLbl.lineBreakMode = UILineBreakModeWordWrap;
		
		_mobileOrEmailLbl.textAlignment = UITextAlignmentLeft;
        
        _mobileOrEmailLbl.backgroundColor = [UIColor clearColor];
        
        if (self.mode == MobileMode) 
        {
            _mobileOrEmailLbl.text = L(@"MobilePhone");
        }
        else if (self.mode == EmailMode)
        {
            _mobileOrEmailLbl.text = L(@"email address");
        }
    }
    
    return _mobileOrEmailLbl;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [self nextAction:nil];
    
    return NO;
}

#pragma mark -
#pragma mark UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView 
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
    
    return  1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 60;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    NSString *footerTitle = nil;
    
    if (self.mode == MobileMode)
    {
        footerTitle = L(@"The tips of retrieving passwrod by mobile");
    }
    
    return footerTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	else
    {
		
		[cell.contentView removeAllSubviews];
	}
	
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.contentView addSubview:self.mobileOrEmailLbl];
    
    [cell.contentView addSubview:self.mobileOrEmailFld];
    
    return cell;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
