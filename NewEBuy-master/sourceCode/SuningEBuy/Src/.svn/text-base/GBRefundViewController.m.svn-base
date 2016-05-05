//
//  GBRefundViewController.m
//  SuningEBuy
//
//  Created by li xiaokai on 13-6-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "GBRefundViewController.h"
#import "GBRefundCell.h"
#import "GBOrderListViewController.h"

#import "OrderDetailCell.h"
#import "OrderDetailBtnCell.h"
#import "AllOrderListViewController.h"
#import "SNSwitch.h"
#import "BBSideBarViewController.h"

@interface GBRefundViewController ()

@end

@implementation GBRefundViewController

-(void)dealloc{
    
    TT_RELEASE_SAFELY(_refundDto);
    TT_RELEASE_SAFELY(_cancelService);
    
}

-(GBCancelOrderService *)cancelService{
    
    if (!_cancelService) {
        
        _cancelService = [[GBCancelOrderService alloc] init];
        _cancelService.myDelagate = self;
    }
    
    return _cancelService;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadView{
    [super loadView];
    
    self.view.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.title = L(@"BTRefund");
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"virtual_gourpBuy"),self.title];
    UIView *contentView = self.view;
    CGRect frame = contentView.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height  -44;
    
    self.groupTableView.frame = [self setCommonViewFrame:self.hasNav WithTab:YES];//[self setViewFrame:self.hasNav];//frame;
    self.groupTableView.indicatorStyle =UIScrollViewIndicatorStyleDefault;
    self.groupTableView.scrollEnabled = YES;
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    self.tableView.frame = frame;
//    self.tableView.indicatorStyle =UIScrollViewIndicatorStyleDefault;
//    self.tableView.scrollEnabled = YES;
    [self.view addSubview:self.groupTableView];
    
    self.hasSuspendButton = YES;
//    [self useBottomNavBar];
//    [self.bottomNavBar addSubview:self.bottomCell];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ToolBarButton*)refundReasonsBarBtn
{
    if(!_refundReasonsBarBtn)
    {
        
        _refundReasonsBarBtn = [[ToolBarButton alloc]initWithFrame:CGRectMake(105, 0, 175, 40)];
        
        _refundReasonsBarBtn.backgroundColor = [UIColor clearColor];
        
        [_refundReasonsBarBtn setTitle:L(@"please choose") forState:UIControlStateNormal];
        
        [_refundReasonsBarBtn setTitleColor:[UIColor dark_Gray_Color] forState:UIControlStateNormal];
        
        _refundReasonsBarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        
        _refundReasonsBarBtn.inputView =self.reasonsPickView;
        
        _refundReasonsBarBtn.delegate = self;
        
        _refundReasonsBarBtn.titleLabel.frame = CGRectMake(0, 0, 170, 25);
        
        _refundReasonsBarBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        _refundReasonsBarBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        
    }
    
    return _refundReasonsBarBtn;
}

- (UIPickerView*)reasonsPickView
{
    if(!_reasonsPickView)
    {
        _reasonsPickView = [[UIPickerView alloc] init];
        
        _reasonsPickView.frame = CGRectMake(0, 40, 320, 240);
        
        _reasonsPickView.delegate =self;
        
        _reasonsPickView.dataSource =self;
        
        _reasonsPickView.showsSelectionIndicator = YES;
        
        
    }
    
    return _reasonsPickView;
}

-(NSArray *)infoArr{
    
    if (!_infoArr) {
        
        _infoArr =[[NSArray alloc] initWithObjects:L(@"PVDoNotWantToBuyNow2"),L(@"PVPriseIsSoHigh2"),L(@"PVErrorOrOrderRecur2"),L(@"PVOtherReason2"),nil] ;
    }
    return _infoArr;
}

-(UIButton *)arrowBtn
{
    if (!_arrowBtn) {
        _arrowBtn = [[UIButton alloc] init];
        _arrowBtn.frame = CGRectMake(280, 20, 18/2, 29/2);
        _arrowBtn.selected = NO;
    }
    return _arrowBtn;
}

