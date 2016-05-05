//
//  BoundPhoneService.m
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "BoundPhoneService.h"

@interface BoundPhoneService()

- (void)didBoundPhoneLogonByPhoneFinished:(BOOL)isSuccess;
- (void)didBoundPhoneLogonByEmailFinished:(BOOL)isSuccess;


@end

@implementation BoundPhoneService
@synthesize delegate;

- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


-(void)httpMsgRelease{

    HTTPMSG_RELEASE_SAFELY(boundWhenLogonByEmailHttpMsg);
    HTTPMSG_RELEASE_SAFELY(boundWhenLogonByPhoneHttpMsg);

}

- (void)didBoundPhoneLogonByPhoneFinished:(BOOL)isSuccess{

    if ([self.delegate respondsToSelector:@selector(didBoundPhoneWhenLogonByPhoneComplete:errorDesc:)]) {
        
        if (isSuccess) {
            
            [self.delegate didBoundPhoneWhenLogonByPhoneComplete:isSuccess errorDesc:nil];
            
        }else{
        
             [self.delegate didBoundPhoneWhenLogonByPhoneComplete:isSuccess errorDesc:self.errorMsg];
        }
    }
}

- (void)didBoundPhoneLogonByEmailFinished:(BOOL)isSuccess{
    if ([self.delegate respondsToSelector:@selector(didBoundPhoneWhenLogonByEmailComplete:errorDesc:)]) {
        
        if (isSuccess) {
            
            [self.delegate didBoundPhoneWhenLogonByEmailComplete:isSuccess errorDesc:nil];
            
        }else{
            
            [self.delegate didBoundPhoneWhenLogonByEmailComplete:isSuccess errorDesc:self.errorMsg];
        }
        
    }

}


-(void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_BoundPhoneLogonByEmail) {
        
        [self didBoundPhoneLogonByEmailFinished:NO];
         
    }else{
    
        [self didBoundPhoneLogonByPhoneFinished:NO];
    
    }
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg{
    
    NSDictionary *items = receiveMsg.jasonItems;
    
    if ([[items objectForKey:@"isSuccess"] isEqualToString:@"1"]){
        
        if (receiveMsg.cmdCode == CC_BoundPhoneLogonByEmail) {
            
            [self didBoundPhoneLogonByEmailFinished:YES];
            
        }else{
            
            [self didBoundPhoneLogonByPhoneFinished:YES];
            
        }        
    }else{
        
        NSString *errorCode = [items objectForKey:@"errorCode"];
        
        if ([errorCode isKindOfClass:[NSNull class]] || errorCode == nil) {
            
            errorCode = @"";
        }
        NSString *errorDesc;
        if ([errorCode hasPrefix:@"CMN"]) {
            errorDesc = L(@"ORDER_PAY_SystemError");
        }else{
            errorDesc = [NSString stringWithFormat:@"bindPhone_%@",errorCode];
        }

        self.errorMsg = L(errorDesc);
        
        if (receiveMsg.cmdCode == CC_BoundPhoneLogonByEmail) {
            
            [self didBoundPhoneLogonByEmailFinished:NO];
            
        }else{
            
            [self didBoundPhoneLogonByPhoneFinished:NO];
            
        }
        
    }        
}


- (void)beginBoundPhoneWhenLogonByPhone:(NSString *)phoneNum CodeNum:(NSString *)codeNum{

    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    //storeId
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    [postDataDic setObject:phoneNum forKey:@"phone1"];
    
    //pageFlg    
    [postDataDic setObject:@"ActivateMobileView" forKey:@"pageFlag"];  
    
    //codeNum
    
    NSString *codeNumber = codeNum;
    
    [postDataDic setObject:codeNumber forKey:@"validCode"];    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttp,[@"SNiPhoneConfirmMobileAccount" passport]];
    
    HTTPMSG_RELEASE_SAFELY(boundWhenLogonByPhoneHttpMsg);
    
    boundWhenLogonByPhoneHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_BoundPhoneLogonByPhone];
    
    [self.httpMsgCtrl sendHttpMsg:boundWhenLogonByPhoneHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);


}


- (void)beginBoundPhoneWhenLogonByEmail:(NSString *)phoneNum CodeNum:(NSString *)codeNum{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    //storeId
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];	
    
    //phoneNum    
    [postDataDic setObject:phoneNum forKey:@"phoneNum"];
    
    //pageFlg    
    [postDataDic setObject:@"SNBindMobile" forKey:@"pageFlg"];  
    
    //codeNum
    [postDataDic setObject:codeNum forKey:@"codeNum"];    
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNiPhoneBindMobileCmd"];
    
    HTTPMSG_RELEASE_SAFELY(boundWhenLogonByEmailHttpMsg);
    
    boundWhenLogonByEmailHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_BoundPhoneLogonByEmail];
    
    [self.httpMsgCtrl sendHttpMsg:boundWhenLogonByEmailHttpMsg];

    TT_RELEASE_SAFELY(postDataDic);
}


@end

