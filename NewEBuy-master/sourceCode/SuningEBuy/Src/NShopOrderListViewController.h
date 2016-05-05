//
//  NShopOrderListViewController.h
//  SuningEBuy
//
//  Created by xmy on 6/1/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "NOrderListViewController.h"
#import "ShopOrderListService.h"
#import "AllOrderListPageFreshViewController.h"

@interface NShopOrderListViewController : AllOrderListPageFreshViewController<ShopOrderListServiceDelegate>

@property (nonatomic, strong)ShopOrderListService *shopOrdeListService;
@property(nonatomic,strong) NSMutableArray  *shopOrderList;
@property(nonatomic,copy)   NSString        *orderStatus;
@property(nonatomic,copy)   NSString        *timeRange;
@property(nonatomic,assign) ShopOrderListType   orderListType;

//@property (nonatomic,strong) UIView                      *headView;//下拉框背景
//@property (nonatomic,strong) OrderSelectDownViewController                       *orderSelectDownVC;//下拉弹出界面
//@property (nonatomic,strong) UIButton                    *orderStytleBtn;//订单类型下拉按钮
//@property (nonatomic,strong) UIButton                    *timeBtn;//时间下拉按钮
@property (nonatomic,strong) UILabel                    *alertLbl;
@property (nonatomic,strong) UIImageView                 *alertImageV;

//@property (nonatomic,strong) UIImageView                *headerView;
//@property (nonatomic,strong) UIButton                   *leftButton;
//@property (nonatomic,strong) UIButton                   *rightButton;


@end
