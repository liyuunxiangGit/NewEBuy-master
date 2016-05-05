//
//  AllOrderListViewController.h
//  SuningEBuy
//
//  Created by xmy on 28/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "PageRefreshTableViewController.h"
#import "AllOrderDownSelectViewController.h"

#import "ProOrderListViewController.h"

#import "NShopOrderListViewController.h"

#import "MobilePayQueryViewController.h"

#import "PayServiceQueryViewController.h"

#import "LotteryDealsViewController.h"

#import "PayServiceDTO.h"

#import "GBOrderListViewController.h"

#import "PayServiceQueryViewController.h"

//#import "BusinessOrderCenterViewController.h"
#import "HotelOrderListViewController.h"

#import "MyTicketListViewController.h"

#import "SNWebViewController.h"

@interface AllOrderListViewController : PageRefreshTableViewController<AllOrderDownSelectViewControllerDelegate>
{
    BOOL    isBackFromLottery;
}

@property (nonatomic,strong) UIButton  *arrowImg;//订单类型下拉按钮

@property (nonatomic,strong) UIButton  *orderStytleBtn;//订单类型下拉按钮
@property (nonatomic,strong) AllOrderDownSelectViewController                       *orderSelectDownVC;//下拉弹出界面
@property (nonatomic)NSInteger selectRow;

//@property (nonatomic, strong) UIView  *bottomView;

@property (nonatomic, strong) NSString *orderStatus;

/*商品订单*/
@property (nonatomic,strong) ProOrderListViewController *proOrderListVC;

/*门店订单*/
@property (nonatomic,strong) NShopOrderListViewController *shopListVC;

/*话费充值订单*/
@property (nonatomic,strong) MobilePayQueryViewController *mobileVC;

/*彩票订单*/
@property (nonatomic,strong) LotteryDealsViewController *lotteryVC;

/*生活团购订单*/
@property (nonatomic,strong) GBOrderListViewController *groupBuyVC;

/*水/电/燃气 费缴纳订单*/
@property (nonatomic,strong) PayServiceQueryViewController *waterPayVC;
@property (nonatomic, strong)PayServiceDTO *payServiceDto;

/*机票订单*/
@property (nonatomic,strong) MyTicketListViewController *planeOrderVC;

/*酒店订单*/
@property (nonatomic,strong) HotelOrderListViewController *hotelVC;

/*满座订单*/
@property (nonatomic,strong) SNWebViewController *manzuoVC;

@property (nonatomic, strong) OrderDetailBottomCell *bottomCell;




- (id)initWithData:(NSString*)orderStatus WithSelect:(OrderSelectDownType)row;

- (CGRect)setViewFrame:(BOOL)hasNav;

//- (CGRect)setNextViewFrame:(BOOL)hasNav;

- (CGRect)setViewFrame:(BOOL)hasNav WithTab:(BOOL)hastab;


@end
