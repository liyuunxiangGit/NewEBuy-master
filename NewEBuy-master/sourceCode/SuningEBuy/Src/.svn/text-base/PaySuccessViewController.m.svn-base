//
//  PaySuccessViewController.m
//  SuningEBuy
//
//  Created by  zhang jian on 14-2-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PaySuccessViewController.h"

@interface PaySuccessViewController ()

@property (nonatomic, strong) UIView    *topView;
@property (nonatomic, strong) UIView    *buttomView;

@end

@implementation PaySuccessViewController


- (id)init
{
    self = [super init];
    if (self) {
        self.title = L(@"PFPaidSuccess");
        self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"shopProcess_shop_paySuccess"),self.title];
        self.hasNav = NO;
        self.bSupportPanUI = NO;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.tpTableView.frame = [self visibleBoundsShowNav:YES showTabBar:NO];
    self.tpTableView.backgroundColor = [UIColor view_Back_Color];
    [self.view addSubview:self.tpTableView];
}

- (UILabel *)orderIdLabel
{
    if (!_orderIdLabel) {
        _orderIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 200, 44)];
        _orderIdLabel.textColor = [UIColor dark_Gray_Color];
        _orderIdLabel.backgroundColor = [UIColor clearColor];
        _orderIdLabel.text = self.orderId;
        _orderIdLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    return _orderIdLabel;
}

- (UILabel *)totalPriceLabel
{
    if (!_totalPriceLabel) {
        _totalPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 200, 44)];
        _totalPriceLabel.backgroundColor = [UIColor clearColor];
        _totalPriceLabel.textColor = [UIColor orange_Red_Color];
        _totalPriceLabel.font = [UIFont boldSystemFontOfSize:15.0];
        if ([self.totalPrice hasPrefix:@"￥"]) {
            _totalPriceLabel.text = self.totalPrice;
        }else{
            _totalPriceLabel.text = [NSString stringWithFormat:@"￥%0.2f",[self.totalPrice floatValue]];
        }
    }
    return _totalPriceLabel;
}

- (UILabel *)payModeTypeLabel
{
    if (!_payModeTypeLabel) {
        _payModeTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, 200, 44)];
        _payModeTypeLabel.backgroundColor = [UIColor clearColor];
        _payModeTypeLabel.textColor = [UIColor blackColor];
        _payModeTypeLabel.text = [self getPayModeType];
        _payModeTypeLabel.font = [UIFont boldSystemFontOfSize:15.0];
    }
    return _payModeTypeLabel;
}

- (UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor clearColor];
        _topView.frame = CGRectMake(0, 0, 320, 55);
        
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"merge_success_face.png"]];
        arrowView.frame = CGRectMake(77, 14, 20, 20);
        arrowView.backgroundColor = [UIColor clearColor];
        [_topView addSubview:arrowView];
        
        UILabel *successLabel = [[UILabel alloc] initWithFrame:CGRectMake(arrowView.right+5, 10, 150, 30)];
        successLabel.font = [UIFont boldSystemFontOfSize:15.0];
        successLabel.backgroundColor = [UIColor clearColor];
        successLabel.text = L(@"PFSubmitOrderSuccess");
        [_topView addSubview:successLabel];
    }
    return _topView;
}

