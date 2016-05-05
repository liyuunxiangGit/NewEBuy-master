//
//  FindpFirstViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FindpFirstViewController.h"
#import "OpenUDID.h"
#import "FindpSecondViewController.h"
#import "SNGraphics.h"

#import "UIImageView+WebCache.h"

@interface FindpFirstViewController ()
{

}

@end

@implementation FindpFirstViewController

@synthesize findPasswordDto         = _findPasswordDto;
@synthesize findPasswordService     = _findPasswordService;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_findPasswordDto);
    SERVICE_RELEASE_SAFELY(_findPasswordService);
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.phoneNumTextField becomeFirstResponder];
    self.codeImageView.imageURL = [NSURL URLWithString:[self getImageUrl]];
    self.codeTextField.text = @"";
    
}

- (void)backForePage
{
    [self dismissModalViewControllerAnimated:YES];
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"find_password");
        self.pageTitle = L(@"Member_LoginAndRegister_ResetPassword1");
        if (!_findPasswordDto) {
            _findPasswordDto  = [[FindPasswordDTO alloc] init];
        }
        //if (IOS7_OR_LATER)
        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"BTNextStep")];
//        else
//        self.navigationItem.rightBarButtonItem = [self rightBtnItemWithTitle:L(@"get_check_code")];

        
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)righBarClick
{

    if (![self validateAllInfo]) {
        return;
    }
    [self.phoneNumTextField resignFirstResponder];
    [self.codeTextField resignFirstResponder];
    
    self.findPasswordDto.uuid = [OpenUDID value];
    self.findPasswordDto.imageCode = self.codeTextField.text;
    self.findPasswordDto.cellPhone = self.phoneNumTextField.text;
    self.findPasswordDto.stepIndex = 1;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self displayOverFlowActivityView];
    [self.findPasswordService beginFindPasswordHttpRequest:self.findPasswordDto];
}

- (FindPasswordService *)findPasswordService
{
    if (!_findPasswordService) {
        _findPasswordService = [[FindPasswordService alloc] init];
        _findPasswordService.delegate = self;
    }
    return _findPasswordService;
}

- (void)loadView
{
    [super loadView];
    
    self.groupTableView.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height - 44);
    
    [self.view addSubview:self.groupTableView];
}


- (void)findPasswordHttpComplete:(FindPasswordService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];

    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess) {
        FindpSecondViewController *find = [[FindpSecondViewController alloc] init];
        find.mobileNumString = self.phoneNumTextField.text;
        [self.navigationController pushViewController:find animated:YES];
            
    }else{
        self.codeImageView.imageURL = [NSURL URLWithString:[self getImageUrl]];
        self.codeTextField.text = @"";
        [self presentSheet:service.errorMsg];
    }
}


#pragma mark -
#pragma mark tableView delegate/datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
//    if (!IOS7_OR_LATER)
//    return 10;
//    else
        return 18;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 100;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.footView;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *findpFirstIdentifier = @"findpFirstIdentifier";
    
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:findpFirstIdentifier];
    
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:findpFirstIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        if (!IOS7_OR_LATER)
//        {
//            UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_background_image.png"]];
//            image.frame = cell.frame;
//            image.backgroundColor = [UIColor clearColor];
//            cell.backgroundView = image;
//            
//            cell.backgroundColor = [UIColor clearColor];
//            cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
//            cell.textLabel.textColor = [UIColor colorWithRGBHex:0x444444];
//        }
        
    }
    
    if (indexPath.section == 0) {
//        if (!IOS7_OR_LATER)
//        cell.textLabel.text = L(@"find_password_phoneNum");

        [cell.contentView addSubview:self.phoneNumTextField];
    }else if (indexPath.section == 1){
//        cell.textLabel.text = @"验证码:";
//        [cell.contentView addSubview:self.codeTextField];
//        [cell.contentView addSubview:self.codeImageView];
    }
    
    return cell;
}


- (void)imageExViewDidOk:(EGOImageViewEx *)imageViewEx
{
    self.codeImageView.imageURL = [NSURL URLWithString:[self getImageUrl]];
}

- (void)imageViewFailedToLoadImage:(EGOImageView *)imageView error:(NSError *)error
{
    self.codeImageView.image = [UIImage imageNamed:@"register_fail.png"];
}


#pragma mark -
#pragma mark init view

