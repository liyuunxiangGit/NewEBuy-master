//
//  UserConsultantViewController.m
//  SuningEBuy
//
//  Created by xingxuewei on 13-4-9.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "UserConsultantViewController.h"

@implementation UserConsultantViewController

- (void)dealloc
{
    TT_RELEASE_SAFELY(_categoryLbl);
    TT_RELEASE_SAFELY(_pickView);
    TT_RELEASE_SAFELY(_contentLbl);
    TT_RELEASE_SAFELY(_contentTFd);
    TT_RELEASE_SAFELY(_categoryTypeBtn);
    TT_RELEASE_SAFELY(_wordCountLbl);
    TT_RELEASE_SAFELY(_product);
    SERVICE_RELEASE_SAFELY(_evalutionService);
    TT_RELEASE_SAFELY(_modelType);
}

- (id)initWithBasicDTO:(DataProductBasic *)dto
{
    self = [super init];
    if (self)
    {
        self.product = dto;
        
        _modelType = @"5";
        
        self.title = L(@"PageTitleIWantConsultation");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"show_productDetail_consult"),self.title];

        
//        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"发表"
//                                                                      style:UIBarButtonItemStylePlain
//                                                                     target:self
//                                                                     action:@selector(commit)];
//		
//		self.navigationItem.rightBarButtonItem = rightItem;
//        
//        TT_RELEASE_SAFELY(rightItem);

        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"Product_Public")];

        if (!_categoryList) {
            _categoryList = [[NSArray alloc] initWithObjects:L(@"Product advisory"),L(@"Inventory distribution"),L(@"Invoice warranty"),L(@"Payment information"),L(@"Promotional discounts"),L(@"Other question"), nil];
        }
    }
    return self;
}

- (void)righBarClick
{
    [self commit];
}

- (void)loadView{
    
    [super loadView];
    
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.tpTableView.frame = frame;
    
    [self.view addSubview:self.tpTableView];
    
    [self.tpTableView addSubview:self.categoryLbl];
    [self.tpTableView addSubview:self.categoryTypeBtn];
    [self.tpTableView addSubview:self.contentLbl];
    [self.tpTableView addSubview:self.contentTFd];
//    [self.tpTableView addSubview:self.wordCountLbl];
}

- (void)commit
{
    NSString *contentString = [self.contentTFd.text trim];
    
    if (IsStrEmpty(contentString))
    {
        [self presentSheet:L(@"Product_InputConsultContent") posY:100];
        [self.contentTFd becomeFirstResponder];
        return;
    }
    if (contentString.length > 150) {
        [self presentSheet:L(@"Product_ContentLimitedIn150") posY:100];
        [self.contentTFd becomeFirstResponder];
        return;
    }
    
//    NSString *content = [NSString stringWithFormat:@"authornickname=%@<⊙>content=%@",!IsStrEmpty([UserCenter defaultCenter].userInfoDTO.nickName)?[UserCenter defaultCenter].userInfoDTO.nickName:[Config currentConfig].username,contentString?contentString:@""];
    
    [self.contentTFd resignFirstResponder];
    [self.categoryTypeBtn resignFirstResponder];
    
    [self displayOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = NO;
//    [self.evalutionService beginEvalutionPublish:_product.productCode catentryId:_product.productId modelType:self.modelType content:content isBook:_product.isABook];
}

- (NewEvalutionService *)evalutionService
{
    if (!_evalutionService) {
        _evalutionService = [[NewEvalutionService alloc] init];
        _evalutionService.delegate = self;
    }
    return _evalutionService;
}

- (UILabel *)categoryLbl
{
    if (!_categoryLbl) {
        _categoryLbl = [[UILabel alloc] init];
        _categoryLbl.text = L(@"Classification");
        _categoryLbl.frame = CGRectMake(10, 10, 40, 30);
        _categoryLbl.backgroundColor = [UIColor clearColor];
    }
    return _categoryLbl;
}

//咨询类型选择框
- (ToolBarButton *)categoryTypeBtn{
    
    if (!_categoryTypeBtn) {
        _categoryTypeBtn = [[ToolBarButton alloc] initWithFrame:CGRectMake(self.categoryLbl.right+10, 10, 220, 30)];
        _categoryTypeBtn.backgroundColor = [UIColor clearColor];
        _categoryTypeBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _categoryTypeBtn.inputView = self.pickView;
        _categoryTypeBtn.delegate = self;
        _categoryTypeBtn.tag = 9;
        [_categoryTypeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
        [_categoryTypeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_categoryTypeBtn setTitle:[_categoryList objectAtIndex:0] forState:UIControlStateNormal];
        [_categoryTypeBtn setBackgroundImage:[UIImage imageNamed:@"constant_btn.png"] forState:UIControlStateNormal];

    }
    return _categoryTypeBtn;
}

- (UIPickerView *)pickView{
    
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] init];
        _pickView.delegate = self;
        _pickView.dataSource = self;
        _pickView.showsSelectionIndicator = YES;
    }
    return _pickView;
}

