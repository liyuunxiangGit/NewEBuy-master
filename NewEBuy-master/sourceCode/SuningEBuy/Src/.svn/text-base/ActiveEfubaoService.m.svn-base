//
//  ActiveEfubaoService.m
//  SuningEBuy
//
//  Created by shasha on 12-9-4.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "ActiveEfubaoService.h"

@interface ActiveEfubaoService()

- (void)didSendGeneralEfubaoRequestFinished:(BOOL)isSuccess;
- (void)didSendReadyEfubaoRequestFinished:(BOOL)isSuccess;
- (void)didActiveEfubaoFinished:(BOOL)isSuccess;

@end

@implementation ActiveEfubaoService
@synthesize delegate = _delegate;
@synthesize readyName = _readyName;
@synthesize readyIdCode = _readyIdCode;
@synthesize readyCardType = _readyCardType;

- (void)httpMsgRelease{
    HTTPMSG_RELEASE_SAFELY(generalEfubaoHttpMsg);
    HTTPMSG_RELEASE_SAFELY(readyEfubaoHttpMsg);
    HTTPMSG_RELEASE_SAFELY(activeEfubaoHttpMsg);
}

- (void)didSendGeneralEfubaoRequestFinished:(BOOL)isSuccess{
    
    if (isSuccess) {
        
        if ([self.delegate respondsToSelector:@selector(didSendGeneralEfubaoRequestComplete:errorDesc:)]) {
            
            [self.delegate didSendGeneralEfubaoRequestComplete:isSuccess errorDesc:nil];
        }
        
    }else{
        
        [self.delegate didSendGeneralEfubaoRequestComplete:isSuccess errorDesc:self.errorMsg];
        
    }
    
}
- (void)didSendReadyEfubaoRequestFinished:(BOOL)isSuccess{
    
    if (isSuccess) {
        
        if ([self.delegate respondsToSelector:@selector(didSendSendReadyEfubaoRequestComplete:errorDesc:)]) {
            
            [self.delegate didSendSendReadyEfubaoRequestComplete:isSuccess errorDesc:nil];
        }
        
    }else{
        
        [self.delegate didSendSendReadyEfubaoRequestComplete:isSuccess errorDesc:self.errorMsg];
        
    }
    
}
- (void)didActiveEfubaoFinished:(BOOL)isSuccess{
    
    if (isSuccess) {
        
        if ([self.delegate respondsToSelector:@selector(didActiveEfubaoComplete:errorDesc:)]) {
            
            [self.delegate didActiveEfubaoComplete:isSuccess errorDesc:nil];
        }
        
    }else{
        
        [self.delegate didActiveEfubaoComplete:isSuccess errorDesc:self.errorMsg];
        
    }
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    switch (receiveMsg.cmdCode) {
            
        case CC_GeneralEfubao:
            [self didSendGeneralEfubaoRequestFinished:NO];
            break;
            
        case CC_ReadyEfubao:
            [self didSendReadyEfubaoRequestFinished:NO];
            break;
            
        case CC_ActiveEfubao:
            [self didActiveEfubaoFinished:NO];
            break;
            
        default:
            break;
    }
}

