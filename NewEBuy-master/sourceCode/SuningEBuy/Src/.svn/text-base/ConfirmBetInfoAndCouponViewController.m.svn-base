//
//  ConfirmBetInfoAndCouponViewController.m
//  SuningEBuy
//
//  Created by 周俊杰 on 14-3-12.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConfirmBetInfoAndCouponViewController.h"
#import "CouponUserinfoView.h"
#import "CouponBottomView.h"
#import "BallInfoCell.h"
#import "CouponTitleCell.h"
#import "CouponTitleView.h"
#import "CouponContectView.h"
#import "CouponModel.h"
#import "LotteryPayPlugin.h"
#import "LotteryPayPageViewController.h"

@interface ConfirmBetInfoAndCouponViewController ()
{
    BOOL showInfo[2];
}
@property (nonatomic ,strong) CouponUserinfoView *userinfoView;
@property (nonatomic ,strong) CouponBottomView *bottomView;
@property (nonatomic ,strong) CouponTitleView *couponTitleView;
@property (nonatomic ,strong) CouponContectView *couponContectView;
@end

@implementation ConfirmBetInfoAndCouponViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc{
    TT_RELEASE_SAFELY(_userinfoView);
    TT_RELEASE_SAFELY(_bottomView);
    TT_RELEASE_SAFELY(_couponTitleView);
    TT_RELEASE_SAFELY(_couponContectView);
    TT_RELEASE_SAFELY(_submitDto);
    TT_RELEASE_SAFELY(_couponInfoArray);
    TT_RELEASE_SAFELY(_userInfoDic);

    SERVICE_RELEASE_SAFELY(_couponService);
    [LotteryPayPlugin cancelPay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.couponService fetchUserDetailInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView{
    
    [super loadView];
    
    self.title = L(@"LOMakeSureInfo");
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_lottery"),self.title];
    
    UIButton *submitOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    submitOrderBtn.frame = CGRectMake(0, 0, 70, 30);
    [submitOrderBtn setTitleColor:[UIColor colorWithRGBHex:0x313131] forState:UIControlStateNormal];
    [submitOrderBtn setTitle:L(@"commitPay") forState:UIControlStateNormal];
    submitOrderBtn.titleLabel.font = [UIFont boldSystemFontOfSize: 13.0];
    [submitOrderBtn addTarget:self action:@selector(submitOrderAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:submitOrderBtn];
    TT_RELEASE_SAFELY(submitOrderBtn);
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (IOS7_OR_LATER) {
        self.tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 50 - 44 - 20);
    }else{
        self.tableView.frame = CGRectMake(0, 0, 320, self.view.frame.size.height - 50 - 44);
    }
    [self.tableView addSubview:(UIView *) self.refreshHeaderView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [self.view addSubview:self.bottomView];

    showInfo[0] = NO;
    showInfo[1] = YES;
}

#pragma mark -提交订单
- (void)submitOrderAction{

    if ([LotteryPayPlugin open])
    {
        [LotteryPayPlugin startPayWithDto:self.submitDto fromController:self];
    }
    else
    {
        LotteryPayPageViewController *ctrl = [[LotteryPayPageViewController alloc]initWithSubmitLotteryDTO:self.submitDto];
        
        [self.navigationController pushViewController:ctrl animated:YES];
        
        TT_RELEASE_SAFELY(ctrl);
    }
}

#pragma mark - getMethod

- (CouponService *)couponService{
    
    
    if (!_couponService) {
        
        _couponService = [[CouponService alloc] init];
        
        _couponService.delegate = self;
    }
    return _couponService;
}

- (CouponUserinfoView *)userinfoView{
    
    if (_userinfoView == nil) {
        
        _userinfoView = [[CouponUserinfoView alloc] initWithFrame:CGRectMake(0, 0, 320, 120)];
    }
    return _userinfoView;
    
}

- (CouponBottomView *)bottomView{
    
    if (_bottomView == nil) {
        _bottomView = [[CouponBottomView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, 320, 50)];
        _bottomView.payNumLabel.text = [NSString stringWithFormat:L(@"LOIssue5"),self.submitDto.productMoney,self.submitDto.productMoney,@"0"];

    }
    return _bottomView;
    
}

- (CouponTitleView *)couponTitleView{
    
    if (_couponTitleView == nil) {
        _couponTitleView = [[CouponTitleView alloc] initWithFrame:CGRectMake(0, 0, 320, 65)];
        [_couponTitleView addTarget:self action:@selector(shouCouponTitle) forControlEvents:UIControlEventTouchUpInside];
        _couponTitleView.nameLabel.text = [NSString stringWithFormat:L(@"LOIssue6"),
                                           self.submitDto.productName,
                                           self.submitDto.productTimes,
                                           ([self.submitDto.productMoney intValue]/2)/([self.submitDto.multiNo integerValue]),
                                           self.submitDto.multiNo];
    }
    return _couponTitleView;
    
}

- (CouponContectView *)couponContectView {
    if (!_couponContectView) {
        _couponContectView = [[CouponContectView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [_couponContectView addTarget:self action:@selector(shouCouponContent) forControlEvents:UIControlEventTouchUpInside];

    }
    return _couponContectView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        if (showInfo[0]) {
            return [self.ballInfoArray count];
        }else{
            return 0;
        }
    }else if (section == 2){
        if (showInfo[1]) {
            return [self.couponInfoArray count] + 1;
        }else{
            return 0;
        }
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"BallInfoCell";
        BallInfoCell *cell = (BallInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[BallInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        cell.infoLabel.text = self.ballInfoArray[indexPath.row];

        return cell;
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            static NSString *CellIdentifier = @"CouponTitleCell";
            CouponTitleCell *cell = (CouponTitleCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[CouponTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            return cell;
        }else{
            static NSString *CellIdentifier = @"CouponInfoCell";
            CouponInfoCell *cell = (CouponInfoCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[CouponInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            cell.delegate = self;
            CouponModel *aCoupon = self.couponInfoArray[indexPath.row - 1];
            cell.couponMeodel = aCoupon;
            cell.stateButton.selected = aCoupon.remarked;
            float fMoney = [aCoupon.totalMoney floatValue];
            NSString *strMoneyInfo = [NSString stringWithFormat:@"%.02f", fMoney];
            cell.moneyInfoLabel.text = strMoneyInfo;
            cell.timeInfoLabel.text = aCoupon.expiryDate;
            cell.typeInfoLabel.text = aCoupon.couponName;
            return cell;
        }
    }
    
    static NSString *CellIdentifier = @"Cell2";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 120;
    }else if (section == 1){
        return 65;
    }else if (section == 2){
        return 40;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return 30;
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 40;
        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return self.userinfoView;
    }else if (section == 1) {
        return self.couponTitleView;
    }else if (section == 2){
        return self.couponContectView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
    if (section == 2) {
        footerView.backgroundColor = [UIColor whiteColor];
    }else{
        footerView.backgroundColor = [UIColor uiviewBackGroundColor];
    }
    return footerView;
}

#pragma mark - InfoUIShow&dismiss
- (void)shouCouponTitle {
    if (showInfo[0]) {
        self.couponTitleView.indicatorImageView.image = [UIImage imageNamed:@"coupon_show.png"];
    }else{
        self.couponTitleView.indicatorImageView.image = [UIImage imageNamed:@"coupon_dismiss.png"];
    }
    showInfo[0] = !showInfo[0];

    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];

}

- (void)shouCouponContent {
    if (showInfo[1]) {
        self.couponContectView.indicatorImageView.image = [UIImage imageNamed:@"coupon_show.png"];
    }else{
        self.couponContectView.indicatorImageView.image = [UIImage imageNamed:@"coupon_dismiss.png"];
    }
    showInfo[1] = !showInfo[1];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -CouponServiceDelegate
- (void)couponUserQueryFinished:(CouponService *)service withUserInfo:(ConfirmBetInfoModel *)info
{
    self.betInfo = info;
    _userinfoView.userInfoLabel.text = [NSString stringWithFormat:L(@"LOIssue7"),
                                        info.userName,
                                        info.IDNumber,
                                        info.phoneNum
                                        ];
}

- (void)couponCheckFinished:(CouponService *)service withInfoArray:(NSArray *)infoArray
                    errCode:(NSInteger)errCode
                     errStr:(NSString *)errStr
{
    [self removeOverFlowActivityView];
    
    if (errCode == 1) {
        [self presentSheet:errStr];
        return ;
    }//判断用券是否可用
    
    if ([infoArray count] >0){
        self.useCouponArray = infoArray;
        
        float couponTotalMoney = 0.0;
        for (CouponModel *couponModel in infoArray) {
            couponTotalMoney = couponTotalMoney+[couponModel.remainMoney floatValue];
        }
        
        if (couponTotalMoney>=[self.submitDto.productMoney floatValue])
        {
            self.betInfo.payAmountMoney = [NSString stringWithFormat:@"0"];
            self.betInfo.amountMoney    = self.submitDto.productMoney ;
            self.betInfo.coupon         = self.submitDto.productMoney ;
        }else
        {
            self.betInfo.payAmountMoney = [NSString stringWithFormat:@"%.2f",([self.submitDto.productMoney floatValue]-couponTotalMoney)];
            self.betInfo.amountMoney    = self.submitDto.productMoney ;
            self.betInfo.coupon         = [NSString stringWithFormat:@"%.2f",couponTotalMoney];
        }
        
        _bottomView.payNumLabel.text = [NSString stringWithFormat:L(@"LOIssue5"),self.betInfo.payAmountMoney,self.betInfo.amountMoney,self.betInfo.coupon];
        
        self.submitDto.eppPayedMoney  = self.betInfo.payAmountMoney;
        self.submitDto.coupons        = self.checkCouponCode;
        self.submitDto.commPayedMoney = self.betInfo.coupon;
        self.submitDto.needCoupon     = YES;

        if (couponTotalMoney >[self.submitDto.productMoney floatValue])
        {
            [self presentSheet:L(@"LOOverSum")];
            
        }else if(couponTotalMoney <[self.submitDto.productMoney floatValue])
        {
            [self presentSheet:L(@"LOLowSum")];
        }
    }
}

- (void)couponQueryFinished:(CouponService *)service withInfoArray:(NSArray *)infoArray
{
    [self removeOverFlowActivityView];
    if ([infoArray count] >0)
    {
        self.couponInfoArray = infoArray;
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
    }
    [self refreshDataComplete];

}

#pragma mark - CouponInfoCellDelegate

- (void)couponButtonClicked:(CouponInfoCell *)cell withClickedButton:(UIButton *)button{
    button.selected = !button.selected;
    cell.couponMeodel.remarked = button.selected;
    
    self.checkCouponCode = @"";
    for (CouponModel *model in self.couponInfoArray)
    {
        if (model.remarked){
            if ([self.checkCouponCode isEqualToString:@""]) {
                self.checkCouponCode =  model.couponNo;
            }
            else{
                self.checkCouponCode = [self.checkCouponCode stringByAppendingFormat:@",%@",model.couponNo];
            }
        }
    }
  
    if ([self.checkCouponCode isEqualToString:@""]) {
        [self presentSheet:L(@"LONotChooseCertification")];
        _bottomView.payNumLabel.text = [NSString stringWithFormat:L(@"LOIssue5"),self.submitDto.productMoney,self.submitDto.productMoney,@"0"];
        
        //取消最后一个用券
        self.submitDto.eppPayedMoney  = self.betInfo.payAmountMoney;
        self.submitDto.coupons        = @"";
        self.submitDto.needCoupon     = NO;
        return;
    }
    
    [self displayOverFlowActivityView];
    [self.couponService checkCouponWithSubmitLotteryDto:self.submitDto couponCode:self.checkCouponCode];
    
    
    

}

#pragma mark - 刷新
- (void)refreshData
{
    
    [super refreshData];
    [self displayOverFlowActivityView];
    [self.couponService fetchUserDetailInfo];
    
    [self.couponService couponQueryWithSubmitLotteryDto:self.submitDto];
}
@end
