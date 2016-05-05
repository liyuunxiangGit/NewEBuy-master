//
//  PayServiceQueryViewController.m
//  SuningEBuy
//
//  Created by 谢伟 on 12-9-29.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PayServiceQueryViewController.h"
#import "PayServiceQueryItemCell.h"
#import "PayServiceQueryDTO.h"
#import "AppDelegate.h"

@implementation PayServiceQueryViewController

@synthesize typeCode = _typeCode;
@synthesize itemLists = _itemLists;
@synthesize payServiceQueryService = _payServiceQueryService;

- (id)init
{
    self = [super init];
    if (self)
    {
        self.title = L(@"Payment query");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"finance_wegCharge_wegHistory"),self.title];
        self.isBottomView = YES;
    }
    return self;
}

- (void)dealloc
{
    TT_RELEASE_SAFELY(_typeCode);
    TT_RELEASE_SAFELY(_itemLists);
    
    SERVICE_RELEASE_SAFELY(_payServiceQueryService);
    
    TT_RELEASE_SAFELY(_alertImageV);
    TT_RELEASE_SAFELY(_alertLbl);

    
}

- (PayServiceQueryService *)payServiceQueryService
{
    if (!_payServiceQueryService) {
        _payServiceQueryService = [[PayServiceQueryService alloc] init];
        _payServiceQueryService.delegate = self;
    }
    
    return _payServiceQueryService;
}


#pragma mark -
#pragma mark View lifecycle
- (void)loadView
{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tableView.frame = [self setViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav WithTab:self.isBottomView];//[self visibleBoundsShowNav:YES showTabBar:NO];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView addSubview:(UIView*)self.refreshHeaderView];
    
    UIView *view =[[UIView alloc] init];
    view.backgroundColor =[UIColor clearColor];
    self.tableView.tableFooterView =view;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;

    self.tableView.hidden =YES;
    self.alertLbl.hidden =YES;
    self.alertImageV.hidden =YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self refreshData];
}


- (UILabel*)alertLbl
{
    if(!_alertLbl)
    {
        _alertLbl = [[UILabel alloc] init];
        _alertLbl.font = [UIFont systemFontOfSize:17];
        _alertLbl.backgroundColor = [UIColor clearColor];
        _alertLbl.frame = CGRectMake(0, self.alertImageV.bottom, self.view.frame.size.width, 60);
        _alertLbl.textAlignment = UITextAlignmentCenter;
        _alertLbl.textColor = [UIColor colorWithRGBHex:0x313131];
        
        _alertLbl.hidden = YES;
        
        [self.view addSubview:_alertLbl];
    }
    
    switch ([self.typeCode intValue]) {
        case 1:
            _alertLbl.text = L(@"VPHaveNoWaterPayList");
            break;
        case 2:
            _alertLbl.text = L(@"VPHaveNoElectricityPayList");
            break;
            
        case 3:
            _alertLbl.text = L(@"VPHaveNoGasPayList");
            
        default:
            break;
    }

    return _alertLbl;
}

- (UIImageView*)alertImageV
{
    if(!_alertImageV)
    {
        _alertImageV = [[UIImageView alloc] init];
        
        _alertImageV.image = [UIImage imageNamed:@"order_NoOrder.png"];
        
        _alertImageV.frame = CGRectMake(116.5, self.view.frame.size.height/2-76-46, 77, 76);
        
        _alertImageV.hidden = YES;
        
        [self.view addSubview:_alertImageV];
        
    }
    
    return _alertImageV;
}

#pragma mark -
#pragma mark Table View Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.itemLists count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PayServiceQueryItemCell height:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 15)];
    
//    if(IOS7_OR_LATER)
//    {
//        view.backgroundColor = [UIColor uiviewBackGroundColor];
//        
//    }
//    else
//    {
        view.backgroundColor = [UIColor clearColor];
        
//    }
    
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.00001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    
    static NSString *PayServiceQueryCellIdentifier = @"PayServiceQueryCellIdentifier";
    
    PayServiceQueryItemCell *cell = (PayServiceQueryItemCell *)[tableView dequeueReusableCellWithIdentifier:PayServiceQueryCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[PayServiceQueryItemCell alloc] initWithReuseIdentifier:PayServiceQueryCellIdentifier];
        cell.typeCode = self.typeCode;
        cell.backgroundColor = [UIColor cellBackViewColor];
    }
    
    PayServiceQueryDTO *dto = [self.itemLists objectAtIndex:section];
    cell.itemDTO = dto;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)showInfo:(NSString *)information
{
    if (information == nil || [information isEqualToString:@""])
    {
        [self presentSheet:L(@"VPSorryForUnknownError") posY:80];
        
        return;
    }
    
    [self presentSheet:information posY:80];
}

#pragma mark -
#pragma mark 开始下拉刷新
- (void)refreshData
{
    [self displayOverFlowActivityView];
    [self.payServiceQueryService beginGetFeeListWithTypeCode:_typeCode];
}

#pragma mark -
#pragma mark 代理方法
- (void)getFeeListCompleteWithService:(PayServiceQueryService *)service
                               Result:(BOOL)isSuccess
                             errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    
    if (self.isFromHead) {
        [self refreshDataComplete];
    }
    
    if (isSuccess) {
        self.itemLists = self.payServiceQueryService.itemLists;
        
        self.alertImageV.hidden =YES;
        self.alertLbl.hidden =YES;
            
        self.tableView.hidden =NO;
    
        //下拉刷新完成
        [self.tableView reloadData];
        
    }
    else
    {
        if (self.payServiceQueryService.isEmptyHistory) {
//            NSString *information = [NSString stringWithString:L(@"History is empty")];
//            [self performSelectorOnMainThread:@selector(showInfo:) withObject:information waitUntilDone:YES];
        }
        else
        {
            [self presentCustomDlg:L(@"Request Failed")];
        }
        
        self.alertImageV.hidden =NO;
        self.alertLbl.hidden =NO;
        
        self.tableView.hidden =YES;
    }
}

@end
