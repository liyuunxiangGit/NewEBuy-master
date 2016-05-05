//
//  ConfirmReceiptWebViewController.m
//  SuningEBuy
//
//  Created by YANG on 14-5-5.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "ConfirmReceiptWebViewController.h"
#import "ProductDetailViewController.h"
#import "SearchListViewController.h"
#import "AppDelegate.h"
#import "PurchaseDetailViewController.h"
#import "DJGroupListItemDTO.h"
#import "DJGroupDetailViewController.h"
#import "LoginViewController.h"
#import "JASidePanelController.h"
#import "FilterRootViewController.h"
#import "FilterNavigationController.h"

#import "PaymentModeViewController.h"
#import "PaymentCenterViewController.h"


@interface ConfirmReceiptWebViewController ()

@end

@implementation ConfirmReceiptWebViewController

- (id)initWithRequest:(NSURLRequest *)request
{
    if (self = [super initWithRequest:request])
    {
        self.shouldGoBackInWebWhenTouchNavBack = YES;
        self.hasNav = YES;
        NSMutableArray *patternArr = [_urlPatterns mutableCopy];
        [patternArr insertObject:@{@"regex": kOrderConfirmAcceptWapBackUrl,
                                   @"action" : @"confirmAcceptWapBackUrl:",}
                                   atIndex:0];
        _urlPatterns = patternArr;
    }

    return self;
}

- (void)setActiveName:(NSString *)activeName
{
    if (_activeName != activeName) {
        _activeName = activeName;
        self.stableTitle = activeName;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIBarButtonItem *item = [UIBarButtonItem initWithImage:@"home_back_btn.png"];// wihtSel:nil];
    if (item.customView) {
        UIButton *btn = (UIButton *)item.customView;
        [btn addTarget:self action:@selector(backForePage) forControlEvents:UIControlEventTouchUpInside];
    }
    self.navigationItem.leftBarButtonItem = item;
    
    self.title = self.activeName;
    
    self.pageTitle = [NSString stringWithFormat:@"%@-%@",L(@"sale_eightPage"),self.title];
}


- (BOOL)confirmAcceptWapBackUrl:(NSString *)url
{
    [self displayOverFlowActivityView];
    [self.confirmService sendConfirmAcceptServiceRequest:self.orderID WithItemId:self.orderItemId WithShopCode:self.supplierCode];
    return NO;
}

#pragma mark - ConfirmAcceptService

- (ConfirmAcceptService *)confirmService
{
    if(!_confirmService)
    {
        _confirmService = [[ConfirmAcceptService alloc] init];
        
        _confirmService.delegate = self;
    }
    
    return _confirmService;
}

- (void)ConfirmAcceptServiceComplete:(ConfirmAcceptService *)service WithIsSuccess:(BOOL)isSuccess
{
    [self removeOverFlowActivityView];
    if(isSuccess)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIPT_CONFIRM_SUCCESS object:nil];
        BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:nil message:L(@"AlertTransactionSuccess") delegate:self cancelButtonTitle:L(@"Ok") otherButtonTitles:nil];
        
        [alertView setCancelBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertView show];
        
    }
    else
    {
        [self presentSheet:service.errorMsg];
    }
}

/**
 *  需要信任登录到epp
 *
 *  @author liukun
 */
- (BOOL)shouldTrushToEpp
{
    return YES;
}

@end
