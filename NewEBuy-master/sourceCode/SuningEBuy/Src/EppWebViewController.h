//
//  MyEppWebViewController.h
//  SuningEBuy
//
//  Created by  liukun on 13-7-29.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "PWWebViewController.h"

#define kEppWebMyEpp                (1)
#define kEppWebPayCachier           (2)
#define kEppWebPayCachierCaiPiao    (3)
#define kEppWebPayCachierPlanePiao  (4)

@interface EppWebViewController : PWWebViewController

@property (nonatomic, assign) NSInteger webType;
@property (nonatomic, assign) BOOL      isCOrder;

//我的易付宝
- (id)initAsMyEpp;

//web收银台
- (id)initAsWebCashier:(NSString *)formString;

//彩票收银台
- (id)initAsWebCashierForCaiPiao:(NSString *)url;

//机票收银台
- (id)initAsWebCashierForPlanePiao:(NSString *)url;

//web页面切换其他页面键盘消失
- (void)lostKeyboard;
@end
