//
//  ProductEvaluateViewController.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-12-9.
//  Copyright (c) 2011年 Suning. All rights reserved.
//

#import "ProductEvaluateViewController.h"

#import "AddressInfoDAO.h"

@implementation ProductEvaluateViewController

@synthesize peTableView = _peTableView;

@synthesize titleTextField = _titleTextField;

@synthesize contentTextView = _contentTextView;

@synthesize rating = _rating;

@synthesize dataSource = _dataSource;

@synthesize mesLabel = _mesLabel;

@synthesize EvaluateService=_EvaluateService;

- (id)init
{
    self = [super init];
    
    if (self)
    {
        self.title = L(@"Write evaluate");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail"),self.title];
        
//        UIBarButtonItem *commit = [[UIBarButtonItem alloc] initWithTitle:L(@"Commit")
//                                                                   style:UIBarButtonItemStyleDone 
//                                                                  target:self
//                                                                  action:@selector(commitEvaluate)];
//        
//        self.navigationItem.rightBarButtonItem = commit;
        
        _EvaluateService=[[EvaluateService alloc]init];
        self.EvaluateService.delegate=self;
        
//        TT_RELEASE_SAFELY(commit);
        
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Commit")];
    }
    
    return self;
}

- (void)righBarClick
{
    [self commitEvaluate];
}

- (void)commitEvaluate
{
    [self.titleTextField resignFirstResponder];
    
    [self.contentTextView resignFirstResponder];
    
    if (self.rating == nil || [self.rating isEqualToString:@""])
    {
        [self presentSheet:L(@"Please touch to grade") posY:80];
        
        return;
    }
    
    if (self.titleTextField.text == nil || [self.titleTextField.text isEqualToString:@""])
    {
        [self presentSheet:L(@"Please fill title") posY:80];
        
        [self.titleTextField becomeFirstResponder];
        
        return;
    }
    
    if (self.contentTextView.text == nil || [self.contentTextView.text isEqualToString:@""])
    {
        [self presentSheet:L(@"Please fill content") posY:80];
        
        [self.contentTextView becomeFirstResponder];
        
        return;
    }
    
    [self.EvaluateService sendProductEvaluateHttpRequest:self.dataSource.productId
                                                     rating:self.rating 
                                                   cityCode:self.dataSource.cityCode 
                                                      title:self.titleTextField.text 
                                                    content:self.contentTextView.text 
                                                     isBook:self.dataSource.isABook ];
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_peTableView);
    
    TT_RELEASE_SAFELY(_titleTextField);
    
    TT_RELEASE_SAFELY(_contentTextView);
    
    TT_RELEASE_SAFELY(_rating);
    
    TT_RELEASE_SAFELY(_dataSource);
    
    TT_RELEASE_SAFELY(_mesLabel);
    
}

- (TPKeyboardAvoidingTableView *)peTableView
{
    if(!_peTableView){
		
        _peTableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero
                                                       style:UITableViewStyleGrouped];    
		
		
		[_peTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		
		[_peTableView setIndicatorStyle:UIScrollViewIndicatorStyleWhite];
		
		_peTableView.scrollEnabled = YES;
		
		_peTableView.userInteractionEnabled = YES;
		
		_peTableView.delegate =self;
		
		_peTableView.dataSource =self;
		
		_peTableView.backgroundColor =[UIColor clearColor];
		
	}
	
	return _peTableView;
}

- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
	
	CGRect frame = contentView.frame;
	
	frame.origin.x = 0;
	
	frame.origin.y = 0;
	
	frame.size.height = contentView.bounds.size.height - 92 ;
    
    self.peTableView.frame = frame;
    
    [self.view addSubview:self.peTableView];

}

- (void)newRating:(DLStarRatingControl *)control :(NSUInteger)rating
{
    if (rating == 0)
    {
        self.mesLabel.hidden = NO;
    }
    else
    {
        self.mesLabel.hidden = YES;
        
        self.rating = [NSString stringWithFormat:@"%d", rating];
    }
}

#pragma mark -
#pragma mark views

