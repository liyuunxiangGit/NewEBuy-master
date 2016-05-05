//
//  ReceiveInsendTimeViewController.m
//  SuningEBuy
//
//  Created by 孔斌 on 14-11-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ReceiveInsendTimeViewController.h"
#import "ReceiveInsendTimeCell.h"
#import "ReceiveZiyingInfoCell.h"
#import "ReceiveInfoProductCell.h"
#import "ReceiveProductInfoViewController.h"
#import "ReceiveInfoViewController.h"
#import "PayFlowService.h"

@interface ReceiveInsendTimeViewController ()<ReceiveInsendTimeCellDelegate,PayFlowServiceDelegate>
{
    NSMutableArray *_dataSourceArray;
    
    NSInteger   currentIndex;
}
@property (nonatomic, strong) UIButton  *togetherCheckBtn;

@property (nonatomic, strong) UIButton  *splitCheckBtn;

@property (nonatomic, strong) UILabel   *togetherLbl;

@property (nonatomic, strong) UILabel   *splitLbl;

@property (nonatomic, strong) PayFlowService    *payFlowService;

@end

@implementation ReceiveInsendTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWith:(ReceiveInfoViewController *)object withType:(InsendTimeType)type withDto:(InsendTimeDTO *)dto
{
    self=[super init];
    if (self) {
        self.title = @"选择送达时间";
        self.obj = object;
        self.hidesBottomBarWhenPushed = YES;
        self.insendTimeType = type;
        self.insendTimeDto = dto;
        
        if (!_insendTimeDic)
        {
            _insendTimeDic = [[NSMutableDictionary alloc] init];
        }
        if (!_togetherInsendDic) {
            _togetherInsendDic = [[NSMutableDictionary alloc] init];
        }
        if (!_splitInsendDic) {
            _splitInsendDic = [[NSMutableDictionary alloc] init];
        }
        
        for (MergeDataOptionDTO *mergeDto in self.insendTimeDto.splitMergeList) {
            for (ItemsVoDTO *itemDto in mergeDto.itemsVoList) {
                insendTimeSubmitDTO *insendSubmitDto = [[insendTimeSubmitDTO alloc] init];
                insendSubmitDto.orderitemsId    = itemDto.orderitemsId;
                insendSubmitDto.delInstallDate  = itemDto.defInstallDate;
                insendSubmitDto.delDate         = mergeDto.defDelDate;
                insendSubmitDto.delTime         = [self timeWithStr:mergeDto.defDelTime];
                [self.splitInsendDic setObject:insendSubmitDto forKey:itemDto.orderitemsId];
            }
        }
        
        for (MergeDataOptionDTO *mergeDto in self.insendTimeDto.togetherMergeList) {
            for (ItemsVoDTO *itemDto in mergeDto.itemsVoList) {
                insendTimeSubmitDTO *insendSubmitDto = [[insendTimeSubmitDTO alloc] init];
                insendSubmitDto.orderitemsId    = itemDto.orderitemsId;
                insendSubmitDto.delInstallDate  = itemDto.defInstallDate;
                insendSubmitDto.delDate         = mergeDto.defDelDate;
                insendSubmitDto.delTime         = [self timeWithStr:mergeDto.defDelTime];
                [self.togetherInsendDic setObject:insendSubmitDto forKey:itemDto.orderitemsId];
            }
        }
        
        if (InsendTimeSplit == self.insendTimeType) {
            self.mergeList = dto.splitMergeList;
            self.togetherCheckBtn.selected = NO;
            self.splitCheckBtn.selected = YES;
            self.insendTimeDic = self.splitInsendDic;
        }
        else
        {
            self.mergeList = dto.togetherMergeList;
            self.togetherCheckBtn.selected = YES;
            self.splitCheckBtn.selected = NO;
            self.insendTimeDic = self.togetherInsendDic;
        }
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.tpTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    [self.tpTableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    [self.view addSubview:self.tpTableView];
    
    [self reloadTableView];
}

- (PayFlowService *)payFlowService
{
    if (!_payFlowService) {
        _payFlowService = [[PayFlowService alloc] init];
        _payFlowService.delegate = self;
    }
    return _payFlowService;
}

- (UILabel *)togetherLbl
{
    if (!_togetherLbl) {
        _togetherLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, 240, 20)];
        _togetherLbl.backgroundColor = [UIColor clearColor];
        _togetherLbl.text = @"最快速度分开送达";
        _togetherLbl.font = [UIFont systemFontOfSize:14];
        _togetherLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _togetherLbl;
}

- (UILabel *)splitLbl
{
    if (!_splitLbl) {
        _splitLbl = [[UILabel alloc] initWithFrame:CGRectMake(50, 44, 240, 20)];
        _splitLbl.backgroundColor = [UIColor clearColor];
        _splitLbl.text = @"所有商品一起送达";
        _splitLbl.font = [UIFont systemFontOfSize:14];
        _splitLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _splitLbl;
}

- (UIButton *)togetherCheckBtn
{
    if (!_togetherCheckBtn) {
        _togetherCheckBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 38, 50, 32)];
        _togetherCheckBtn.backgroundColor = [UIColor clearColor];
        [_togetherCheckBtn setImage:[UIImage imageNamed:@"checkbox_unselect.png"] forState:UIControlStateNormal];
        [_togetherCheckBtn setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                      forState:UIControlStateSelected];
        [_togetherCheckBtn addTarget:self action:@selector(sendTypeSelected:) forControlEvents:UIControlEventTouchUpInside];
        _togetherCheckBtn.tag = 1001;
    }
    return _togetherCheckBtn;
}