- (UITextField *)phoneNumTextField
{
    if (!_phoneNumTextField) {
        CGRect rect = CGRectMake(65, 7., 320 - 28-70., 30.);
        //if (IOS7_OR_LATER)
        rect = CGRectMake(30, 7., 320 - 28-30., 30.);

        _phoneNumTextField = [[UITextField alloc] initWithFrame:rect];
		_phoneNumTextField.delegate = self;
        _phoneNumTextField.font = [UIFont systemFontOfSize:14.0];
		_phoneNumTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_phoneNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_phoneNumTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _phoneNumTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _phoneNumTextField.returnKeyType = UIReturnKeyNext;
        _phoneNumTextField.enablesReturnKeyAutomatically = YES;
		_phoneNumTextField.placeholder = L(@"Please input phone number");
    }
    return _phoneNumTextField;
}


- (UITextField *)codeTextField
{
    if (!_codeTextField) {
        //>zhangliang
        CGRect textRect = CGRectMake(75, 7. + 15, 215 - 28- 70, 30.);
       //if (IOS7_OR_LATER)
        textRect = CGRectMake(30, 7. + 15, 215 - 28- 30, 30.);
        //<zhangliang
        _codeTextField = [[UITextField alloc] initWithFrame:textRect];
		_codeTextField.delegate = self;
        _codeTextField.font = [UIFont systemFontOfSize:14.0];
		_codeTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_codeTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_codeTextField.keyboardType = UIKeyboardTypeEmailAddress;
        _codeTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _codeTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        //if (IOS5_OR_LATER)
        {
            _codeTextField.spellCheckingType = UITextSpellCheckingTypeNo;
        }
        _codeTextField.enablesReturnKeyAutomatically = YES;
		_codeTextField.placeholder = L(@"please_enter_right_code");
    }
    return _codeTextField;
}

- (EGOImageViewEx *)codeImageView
{
    if (!_codeImageView) {
        _codeImageView = [[EGOImageViewEx alloc] init];
        _codeImageView.layer.cornerRadius = 5.0f;
        _codeImageView.delegate = self;
        _codeImageView.exDelegate = self;
        _codeImageView.clipsToBounds = YES;
        _codeImageView.backgroundColor = [UIColor clearColor];
        //>zhangliang
        CGRect codeImageRect =  CGRectMake(4, 5, 73, 34);
        //if (IOS7_OR_LATER)
        codeImageRect =  CGRectMake(26, 5, 73, 34);
        //<zhangliang
        _codeImageView.frame = codeImageRect;
    }
    return _codeImageView;
}

- (UIView *)footView
{
    if (!_footView) {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        _footView.backgroundColor = [UIColor clearColor];
        
        UIImageView *codeBack = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_background_image.png"]];
        codeBack.backgroundColor = [UIColor clearColor];
        //>zhangliang
        CGRect codeRect = CGRectMake(10, 15, 200, 44);
        //#ifdef __IPHONE_7_0
        codeRect = CGRectMake(0, 15, 198, 44);
        //#endif
        //<zhangliang
        codeBack.frame = codeRect;
        [_footView addSubview:codeBack];
        
        //>zhangliang
        
//       if (!IOS7_OR_LATER)
//       {
//           CGRect labelRect = CGRectMake(20, 7 + 15, 70, 30);
//           UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
//           label.backgroundColor = [UIColor clearColor];
//           label.text = L(@"find_password_code");
//           label.font = [UIFont boldSystemFontOfSize:15.0];
//           [_footView addSubview:label];
//       }
        //<zhangliang
       
       
        
        [_footView addSubview:self.codeTextField];
        
        
        UIImageView *codeImage = [[UIImageView alloc] initWithImage:[UIImage streImageNamed:@"password_background_image.png"]];
        codeImage.backgroundColor = [UIColor clearColor];
        //>zhangliang
        CGRect codeImageRect = CGRectMake(225, 15, 80, 44);
        //if (IOS7_OR_LATER)
        codeImageRect = CGRectMake(codeRect.size.width, 15, self.view.frame.size.width-codeRect.size.width, 44);
        //<zhangliang
        codeImage.frame = codeImageRect;
        codeImage.userInteractionEnabled = YES;
        [codeImage addSubview:self.codeImageView];
        [_footView addSubview:codeImage];

        
        //>zhangliang
        CGRect changeRect = CGRectMake(codeImage.left + 20, 10 + codeImage.bottom, 40, 15);
        //if (IOS7_OR_LATER)
        changeRect = CGRectMake(codeImage.left + 40, 10 + codeImage.bottom, 40, 15);
        //<zhangliang
        UIButton *changeBtn = [[UIButton alloc] initWithFrame:changeRect];
        changeBtn.backgroundColor = [UIColor clearColor];
        changeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        [changeBtn setTitleColor:[UIColor colorWithRGBHex:0x0066CC] forState:UIControlStateNormal];
        [changeBtn setTitle:L(@"UCChangeOne") forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageWithColor:[UIColor colorWithRGBHex:0x0066CC] size:CGSizeMake(50, 1)];
        
        UIImageView *view = [[UIImageView alloc] initWithImage:image];
        view.backgroundColor = [UIColor clearColor];
        view.frame = CGRectMake(1, 14, 38, 1);
        [changeBtn addSubview:view];
//        [changeBtn setBackgroundImage:[UIImage imageNamed:@"change_image_url_btn.png"] forState:UIControlStateNormal];
        [changeBtn addTarget:self action:@selector(changeImage) forControlEvents:UIControlEventTouchUpInside];
        
        [_footView addSubview:changeBtn];
        
//        cell.textLabel.text = @"验证码:";
//        [cell.contentView addSubview:self.codeTextField];
//        [cell.contentView addSubview:self.codeImageView];

    }
    return _footView;
}