- (UITextField *)titleTextField
{
    if (!_titleTextField)
    {
        _titleTextField = [[UITextField alloc] init];
        
        _titleTextField.frame = CGRectMake(60, 8, 226, 30);
        
        _titleTextField.placeholder = L(@"Please input title here");
        
        _titleTextField.borderStyle = UITextBorderStyleNone;
        _titleTextField.textColor = [UIColor blackColor];
        _titleTextField.font = [UIFont systemFontOfSize:15.0];
        _titleTextField.backgroundColor = [UIColor clearColor];
        _titleTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _titleTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _titleTextField.returnKeyType = UIReturnKeyDone;
        
        _titleTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        _titleTextField.delegate = self;
    }
    return _titleTextField;
}

- (PlaceholderTextView *)contentTextView
{
    if (!_contentTextView)
    {
        _contentTextView = [[PlaceholderTextView alloc] init];
        
        _contentTextView.frame = CGRectMake(60, 8, 226, 90);
        
        _contentTextView.placeholder = L(@"Please input content here");
        
        _contentTextView.textColor = [UIColor blackColor];
        _contentTextView.font = [UIFont systemFontOfSize:15.0];
        _contentTextView.backgroundColor = [UIColor clearColor];
        _contentTextView.autocorrectionType = UITextAutocorrectionTypeNo;
        
        _contentTextView.keyboardType = UIKeyboardTypeDefault;
        
        _contentTextView.delegate = self;
    }
    return _contentTextView;
}

- (UILabel *)mesLabel
{
    if (!_mesLabel)
    {
        NSString *mesString = [NSString stringWithString:L(@"Push stars to grade")];
        
        CGRect frame = CGRectMake(120, 36, 160, 14);
        
        _mesLabel = [[UILabel alloc] initWithFrame:frame];
        
        _mesLabel.textColor = [UIColor darkGrayColor];
        
        _mesLabel.text = mesString;
        
        _mesLabel.font = [UIFont systemFontOfSize:12];
        
        _mesLabel.backgroundColor = [UIColor clearColor];
    }
    return _mesLabel;
}

#pragma mark -
#pragma mark  Text Delegate Methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.titleTextField resignFirstResponder];
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    [self.contentTextView resignFirstResponder];
    
    return YES;
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ProductEvaluateCellIdentifier = @"ProductEvaluateCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ProductEvaluateCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ProductEvaluateCellIdentifier];
        
        cell.textLabel.font = [UIFont systemFontOfSize:15.0];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        [cell.contentView removeAllSubviews];
    }
    
    if ([indexPath row] == 0)
    {
        cell.textLabel.text = [NSString stringWithString:L(@"Title")];
        
        [cell.contentView addSubview:self.titleTextField];
    }
    else
    {
        cell.textLabel.text = [NSString stringWithString:L(@"Content")];
        
        [cell.contentView addSubview:self.contentTextView];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 46.0;
    }
    return 104.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    DLStarRatingControl *customNumberOfStars = [[DLStarRatingControl alloc] initWithFrame:CGRectMake(0, self.view.top - 20, 320, 50) andStars:5];
	customNumberOfStars.backgroundColor = [UIColor clearColor];
	customNumberOfStars.autoresizingMask =  UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    
	customNumberOfStars.rating = 0;
    
    customNumberOfStars.delegate = self;
    
    [customNumberOfStars addSubview:self.mesLabel];
    
    return customNumberOfStars;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 53;
}

#pragma mark -
#pragma mark NewEvaluateService 

-(void)NewEvaluateHttpRequestCompletedWithService:(EvaluateService *)service isSuccess:(BOOL)isSuccess errorDescMsg:(NSString *)errorDescMsg
{
    if (isSuccess)
    {
        [self presentCustomDlg:L(@"Evaluate success")];
    }
    else
    {
        
        if (errorDescMsg == nil || [errorDescMsg isEqualToString:@""])
        {
            [self presentSheet:L(@"Evaluate failed") posY:80];
        }
        else
        {
            [self presentSheet:errorDescMsg posY:80];
        }
    }

}



- (void)returnUserChooseButtonIndex:(NSInteger)tag andIndex:(NSInteger)index1
{
    [self.navigationController popViewControllerAnimated:YES];
}



@end
