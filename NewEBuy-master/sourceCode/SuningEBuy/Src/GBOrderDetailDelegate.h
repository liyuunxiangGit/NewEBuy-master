//
//  GBOrderDetailDelegate.h
//  SuningEBuy
//
//  Created by 王 漫 on 13-3-1.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GBOrderDetailDelegate <NSObject>
@optional
- (void) returnOrder;
- (void) payOrder;
- (void) cancelOrder;
- (void) gotoVoucherInfo;
- (void)gotoShopInfo;
-(void)gotoVoucherNotice;
@end
