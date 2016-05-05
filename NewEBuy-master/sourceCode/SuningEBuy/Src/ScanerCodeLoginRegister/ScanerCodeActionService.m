//
//  ScanerCodeActionService.m
//  SuningEBuy
//
//  Created by XZoscar on 14-6-20.
//  Copyright (c) 2014年 Suning. All rights reserved.
//  扫码登录、注册（客户端扫码 passport自动登录其它终端）

// 扫描
#define kPASSPORT_MODULE_IDS_ACTION_MobileScaner @"qrLoginMobileScan"
// 授权
#define kPASSPORT_MODULE_IDS_ACTION_Authorize    @"qrLoginMobileAuthorize"

#import "ScanerCodeActionService.h"

@interface ScanerCodeActionService ()
@property (nonatomic,strong) HttpMessage *httpMsg;
@end

@implementation ScanerCodeActionService

- (void)dealloc {
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
}

- (void)scanerCodeToActionLoginWithUuid:(NSString *)uuid {
    
    self.authoUuid = uuid;
    
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kPASSPORT_MODULE_IDS stringByAppendingString:kPASSPORT_MODULE_IDS_ACTION_MobileScaner]
                                         postDataDic:[NSDictionary dictionaryWithObject:uuid forKey:@"uuid"]
                                             cmdCode:CC_ScanerCodeActionLogin];
    _httpMsg.delegate = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

- (void)scanerCodeToActionAuthoWithUuid:(NSString *)uuid {
    
    self.authoUuid = uuid;
    HTTPMSG_RELEASE_SAFELY(_httpMsg);
    _httpMsg = [[HttpMessage alloc] initWithDelegate:self
                                          requestUrl:[kPASSPORT_MODULE_IDS stringByAppendingString:kPASSPORT_MODULE_IDS_ACTION_Authorize]
                                         postDataDic:[NSDictionary dictionaryWithObject:uuid forKey:@"uuid"]
                                             cmdCode:CC_ScanerCodeActionAuthorize];
    _httpMsg.delegate = self;
    _httpMsg.requestMethod = RequestMethodGet;
    
    [self.httpMsgCtrl sendHttpMsg:_httpMsg];
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg {
    
    NSDictionary *dictionary = receiveMsg.jasonItems;
    if (receiveMsg.cmdCode == CC_ScanerCodeActionLogin) {
        if (nil != _delegate
            && [_delegate respondsToSelector:@selector(delegate_scanerCode_actionLogin:error:)]) {
            
            NSString *errCode = dictionary[@"res_code"];
            if (nil != errCode) {
                if ([errCode isEqualToString:@"0"]) {
                    [self setErrorMsg:nil];
                }else if ([errCode isEqualToString:@"1"]) {
                    [self setErrorMsg:L(@"TGC_CookieInexistenceOrInvalid")];
                }else if ([errCode isEqualToString:@"2"]) {
                    [self setErrorMsg:L(@"QR_CodeHaveScanedWaitAuthorize")];
                }else if ([errCode isEqualToString:@"3"]) {
                    [self setErrorMsg:L(@"QR_CodePastDueScanAgain")];
                }else if ([errCode isEqualToString:@"4"]) {
                    [self setErrorMsg:L(@"NWSystemBusyTryLater")];
                }else {
                    [self setErrorMsg:L(@"PVUnknownError")];
                }
            }
            
            [_delegate delegate_scanerCode_actionLogin:dictionary error:self.errorMsg];
        }
    }else if (receiveMsg.cmdCode == CC_ScanerCodeActionAuthorize) {
        if (nil != _delegate
            && [_delegate respondsToSelector:@selector(delegate_scanerCode_actionAutho:error:)]) {
            
            NSString *errCode = dictionary[@"res_code"];
            if (nil != errCode) {
                if ([errCode isEqualToString:@"0"]) {
                    [self setErrorMsg:nil];
                }else if ([errCode isEqualToString:@"1"]) {
                    [self setErrorMsg:L(@"TGC_CookieInexistenceOrInvalid")];
                }else if ([errCode isEqualToString:@"2"]) {
                    [self setErrorMsg:L(@"QR_CodeNotScanedOrAuthorized")];
                }else if ([errCode isEqualToString:@"3"]) {
                    [self setErrorMsg:L(@"QR_CodePastDueScanAgain")];
                }else if ([errCode isEqualToString:@"4"]) {
                    [self setErrorMsg:L(@"NWSystemBusyTryLater")];
                }else {
                    [self setErrorMsg:L(@"PVUnknownError")];
                }
            }
            
            [_delegate delegate_scanerCode_actionAutho:dictionary error:self.errorMsg];
        }
    }
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg {
    [super receiveDidFailed:receiveMsg];
    
     if (receiveMsg.cmdCode == CC_ScanerCodeActionLogin) {
         if (nil != _delegate
             && [_delegate respondsToSelector:@selector(delegate_scanerCode_actionLogin:error:)]) {
             
             
             [_delegate delegate_scanerCode_actionLogin:nil error:self.errorMsg];
         }
     }
}

@end
