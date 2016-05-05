//
//  AllOrderDownSelectViewController.m
//  SuningEBuy
//
//  Created by xmy on 26/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "AllOrderDownSelectViewController.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

@interface AllOrderDownSelectViewController ()

@end

@implementation AllOrderDownSelectViewController

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
	// Do any additional setup after loading the view.
    int  visiableHeight = [self visibleBoundsShowNav:YES showTabBar:NO].size.height;
    if([SNSwitch isOpenShopOrderList] == YES)
    {
        //self.tableView.frame = CGRectMake(0, 0, 320, 440>=visiableHeight?visiableHeight:440);
        self.tableView.frame = CGRectMake(0, 0, 320, 360>=visiableHeight?visiableHeight:360);
    }
    else
    {
        //self.tableView.frame = CGRectMake(0, 0, 320, 400>=visiableHeight?visiableHeight:400);
        self.tableView.frame = CGRectMake(0, 0, 320, 320>=visiableHeight?visiableHeight:320);
    }

    self.tableView.backgroundColor = [UIColor whiteColor];

    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)init
{
    self = [super init];
    
    
    if(self)
    {
        self.selectRow = 0;
        
        if([SNSwitch isOpenShopOrderList] == YES)
        {
            self.selectArr = [[NSArray alloc] initWithObjects:L(@"MyEBuy_GoodsOrder"),L(@"MyEBuy_StoreOrder"),L(@"MyEBuy_Recharge"),L(@"MyEBuy_LotteryOrder"), L(@"MyEBuy_WaterFeePayment"),L(@"MyEBuy_ElectricityFeePayment"),L(@"MyEBuy_GasFeePayment"),/*@"机票订单",@"酒店订单",*/L(@"MyEBuy_ManzuoOrder"),nil];
            

        }
        else
        {
            self.selectArr = [[NSArray alloc] initWithObjects:L(@"MyEBuy_GoodsOrder"),L(@"MyEBuy_Recharge"),L(@"MyEBuy_LotteryOrder"),L(@"MyEBuy_WaterFeePayment"),L(@"MyEBuy_ElectricityFeePayment"),L(@"MyEBuy_GasFeePayment"),/*@"机票订单",@"酒店订单",*/L(@"MyEBuy_ManzuoOrder"),nil];

        }
        
        
        
    }
    
    return self;
}

- (NSArray*)selectArr
{
    if(!_selectArr)
    {
        
        _selectArr = [[NSArray alloc] init];
    }
    
    return _selectArr;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.selectArr count];//7
    
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
    
    if(indexPath.row == self.selectRow)
    {
        UIImageView *checkImageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cellMark.png"]];
        
        checkImageV.frame = CGRectMake(280, 299, 12, 8.5);
        
        cell.accessoryView = checkImageV;
    }
    else
    {
        cell.accessoryView = nil;

    }
   
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.textColor = [UIColor colorWithRGBHex:0x313131];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.selectArr objectAtIndex:indexPath.row]];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectStr = [NSString stringWithFormat:@"%@",[self.selectArr objectAtIndex:indexPath.row]];
    
    self.view.hidden = YES;
    if (indexPath.row + 1 > 9)
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"7101%d",indexPath.row+1], nil]];
    }
    else
    {
        [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"71010%d",indexPath.row+1], nil]];
    }
    
    self.selectRow = indexPath.row;
    
    [self.delegate selectedAllOrderStyleOrTime:selectStr WithRow:indexPath.row];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.view.hidden = YES;
    
    [self.delegate btnsImage];
    
}


@end