#pragma mark - UIPickerView Delagate and dataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [self.infoArr count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = [self.infoArr safeObjectAtIndex:row];
    
    return str;
}


#pragma mark - tableview Delagate and dataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 3;//1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section == 2 || section == 0)
    {
        return 1;
    }
    
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(IsNilOrNull(self.refundDto))
    {
        return 0;
    }
    
    if(indexPath.section == 0)
    {
        if(([self.refundDto.vouncherType isEqualToString:@"2"]))
        {//一券多用
            return 80;
        }
        else
        {
            return 40;
        }
        
    }
    
    return 40;
 /*   if (1 == indexPath.row) {
        
        return 60;
    }
    if([self.refundDto.vouncherType isEqualToString:@"2"]) {
        
        return 330;
    }
    return 300;*/
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


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if(indexPath.section == 0 || (indexPath.section == 1 && indexPath.row == 0))
    {
        static NSString *GBOrdderMoreInfoCellIndentifier = @"OrderDetailWayCell_refundReason";
        OrderDetailWayCell *cell = (OrderDetailWayCell *)[tableView dequeueReusableCellWithIdentifier:GBOrdderMoreInfoCellIndentifier];
        if (cell == nil) {
            cell= [[OrderDetailWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrdderMoreInfoCellIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.myDelegate = self;
        }
        
        
        [cell setGroupRefundDetailCell:self.refundDto WithSectionPosition:indexPath.section WithCellPosition:indexPath.row];
        
        
        
        return cell;

    }
    else if(indexPath.section == 2)
    {
        static NSString *GBOrdderMoreInfoCellIndentifier = @"OrderDetailBtnCell_refund";
        OrderDetailBtnCell *cell = (OrderDetailBtnCell *)[tableView dequeueReusableCellWithIdentifier:GBOrdderMoreInfoCellIndentifier];
        if (cell == nil) {
            cell= [[OrderDetailBtnCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrdderMoreInfoCellIndentifier];
            
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.isAddNotifition = NO;
        }
        
        [cell setGroupRefundCell:self.refundDto];
        
        
        [cell.cancelOrderBtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
    }
    else
    {
        static NSString *GBOrdderMoreInfoCellIndentifier = @"UITableViewCell_refund";
        SNUITableViewCell *cell = (SNUITableViewCell *)[tableView dequeueReusableCellWithIdentifier:GBOrdderMoreInfoCellIndentifier];
        if (cell == nil) {
            cell= [[SNUITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBOrdderMoreInfoCellIndentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            [self.arrowBtn addTarget:self action:@selector(arrowAction:) forControlEvents:UIControlEventTouchUpInside];
            
            if(self.arrowBtn.selected == YES)
            {
                [self.arrowBtn setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
                
            }
            else
            {
                [self.arrowBtn setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
                
            }
            self.arrowBtn.frame = CGRectMake(0, 0, 8.5, 7.5);
            
            cell.accessoryView = self.arrowBtn;

            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 90, 40)];
            
            lbl.text = L(@"GBReasonForRefund");
            
            lbl.font = [UIFont systemFontOfSize:16];
            lbl.textColor = [UIColor light_Black_Color];
            
            [cell.contentView addSubview:lbl];
            
            [cell.contentView addSubview:self.refundReasonsBarBtn];
            
            
        }
        
        return cell;
    }
    
/*    if (1 == indexPath.row) {
        
        static NSString *tableViewCell = @"tableViewCell";
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:tableViewCell];
        if (cell == nil) {
            cell= [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCell];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
       // [cell.contentView removeAllSubviews];
        
        UIButton *okbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        okbtn.frame = CGRectMake(20, 10, 70, 44);
        [okbtn setTitle:@"退款" forState:UIControlStateNormal];
        [okbtn setBackgroundImage:[UIImage imageNamed:@"GB_pay_submit.png"]
                                 forState:UIControlStateNormal];
        [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [okbtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:okbtn];

        
        UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancelbtn.frame = CGRectMake(180, 10, 70, 44);
        [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbtn setBackgroundImage:[UIImage imageNamed:@"GB_order_cancel.png"]
                                 forState:UIControlStateNormal];
        [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancelbtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:cancelbtn];

        
        return cell;
    }
    static NSString *GBRefundCell1 = @"GBRefundCell";
    GBRefundCell *cell = (GBRefundCell *)[tableView dequeueReusableCellWithIdentifier:GBRefundCell1];
    if (cell == nil) {
        cell= [[GBRefundCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:GBRefundCell1];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.myDelegate = self;
    [cell initCellView:self.refundDto];
    
    
    int y = 0;
    
    if ([self.refundDto.vouncherType isEqualToString:@"2"]) {
        
        y = 290;
    }
    else{
        
        y = 245;
    }
    
    UIButton *okbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okbtn.frame = CGRectMake(35, y, 70, 44);
    [okbtn setTitle:@"确定" forState:UIControlStateNormal];
    [okbtn setBackgroundImage:[UIImage imageNamed:@"quanxuan_butten.png"]
                     forState:UIControlStateNormal];
    [okbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okbtn addTarget:self action:@selector(okAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:okbtn];
    
    
    UIButton *cancelbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelbtn.frame = CGRectMake(200, y, 70, 44);
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelbtn setBackgroundImage:[UIImage imageNamed:@"quanxuan_butten.png"]
                         forState:UIControlStateNormal];
    [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelbtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cancelbtn];
    self.singleBtn = cell.singleBtn;
    return cell;
*/
}


- (void)refund:(GBCancelOrderService *)service
          info:(NSDictionary *)dicinfo
        Result:(BOOL)isSuccess{
    
    [self removeOverFlowActivityView];
    if (isSuccess) {
        
        BBAlertView *alert1 =[ [BBAlertView alloc]initWithTitle:L(@"GBRefundSuccess") message:L(@"GBRefundInfo") delegate:nil cancelButtonTitle:L(@"Confirm") otherButtonTitles:nil];
        [alert1 setCancelBlock:^{
            
/*            NSArray *array = self.navigationController.viewControllers;
            if (2 <= [array count]) {
                
//                UIViewController *v = (UIViewController *)[array objectAtIndex:1];
                
                for(UIViewController *v in array)
                {
                    if ([v isKindOfClass:[AllOrderListViewController class]]) {
                        
                        AllOrderListViewController *orderListVC = (AllOrderListViewController*)v;
                        
                        if([SNSwitch isOpenShopOrderList] == YES)
                        {
//                            orderListVC = [[AllOrderListViewController alloc]initWithData:@"A" WithSelect:eTuanGouOrderList];
                            
                            orderListVC.selectRow = eTuanGouOrderList;
                            
                        }
                        else
                        {
//                            orderListVC = [[AllOrderListViewController alloc]initWithData:@"A" WithSelect:eCaiPiaoOrderList];
                            
                            orderListVC.selectRow = eCaiPiaoOrderList;
                            
                        }

                        [orderListVC.groupBuyVC refreshData];
                        
                        
                        [self.navigationController popToViewController:v animated:YES];
                    }
                    
                }
                
            }
            else{
                
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
//            AllOrderListViewController *orderListVC = nil;
//            
//            if([SNSwitch isOpenShopOrderList] == YES)
//            {
//                orderListVC = [[AllOrderListViewController alloc]initWithData:@"A" WithSelect:eTuanGouOrderList];
//
//                orderListVC.selectRow = eTuanGouOrderList;
//
//            }
//            else
//            {
//                orderListVC = [[AllOrderListViewController alloc]initWithData:@"A" WithSelect:eCaiPiaoOrderList];
//
//                orderListVC.selectRow = eCaiPiaoOrderList;
//
//            }
//
//            orderListVC.hidesBottomBarWhenPushed = YES;
//            orderListVC.bottomCell.backBtn.hidden = YES;
//                        
//            [self.navigationController popToViewController:orderListVC animated:YES];
            
//            [self.navigationController pushViewController:orderListVC animated:YES];

            
//            GBOrderListViewController *orderListVC = [[GBOrderListViewController alloc] init];
//            [self.navigationController pushViewController:orderListVC animated:YES];
            */
            
            AllOrderListViewController *orderListVC = nil;
            
//            if([SNSwitch isOpenShopOrderList] == YES)
//            {
//                orderListVC = [[AllOrderListViewController alloc]initWithData:@"A" WithSelect:eTuanGouOrderList];
//                
//                orderListVC.selectRow = eTuanGouOrderList;
//                
//            }
//            else
//            {
                orderListVC = [[AllOrderListViewController alloc]initWithData:@"A" WithSelect:eCaiPiaoOrderList];
                
                orderListVC.selectRow = eCaiPiaoOrderList;
                
//            }
            
            orderListVC.hidesBottomBarWhenPushed = YES;
            orderListVC.bottomCell.backBtn.hidden = YES;
            
            [BBSideBarViewController backToEbuyAnimated:NO];
            
            [[AppDelegate currentAppDelegate].tabBarViewController setSelectedIndex:4];
            
            UINavigationController *vc = [[AppDelegate currentAppDelegate].tabBarViewController.viewControllers safeObjectAtIndex:4];
            
            [vc popToRootViewControllerAnimated:NO];
            [vc pushViewController:orderListVC  animated:NO];

        }];
        
        [alert1 show];
        
    }
    else{
        
        [self presentSheet:service.errorMsg posY:50];
    }
}
-(void)okAction:(UIButton *)btn{
    
    
    BBAlertView *alert =[ [BBAlertView alloc]initWithTitle:L(@"GBApplyForRefund") message:@"GBAreYouSureRefund" delegate:nil cancelButtonTitle:L(@"Cancel") otherButtonTitles:L(@"Ok")];
    [alert setConfirmBlock:^{
        
        if ([self.refundDto.refundCount intValue] > self.refundDto.maxCount
            || [self.refundDto.refundCount intValue] > 5) {
            
            [self presentSheet:L(@"Number wrong,please enter again") posY:30];

        }
        else{
            
            self.refundDto.refundReason = self.refundReasonsBarBtn.titleLabel.text;
            
            if(IsStrEmpty(self.refundDto.refundReason) || [self.refundDto.refundReason isEqualToString:L(@"please choose")])
            {
                [self presentSheet:L(@"GBPleaseChooseReasonOfRefund") posY:30];
                return ;
            }
            
            
            [self displayOverFlowActivityView];
            [self.cancelService beginRefund:self.refundDto];
        }
        
    }];
    [alert setCancelBlock:^{
       // [self.tableView reloadData];
    }];
    [alert show];
    TT_RELEASE_SAFELY(alert);

}

- (void)alertView:(BBAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

- (void)alertView:(BBAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
}

-(void)cancelAction:(UIButton *)btn{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)insertErrorMsg:(NSString *)errorMsg{
    
    [self presentSheet:errorMsg posY:30];
}


#pragma  mark - ToolBarButtonDelegate
- (void)arrowAction:(id)sender
{
    [self setArrowBtnImage];
    [self.refundReasonsBarBtn becomeFirstResponder];
}

- (void)cancelButtonClicked:(id)sender
{

    [self setArrowBtnImage];
}
- (void)doneButtonClicked:(id)sender
{
    
    [self setArrowBtnImage];
    
    NSInteger selectPickerRow = [self.reasonsPickView selectedRowInComponent:0];
    
    NSString *str = [self.infoArr safeObjectAtIndex:selectPickerRow];
    
    [self.refundReasonsBarBtn setTitle:str forState:UIControlStateNormal];
    
}

- (void)singleClickButton:(id)sender
{
    [self setArrowBtnImage];
    [self.refundReasonsBarBtn becomeFirstResponder];
}

- (void)setArrowBtnImage
{
    self.arrowBtn.enabled = YES;
    self.arrowBtn.selected = !self.arrowBtn.isSelected;
    if(self.arrowBtn.selected == YES)
    {
        [self.arrowBtn setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Down.png"] forState:UIControlStateNormal];
        self.arrowBtn.enabled = NO;

    }
    else
    {
        [self.arrowBtn setBackgroundImage:[UIImage imageNamed:@"N_Arrow_Up.png"] forState:UIControlStateNormal];
        self.arrowBtn.enabled = YES;

        
    }

}
@end
