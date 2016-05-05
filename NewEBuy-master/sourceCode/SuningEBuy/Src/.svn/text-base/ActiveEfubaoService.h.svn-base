//
//  ActiveEfubaoService.h
//  SuningEBuy
//
//  Created by shasha on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "DataService.h"

@protocol ActiveEfubaoServiceDelegate;

@interface ActiveEfubaoService : DataService{
    
    HttpMessage     *generalEfubaoHttpMsg;
    
    HttpMessage     *readyEfubaoHttpMsg;
    
    HttpMessage     *activeEfubaoHttpMsg;
    
}

@property (nonatomic, weak) id  <ActiveEfubaoServiceDelegate>delegate;

@property (nonatomic, copy)   NSString  *readyName; 
@property (nonatomic, copy)   NSString  *readyCardType;
@property (nonatomic, copy)   NSString  *readyIdCode;

- (void)beginSendGeneralEfubaoRequest;
- (void)beginSendReadyEfubaoRequest;
- (void)beginActiveEfubao:(BOOL)isLogonByPhone validateCode:(NSString *)validateCode mobile:(NSString *)mobile name:(NSString *)name password:(NSString *)passWord rePassWord:(NSString *)rePassWord identifyType:(NSString *)identyType identifyNum:(NSString *)identyfyNum securityQ:(NSString *)question SecurityA:(NSString *)answer;

@end

@protocol ActiveEfubaoServiceDelegate <NSObject>

- (void)didSendGeneralEfubaoRequestComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc;
- (void)didSendSendReadyEfubaoRequestComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc;
- (void)didActiveEfubaoComplete:(BOOL)isSuccess errorDesc:(NSString *)errorDesc;

@end