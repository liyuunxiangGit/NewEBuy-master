//
//  ReturnGoodsDetailViewController.m
//  SuningEBuy
//
//  Created by 漫 王 on 12-9-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ReturnGoodsDetailViewController.h"

#import "ReturnGoodsStatusCell.h"
#import "ReturnGoodsStatusDTO.h"
#import "ReturnGoodsOrderInfoCell.h"
#import "OSGetStatusCommand.h"
#import "OSLeaveMessageViewController.h"

#import "NProOrderProductInfoCell.h"

@implementation ReturnGoodsDetailViewController

@synthesize returnGoodsDto = _returnGoodsDto;

- (void)dealloc {
    
    [CommandManage cancelCommandByClass:[OSGetStatusCommand class]];
    TT_RELEASE_SAFELY(_returnGoodsDto);
    
}

- (id)init {
    self = [super init];
    if (self) {
        
        self.title = L(@"return order detail");
        
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"member_myEbuy"),self.title];
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        btn.backgroundColor = [UIColor clearColor];
//        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
//        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 2.5, 0, 0)];
//        [btn setTitleColor:[UIColor colorWithRGBHex:0x444444] forState:UIControlStateNormal];
//        [btn setBackgroundImage:[UIImage imageNamed:@"right_item_light_btn.png"] forState:UIControlStateNormal];
//        [btn setTitle:@"寄回商品" forState:UIControlStateNormal];
//        [btn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
//        btn.frame = CGRectMake(0, 6, 70, 32);
//        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
//        self.navigationItem.rightBarButtonItem = nil;//item;
        if (!_returnGoodsDto) {
            
            _returnGoodsDto = [[ReturnGoodsQueryDTO alloc]init];
        }
        
        _onlineStatus = -1;
    }
    return self;
}
-(void)righBarClick
{
    [self submit];
}
-(void)submit
{
    
    
    CShopChooseExpressListViewController *vc = [[CShopChooseExpressListViewController alloc]init];
    vc.queryDto = self.returnGoodsDto;
    vc.expressList = self.expressList;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadView{
    
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.size.height = contentView.bounds.size.height -92;
    
    frame.origin.x = 0;
    
    frame.origin.y = 0;
    
    self.groupTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    
    self.groupTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    [self.view addSubview:self.groupTableView];
    
    self.hasSuspendButton = YES;
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (![self.returnGoodsDto.returnGoodsFlag isEqualToString:@"1"])
    {
        self.navigationItem.rightBarButtonItem =nil;
    }
    
    if (!_isGetOnlineStatusOk)
    {
        [self getOnlineServiceStatus];  //获取在线客服状态
    }
    
}
- (void)viewDidLoad{
    
    [super viewDidLoad];
}

- (void)viewDidUnload{
    
    [super viewDidUnload];
}


#pragma mark - call action

- (void)callAction
{
    if (!_callWebView) {
        _callWebView = [[UIWebView alloc] init];
    }
    
    [_callWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://4008365365"]]];
}

#pragma mark tableView delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return [self.returnGoodsDto.detailList count];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 ) {
        
        return [ReturnGoodsOrderInfoCell heightNewCell:self.returnGoodsDto status:_onlineStatus];
    }
    ReturnGoodsStatusDTO *dto = [self.returnGoodsDto.detailList objectAtIndex:indexPath.row];
    return [ReturnGoodsStatusCell height:dto];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        static  NSString  *returnGoodsInfoIdentifier = @"returnGoodsInfoIdentifier_returnGoods";
      
        ReturnGoodsOrderInfoCell * cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsInfoIdentifier];
        
        if (cell == nil)  
        {
            
            cell = [[ReturnGoodsOrderInfoCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:returnGoodsInfoIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        [cell.shopConnect addTarget:self action:@selector(contactSNShop) forControlEvents:UIControlEventTouchUpInside];
        [cell.cShopConnect addTarget:self action:@selector(contactCShop) forControlEvents:UIControlEventTouchUpInside];
        [cell.Phone addTarget:self action:@selector(callAction) forControlEvents:UIControlEventTouchUpInside];
        
        [cell setNewItem:self.returnGoodsDto status:_onlineStatus];
        
        return cell;
    }
    
    static  NSString  *returnGoodsStatusCellIdentifier = @"returnGoodsStatusCellIdentifier";
    
    ReturnGoodsStatusCell * cell = [tableView dequeueReusableCellWithIdentifier:returnGoodsStatusCellIdentifier];
    
    if (cell == nil)  
    {
        
        cell = [[ReturnGoodsStatusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:returnGoodsStatusCellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
    }
//    [cell setCoolBgViewWithCellPosition:CellPositionMake(self.returnGoodsDto.detailList.count, indexPath.row)];
    
    ReturnGoodsStatusDTO *dto = [self.returnGoodsDto.detailList objectAtIndex:indexPath.row];
    
    
    if([self.returnGoodsDto.detailList count] == 1 )
    {//只有一行
        [cell setReturnTimeAndRecord:dto WithRow:-2];
        
    }
    else
    {
        if([self.returnGoodsDto.detailList count] - 1 == indexPath.row && [self.returnGoodsDto.detailList count] > 1)
        {//最后一行
            [cell setReturnTimeAndRecord:dto WithRow:-1];
            
        }
        else
        {
            [cell setReturnTimeAndRecord:dto WithRow:indexPath.row];

        }

    }
    
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
//    if (section == 1) {
//        
//        return L(@"return order status");
//    }
    return nil;
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


#pragma mark ----------------------------- 在线客服

- (void)getOnlineServiceStatus
{
    __weak ReturnGoodsDetailViewController *weakSelf = self;

    
    if (self.returnGoodsDto.vendorCode.length)
    {
        OSGetStatusCommand *cmd_ = [[OSGetStatusCommand alloc] initAsCShop:self.returnGoodsDto.vendorCode ProductName:nil ProductCode:nil OrderNo:self.returnGoodsDto.orderId];
        
        [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
            
            ReturnGoodsDetailViewController *self = weakSelf;
            OSGetStatusCommand *__cmd = (OSGetStatusCommand *)cmd;
            if (__cmd.onlineStatus >= -1)
            {
                self->_onlineStatus = __cmd.onlineStatus;
                self->_isGetOnlineStatusOk = YES;
                [self.groupTableView reloadData];
            }
            
        }];
    }
    else
    {
        OSGetStatusCommand *cmd_ = [[OSGetStatusCommand alloc] initAsB2CReturnOrderWithOrderNo:self.returnGoodsDto.orderId];
        [CommandManage excuteCommand:cmd_ completeBlock:^(id<Command> cmd) {
            
            ReturnGoodsDetailViewController *self = weakSelf;
            OSGetStatusCommand *__cmd = (OSGetStatusCommand *)cmd;
            if (__cmd.onlineStatus >= -1)
            {
                self->_onlineStatus = __cmd.onlineStatus;
                self->_isGetOnlineStatusOk = YES;
                [self.groupTableView reloadData];
            }
            
        }];
    }
}

- (void)contactSNShop
{
    //b2c客服
    [self checkLoginWithLoginedBlock:^{
        OSChatViewController *vc = [[OSChatViewController alloc] initAsB2CReturnOrderWithOrderNo:self.returnGoodsDto.orderId];
        AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
        [self presentModalViewController:nav animated:YES];
    } loginCancelBlock:nil];
}

- (void)contactCShop
{
    [self checkLoginWithLoginedBlock:^{
        if (_onlineStatus == 0)
        {
            OSLeaveMessageViewController *vc = [[OSLeaveMessageViewController alloc] initWithShopCode:self.returnGoodsDto.vendorCode ShopName:self.returnGoodsDto.vendorName ProductCode:nil ProductName:nil OrderId:self.returnGoodsDto.orderId];
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
        else
        {
            OSChatViewController *vc = [[OSChatViewController alloc] initAsCShop:self.returnGoodsDto.vendorCode ProductName:nil ProductCode:nil OrderNo:self.returnGoodsDto.orderId];
            vc.vendorName = self.returnGoodsDto.vendorName;
            AuthManagerNavViewController *nav = [[AuthManagerNavViewController alloc] initWithRootViewController:vc];
            [self presentModalViewController:nav animated:YES];
        }
    } loginCancelBlock:nil];
}


@end