- (UILabel *)contentLbl
{
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.frame = CGRectMake(10, self.categoryLbl.bottom, 40, 30);
        _contentLbl.text = [NSString stringWithFormat:@"%@:",L(@"Product_Content")];
        _contentLbl.backgroundColor = [UIColor clearColor];
    }
    return _contentLbl;
}

- (PlaceholderTextView *)contentTFd
{
    if (!_contentTFd) {
        _contentTFd = [[PlaceholderTextView alloc] init];
        _contentTFd.frame = CGRectMake(10, self.contentLbl.bottom, 300, 100);
        _contentTFd.placeholder = L(@"Product_InputConsultContent150");
        _contentTFd.font = [UIFont systemFontOfSize:14];
        _contentTFd.delegate = self;
    }
    return _contentTFd;
}

- (UILabel *)wordCountLbl
{
    if (!_wordCountLbl) {
        _wordCountLbl = [[UILabel alloc] init];
        _wordCountLbl.frame = CGRectMake(230, self.contentTFd.bottom, 80, 30);
        _wordCountLbl.backgroundColor = [UIColor clearColor];
        _wordCountLbl.textAlignment = UITextAlignmentRight;
        _wordCountLbl.text = @"0/150";
    }
    return _wordCountLbl;
}

#pragma mark - Picker Data Source Methods
#pragma mark   PickerView 的代理方法
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return [_categoryList count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	return [_categoryList objectAtIndex:row];
}

- (void)doneButtonClicked:(id)sender
{    
    NSInteger categoryTypeRow = [self.pickView selectedRowInComponent:0];
    
    [self.categoryTypeBtn setTitle:[_categoryList objectAtIndex:categoryTypeRow] forState:UIControlStateNormal];
    
    self.modelType = [NSString stringWithFormat:@"%d",categoryTypeRow+5];
    
    [self.categoryTypeBtn resignFirstResponder];
}

- (void)cancelButtonClicked:(id)sender
{
    [self.pickView resignFirstResponder];
}

- (void)evalutionPublishCompletedWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        BBAlertView *alert = [[BBAlertView alloc] initWithTitle:L(@"Tips")
                                                        message:L(@"Product_CommitSuccess")
                                                       delegate:self
                                              cancelButtonTitle:L(@"Ok")
                                              otherButtonTitles:nil];
        [alert show];
    }else{
        NSString *errorMsg1 = errorMsg ? errorMsg :L(@"Product_ConsultFailedTryLater");

        [self presentSheet:errorMsg1];
    }
}


- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{

    [textView resignFirstResponder];
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
//    self.wordCountLbl.text = [NSString stringWithFormat:@"%d/150",[textView.text replacedWhiteSpacsByString:@""].length];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
//    if (textView  == self.contentTFd)
//    {
//        if (textView.text.length + text.length - range.length > 150) {
//            
//            return NO;
//        }
//        if (textView.text.length >=150 && range.location >= 150)
//        {            
//            return NO;
//        }
//    }

    return YES;
}

@end
