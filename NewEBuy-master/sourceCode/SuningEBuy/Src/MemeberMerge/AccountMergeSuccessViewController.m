//
//  AccountMergeSuccessViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-14.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccountMergeSuccessViewController.h"
#import "MyCardViewController.h"
#import "UITableViewCell+BgView.h"
#import "SFHFKeychainUtils.h"
#import "PasswdUtil.h"

@interface AccountMergeSuccessViewController ()
{
}
@end

@implementation AccountMergeSuccessViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"UCMergeSuccess");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];
        
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"UCOk")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(goToLogin)];
        self.navigationItem.rightBarButtonItem = rightButton;

    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.groupTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.groupTableView.backgroundColor = [UIColor view_Back_Color];
    
    [self.view addSubview:self.groupTableView];
}

- (UIView *)successView
{
    if (!_successView) {
        _successView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
        _successView.backgroundColor = [UIColor clearColor];
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"merge_success_face.png"]];
        arrowView.frame = CGRectMake(100, 14, 22, 22);
        arrowView.backgroundColor = [UIColor clearColor];
        [_successView addSubview:arrowView];
        
        UILabel *successLabel = [[UILabel alloc] initWithFrame:CGRectMake(arrowView.right, 10, 100, 30)];
        successLabel.font = [UIFont boldSystemFontOfSize:18.0];
        successLabel.backgroundColor = [UIColor clearColor];
        successLabel.textColor = [UIColor dark_Gray_Color];
        successLabel.text = [NSString stringWithFormat:@"%@！",L(@"UCMergeSuccess")];
        [_successView addSubview:successLabel];
        
        UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, arrowView.bottom + 12, 270, 50)];
        descLabel.text = L(@"UCMemberCardAndEBuyAccountMergeSuccess");
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.numberOfLines = 0;
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.textColor = [UIColor dark_Gray_Color];
        descLabel.font = [UIFont systemFontOfSize:16.0];
        [_successView addSubview:descLabel];
    }
    return _successView;
}


#pragma mark -
#pragma mark tableView delegate/datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70 + 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 70 + 40)];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 40)];
    tipLabel.backgroundColor = [UIColor clearColor];
    tipLabel.textColor = [UIColor dark_Gray_Color];
    tipLabel.font = [UIFont boldSystemFontOfSize:14.0];
    tipLabel.text = L(@"UCFriendTips");
    tipLabel.numberOfLines = 0;
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:tipLabel];
    
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.successView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *mergeSuccessIdentifier = @"mergeSuccessIdentifier";
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mergeSuccessIdentifier];
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mergeSuccessIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor light_Black_Color];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.detailTextLabel.textColor = [UIColor light_Black_Color];
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = [NSString stringWithFormat:@"%@:  %@",L(@"UCEBuyAccount"),IsStrEmpty(self.memberInfoDto.suningAccount)?@"":self.memberInfoDto.suningAccount];
            break;
        case 1:
            cell.textLabel.text = [NSString stringWithFormat:@"%@:  %@",L(@"UCMemberCardNumber"),IsStrEmpty(self.memberInfoDto.cardNum)?@"":self.memberInfoDto.cardNum];
            break;
        case 2:
            cell.textLabel.text = [NSString stringWithFormat:@"%@:  %@",L(@"LBMobilePhoneNumber"),IsStrEmpty(self.memberInfoDto.cellphone)?@"":self.memberInfoDto.cellphone];
            break;
        case 3:
            cell.textLabel.text = [NSString stringWithFormat:@"%@:  %d%@",L(@"UCCloudDiamondAmount"),IsStrEmpty(self.memberInfoDto.achieve)?0:[self.memberInfoDto.achieve integerValue],L(@"Score")];
            break;
        default:
            break;
    }
    
    return cell;
}

//登录
- (void)goToLogin
{
    if ([UserCenter defaultCenter].userInfoDTO == nil) {
        
        NSString *password = [PasswdUtil encryptString:[UserCenter defaultCenter].suningPassword
                                                 forKey:kLoginPasswdParamEncodeKey
                                                   salt:kPBEDefaultSalt];
        [SFHFKeychainUtils storeUsername:kSuningLoginUserNameKey
                             andPassword:[UserCenter defaultCenter].suningUsername
                          forServiceName:kSNKeychainServiceNameSuffix
                          updateExisting:YES
                                   error:nil];
        [SFHFKeychainUtils storeUsername:kSuningLoginPasswdKey
                             andPassword:password
                          forServiceName:kSNKeychainServiceNameSuffix
                          updateExisting:YES
                                   error:nil];
//        [Config currentConfig].username = [UserCenter defaultCenter].suningUsername;
//        [Config currentConfig].password = [UserCenter defaultCenter].suningPassword;
        [[NSNotificationCenter defaultCenter] postNotificationName:MERGE_SUCCESS_ACTION object:nil];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else{
        for (UINavigationController *ctrl in [self.navigationController viewControllers]) {
            if ([ctrl isKindOfClass:[MyCardViewController class]]) {
                [self.navigationController popToViewController:ctrl animated:NO];
            }
        }
    }
}

@end
