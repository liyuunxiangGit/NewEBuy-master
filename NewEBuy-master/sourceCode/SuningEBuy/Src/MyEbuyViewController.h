//
//  MyEbuyViewController.h
//  SuningEBuy
//
//  Created by 刘坤 on 12-8-16.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "MyEbuyCenterButtonsView.h"
#import "UserDiscountService.h"
#import "MyIntegralService.h"
#import "MyCouponSerivce.h"

#import "MyCouponViewController.h"
#import "CustomSegment.h"

#import "OrderCenterService.h"
#import "InvitationService.h"

#import "CardService.h"
#import "CardDTO.h"
#import "CardDetailBaseDTO.h"
#import "CardWbSerVice.h"
#import "OrdersNumberService.h"
#import "NewEvalutionService.h"
#import "ReturnGoodsQueryService.h"
#import "AutoLoginCommand.h"
#import "FormattersValidators.h"
#import "MyEBuyViewCell.h"
#import "AfterSaleViewController.h"
#import "MembershipInfoViewController.h"

@class MyEbuyViewController;

@interface MyEbuyViewController : CommonViewController

/*!
 @abstract      获取用户优惠信息的service。
 @discussion    包括易付宝余额、易购券、云钻等。 
                用户登出的时候设为nil。登录成功的时候，重新请求数据，刷新数据。
  */
@property(nonatomic, strong)OrderStatInfo    *orderStatInfo;

@property (nonatomic, strong) UserDiscountService  *userDiscountService;

@property (strong,nonatomic)  InvitationService *invita;

@property (strong,nonatomic) NSString  *activerule;

@property (nonatomic, strong) OrdersNumberService *orderNumberService;

@property (nonatomic) BOOL         isLoadUserImage;

@property (nonatomic) BOOL         isLoadOrderNumber;

@property (nonatomic, strong) NewEvalutionService *evalutionNumberService;

//@property(nonatomic, strong)OrderCenterService        *orderService;

- (void)gotoFavorite;

- (void)gotoOrderCenter;

- (void)gotoEfubao;

- (void)gotoIntegral;

- (void)gotoCoupon;

- (void)gotoTicketList;

- (void)gotoSetting;

//- (void)gotoMyEasilyBuy;

- (void)gotoReturnGoods;

- (void)goToPlaneOrderCenter;
- (void)goToHotelOrderCenter;


- (void)loginBtnAction;

@end
