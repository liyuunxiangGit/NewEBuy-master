//
//  EfubaoAccountService.m
//  SuningEBuy
//
//  Created by shasha on 12-8-29.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EfubaoAccountService.h"
#import "UserCenter.h"

@interface EfubaoAccountService () 

- (void)didGetEfubaoAccountInfoFinished:(BOOL)isSuccess;

@end

@implementation EfubaoAccountService
@synthesize delegate = _delegate;
@synthesize efubaoBalance = _efubaoBalance;
@synthesize eppStatus = _eppStatus;


- (void)dealloc {
    
    _delegate = nil;
        
}

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        _efubaoBalance = nil;
        _eppStatus = nil;
                
    }
    return self;
}


-(void)httpMsgRelease{

    HTTPMSG_RELEASE_SAFELY(efubaoAcountHttpMsg);
}


- (void)didGetEfubaoAccountInfoFinished:(BOOL)isSuccess
{
    if (isSuccess) {
        [UserCenter defaultCenter].userInfoDTO.yifubaoBalance = self.efubaoBalance;
        [UserCenter defaultCenter].userInfoDTO.eppStatuss = self.eppStatus;
    }

    if ([_delegate respondsToSelector:@selector(didGetEfubaoAccountCompleted:errorMsg:)])
    {
        [_delegate didGetEfubaoAccountCompleted:isSuccess errorMsg:self.errorMsg];
    }
    
}

#pragma mark - 
#pragma mark - send http request for getting whole Information

//易付宝余额接口返回结果

- (void)beginGetEfubaoAccountInfo{

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] init];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    [postDataDic setObject:[UserCenter defaultCenter].userInfoDTO.userId?[UserCenter defaultCenter].userInfoDTO.userId:@"" forKey:@"userId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNiPhoneAppBalanceViewNew" passport]];
    
    HTTPMSG_RELEASE_SAFELY(efubaoAcountHttpMsg);
    
    efubaoAcountHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_EfubaoAcount];
    
    TT_RELEASE_SAFELY(postDataDic);
    efubaoAcountHttpMsg.requestMethod =RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:efubaoAcountHttpMsg];

}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    [self didGetEfubaoAccountInfoFinished:NO];
    
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
        
    if (receiveMsg.jasonItems == nil) {
        
        self.errorMsg = kHttpResponseJSONValueFailError;
        [self didGetEfubaoAccountInfoFinished:NO];
        
    }else{
        
        NSString *isSuccess = [items objectForKey:@"isSuccess"];
        if (!IsStrEmpty(isSuccess)&&[isSuccess isEqualToString:@"1"]) {

            NSString *efubaoAccount = [items objectForKey:@"balance"];
            NSString *eppStatusStr  = [items objectForKey:@"eppStatus"];
            
            self.efubaoBalance = IsStrEmpty(efubaoAccount)?@"":efubaoAccount;
            self.eppStatus = IsStrEmpty(eppStatusStr)?@"":eppStatusStr;
            
            [self didGetEfubaoAccountInfoFinished:YES];
            
        }else{
        
            NSString *errorCode = [items objectForKey:@"errorCode"];
            
            if (IsStrEmpty(errorCode)) {
                self.errorMsg = L(@"EfubaoBalance_Error");
            }else{            
                if ([errorCode isEqualToString:@"5015"]) {
                    self.errorMsg = kLoginStatusMessageStatusUnNormal;
                }else{
                    self.errorMsg = L(@"EfubaoBalance_Error");                
                }
            }
            
            [self didGetEfubaoAccountInfoFinished:NO];
            
        }
    
    }

}

@end
