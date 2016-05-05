//
//  FilterPickForSalesPromotion.m
//  SuningEBuy
//
//  Created by chupeng on 14-5-29.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "FilterPickForSalesPromotion.h"
#import <SSA_IOS/SSAIOSSNDataCollection.h>

#define TXTCOLOR_GRAY          RGBCOLOR(49, 49, 49)

@implementation SalesFilterDto

@end

@implementation FilterPickForSalesPromotion

- (id)init
{
    if (self = [super init])
    {
        if (IOS7_OR_LATER) {
            self.edgesForExtendedLayout = UIRectEdgeBottom;
        }
        
        self.pageTitle =L(@"search_searchPage_PromotionFilter");
        self.isNeedBackItem = YES;
        self.arrayItems = [NSMutableArray array];
        
        NSArray *arrTemp = @[L(@"Search_AllGoods"), L(@"Search_AllPromotion"), L(@"Search_Reduce"), L(@"Search_GroupPurchase"), L(@"Search_ReturnTicket"), L(@"Search_PanicBuying")];
        
        for (int i = 0; i < 6; i++)
        {
            SalesFilterDto *dto = [[SalesFilterDto alloc] init];
            dto.name = [arrTemp objectAtIndex:i];
            [self.arrayItems addObject:dto];
        }
        [[self.arrayItems objectAtIndex:2] setValue:@"zj" forKey:@"value"];
        [[self.arrayItems objectAtIndex:3] setValue:@"tg" forKey:@"value"];
        [[self.arrayItems objectAtIndex:4] setValue:@"fq" forKey:@"value"];
        [[self.arrayItems objectAtIndex:5] setValue:@"qg" forKey:@"value"];
    }
    
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.tableView.frame = self.view.bounds;
    if (IOS7_OR_LATER)
        self.tableView.backgroundColor = [UIColor uiviewBackGroundColor];
    
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:self.tableView];
    
    //做分割,方便显示勾选
    self.arraySelected = [[self.searchCondition.salesPromotion componentsSeparatedByString:@","] mutableCopy];
}

#pragma mark -
#pragma mark Table View Delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayItems.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 36;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *filterCellIdentifier = @"SalesPromotionFilterCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:filterCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:filterCellIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0];
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.lineBreakMode = UILineBreakModeCharacterWrap;
        cell.textLabel.textColor = TXTCOLOR_GRAY;
        
        
    }
    
    
    [cell.contentView removeAllSubviews];
    cell.accessoryView = nil;
    int row = indexPath.row;
    
    //名称
    SalesFilterDto *dto = [self.arrayItems objectAtIndex:row];
    cell.textLabel.text = [dto valueForKey:@"name"];
    
    //分割线
    UIImageView *cellSep = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"line"]];
    cellSep.frame = CGRectMake(0, 35.5, 320,0.5);
    [cell.contentView addSubview:cellSep];
    
    //勾选框
    if (self.arraySelected .count == 4)  //全部促销
    {
        if (row == 1)
        {
            UIImageView *vCheck = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
            cell.accessoryView = vCheck;
        }
    }
    else if (self.arraySelected.count == 0) //全部商品
    {
        if (row == 0)
        {
            UIImageView *vCheck = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
            cell.accessoryView = vCheck;
        }
    }
    else //单选促销
    {
        NSString *strSelected = [self.arraySelected objectAtIndex:0];
        
        for (SalesFilterDto *dto in self.arrayItems)
        {
            if ([dto.value isEqualToString:strSelected])
            {
                int index = [self.arrayItems indexOfObject:dto];
                if (row == index)
                {
                    UIImageView *vCheck = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"rightIcon"]];
                    cell.accessoryView = vCheck;
                }
            }
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont *font = [UIFont boldSystemFontOfSize:14.0];
    CGSize size = CGSizeMake(180, 300);
    CGSize finalSize = [cell.textLabel.text sizeWithFont:font
                                       constrainedToSize:size
                                           lineBreakMode:UILineBreakModeCharacterWrap];
    cell.textLabel.size = finalSize;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"83080%d",indexPath.row + 2], nil]];
    //选中全部
    if (indexPath.row == 0) {
        self.searchCondition.salesPromotion = nil;
        
    }
    //选择全部促销
    else if (indexPath.row == 1)
    {
        self.searchCondition.salesPromotion = @"qg,zj,tg,fq";
    }
    else
    {
        SalesFilterDto *dto = [self.arrayItems objectAtIndex:indexPath.row];

        self.searchCondition.salesPromotion = dto.value;
    }
    
    if (_selectFilterBlock)
    {
        _selectFilterBlock();
    }
}

- (void)pickFinish
{
    [self dismissPopover:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(filterPickDidOk)]) {
        [_delegate filterPickDidOk];
    }
}

@end
