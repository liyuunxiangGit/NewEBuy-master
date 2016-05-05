//
//  OrderSelectDownViewController.m
//  SuningEBuy
//
//  Created by xmy on 21/11/13.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "OrderSelectDownViewController.h"

@interface OrderSelectDownViewController ()

@end

@implementation OrderSelectDownViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithIsOnlineOrder:(BOOL)isOnlineOrder
{
    self = [super init];
    
    if(self)
    {
        if(isOnlineOrder == YES)
        {
            
            self.orderArr = [NSArray arrayWithObjects:L(@"MyEBuy_AllOrders"),L(@"MyEBuy_PaidOrders"),L(@"MyEBuy_WaitingForPayOrders"),L(@"MyEBuy_ProcessingOrders"), L(@"MyEBuy_CanceledOrders"),L(@"MyEBuy_ReturnSuccessOrders"), L(@"MyEBuy_HaveBeenDeliveredOrders"), L(@"MyEBuy_ReceiptedOrders"),nil];
            
            self.orderTimeArr = [NSArray arrayWithObjects:L(@"MyEBuy_NearlyOneMonth"), L(@"MyEBuy_NearlySixMonths"), L(@"All"), nil];
            
            
        }
        else if(isOnlineOrder == NO)
        {
//            self.orderArr = [NSArray arrayWithObjects:@"全部订单",@"已支付订单",@"发货处理中订单", @"退款完成订单",@"退货成功订单",nil];
            
            self.orderArr = [NSArray arrayWithObjects:L(@"MyEBuy_AllOrders"),nil];

            self.orderTimeArr = [NSArray arrayWithObjects:L(@"MyEBuy_NearlySixMonths"), L(@"All"), nil];
        }

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
//    if(self.isOnlineOrder == YES)
//    {
//        
//        self.orderArr = [NSArray arrayWithObjects:@"全部订单",@"已支付订单",@"待支付订单",@"发货处理中订单", @"已取消订单",@"退货成功订单", @"已发货订单", @"收货完成订单",nil];
//        
//        self.orderTimeArr = [NSArray arrayWithObjects:@"近一月", @"近六月", @"全部", nil];
//
//        
//    }
//    else if(self.isOnlineOrder == NO)
//    {
//        self.orderArr = [NSArray arrayWithObjects:@"全部订单",@"已支付订单",@"发货处理中订单", @"退款完成订单",@"退货成功订单",nil];
//        
//        self.orderTimeArr = [NSArray arrayWithObjects:@"近六月", @"全部", nil];
//    }
    
    self.tableView.frame = CGRectMake(0, 0, 145, 90);
    
    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.tableView.separatorColor = [UIColor whiteColor];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    self.backView.frame = CGRectMake(10, 40, 145, 250);
        
    [self.view addSubview:self.backView];
    
    self.view.backgroundColor = [UIColor clearColor];

    [self.backView addSubview:self.tableView];

    self.view.backgroundColor = [UIColor clearColor];//[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    
}

- (UIImageView*)backView
{
    if(!_backView)
    {
        UIImage *image = [UIImage newImageFromResource:@"order_selectBack.png"];
        UIImage *strImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(20, 2, 50, 140)];

        _backView = [[UIImageView alloc] initWithImage:strImage];
        
        _backView.backgroundColor = [UIColor clearColor];
        
        _backView.userInteractionEnabled = YES;
        
    }
    return _backView;
}

- (NSArray*)orderArr
{
    if(!_orderArr)
    {
        _orderArr = [[NSArray alloc] init];
    }
    
    return _orderArr;
}

- (NSArray*)orderTimeArr
{
    if(!_orderTimeArr)
    {
        _orderTimeArr = [[NSArray alloc] init];
    }
    
    return _orderTimeArr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isTime == YES)
    {
        return [self.orderTimeArr count];//3
    }
    else
    {
        return [self.orderArr count];//7
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellOrderSelectDownViewController";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.textLabel.font = [UIFont systemFontOfSize:13];
    if(self.isTime == YES)
    {//时间选择
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.orderTimeArr objectAtIndex:indexPath.row]];
    }
    else
    {//订单类型选择
        cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.orderArr objectAtIndex:indexPath.row]];

    }
    
       return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectStr = nil;
    
    if(self.isTime == YES)
    {//时间选择
        selectStr = [NSString stringWithFormat:@"%@",[self.orderTimeArr objectAtIndex:indexPath.row]];
    }
    else
    {//订单类型选择
        selectStr = [NSString stringWithFormat:@"%@",[self.orderArr objectAtIndex:indexPath.row]];
        
    }

    self.view.hidden = YES;
    
    [self.delegate selectedOrderStyleOrTime:selectStr WithRow:indexPath.row];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.hidden = YES;
    
    [self.delegate btnsImage];
    
}




@end
