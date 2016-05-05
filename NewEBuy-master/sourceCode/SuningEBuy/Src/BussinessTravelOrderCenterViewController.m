//
//  BussinessTravelOrderCenterViewController.m
//  SuningEBuy
//
//  Created by jian  zhang on 12-7-5.
//  Copyright (c) 2012年 nanjing. All rights reserved.
//

#import "BussinessTravelOrderCenterViewController.h"
#import "GradientCell.h"
#import "HotelOrderListViewController.h"
#import "MyTicketListViewController.h"


@implementation BussinessTravelOrderCenterViewController

@synthesize itemList = _itemList;


-(id)init
{
	if((self = [super init]))
	{ 
		self.title = L(@"My_Bussiness");
        
        self.pageTitle = L(@"member_myEbuy_myBusiness");
        
        if (!_itemList)
        {
            _itemList = [[NSArray alloc] initWithObjects: L(@"PanelOrder"), L(@"HotelOrder"), nil];
        }
	}
	
    return self;
}

- (void)dealloc
{
    
    TT_RELEASE_SAFELY(_itemList);
    
}

- (void)loadView
{
    [super loadView];
    
    UIView *contentView = self.view;
    
    CGRect frame = contentView.frame;
    
    frame.origin.x = 0;
    frame.origin.y = 0;
    frame.size.height = contentView.bounds.size.height - 92;
    
    self.groupTableView.frame = frame;
    
    [self.view addSubview:self.groupTableView];

}



#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
    return [self.itemList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *BussinessInfoCellIdentifier = @"BussinessInfoCellIdentifier";
    
    GradientCell *cell = [tableView dequeueReusableCellWithIdentifier:BussinessInfoCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[GradientCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:BussinessInfoCellIdentifier];
        
        [cell ConfigureWithTableView:tableView indexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:17.0];
        
        cell.textLabel.text = [self.itemList objectAtIndex: indexPath.row];
        
        cell.textLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8];
    }
    return cell;
        
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.row == 0) {
        
        MyTicketListViewController *TV = [[MyTicketListViewController alloc] init];
        
        [self.navigationController pushViewController:TV animated:YES];
        
        TT_RELEASE_SAFELY(TV);
        
    }
    if (indexPath.row == 1) {
        
        HotelOrderListViewController *nextController = [[HotelOrderListViewController alloc] init];
        
        [self.navigationController pushViewController:nextController animated:YES];
        

    }
    
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{

    return L(@"MyHotelPanelTicket");
}






@end
