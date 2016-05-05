//
//  ScanerCodeActionService.h
//  SuningEBuy
//
//  Created by XZoscar on 14-6-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  扫码登录、注册（客户端扫码 passport自动登录其它终端）

#import "DataService.h"

@protocol ScanerCodeActionServiceDelegate <NSObject>
@optional
// 扫码后 通知passport返回
- (void)delegate_scanerCode_actionLogin:(NSDictionary *)dictionary
                                        error:(NSString *)errDesc;

- (void)delegate_scanerCode_actionAutho:(NSDictionary *)dictionary
                                  error:(NSString *)errDesc;
@end

@interface ScanerCodeActionService : DataService
@property (nonatomic,weak) id<ScanerCodeActionServiceDelegate> delegate;
@property (nonatomic,strong) NSString *authoUuid;

- (void)scanerCodeToActionLoginWithUuid:(NSString *)uuid;

- (void)scanerCodeToActionAuthoWithUuid:(NSString *)uuid;

@end
