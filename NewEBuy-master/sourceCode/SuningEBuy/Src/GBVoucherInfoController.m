//
//  GBVourcherInfoController.m
//  SuningEBuy
//
//  Created by xingxuewei on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBVoucherInfoController.h"
#import "GBVoucherInfoCell.h"
#import "GBRefundViewController.h"

@implementation GBVoucherInfoController

@synthesize voucherDTO = _voucherDTO;
@synthesize voucherType = _voucherType;
@synthesize voucherList = _voucherList;


- (void)dealloc
{
    TT_RELEASE_SAFELY(_voucherDTO);
    TT_RELEASE_SAFELY(_orderDetailDto);
    
    TT_RELEASE_SAFELY(_refundBtn);
    TT_RELEASE_SAFELY(_allSelectBtn);
}

- (id)init
{
    self = [super init];
    if (self) {

        self.title = L(@"GBDetailOfGroupCertification");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
        self.tuanGouType = -1;
        
        if (!_voucherDTO)
        {
            _voucherDTO = [[GBVoucherDTO alloc] init];
        }
        if (!_voucherList) {
            _voucherList = [[NSArray alloc] init];
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    frame.size.height = contentView.bounds.size.height - kUINavigationBarFrameHeight - 60;
    

    self.allSelectBtn.enabled = NO;
    
    if (2 == self.orderDetailDto.voucherType) {
        
        self.allSelectBtn.hidden = YES;
        if (0 == self.orderDetailDto.voucherMap.notUse
            || NO == self.orderDetailDto.voucherMap.canRefund) {
            
            self.bottomCell.bottomPayBtn.enabled = NO;
//            self.refundBtn.enabled = NO;
        }
        
        frame.size.height = contentView.bounds.size.height - kUINavigationBarFrameHeight - 120;
    }
    else{
        
//        self.refundBtn.enabled = NO;
        self.bottomCell.bottomPayBtn.enabled = NO;

        for (GBVoucherSingleInfoDTO *dto in self.orderDetailDto.voucherList) {
            
            if (2 == dto.status && 0 == dto.gbType) {
                
                self.allSelectBtn.enabled = YES;
                
                break;
            }
        }
    }
    
    self.groupTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.groupTableView.indicatorStyle = UIScrollViewIndicatorStyleDefault;

    [self.view addSubview:self.groupTableView];
    self.hasSuspendButton = YES;
   
    if(self.isRefund == YES)
    {
        SNUIBarButtonItem *rightButton = [SNUIBarButtonItem itemWithTitle:L(@"Next Step")
                                                                    Style:SNNavItemStyleDone
                                                                   target:self
                                                                   action:@selector(refundAction:)];
        self.navigationItem.rightBarButtonItem = rightButton;
        self.navigationItem.rightBarButtonItem.enabled = [self judgeNextBtnIsEnable];

    }
    else
    {
        self.navigationItem.rightBarButtonItem = nil;

    }
   

    for (GBVoucherSingleInfoDTO *dto in self.orderDetailDto.voucherList) {
        
        dto.isSelect = NO;
    }
    
}

- (UILabel*)alertLbl
{
    if(!_alertLbl)
    {
        _alertLbl = [[UILabel alloc] init];
        _alertLbl.font = [UIFont systemFontOfSize:17];
        _alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.frame = CGRectMake(0, self.view.frame.size.height/2-76-46+15, self.view.frame.size.width, 30);
        _alertLbl.textAlignment = UITextAlignmentCenter;
        _alertLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        _alertLbl.hidden = YES;
        [self.view addSubview:_alertLbl];
    }
    return _alertLbl;
}

- (void)updateTable
{
    self.alertLbl.hidden = YES;
//    self.alertImageV.hidden = YES;
    
    if (0 == [self.orderDetailDto.voucherList count]
        &&  2 != self.orderDetailDto.voucherType) {
        //一圈一用 但券未生效时不展示
        
        self.alertLbl.text = L(@"GBPleaseWaitCertificateToBeEffect");
        
        self.alertLbl.hidden = NO;
        
        self.navigationItem.rightBarButtonItem.enabled = [self judgeNextBtnIsEnable];
//        self.alertImageV.hidden = NO;
    }
    self.navigationItem.rightBarButtonItem.enabled = [self judgeNextBtnIsEnable];

    [self.groupTableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self updateTable];
}



#pragma mark - TableView Delegate Datasource Methods
#pragma mark   TableView 的代理以及数据源方法。
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.orderDetailDto.voucherType == 0 || self.orderDetailDto.voucherType == 1) {
        
        return [self.orderDetailDto.voucherList count]+1;
    }
    return 2;
//    return 1;
//    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 1;

    if(section == 0)
    {
        return 1;
    }
    else
    {
//        if (self.orderDetailDto.voucherType == 0 || self.orderDetailDto.voucherType == 1) {
//            
//            return [self.orderDetailDto.voucherList count];
//        }
        return 1;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        if(self.isRefund == YES)
        {
            return 0;
        }
        
        if (IsArrEmpty(self.orderDetailDto.voucherList) && ![self.orderDetailDto.voucherList count] && IsNilOrNull(self.orderDetailDto.voucherMap))
        {
            return 0;
        }
        
        return 40;

    }
    
    
    switch (self.orderDetailDto.voucherType) {
        case 0://酒店券
        {

        }
        case 1://一券一用
        {

            if (IsArrEmpty(self.orderDetailDto.voucherList) || ![self.orderDetailDto.voucherList count])
            {
                return 0;
            }
            
            GBVoucherSingleInfoDTO *voucherSingleDTO = [self.orderDetailDto.voucherList safeObjectAtIndex:indexPath.section-1];
            
            if (0 == [voucherSingleDTO.voucherPasswd length]) {
                
                return 115;
            }
            return 140;
        }
            break;
            
        case 2://一券多用
        {
            return 230;
        }
            break;
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        static NSString *GBVoucherSingleInfoCellIdentifier = @"CellIdentifier_SNUITableViewCell";
        
        SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GBVoucherSingleInfoCellIdentifier];
        
        if (!cell)
        {
            cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBVoucherSingleInfoCellIdentifier];
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            if(self.isRefund == YES)
            {
                return cell;
            }
            
            
            if (IsArrEmpty(self.orderDetailDto.voucherList) && ![self.orderDetailDto.voucherList count] && IsNilOrNull(self.orderDetailDto.voucherMap))
            {
                return cell;
            }

            UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 306, 47)];
            lab.backgroundColor = [UIColor clearColor];
            lab.font = [UIFont systemFontOfSize:13];
            lab.numberOfLines = 0;
            
            
            if (2 == self.orderDetailDto.voucherType) {
                
                lab.text = L(@"GBPleaseGiveOutYourSecretCode");
            }
            else{
                
                lab.text = L(@"GBPleaseNotGiveOutYourSecretCode");
            }

            [cell.contentView addSubview:lab];

        }
        
        return cell;

    }
    else
    {
        switch (self.orderDetailDto.voucherType) {
            case 0://酒店券
            {
                
            }
            case 1://一券一用
            {
                
                if (IsArrEmpty(self.orderDetailDto.voucherList) || ![self.orderDetailDto.voucherList count])
                {
                    return nil;
                }
                
                GBVoucherSingleInfoDTO *voucherSingleDTO = [self.orderDetailDto.voucherList safeObjectAtIndex:indexPath.section-1];
                
                static NSString *GBVoucherSingleInfoCellIdentifier = @"GBVoucherSingleInfoCellIdentifier";
                
                GBVoucherSingleInfoCell *cell = (GBVoucherSingleInfoCell *)[tableView dequeueReusableCellWithIdentifier:GBVoucherSingleInfoCellIdentifier];
                
                if (!cell)
                {
                    cell = [[GBVoucherSingleInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBVoucherSingleInfoCellIdentifier];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                    cell.tuanGouType = self.orderDetailDto.gbType;
                    
                }
                
                [cell setItem:voucherSingleDTO WithIsrefund:self.isRefund];
                
                cell.myDelegate = self;
                
                return cell;
                
            }
                break;
                
            case 2://一券多用
            {
                static NSString *GBVoucherInfoCellIdentifier = @"GBVoucherInfoCellIdentifier";
                
                GBVoucherInfoCell *cell = (GBVoucherInfoCell *)[tableView dequeueReusableCellWithIdentifier:GBVoucherInfoCellIdentifier];
                
                if (!cell)
                {
                    cell = [[GBVoucherInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBVoucherInfoCellIdentifier];
                    
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    
                }
                
                [cell setItem:self.orderDetailDto.voucherMap];
                
                return cell;
            }
                break;
                
            default:
                break;
        }

    }
    
    return [[UITableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    
    if(IOS7_OR_LATER)
    {
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    else
    {
        view.backgroundColor = [UIColor clearColor];
        
    }
    
    return view;
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.00001)];
    
    if(IOS7_OR_LATER)
    {
        view.backgroundColor = [UIColor uiviewBackGroundColor];
        
    }
    else
    {
        view.backgroundColor = [UIColor clearColor];
        
    }
    
    return view;
}


/*
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == 0)
    {
        return 55;
    }
    return 15;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 55)];
    
    v.backgroundColor = [UIColor clearColor];
//    v.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"home_system_background.png"]];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(7, 8, 306, 47)];
    lab.backgroundColor = [UIColor clearColor];
    lab.font = [UIFont systemFontOfSize:13];
    lab.numberOfLines = 0;
    //lab.textAlignment = UITextAlignmentCenter;

    if (2 == self.orderDetailDto.voucherType) {

        lab.text = @"为了保证您的权益，请到店消费时提供密码，预约时无需提供。若您购买多个数量，密码可重复使用。";
    }
    else{

        lab.text = @"为了保证您的权益，预约时无需提供券号和券密码，请到店消费时再提供。";
    }

    [v addSubview:lab];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

-(UIView *)footView{
    
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, self.tableView.bottom, 320, self.view.size.height-self.tableView.size.height)];
    
    v.backgroundColor = [UIColor clearColor];
    
    if (2 == self.orderDetailDto.voucherType) {
        
        self.refundBtn.frame = CGRectMake(25,10, 270, 44);
    }

    [v addSubview:self.allSelectBtn];

    [v addSubview:self.refundBtn];
    
    return v;
}
*/
-(UIButton *)refundBtn{
    
    if (!_refundBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _refundBtn = btn;
        _refundBtn.frame = CGRectMake(210,5, 90, 44);
        [_refundBtn setTitle:L(@"BTRefund") forState:UIControlStateNormal];
        UIImage *backImg = nil;//[UIImage imageNamed:@"GB_order_cancel.png"];
        backImg = [[UIImage imageNamed:@"tuikuan_butten.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(15, 20, 15, 20)];

        [_refundBtn setBackgroundImage:backImg
                              forState:UIControlStateNormal];
        [_refundBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_refundBtn addTarget:self action:@selector(refundAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _refundBtn;
}

-(UIButton *)allSelectBtn{
    
    if (!_allSelectBtn) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _allSelectBtn = btn;
        _allSelectBtn.frame =CGRectMake(20,5, 70, 44);
        [_allSelectBtn setTitle:L(@"ShopCart_Select_All") forState:UIControlStateNormal];
        
        UIImage *backImg = nil;//[UIImage imageNamed:@"GB_order_cancel.png"];
        backImg = [[UIImage imageNamed:@"quanxuan_butten.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(15, 20, 15, 20)];

        [_allSelectBtn setBackgroundImage:backImg
                              forState:UIControlStateNormal];
        [_allSelectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_allSelectBtn addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _allSelectBtn;
}
-(void)selectAction:(GBVoucherSingleInfoDTO *)item cell:(NSIndexPath *)indexPath{
    
    BOOL btnEnable = NO;
    
    for (GBVoucherSingleInfoDTO *dto in self.orderDetailDto.voucherList) {
        
        if (dto.isSelect) {
            
            btnEnable = YES;
            break;
        }
    }
    self.bottomCell.bottomPayBtn.enabled = btnEnable;

    self.navigationItem.rightBarButtonItem.enabled = btnEnable;
//    self.refundBtn.enabled = btnEnable;
}
-(void)allSelectAction:(UIButton *)btn{
    
    for (GBVoucherSingleInfoDTO *dto in self.orderDetailDto.voucherList) {
        
        if (2 == dto.status && 0 == dto.gbType
            && YES == dto.canRefund) {
            
            dto.isSelect = YES;
            
            self.bottomCell.bottomPayBtn.enabled = YES;

//            self.refundBtn.enabled = YES;
        }
    }
     
    self.navigationItem.rightBarButtonItem.enabled = [self judgeNextBtnIsEnable];
    [self.groupTableView reloadData];
}

- (BOOL)judgeNextBtnIsEnable
{
    if((IsNilOrNull(self.orderDetailDto.voucherList) || [self.orderDetailDto.voucherList count] == 0) && IsNilOrNull(self.orderDetailDto.voucherMap))
    {
        return NO;
    }
    
    NSMutableArray *selectList = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (GBVoucherSingleInfoDTO *dto in self.orderDetailDto.voucherList) {
        
        if (dto.isSelect) {
            
            [selectList addObject:dto];
        }
    }
    
    if((IsNilOrNull(selectList) || [selectList count] == 0) && IsNilOrNull(self.orderDetailDto.voucherMap))
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

//退款
-(void)refundAction:(UIButton *)btn{
    
    
    NSMutableArray *selectList = [[NSMutableArray alloc] initWithCapacity:1];
    
    for (GBVoucherSingleInfoDTO *dto in self.orderDetailDto.voucherList) {
        
        if (dto.isSelect) {
            
            [selectList addObject:dto];
        }
    }
    
    ReFundInfoDto *reFundDto = [[ReFundInfoDto alloc] init];
    
    reFundDto.orderId = self.orderDetailDto.orderId;
    reFundDto.tuanGouType = [NSString stringWithFormat:@"%d",self.orderDetailDto.gbType];
    reFundDto.userId = [UserCenter defaultCenter].userInfoDTO.userId;
    
    if (2 == self.orderDetailDto.voucherType) {
        
        reFundDto.vouncherType = @"2";
        
        reFundDto.maxCount = self.orderDetailDto.voucherMap.notUse;
    }
    else{
        
        reFundDto.vouncherType = @"";
    }
    
    reFundDto.orderItemIdArray = selectList;
    
    if (0 != [self.orderDetailDto.saleCount length]
        && 0 != [self.orderDetailDto.orderAmount length]
        && 0 != [self.orderDetailDto.saleCount intValue]) {
        
        reFundDto.price = [self.orderDetailDto.orderAmount floatValue]/[self.orderDetailDto.saleCount floatValue];
    }
    else{
        reFundDto.price = 0;
    }
    
    GBRefundViewController *v = [[GBRefundViewController alloc] init];
    v.refundDto = reFundDto;
    v.orderDto = self.orderDetailDto;
    v.hasNav = YES;
    v.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:v animated:YES];
    
    
}
@end
