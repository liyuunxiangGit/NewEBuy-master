//
//  AccountCertainViewController.m
//  SuningEBuy
//
//  Created by 荀晓冬 on 13-10-8.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccountCertainViewController.h"
#import "MergerSecondCell.h"
#import "UITableViewCell+BgView.h"
#import "RegisterFirstViewController.h"
#import "AccountListCell.h"
#import "AccountMergeSuccessViewController.h"

@interface AccountCertainViewController()
{
    NSInteger           selectIndex;
}
@end


@implementation AccountCertainViewController

- (void)dealloc
{
    SERVICE_RELEASE_SAFELY(_memberMergeService);
    SERVICE_RELEASE_SAFELY(_accountCheckCodeService);
}


- (id)init{
    self = [super init];
    if (self) {        
        self.title = L(@"UCAccountMerge");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"Member_LoginAndRegister"),self.title];

        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"UCOk")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(goToRegist)];
        self.navigationItem.rightBarButtonItem = rightButton;

    }
    return self;
}

#pragma mark -
#pragma mark view lifycycle

- (void)loadView
{    
    [super loadView];
    
	self.tpTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    [self.view addSubview:self.tpTableView];
    self.tpTableView.backgroundColor = [UIColor view_Back_Color];
    self.secondLable.frame = CGRectMake(10, 25, 320, 30);
}

//绑定事件
-(void)goToRegist
{
    [self displayOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    CardNoListDTO *dto = [self.accoutList objectAtIndex:selectIndex];
    [self.accountCheckCodeService beginGetCheckCode:dto.cardNo email:@"" checkCodeState:eMergeAccountCode validateCode:@""];
}

- (AccountCheckCodeService *)accountCheckCodeService
{
    if (!_accountCheckCodeService) {
        _accountCheckCodeService = [[AccountCheckCodeService alloc] init];
        _accountCheckCodeService.delegate = self;
    }
    return _accountCheckCodeService;
}

- (void)didGetCheckCodeComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc
{
    [self removeOverFlowActivityView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    if (isSuccess) {
        AccountMergeSuccessViewController *find = [[AccountMergeSuccessViewController alloc] init];
        find.memberInfoDto = self.accountCheckCodeService.memberInfoDto;
        [self.navigationController pushViewController:find animated:YES];
    }else{
        [self presentSheet:IsStrEmpty(errorDesc)?L(@"ASI_CONNECTION_FAILURE_ERROR"):errorDesc posY:60];
    }
}

#pragma mark - 
#pragma mark init view
-(UILabel *)secondLable
{
    if (!_secondLable) {
        _secondLable = [[UILabel alloc]init];
        _secondLable.backgroundColor = [UIColor clearColor];
        _secondLable.text = L(@"UCOnlyBoundMobilePhoneNumber");
        _secondLable.textColor = [UIColor dark_Gray_Color];
        _secondLable.numberOfLines = 0;
        _secondLable.font = [UIFont systemFontOfSize:13.0f];
    }
    return _secondLable;
}


- (NSMutableArray *)accoutList
{
    if (!_accoutList) {
        _accoutList = [[NSMutableArray alloc] init];
        for (int i = 0; i < 2; i ++) {
            CardNoListDTO *dto = [[CardNoListDTO alloc] init];
            dto.isSelected = NO;
            dto.ecoType = L(@"UCElectricCard");
            dto.cardNo = [NSString stringWithFormat:@"12312341234 %d",i];
            [_accoutList addObject:dto];
        }        
    }
    return _accoutList;
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
#pragma mark tableview datasource/delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
   	return self.accoutList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){        
        CGSize size = [L(@"UCPleaseSelectUniformBoundMobilePhoneNo") sizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(291, MAXFLOAT)];
        
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, size.height + 50)];
        v.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 300, size.height + 5)];
        lab.backgroundColor = [UIColor clearColor];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor dark_Gray_Color];
        lab.numberOfLines = 0;
        lab.text = L(@"UCPleaseSelectUniformBoundMobilePhoneNo");
        [v addSubview:lab];
        [v addSubview:self.secondLable];
        return v;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *firstCellIdentifier = @"firstCellIdentifier";
    MergerSecondCell* firstCell = [tableView dequeueReusableCellWithIdentifier:firstCellIdentifier];
    if (firstCell == nil) {
        firstCell = [[MergerSecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:firstCellIdentifier];
        firstCell.selectionStyle = UITableViewCellSelectionStyleNone;
//        [firstCell.selectButton addTarget:self action:@selector(selectBtnAction: event:) forControlEvents:UIControlEventTouchUpInside];
    }
    CardNoListDTO *dto = [self.accoutList objectAtIndex:indexPath.row];
    if (dto.isSelected) {
        firstCell.accessoryView = self.markView;
    }else{
        firstCell.accessoryView = nil;
    }
    firstCell.item = dto;
    return firstCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectIndex = indexPath.row;
    
    [self changeSelectStatus];
}


- (void)selectBtnAction:(id)sender event:(id)event
{
    NSSet *touches = [event allTouches];
    UITouch *touch = [touches anyObject];
    CGPoint currentTouchPosition = [touch locationInView : self.tpTableView];
    NSIndexPath *indexPath = [self.tpTableView indexPathForRowAtPoint : currentTouchPosition];
    if (indexPath != nil) {
        selectIndex = indexPath.row;
        [self changeSelectStatus];
    }
}

//点击事件
- (void)changeSelectStatus
{
    for (int i = 0; i < [self.accoutList count]; i ++) {
        CardNoListDTO *dto = [self.accoutList objectAtIndex:i];
        if (i == selectIndex) {
            dto.isSelected = YES;
        }else{
            dto.isSelected = NO;
        }
    }
    [self.tpTableView reloadData];    
}

@end