- (UIButton *)splitCheckBtn
{
    if (!_splitCheckBtn) {
        _splitCheckBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 6, 50, 32)];
        _splitCheckBtn.backgroundColor = [UIColor clearColor];
        [_splitCheckBtn setImage:[UIImage imageNamed:@"checkbox_unselect.png"] forState:UIControlStateNormal];
        [_splitCheckBtn setImage:[UIImage streImageNamed:@"checkbox_selected.png"]
                           forState:UIControlStateSelected];
        [_splitCheckBtn addTarget:self action:@selector(sendTypeSelected:) forControlEvents:UIControlEventTouchUpInside];
        _splitCheckBtn.tag = 1002;
    }
    return _splitCheckBtn;
}

- (void)sendTypeSelected:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (currentIndex == btn.tag) {
        return;
    }
    //合并
    if (btn.tag == 1001) {
        self.togetherCheckBtn.selected = YES;
        self.splitCheckBtn.selected = NO;
        self.mergeList = self.insendTimeDto.togetherMergeList;
        self.insendTimeType = InsendTimeTogether;
        [self.insendTimeDic removeAllObjects];
        self.insendTimeDic = self.togetherInsendDic;
    }
    else //分开送达
    {
        self.togetherCheckBtn.selected = NO;
        self.splitCheckBtn.selected = YES;
        self.mergeList = self.insendTimeDto.splitMergeList;
        self.insendTimeType = InsendTimeSplit;
        [self.insendTimeDic removeAllObjects];
        self.insendTimeDic = self.splitInsendDic;
    }
    [self reloadTableView];
    currentIndex = btn.tag;
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
    
    //第一个section
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        //添加数据
        NSMutableArray *cellList = [NSMutableArray array];
        //送达方式
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"SendType_Cell",
                                      kTableViewCellHeightKey: @44.f
                                      };
            [cellList addObject:cellDic];
        }
        //送达方式选择
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"SendTypeSelect_Cell",
                                      kTableViewCellHeightKey: @75.f
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@15.0f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@7.5f forKey:kTableViewSectionFooterHeightKey];
        
        [array addObject:dic];
    }
    
    //第二个section,商品信息
    for (MergeDataOptionDTO *mergeDataDto in self.mergeList) {
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        NSMutableArray *cellList = [NSMutableArray array];
        
        if (mergeDataDto.itemsVoList.count == 1) {
            ItemsVoDTO *itemDto = [mergeDataDto.itemsVoList objectAtIndex:0];
            ShopCartV2DTO *dto  = [[ShopCartV2DTO alloc] init];
            dto.partNumber      = itemDto.partNumber;
            dto.itemPrice       = @([itemDto.itemPrice doubleValue]);
            dto.quantity        = itemDto.quantity;
            dto.productName     = itemDto.productName;
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"Item_Cell",
                                      kTableViewCellDataKey: dto,
                                      kTableViewCellHeightKey : @78.0f
                                      };
            [cellList addObject:cellDic];
        }
        else
        {
            NSMutableArray *itemsVoList = [[NSMutableArray alloc] init];
            for (ItemsVoDTO *itemDto in mergeDataDto.itemsVoList) {
                ShopCartV2DTO *shopCartDto = nil;
                shopCartDto = itemDto.transformToShopCartV2DTO;
                [itemsVoList addObject:shopCartDto];
            }
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"SuningItem_Cell",
                                      kTableViewCellDataKey: itemsVoList,
                                      kTableViewCellHeightKey: @78.0f
                                      };
            [cellList addObject:cellDic];
        }
        //自营商品送达时间展示
        {
            NSDictionary *cellDic = @{
                                      kTableViewCellTypeKey: @"SendTimeItem_Cell",
                                      kTableViewCellDataKey: mergeDataDto,
                                      kTableViewCellHeightKey: @([ReceiveInsendTimeCell height:self.insendTimeType isFromReceiveView:NO])
                                      };
            [cellList addObject:cellDic];
        }
        
        [dic setObject:@([cellList count]) forKey:kTableViewNumberOfRowsKey];
        [dic setObject:cellList forKey:kTableViewCellListKey];
        
        [dic setObject:@7.5f forKey:kTableViewSectionHeaderHeightKey];
        [dic setObject:@5.0f forKey:kTableViewSectionFooterHeightKey];
        
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
    
    if ([cellType isEqualToString:@"SendType_Cell"])
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text = @"送达方式：";

        return cell;
    }
    else if ([cellType isEqualToString:@"SendTypeSelect_Cell"])
    {
        SNUITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[SNUITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleSubtitle
                    reuseIdentifier:cellType];
            
            cell.textLabel.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor light_Black_Color];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            [cell.contentView addSubview:self.togetherCheckBtn];
            [cell.contentView addSubview:self.splitCheckBtn];
            [cell.contentView addSubview:self.togetherLbl];
            [cell.contentView addSubview:self.splitLbl];
        }
        
        return cell;
    }
    else if ([cellType isEqualToString:@"Item_Cell"])
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
    else if ([cellType isEqualToString:@"SuningItem_Cell"])
    {
        ReceiveZiyingInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveZiyingInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            UIImageView *imageArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow_right_gray.png"]];
            imageArrow.frame = CGRectMake(270, 17, 6, 11);
            cell.accessoryView = imageArrow;
        }
        NSArray *productLst = (NSArray *)item;
        [cell setProductList:productLst];
        return cell;
    }
    else if ([cellType isEqualToString:@"SendTimeItem_Cell"])
    {
        ReceiveInsendTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellType];
        if (cell == nil) {
            cell = [[ReceiveInsendTimeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellType];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.delegate = self;
        }
        MergeDataOptionDTO *mergeDto = (MergeDataOptionDTO *)item;
        [cell setBaseDto:mergeDto WithType:self.insendTimeType WithShipMode:self.shipMode isFromReceiveView:NO];
        return cell;
    }
    return [UITableViewCell new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *sectionDic = [_dataSourceArray safeObjectAtIndex:indexPath.section];
    
    NSArray *cellList = [sectionDic objectForKey:kTableViewCellListKey];
    NSDictionary *cellDic = [cellList safeObjectAtIndex:indexPath.row];
    
    NSString *cellType = [cellDic objectForKey:kTableViewCellTypeKey];
    id item = [cellDic objectForKey:kTableViewCellDataKey];
    
    if ([cellType isEqualToString:@"SuningItem_Cell"])
    {
        NSArray *productLst = (NSArray *)item;
        
        ReceiveProductInfoViewController *vc = [[ReceiveProductInfoViewController alloc] init];
        vc.productList = productLst;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - ReceiveInsendTimeCellDelegate Method

- (void)selectSendTimeWith:(NSString *)orderitemsId dateStr:(NSString *)dateStr timeStr:(NSString *)timeStr
{
    self.changeTimeStr = [self timeWithStr:timeStr];
    self.changeDateStr = dateStr;
    [self displayOverFlowActivityView];
    [self.payFlowService beginGetInstallDateWithdeliverTime:dateStr dayTime:self.changeTimeStr orderItemIds:orderitemsId];
}

- (NSString *)timeWithStr:(NSString *)changeTimeStr
{
    NSString *timeStr = @"";
    if ([changeTimeStr isEqualToString:@"09:00-18:00"]) {
        timeStr = @"18:00:00";
    }else if ([changeTimeStr isEqualToString:@"09:00-14:00"])
    {
        timeStr = @"09:00:00";
    }
    else if ([changeTimeStr isEqualToString:@"14:00-18:00"])
    {
        timeStr = @"15:00:00";
    }
    else if ([changeTimeStr isEqualToString:@"18:00-22:00"])
    {
        timeStr = @"20:00:00";
    }
    
    return timeStr;
}

#pragma mark - PayFlowServiceDelegate Method
- (void)getInstallDateCompletionWithResult:(BOOL)isSuccess installDateArr:(NSArray *)installDateArr errorMsg:(NSString *)errorMsg
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        for (InstallDateDTO *dto in installDateArr) {
            insendTimeSubmitDTO *submitDto = [self.insendTimeDic objectForKey:dto.orderitemsId];
            submitDto.delInstallDate = dto.defInstallDate;
            submitDto.delDate = self.changeDateStr;
            submitDto.delTime = self.changeTimeStr;
            [self.insendTimeDic setObject:submitDto forKey:dto.orderitemsId];
        }
    }
    else
    {
//        [self presentSheet:errorMsg];
    }
}

- (void)backForePage
{
    [self.obj selectSendTimeFinished:self.insendTimeType withDictionary:self.insendTimeDic];
    [self.navigationController popToViewController:self.obj animated:YES];
}

@end