- (BOOL)isErrCodeValide:(NSString *)errorCode{
    
    NSArray *valideErrorCodeArr = [NSArray arrayWithObjects:@"2012",@"9001",@"9002",@"9003",@"9004",@"9005",@"9006",@"9007",@"9008",@"9009",@"9010",@"9011",@"9012",@"9013",@"9014",@"9015",@"6016",@"9017",@"5015",@"9000",@"1020", nil];
    for (NSString *valideErrCode in valideErrorCodeArr) {
        if ([errorCode isEqualToString:valideErrCode]) {
            return YES;
        }
    }
    return NO;
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    switch (receiveMsg.cmdCode) {
            
        case CC_GeneralEfubao:{
            
            if (IsNilOrNull(items)) {
                
                self.errorMsg = @"Request_Error_Null";
                
                [self didSendGeneralEfubaoRequestFinished:NO];
                
            }
            
            if (![[items objectForKey:@"isSuccess"] isEqualToString:@"1"])
            {
                DLog(@"requestMemberInfoUpdateFail from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);	
                
                NSString *errorCode = [items objectForKey:@"errorCode"];
                
                if ([errorCode isKindOfClass:[NSNull class]] || errorCode == nil) {
                    errorCode = @"";
                }
                
                /*
                 "activeEfubao_5015"="激活易付宝失败，请先登陆";
                 "activeEfubao_9001"="激活易付宝失败";
                 
                 5015： 未登录；
                 9012： 未输入验证码或验证码不正确；
                 9013： 手机号已被绑定；
                 9001： 两次输入的支付密码不一致；
                 9011： 手机绑定失败；
                 1020： 身份证格式不对
                 9006：
                 
                 */
                
                NSString *errorDesc = [NSString stringWithFormat:@"activeEfubao_%@",errorCode];
                
                NSString *errorMsg = [L(errorDesc) eq:errorDesc]?L(@"activeEfubao_Error_Default"):L(errorDesc);
                
                self.errorMsg = errorMsg;
                
                [self didSendGeneralEfubaoRequestFinished:NO];
                
                return;
                
            }
            
            [self didSendGeneralEfubaoRequestFinished:YES];
            
        }
            break;
            
        case CC_ReadyEfubao:{
            
            DLog(@"requestMemberInfoUpdateOK from server  NSUrlString=%@\n",[items description]);
            
            NSString *name = [items objectForKey:@"name"];
            NSString *idType = [items objectForKey:@"cardType"];
            NSString *idCode = [items objectForKey:@"idCode"];
            
            if (![name isKindOfClass:[NSNull class]] && name != nil && ![name isEqualToString:@""]) {
                
                self.readyName = name;                
            }
            
            
            if (![idType isKindOfClass:[NSNull class]] && idType != nil && ![idType isEqualToString:@""]) {
                
                self.readyCardType = idType;   
                
            }
            
            if (![idCode isKindOfClass:[NSNull class]] && idCode != nil && ![idCode isEqualToString:@""]) {
                
                self.readyIdCode = idCode;   
                
            }
            
            [self didSendReadyEfubaoRequestFinished:YES];
            
        }
            break;
            
        case CC_ActiveEfubao:{
            
            if (![[items objectForKey:@"isSuccess"] isEqualToString:@"1"])
            {
                DLog(@"requestMemberInfoUpdateFail from server  NSUrlString=%@\n",[receiveMsg.jasonItems description]);	
                NSString *errorCode = [items objectForKey:@"errorCode"];
                
                if ([errorCode isKindOfClass:[NSNull class]] || errorCode == nil || ![self isErrCodeValide:errorCode]) {
                    errorCode = @"";
                }                
                /*
                 "activeEfubao_5015"="激活易付宝失败，请先登陆";
                 "activeEfubao_9001"="激活易付宝失败";
                 */
                NSString *errorDesc;
                if ([errorCode hasPrefix:@"CMN"]) {
                    errorDesc = L(@"ORDER_PAY_SystemError");
                }else{
                    errorDesc = [NSString stringWithFormat:@"activeEfubao_%@", errorCode];
                    errorDesc = [L(errorDesc) eq:errorDesc]?L(@"activeEfubao_Error_Default"):L(errorDesc);
                }

                self.errorMsg = errorDesc;
                
                [self didActiveEfubaoFinished:NO];
                
                return;
                
            }else{
                
                [self didActiveEfubaoFinished:YES];
            }
            
        }
            break;
            
        default:
            break;
    }
    
}

- (void)beginSendGeneralEfubaoRequest{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    //通用参数
    //storeId
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    //actionType  第一次：空值  第二次："completeEppAccount"
    
    [postDataDic setObject:@"" forKey:@"actionType"];
    
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        //logonIdType   手机登陆：1 邮箱登陆：“0”  
        [postDataDic setObject:@"0" forKey:@"logonIdType"]; 
    }else{
        //logonIdType   手机登陆：1 邮箱登陆：“0”  
        [postDataDic setObject:@"1" forKey:@"logonIdType"]; 
    }

    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNmobileActiveEppCmd" passport]];
    
    HTTPMSG_RELEASE_SAFELY(generalEfubaoHttpMsg);
    
    generalEfubaoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_GeneralEfubao];
    
    [self.httpMsgCtrl sendHttpMsg:generalEfubaoHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
    
}
- (void)beginSendReadyEfubaoRequest{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    //通用参数
    //storeId
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    [postDataDic setObject:kHttpRequestHomeCatalogIdValue forKey:kHttpRequestHomeCatalogIdKey];	
    
    [postDataDic setObject:@"0" forKey:@"dealFlg"];	
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNMobilePreCardInfoModify" passport]];
    
    HTTPMSG_RELEASE_SAFELY(readyEfubaoHttpMsg);
    
    readyEfubaoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ReadyEfubao];
    
    [self.httpMsgCtrl sendHttpMsg:readyEfubaoHttpMsg];
	
	TT_RELEASE_SAFELY(postDataDic);
    
}

