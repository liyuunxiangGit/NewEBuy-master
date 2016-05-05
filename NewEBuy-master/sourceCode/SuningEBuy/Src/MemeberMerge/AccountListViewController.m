//
//  AccountListViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccountListViewController.h"
#import "YigouAccountViewController.h"
#import "AccountMergeSuccessViewController.h"
#import "DataValidate.h"
#import "MyCardViewController.h"

@interface AccountListViewController ()
{
    NSInteger           selectedIndex;
}
@end

@implementation AccountListViewController


- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_memberMergeService);
}

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"UCMergeAccount");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];
        selectedIndex = 0;
        if ([UserCenter defaultCenter].userInfoDTO == nil) {
            self.isLogoned = NO;
        }else{
            self.isLogoned = YES;
        }
    }
    return self;
}

//下一步
- (void)nextStepBtnAction
{
    
    if (selectedIndex < 0) {
        [self presentSheet:L(@"UCPleaseSelectBoundMemberCard")];
        return;
    }
    
    NSString *passErrorMsg;
    if (![DataValidate validatePassWord:self.cardPassTextField.text error:&passErrorMsg]) {
        [self presentSheet:passErrorMsg];
        [self.cardPassTextField becomeFirstResponder];
        return;
    }
    
    [self.cardPassTextField resignFirstResponder];
    CardNoListDTO *dto = [self.accoutList objectAtIndex:selectedIndex];
    
    if ([dto.isBindB2CAccount isEqualToString:@"1"]) {
        [self presentSheet:L(@"UCMemberCardMergeWithEBuyAccount")];
        return;
    }
    
    [self displayOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    if (self.isLogoned) {
        [self.memberMergeService beginAccountBindMbrCardWithCardNum:dto.cardNo cardPsw:self.cardPassTextField.text];
    }else{
        [self.memberMergeService beginMbrCardBindAccountLoginId:@"" logonPassword:@"" cardNum:dto.cardNo cardPsw:self.cardPassTextField.text];
    }
}

- (void)accountBindMbrCardHttpComplete:(MemeberMergeService *)service isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MERGE_SUCCESS_ACTION object:nil];
        for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
            if ([ctrl isKindOfClass:[MyCardViewController class]]) {
                [self.navigationController popToViewController:ctrl animated:NO];
            }
        }
    }else{
        [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg];
    }
}

- (void)mbrCardBindAccountHttpComplete:(MemeberMergeService *)service isMergeSuccess:(BOOL)isMergeSuccess isSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    if (isSuccess) {
        if ([UserCenter defaultCenter].isLogined) {
          
        }else{
            YigouAccountViewController *success = [[YigouAccountViewController alloc] init];
            success.suningAccount = self.suningAccount;
            CardNoListDTO *dto = [self.accoutList objectAtIndex:selectedIndex];
            success.cardNum = dto.cardNo;
            success.cardPass = self.cardPassTextField.text;
            [self.navigationController pushViewController:success animated:YES];            
        }
    }else{
        [self presentSheet:IsStrEmpty(service.errorMsg)?L(@"ASI_CONNECTION_FAILURE_ERROR"):service.errorMsg];
    }
}

- (NSMutableArray *)accoutList
{
    if (!_accoutList) {
        _accoutList = [[NSMutableArray alloc] init];
        for (int i = 0; i < 2; i ++) {
            CardNoListDTO *dto = [[CardNoListDTO alloc] init];
            dto.isSelected = NO;
            if (i == 0) {
                dto.isSelected = YES;
            }
            dto.ecoType = L(@"UCElectricCard");
            dto.cardNo = [NSString stringWithFormat:@"12312341234 %d",i];
            [_accoutList addObject:dto];
        }
    }
    return _accoutList;
}

- (void)loadView
{
    [super loadView];
    
    self.tpTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.view addSubview:self.tpTableView];
    self.tpTableView.backgroundColor = [UIColor view_Back_Color];
    [self addHeadView];
}

- (void)addHeadView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    v.backgroundColor = [UIColor clearColor];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 20)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:14.0];
    lab.textColor = [UIColor dark_Gray_Color];
    lab.numberOfLines = 0;
    lab.text = L(@"UCSelectCommonlyUsedMemberCard");
    [v addSubview:lab];
    self.tpTableView.tableHeaderView = v;
}

- (PasswordToggleView *)passwordToggleView
{
    if (!_passwordToggleView) {
        _passwordToggleView = [[PasswordToggleView alloc] init];
        [_passwordToggleView addTarget:self action:@selector(changePasswordShowState) forControlEvents:UIControlEventValueChanged];
    }
    return _passwordToggleView;
}

- (void)changePasswordShowState
{
    self.cardPassTextField.secureTextEntry = !self.passwordToggleView.isShowWords;
    [self.tpTableView reloadData];
}


#pragma mark -
#pragma mark init view
- (UILabel *)cardPassLabel
{
    if (!_cardPassLabel) {
        _cardPassLabel = [[UILabel alloc] init];
        _cardPassLabel.backgroundColor = [UIColor clearColor];
        _cardPassLabel.text = [NSString stringWithFormat:@"%@：",L(@"UCMemberCardPassword")];
        _cardPassLabel.font = [UIFont boldSystemFontOfSize:14.0];
        _cardPassLabel.frame = CGRectMake(15, 0, 85, 40);
        _cardPassLabel.textColor = [UIColor light_Black_Color];
    }
    return _cardPassLabel;
}


