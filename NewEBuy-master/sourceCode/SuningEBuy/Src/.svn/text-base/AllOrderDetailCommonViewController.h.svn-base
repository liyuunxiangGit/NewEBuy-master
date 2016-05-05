//
//  AllOrderDetailCommonViewController.h
//  SuningEBuy
//
//  Created by xmy on 10/2/14.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "OrderDetailBottomCell.h"
typedef enum {
    noAppraisal,                        //没有鉴定方，不用鉴定
    myCompany,                          //我司售后人员鉴定
    factory,                            //供应商鉴定
    store                               //店面3c服务中心鉴定
} ReturnGoodsAppraisal;
@interface AllOrderDetailCommonViewController : CommonViewController

//@property (nonatomic, strong) UIView  *bottomView;

@property (nonatomic, strong) OrderDetailBottomCell *bottomCell;

- (CGRect)setViewFrame:(BOOL)hasNav;
- (CGRect)setCommonViewFrame:(BOOL)hasNav WithTab:(BOOL)hastab;

@end
