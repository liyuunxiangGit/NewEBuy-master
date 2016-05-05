//
//  BuyNowCommand.m
//  SuningEBuy
//
//  Created by  liukun on 13-10-18.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "BuyNowCommand.h"
#import "ShopCartV2ViewController.h"
#import "ShopCartV2Service.h"
#import "ReceiveInfoViewController.h"

@interface BuyNowCommand() <ShopCartV2ServiceDelegate>
{
    ShopCartV2ViewController *_shopCart;
}

@property (nonatomic, strong) ShopCartV2Service *cartService;
@property (nonatomic, strong) ShopCartLogic *logic;

@end

/*********************************************************************/

@implementation BuyNowCommand

- (id)init
{
    self = [super init];
    if (self) {
        _shopCart = [ShopCartV2ViewController sharedShopCart];
        _cartService = [[ShopCartV2Service alloc] init];
        _cartService.delegate = self;
    }
    return self;
}

- (void)cancel
{
    SERVICE_RELEASE_SAFELY(_cartService);
    
    [super cancel];
}

//Kristopher
- (void)execute
{
    if (self.product.cityCode.length == 0)
    {
        self.product.cityCode = [[Config currentConfig] defaultCity];
    }
/*
    //copy the shopCart shop List
    ShopCartLogic *logicCopy = [_shopCart.logic copy];
    
    //全不选
    [logicCopy unSelectAll];
    
    [logicCopy addProductToLocalShopCart:self.product isMerge:NO];
    
    self.logic = logicCopy;
    
    [self.sController displayOverFlowActivityView];
    
    [self.cartService requestOrderCheckOut:logicCopy.shopCartList];
 */
    
    ShopCartLogic *logic1 = [[ShopCartLogic alloc] init];
    
    [logic1 addProductToLocalShopCart:self.product isMerge:NO];
    
    self.logic = logic1;
    
    [self.cartService requestBuyNowOrder:logic1.shopCartList];
}

- (void)service:(ShopCartV2Service *)service orderCheckOutComplete:(BOOL)isSuccess
{
    [self.sController removeOverFlowActivityView];
    
    if (isSuccess)
    {
        //       返回修改
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] init];
        barButtonItem.title = L(@"BTBack");
        self.sController.navigationItem.backBarButtonItem = barButtonItem;
        
        // 导航到去结算页面
        ReceiveInfoViewController *receiveViewController = [[ReceiveInfoViewController alloc] init];
        receiveViewController.powerFlag = service.powerFlag;
        [receiveViewController calculateProduct:service.shopCartItemList];
        
        NSString *cityCode = nil, *cityName = nil;
        [self.logic getDeliveryCityCode:&cityCode cityName:&cityName];
        receiveViewController.deliveryCityCode = cityCode;
        receiveViewController.deliveryCityName = cityName;
        receiveViewController.currentCityCode = cityCode;
        
        double price = [service.productAllPrice doubleValue];
        receiveViewController.totalPriceStr = [NSString stringWithFormat:@"￥%0.2f",price];
        
        double shouldPayprice = [service.userPayAllPrice doubleValue];
        receiveViewController.shouldPayPrice = [NSString stringWithFormat:@"￥%0.2f",shouldPayprice];
        
        double fare = [service.totalShipPrice doubleValue];
        receiveViewController.totalFareStr = [NSString stringWithFormat:@"￥%0.2f",fare];
        
        double discount = [service.totalDiscount doubleValue];
        receiveViewController.totalDiscount = [NSString stringWithFormat:@"￥%0.2f",discount];
        receiveViewController.isAllCOrder = service.isallCorder;
        receiveViewController.isCOrder = service.isCOrder;
        receiveViewController.isFromBuyNow = YES;
        receiveViewController.buyNowLogic = self.logic;
        receiveViewController.hidesBottomBarWhenPushed = YES;
        [self.sController.navigationController pushViewController: receiveViewController animated:YES];
        TT_RELEASE_SAFELY(receiveViewController);
    }
    else
    {
        ShopCartV2DTO *errorItem = self.cartService.errorItem;
        
        if (errorItem)
        {
            NSString *errorMsg = errorItem.errorDesc;
            if ([errorMsg isEqualToString:L(@"SCBigGatherSaleOver")]) {
                NSString *errorStr = L(@"SCTheGoodBigGatherSaleOver");
                [self.sController presentCustomDlg:errorStr];
            }
            else
            {
                [self.sController presentSheetOnNav:errorMsg];
            }
            
        }
        else
        {
            NSString *errorMsg = service.errorMsg ? service.errorMsg : L(@"System_Abnomal_Try_later");
            [self.sController presentSheetOnNav:errorMsg];
        }
    }
    
    [self done];
}

@end
