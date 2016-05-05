//
//  GBOrderMoreInfo.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-11.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCellEx.h"
#import "GBOrderDetailDelegate.h"
#import "GBOrderInfoDTO.h"
//订单取消
#define GB_ORDER_CANCEL_FAIL  @"GB_ORDER_CANCEL_FAIL"

@interface GBOrderMoreInfoCell : UITableViewCellEx
{
    NSInteger orderStatus;
    NSInteger tuanGouType;
    GBOrderInfoDTO *_item;
}

@property (nonatomic, copy)GBOrderInfoDTO *item;
@property (nonatomic, strong)UIView *singleInfoView;
@property (nonatomic, strong)UIView *doubleInfoView;
@property (nonatomic, strong)UIView *threeInfoView;
@property (nonatomic, strong)UIButton *returnButton;
@property (nonatomic, strong)UIButton *payButton;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, weak)id <GBOrderDetailDelegate>delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void)setItem:(GBOrderInfoDTO *)item;
+(CGFloat)height:(GBOrderInfoDTO *)item;
- (void)gotoVoucherInfo;
- (void)gotoShopInfo;
- (void)gotoVoucherNotice;
- (void)returnOrder;
- (void)payOrder;
- (void)cancelOrder;
- (void)notCancelOrder;
@end