- (UITextField *)cardPassTextField
{
    if (!_cardPassTextField) {
        _cardPassTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.cardPassLabel.right, 0, 140 + 20, 40)];
		_cardPassTextField.delegate = self;
        _cardPassTextField.font = [UIFont systemFontOfSize:14.0];
		_cardPassTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
		_cardPassTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
		_cardPassTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _cardPassTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _cardPassTextField.returnKeyType = UIReturnKeyDone;
        _cardPassTextField.enablesReturnKeyAutomatically = YES;
		_cardPassTextField.placeholder = L(@"UCPleaseEnterMemberCardPassword");
        _cardPassTextField.secureTextEntry = YES;
    }
    return _cardPassTextField;
}


- (UIImageView *)markView
{
    if (!_markView) {
        _markView = [[UIImageView alloc] init];
        _markView.backgroundColor = [UIColor clearColor];
        _markView.image = [UIImage imageNamed:@"cellMark.png"];
        _markView.frame = CGRectMake(290, ( 40 - 7 ) / 2.0, 12, 7);
    }
    return _markView;
}

//- (UIView *)nextStepView
//{
//    if (!_nextStepView) {
//        _nextStepView = [[UIButton alloc] init];
//        _nextStepView.backgroundColor = [UIColor clearColor];
//        _nextStepView.frame = CGRectMake(0, 0, 320, 70);
//        
//        UIButton *_nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _nextStepBtn.backgroundColor = [UIColor clearColor];
//        [_nextStepBtn setBackgroundImage:[UIImage streImageNamed:@"yellowButton_new.png"] forState:UIControlStateNormal];
//        [_nextStepBtn setTitleColor:[UIColor colorWithRGBHex:0x543500] forState:UIControlStateNormal];
//        if (!self.isLogoned) {
//            [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
//        }else{
//            [_nextStepBtn setTitle:@"确认绑定" forState:UIControlStateNormal];
//        }
//        [_nextStepBtn addTarget:self action:@selector(nextStepBtnAction) forControlEvents:UIControlEventTouchUpInside];
//        _nextStepBtn.frame = CGRectMake(24, 20, 272, 42);
//        [_nextStepView addSubview:_nextStepBtn];
//    }
//    return _nextStepView;
//}

#pragma mark 会员请求
- (MemeberMergeService *)memberMergeService
{
    if (!_memberMergeService) {
        _memberMergeService = [[MemeberMergeService alloc] init];
        _memberMergeService.delegate = self;
    }
    return _memberMergeService;
}


#pragma mark -
#pragma mark tableview delegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == selectedIndex) {
        return 2;
    }
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.accoutList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.;
    }
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == selectedIndex) {
//        return 50;
//    }
//    return 0;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    if (section == selectedIndex) {
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor clearColor];
//        [view addSubview:self.cardPassLabel];
//        [view addSubview:self.cardPassTextField];
//        return view;
//    }
//    return nil;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1){
        static NSString *accountPassIdentifier = @"accountPassIdentifier";
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:accountPassIdentifier];
        if(cell == nil)
        {
            cell = [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountPassIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }else{
            [cell.contentView removeAllSubviews];
        }
        self.passwordToggleView.left = self.cardPassTextField.right+5;
        self.passwordToggleView.top = 10;
        [cell.contentView addSubview:self.passwordToggleView];
        [cell.contentView addSubview:self.cardPassLabel];
        [cell.contentView addSubview:self.cardPassTextField];
        
        return cell;
    }
    static NSString *accountListIdentifier = @"accountListIdentifier";
    AccountListCell *cell = [tableView dequeueReusableCellWithIdentifier:accountListIdentifier];
    if(cell == nil)
    {
        cell = [[AccountListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:accountListIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }else{
        [cell.contentView removeAllSubviews];
    }
    CardNoListDTO *dto = [self.accoutList objectAtIndex:indexPath.section];
    cell.item = dto;
    if (dto.isSelected) {
        cell.accessoryView = self.markView;
    }else{
        cell.accessoryView = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 1)
    {
        if (selectedIndex != indexPath.section) {
            self.cardPassTextField.text = @"";
        }
        selectedIndex = indexPath.section;
        
        [self changeSelectStatus];
    }
}


- (void)selectBtnAction:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView: self.tpTableView];
    NSIndexPath *indexPath = [self.tpTableView indexPathForRowAtPoint:currentTouchPosition];
    if (indexPath != nil) {
        if (selectedIndex != indexPath.section) {
            self.cardPassTextField.text = @"";
        }
        selectedIndex = indexPath.section;
        [self changeSelectStatus];
    }
}

//点击事件
- (void)changeSelectStatus
{
    for (int i = 0; i < [self.accoutList count]; i ++) {
        CardNoListDTO *dto = [self.accoutList objectAtIndex:i];
        if (i == selectedIndex) {
            dto.isSelected = YES;
        }else{
            dto.isSelected = NO;
        }
    }
    [self.tpTableView reloadData];
}



#pragma mark -
#pragma mark textfield delegate/datasource

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.cardPassTextField) {
        [self.cardPassTextField resignFirstResponder];
        [self nextStepBtnAction];
    }
    return YES;
}

@end
