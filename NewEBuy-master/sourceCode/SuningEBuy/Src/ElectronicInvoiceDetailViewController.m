//
//  ElectronicInvoiceDetailViewController.m
//  SuningEBuy
//
//  Created by Yang on 14-7-15.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ElectronicInvoiceDetailViewController.h"
#import "ElectronicInvoiceDetailCell.h"
#import "MemberOrderDetailsDTO.h"
@interface ElectronicInvoiceDetailViewController ()

@end

@implementation ElectronicInvoiceDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    [self.view addSubview:self.tableView];
    
    self.title = L(@"MyEBuy_ElectronicInvoiceInformation");
    
    // Do any additional setup after loading the view.
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 135;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.SNShopList count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


//将订单信息传送到cell中显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *NewOrderProInfoCellIdentifier = @"ElectronicInvoiceDetailCell";
    
    ElectronicInvoiceDetailCell *cell = (ElectronicInvoiceDetailCell*)[tableView dequeueReusableCellWithIdentifier:NewOrderProInfoCellIdentifier];
    
    if(cell == nil){
        
        cell = [[ElectronicInvoiceDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NewOrderProInfoCellIdentifier];
        
        cell.contentView.backgroundColor = [UIColor clearColor];
        
        cell.backgroundColor = [UIColor clearColor];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    MemberOrderDetailsDTO *dto =  [self.SNShopList safeObjectAtIndex:indexPath.section];
    [cell setElectronicInvoiceDetailCell:dto CShopList:self.CShopList row:indexPath.row];
    return cell;

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