//error 9014:不能使用登录密码
- (void)beginActiveEfubao:(BOOL)isLogonByPhone validateCode:(NSString *)validateCode mobile:(NSString *)mobile name:(NSString *)name password:(NSString *)passWord rePassWord:(NSString *)rePassWord identifyType:(NSString *)identyType identifyNum:(NSString *)identyfyNum securityQ:(NSString *)question SecurityA:(NSString *)answer{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    //通用参数
    //storeId
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    //actionType  第一次：空值  第二次："completeEppAccount"
    
    [postDataDic setObject:@"completeEppAccount" forKey:@"actionType"];
    
    //logonIdType   手机登陆：1 邮箱登陆：“0”  
    
    if (isLogonByPhone == YES) {
        
        [postDataDic setObject:@"1" forKey:@"logonIdType"];    
        
    }else{
        
        [postDataDic setObject:@"0" forKey:@"logonIdType"];    
        
    }
    
    if ([UserCenter defaultCenter].efubaoStatus == eLoginByEmailPhoneUnBound) {
        //未绑定手机号码时候需要获取的参数。
        //验证码
        if (!IsStrEmpty(validateCode)) {
            [postDataDic setObject:validateCode forKey:@"validateCode"];    
        }
        //手机号
        if (!IsStrEmpty(mobile)) {
            [postDataDic setObject:mobile forKey:@"mobile"];   
        }
    }
    
    //支付密码
    [postDataDic setObject:passWord forKey:@"payPwd"];  
    
    //支付确认密码
    [postDataDic setObject:rePassWord forKey:@"confirmPayPwd"];  
    
    //姓名
    [postDataDic setObject:name forKey:@"realName"];  
    
    //证件类别  “001”身份证
    [postDataDic setObject:identyType forKey:@"idCardType"];  
    
    //证件号码
    [postDataDic setObject:identyfyNum forKey:@"idCardNum"]; 
    
    //安全问题"4"我爸爸妈妈的名字是什么？
    [postDataDic setObject:question forKey:@"safePro"];  
    
    //安全问题回答
    [postDataDic setObject:answer forKey:@"safeAnswer"];  
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNmobileActiveEppCmd" passport]];
    
    HTTPMSG_RELEASE_SAFELY(activeEfubaoHttpMsg);
    
    activeEfubaoHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_ActiveEfubao];
	
    [self.httpMsgCtrl sendHttpMsg:activeEfubaoHttpMsg];
    
	TT_RELEASE_SAFELY(postDataDic);
    
}



@end


