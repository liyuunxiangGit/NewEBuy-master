//
//  QYaoYiYaoViewCtrler+Req.m
//  SuningEBuy
//
//  Created by XZoscar on 14-4-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "QYaoYiYaoViewCtrler+Req.h"
//#import "CheckInViewController.h"
#import "QYaoYiYaoDTO.h"
#import "SNWebViewController.h"

@implementation QYaoYiYaoViewCtrler (Req)

#pragma mark - HttpServe object

// 云钻不足，下一步 跳转到云钻乐园（不再跳到签到页面） xzoscar 2014/08/19
//- (RegistrationService *)registService
//{
//    if (nil == __registHttpServe) {
//        __registHttpServe = [[RegistrationService alloc] init];
//        __registHttpServe.delegate = self;
//    }
//    return __registHttpServe;
//}

- (QYaoHttpService *)yaoJiangService {
    
    if (nil == __yaoHttpServe) {
        __yaoHttpServe = [[QYaoHttpService alloc] init];
        __yaoHttpServe.httpDelegate = self;
    }
    return __yaoHttpServe;
}

- (void)actionLoadCloneToFriendCtrler {
    
    // ->克隆给朋友（webView呈现相应可克隆云钻的二维码）
    if (nil != self.activeResultBean.cloneUrl) {
        
        SNWebViewController *vc = [[SNWebViewController alloc] initWithType:SNWebViewTypeYaoYiYao attributes:@{@"url": self.activeResultBean.cloneUrl}];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)alertViewToLoadCloneToFriendCtrler:(NSString *)notice {
    
    BBAlertView *alertView = [[BBAlertView alloc] initWithTitle:L(@"Tips")
                                                        message:notice
                                                       delegate:self
                                              cancelButtonTitle:L(@"Cancel")
                                              otherButtonTitles:L(@"Ok")];
    
    [alertView setConfirmBlock:^{
        
        [self actionLoadCloneToFriendCtrler];
    }];
    [alertView show];
    TT_RELEASE_SAFELY(alertView);
}


#pragma mark - QYaoHttpServiceDelegate

- (void)delegate_yaoYiYaoHttpServeResult:(id)object {
    
    QHttpObject *obj = object;
    if (nil == obj.errMsg) {    // ok
        if (obj.cmd == CC_YaoYiYaoActiveQuery) {            // 查询活动
            
            QYaoQueryDTO *bean = (QYaoQueryDTO *)obj;
            self.activeQueryBean    = bean;
        
            if (nil != bean.activeRuleUrl
                && [bean.activeRuleUrl hasPrefix:@"http"]) {
                self.moreRuleButton.hidden = NO;
            }
            [self showQueryActiveResultDesc:bean.resultDesc err:bean.resultCode];// e01 当前没有正在进行的活动
            
        }else if (obj.cmd == CC_YaoYiYaoActiveShakeJiang) { // 活动抽奖
            
            QYaoChouJiangDTO *bean = (QYaoChouJiangDTO *)obj;
            self.activeResultBean = bean;
            
            [self showShakePrizeResult:bean.stateType desc:bean.resultDesc];
            
        }else if (obj.cmd == CC_YaoYiYaoActiveCloneValidate) {  //克隆校验
            
            [self updateViewUserInteractionEnabled:YES];
            
            QYaoCloneValidateDTO *bean = (QYaoCloneValidateDTO *)obj;
            if (nil != bean.firstCloneMsg
                && bean.firstCloneMsg.length > 0) {
                [self alertViewToLoadCloneToFriendCtrler:bean.firstCloneMsg];
            }else {
                [self actionLoadCloneToFriendCtrler];
            }
        }
        
    }else { // error
        if (obj.cmd == CC_YaoYiYaoActiveShakeJiang) {
            [self showShakePrizeResult:kQYaoYiYaoResultStateUnknown desc:nil];
        }
        [self presentSheet:obj.errMsg];
    }
    
    [self removeOverFlowActivityView];
    
    [self updateViewUserInteractionEnabled:YES];
}

#pragma mark - UIWebViewDelegate

- (BOOL)yaoYiYao_copy:(NSURL *)url
{
    NSString *paras = [url query];
    
    NSArray *arr = [paras componentsSeparatedByString:@"&"];
    NSMutableDictionary *paraDic = [NSMutableDictionary dictionary];
    for (NSString *str in arr) {
        NSArray *arr0 = [str componentsSeparatedByString:@"="];
        if (arr0.count >= 1) {
            [paraDic setObject:arr0[1] forKey:arr0[0]];
        }
    }
    
    if ([paras isEqualToString:@"yaoyiyaofuzhi"]
        || [paraDic[@"yaoyiyaofuzhi"] isEqualToString:@"1"]) {
        [self presentSheet:L(@"WC_CopySuccess") posY:self.view.bounds.size.height - 100.0f];
        
        NSString *pasteStr = nil;
        NSString *cot = paraDic[@"content"];
        NSArray *arr1 = [url.absoluteString componentsSeparatedByString:@"?"];
        if (nil != cot && cot.length > 0) {
            pasteStr = [NSString stringWithFormat:@"%@ %@",cot,(arr1.count > 0) ? arr1[0] : @""];
        }else {
            pasteStr = ((arr1.count > 0) ? arr1[0] : @"");
        }
        pasteStr = [pasteStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIPasteboard generalPasteboard] setString:pasteStr];
        
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType {
    
    if ([self yaoYiYao_copy:request.URL]) {
        return NO;
    }
    
    if ([request.URL.absoluteString hasPrefix:kPassportLoginUrl]) {
        [self presentLoginViewCtrler];
        
        return NO;
    }
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self displayOverFlowActivityView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self removeOverFlowActivityView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    
    [self removeOverFlowActivityView];
    
    switch (error.code) {
        case NSURLErrorCannotFindHost:
        case NSURLErrorCannotConnectToHost:
        case NSURLErrorNotConnectedToInternet:
        case NSURLErrorTimedOut:
            [self presentSheet:kNetUnreachErrorMsg];
        default:
            break;
    }
}

@end
