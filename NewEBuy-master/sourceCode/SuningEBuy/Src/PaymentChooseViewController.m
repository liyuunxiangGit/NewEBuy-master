//
//  PaymentChooseViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PaymentChooseViewController.h"
#import "PayModeDTO.h"
#import "SNSwitch.h"


@interface PaymentChooseViewController ()
{
    BOOL     isLoaded;
    BOOL     isFirstSavePaymentType;
}
@property (nonatomic, strong)NSMutableArray         *payModeArr;          // 支付方式列表

@end

@implementation PaymentChooseViewController


- (void)dealloc {
    
    SERVICE_RELEASE_SAFELY(_payflowService);
}
- (id)initWithPayFlowDTO:(payFlowDTO *)dto andShipMode:(ShipMode)mode
{
    self = [super init];
    if (self) {
        self.title = L(@"PFSelectPaymentWay");
        isLoaded = NO;
        self.payDTO = dto;
        self.shipMode = mode;
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"shopProcess_shop_payMethodChoice"),self.title];

    }
    return self;
}

- (void)confirm
{
    if (self.payDTO.payMode == PayModeUnSelect) {
        [self presentSheet:L(@"PFPleaseSelectPaymentWay")];
    }else{
        [self displayOverFlowActivityView];
        [self.payflowService beginSavePayMethodRequest:self.payDTO.policyId subPayMethod:self.payDTO.subCodpolicyId];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!isLoaded) {
        [self displayOverFlowActivityView];
        [self.payflowService beginGetPaymentChooseInfoRequest];
    }
}

- (UIImageView *)createAccessoryImageSelect:(BOOL)isSelect
{
    UIImageView *_rightImage=[[UIImageView alloc] init];
    _rightImage.frame = CGRectMake(265, 9, 12, 9);
    _rightImage.backgroundColor=[UIColor clearColor];
    if (isSelect) {
        _rightImage.image=[UIImage imageNamed:@"cellMark.png"];
    }else{
        _rightImage.image=nil;//[UIImage imageNamed:@"checkbox_unselect.png"];
    }
    return _rightImage;
}


#pragma mark - View lifecycle

- (void)loadView
{
    [super loadView];
    
    self.groupTableView.frame = [self visibleBoundsShowNav:self.hasNav showTabBar:NO];
    self.groupTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.groupTableView.backgroundColor = [UIColor view_Back_Color];
   	[self.view addSubview:self.groupTableView];
}


- (PayFlowService *)payflowService
{
    if (!_payflowService) {
        _payflowService = [[PayFlowService alloc] init];
        _payflowService.delegate = self;
    }
    return _payflowService;
}

- (void)paymentChooseCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg payDTO:(payFlowDTO *)dto
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        isLoaded = YES;
        dto.payMode = self.payDTO.payMode;
        dto.cashPayMode = self.payDTO.cashPayMode;
        dto.policyId = self.payDTO.policyId;
        dto.subCodpolicyId = self.payDTO.subCodpolicyId;
        dto.subpolicyid = self.payDTO.subpolicyid;
        self.payDTO = dto;
//        [self.payDTO setPayMode:PayModeUnSelect];
//        [self.payDTO setCashPayMode:CashOnDeliveryUnSelect];
        [self setUpDataSource];
        [self.groupTableView reloadData];
    }else{
        isLoaded = NO;
        [self presentSheet:errorMsg];
    }
}

- (void)savePayMethodCompletionWithResult:(BOOL)isSuccess errorMsg:(NSString *)errorMsg payDTO:(payFlowDTO *)dto
{
    [self removeOverFlowActivityView];
    if (isSuccess) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(choosePaymentOK:)]) {
            [self.delegate choosePaymentOK:self.payDTO];
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self presentSheet:errorMsg];
    }
}


//初始化数据
- (void)setUpDataSource
{
    NSMutableArray *tempPayModeArr = [NSMutableArray array];
    
    //加货到付款 刷卡
    PayModeDTO *dto0 = [PayModeDTO onLineCard2DTO:self.payDTO];
    [tempPayModeArr addObject:dto0];
    
    //加货到付款 刷卡
    PayModeDTO *dto1 = [PayModeDTO POSCard2OnDeliveryDTO:self.payDTO];
    [tempPayModeArr addObject:dto1];
    
    //加货到付款 现金
    PayModeDTO *dto11 = [PayModeDTO cashCard2OnDeliveryDTO:self.payDTO];
    [tempPayModeArr addObject:dto11];
    
    //门店支付
    [tempPayModeArr addObject:[PayModeDTO onStoreCard2DTO:self.payDTO shipMode:self.shipMode]];
    
    self.payModeArr = tempPayModeArr;
}


#pragma mark -
#pragma mark table view delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.payModeArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSInteger row = indexPath.row;
    static NSString *SettlementIdentifier = @"CellIdentifier";
    
    SNUITableViewCell *cell = nil;
    
    if (cell == nil)
    {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                        reuseIdentifier:SettlementIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:16.0f];
        cell.textLabel.textColor =  [UIColor light_Black_Color];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13.0];
        cell.detailTextLabel.numberOfLines = 3;
        cell.detailTextLabel.textColor = [UIColor dark_Gray_Color];
        cell.detailTextLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    else
    {
        [cell.contentView removeAllSubviews];
    }
    
    PayModeDTO *dto = [self.payModeArr objectAtIndex:row];
    cell.textLabel.text = dto.mainDesc;
    if (dto.supportPay)
    {
        cell.detailTextLabel.text = dto.detailDesc;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor light_Black_Color];
        if (self.payDTO.payMode == dto.payMode && self.payDTO.cashPayMode == dto.subPayMode)
        {
            cell.accessoryView = [self createAccessoryImageSelect:YES];
        }
        else
        {
            cell.accessoryView = [self createAccessoryImageSelect:NO];
        }
    }
    else
    {
        cell.textLabel.textColor = [UIColor dark_Gray_Color];
        cell.detailTextLabel.text = dto.detailUnsupportDesc;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
{
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat mainLabelHeight = 26.0f;
    CGFloat rowHeight = 44.0f;
    
    NSInteger row = indexPath.row;
    NSString *detailMessage = nil;
    CGSize detailMsgSize = CGSizeZero;
    PayModeDTO *dto = [self.payModeArr objectAtIndex:row];
    CGFloat width;
    if (dto.supportPay) {
        detailMessage = dto.detailDesc;
        width = 240;
    }else{
        detailMessage = dto.detailUnsupportDesc;
        width = 279;
    }
    detailMsgSize = [detailMessage heightWithFont:[UIFont systemFontOfSize:13.0]
                                            width:width
                                        linebreak:NSLineBreakByCharWrapping];
    CGFloat msgHeight = detailMsgSize.height>45?45:detailMsgSize.height;
    rowHeight = mainLabelHeight + msgHeight + 5;
    return rowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [SSAIOSSNDataCollection CustomEventCollection:@"click" keyArray: [NSArray arrayWithObjects:@"clickno", nil]valueArray: [NSArray arrayWithObjects:[NSString stringWithFormat:@"102050%d",indexPath.row+1], nil]];
    PayModeDTO *dto = [self.payModeArr objectAtIndex:indexPath.row];
    if (dto.supportPay) {
        self.payDTO.payMode = dto.payMode;
        self.payDTO.cashPayMode = dto.subPayMode;
        [self confirm];
        [self.groupTableView reloadData];
    }else{
        
    }
}




@end
