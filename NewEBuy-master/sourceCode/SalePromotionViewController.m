//
//  SalePromotionViewController.m
//  SuningEBuy
//
//  Created by GUO on 14-9-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "SalePromotionViewController.h"
#import "SalePromotionCell.h"

@interface SalePromotionViewController ()
{
    NSString *_model;
}
@end

@implementation SalePromotionViewController

- (id)init
{
    self = [super init];
    if(self)
    {
        self.title = @"促销专题";
        self.hasNav = YES;
        self.hidesBottomBarWhenPushed = YES;
        _model = @"7";
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.tableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        if([_model isEqualToString:@"3"])
        {
            return 170;
        }else
        {
            return 160;
        }
    }
    else
    {
        if([_model isEqualToString:@"1"])
        {
            return 285;
        }
        else if([_model isEqualToString:@"2"])
        {
            return 160;
        }else if([_model isEqualToString:@"3"])
        {
            return 130;
        }
        else if([_model isEqualToString:@"4"])
        {
            return 310;
        }else if([_model isEqualToString:@"5"])
        {
            return 160;
        }else
        {
            return 160;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *salePromotionReuseIdentifier = [@"SalePromotion_" stringByAppendingString:_model];
    SalePromotionCell *promotionCell = [tableView dequeueReusableCellWithIdentifier:salePromotionReuseIdentifier];
    if(!promotionCell)
    {
        promotionCell = [[SalePromotionCell alloc] initWithStyle:UITableViewCellSelectionStyleNone reuseIdentifier:salePromotionReuseIdentifier];
        promotionCell.backgroundColor = [UIColor clearColor];
    }
    promotionCell.tag = indexPath.row;
    [promotionCell setViewsForModel:_model];
    return promotionCell;
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
