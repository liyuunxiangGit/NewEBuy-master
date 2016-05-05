//
//  QYaoYiYaoViewCtrler+Req.h
//  SuningEBuy
//
//  Created by XZoscar on 14-4-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
//  云钻不足，下一步 跳转到云钻乐园（不再跳到签到页面） xzoscar 2014/08/19 modify

#import "QYaoYiYaoViewCtrler.h"
#import "QYaoHttpService.h"

@interface QYaoYiYaoViewCtrler (Req) <QYaoHttpServiceDelegate>

- (QYaoHttpService *)yaoJiangService;

@end