- (void)changeImage
{
    //self.codeImageView.imageURL = [NSURL URLWithString:[self getImageUrl]];
    // xzoscar 2014/10/10   bug fixed
    [self.codeImageView sd_setImageWithURL:[NSURL URLWithString:[self getImageUrl]]];
}

- (NSString *)getImageUrl
{
    double time = [[NSDate date] timeIntervalSince1970];
    NSString *url = [NSString stringWithFormat:@"%@?uuid=%@&yys=%f",kHostVCSImageCode,[OpenUDID value],time];
    return url;
}


#pragma mark -
//验证手机号码
- (BOOL) validateMobileNo: (NSString *) mobileNo {
    NSString *mobileNoRegex = @"1[0-9]{10,10}";
    NSPredicate *mobileNoTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileNoRegex];
	
    return [mobileNoTest evaluateWithObject:mobileNo];
}

//数据校验
- (BOOL)validateAllInfo
{
    if (IsStrEmpty(self.phoneNumTextField.text)) {
        [self presentSheet:L(@"PhoneNum_Error_NotValide")];
        [self.phoneNumTextField becomeFirstResponder];
        return NO;
    }
    
    if (![self validateMobileNo:self.phoneNumTextField.text]) {
        [self presentSheet:L(@"PhoneNum_Error_NotValide")];
        [self.phoneNumTextField becomeFirstResponder];
        return NO;
    }
    
    if(IsStrEmpty(self.codeTextField.text))
    {
        [self presentSheet:L(@"Please_input_Picture_VerifyNum") posY:50];
        [self.codeTextField becomeFirstResponder];
        return NO;
    }
    if (self.codeTextField.text.length < 4 || self.codeTextField.text.length > 10) {
        [self presentSheet:L(@"Please_input_correct_Picture_VerifyNum") posY:50];
        [self.codeTextField becomeFirstResponder];
        return NO;
    }
    
    NSString *verifyCodeRegex = [NSString stringWithFormat:@"([a-z,A-Z,0-9]+)"];
    NSPredicate *verifyCodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", verifyCodeRegex];
    if ([verifyCodeTest evaluateWithObject:self.codeTextField.text]==NO) {
        [self presentSheet:L(@"Please_input_correct_Picture_VerifyNum") posY:50];
        [self.codeTextField becomeFirstResponder];
        return NO;
    }
    return YES;
}

#pragma mark -
#pragma mark textfield delegate
//手机号码长度不超过11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField  == self.phoneNumTextField)
    {
        if (textField.text.length >= 11 && range.location >=11)
        {
            return NO;
        }
        if (textField.text.length + string.length - range.length > 11) {
            
            return NO;
        }
    }else if (textField == self.codeTextField){
        if (textField.text.length >= 10 && range.location >= 10)
        {
            return NO;
        }
        if (textField.text.length + string.length - range.length > 10) {
            
            return NO;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.phoneNumTextField) {
        [self.codeTextField becomeFirstResponder];
    }else if (textField == self.codeTextField){
        [self righBarClick];
    }
    return YES;
}

@end
