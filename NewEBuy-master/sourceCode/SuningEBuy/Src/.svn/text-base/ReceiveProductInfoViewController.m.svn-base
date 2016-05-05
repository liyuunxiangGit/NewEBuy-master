//
//  ReceiveProductInfoViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReceiveProductInfoViewController.h"
#import "ShopCartV2DTO.h"
#import "ReceiveInfoProductCell.h"

@interface ReceiveProductInfoViewController ()
{
    NSMutableArray *_dataSourceArray;
}
@end

@implementation ReceiveProductInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadView
{
    [super loadView];
    
    self.title = @"商品信息";
    self.tpTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    [self.tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:self.tpTableView];
    [self reloadTableView];
    
}

#pragma mark ----------------------------- tableview reload

- (void)reloadTableView
{
    [self prepareTableViewDatasource];
    
    [self.tpTableView reloadData];
}

- (void)prepareTableViewDatasource
{
    NSMutableArray *array = [NSMutableArray array];
    
    //第二个section,商品信息
    for (ShopCartV2DTO *dto in self.productList) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *cellList = [NSMutableArray array];
        
        NSDictionary *cellDic = @{
                                  kTableViewCellTypeKey: @"Item_Cell",
                                  kTableViewCellDataKey: dto,
                                  kTableViewCellHeightKey : @78.0f
                                  };
        [cellList addObject:cellDic];
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@7.5f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@7.5f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    
    _dataSourceArray = array;
}

#pragma mark ----------------------------- tableView dataSource and delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataSourceArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewNumberOfRowsKey] integerValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    return [[cellDic objectForKey:kTableViewCellHeightKey] floatValue];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionHeaderHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor clearColor];
    return v;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:section];
    return [[sectionDic objectForKey:kTableViewSectionFooterHeightKey] floatValue];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"Item_Cell"])
    {
        ReceiveInfoProductCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveInfoProductCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        ShopCartV2DTO *dto = (ShopCartV2DTO *)item;
        cell.shopCartDto = dto;
        return cell;
    }
    return [UITableViewCell new];
}

@end