- (UIView *)buttomView
{
    if (!_buttomView) {
        _buttomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        _buttomView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        NSString *tips = [self getTips];
        CGSize size = [tips sizeWithFont:[UIFont boldSystemFontOfSize:13.0] constrainedToSize:CGSizeMake(290, 60)];
        label.numberOfLines = 0;
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont boldSystemFontOfSize:13.0];
        label.textColor = [UIColor dark_Gray_Color];
        label.frame = CGRectMake(15, 10, 290, size.height);
        label.text = tips;
        [_buttomView addSubview:label];
        
        
        //add go to Shopping button
        UIButton *btnShopping = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnShopping setTitle:L(@"goShopping") forState:UIControlStateNormal];
        [btnShopping setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"]
                               forState:UIControlStateNormal];
        [btnShopping setBackgroundImage:[UIImage imageNamed:@"button_white_normal.png"]
                               forState:UIControlStateHighlighted];
        btnShopping.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [btnShopping setTitleColor:[UIColor dark_Gray_Color]
                          forState:UIControlStateNormal];
        [btnShopping addTarget:self action:@selector(goAroundComplete)
              forControlEvents:UIControlEventTouchUpInside];
        btnShopping.frame = CGRectMake(20, label.bottom + 10, 134, 38);
        [_buttomView addSubview:btnShopping];

        UIButton *btnOrder = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnOrder setTitle:L(@"AlertCheckOrders") forState:UIControlStateNormal];
        [btnOrder setBackgroundImage:[UIImage imageNamed:@"orange_button.png"]
                               forState:UIControlStateNormal];
        [btnOrder setBackgroundImage:[UIImage imageNamed:@"orange_button_clicked.png"] forState:UIControlStateHighlighted];
        btnOrder.titleLabel.font = [UIFont systemFontOfSize:18.0];
        [btnOrder setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnOrder addTarget:self action:@selector(goToFavorite) forControlEvents:UIControlEventTouchUpInside];
        btnOrder.frame = CGRectMake(166, label.bottom + 10, 134, 38);
        [_buttomView addSubview:btnOrder];
    }
    return _buttomView;
}

- (void)goAroundComplete
{
    __weak PaySuccessViewController *weakSelf = self;
    [weakSelf goAroundWithCompleteBlock:^{
        
        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
    }];
}

- (NSString *)getTips
{
    NSString *string = @"";
    switch (self.paymodeType) {
        case PayModeByCoupons:
            string = L(@"PFNoSuningGoodsInvoiceBySupplier");
            break;
        case PayModeByCash:
            string = L(@"PFSubmitOrderSuccessAndCanPayByCash");
            break;
        case PayModeByPOS:
            string = L(@"PFSubmitOrderSuccessAndCanPayByCard");
            break;
        case PayModeByMention:
            string = L(@"PFPickUpAndPayInStore");
            break;
        case PayModeByStore:
            string = L(@"PFSubmitOrderSuccessAndPayInAnyStore");
            break;
        default:
            break;
    }
    return string;
}

- (void)goToFavorite
{
    //edited by gjf
    __weak PaySuccessViewController *weakSelf = self;
    [weakSelf jumpToOrderCenterBoard:^{
        
        [weakSelf.navigationController popToRootViewControllerAnimated:NO];
    }];
}

#pragma mark -
#pragma mark tableview delegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 150;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.topView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return self.buttomView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *paySuccessIdentifier = @"paySuccessIdentifier";
    SNUITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:paySuccessIdentifier];
    if (cell == nil) {
        cell = [[SNUITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:paySuccessIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.0];
        cell.textLabel.frame = CGRectMake(15, 0, 60, 44);
    }else{
        [cell.contentView removeAllSubviews];
    }
    switch (indexPath.row) {
        case 0:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@：",L(@"LBOrderCodes")];
            [cell.contentView addSubview:self.orderIdLabel];
        }
            break;
        case 1:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@：",L(@"LBPaymentAmount")];
            [cell.contentView addSubview:self.totalPriceLabel];
        }
            break;
        case 2:
        {
            cell.textLabel.text = [NSString stringWithFormat:@"%@：",L(@"PFPaymentWay")];
            [cell.contentView addSubview:self.payModeTypeLabel];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (NSString *)getPayModeType
{
    NSString *payMode = @"";
    switch (self.paymodeType) {
        case PayModeByCoupons:
            payMode = L(@"PFCouponPaymentInFull");
            break;
        case PayModeByCash:
            payMode = [NSString stringWithFormat:@"%@--%@",L(@"PFCashOnDelivery"),L(@"PFCash")];
            break;
        case PayModeByPOS:
            payMode = [NSString stringWithFormat:@"%@--%@",L(@"PFCashOnDelivery"),L(@"PFPayByCard")];
            break;
        case PayModeByStore:
            payMode = L(@"PFPayInStore");
            break;
        case PayModeByMention:
            payMode = L(@"PFSuningStorePay");
            break;
        default:
            break;
    }
    return payMode;
}


@end
