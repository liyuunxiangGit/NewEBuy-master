//
//  EditNickNameService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-5-31.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "EditNickNameService.h"


@interface EditNickNameService(){
    
    
}

- (void)didEditNickNameFinished:(BOOL)isSuccess;

@end

@implementation EditNickNameService

@synthesize delegate            = _delegate;


- (void)httpMsgRelease
{
    HTTPMSG_RELEASE_SAFELY(editNickNameMsg);
}



- (void)beginEditNickNameRequest:(NSString *)nickName
{
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    [postDataDic setObject:nickName?nickName:@"" forKey:@"nickName"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,[@"SNiPhoneAppUserUpdateCmd" passport]];
    
    
    HTTPMSG_RELEASE_SAFELY(editNickNameMsg);
    
    editNickNameMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_editNickName];
    
    [self.httpMsgCtrl sendHttpMsg:editNickNameMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
    
}

-(void)receiveDidFailed:(HttpMessage *)receiveMsg{
    
    [super receiveDidFailed:receiveMsg];

    [self didEditNickNameFinished:NO];
}

-(void)receiveDidFinished:(HttpMessage *)receiveMsg{

    NSDictionary *items = receiveMsg.jasonItems;

    NSString *errorCode = [items objectForKey:@"errorCode"];

    if (IsNilOrNull(errorCode) || [errorCode isEqualToString:@""]) {
        
        [self didEditNickNameFinished:YES];
    }else{
        if (!([errorCode isEqualToString:@"userName_invalid"]||[errorCode isEqualToString:@"nickName_exists"]||[errorCode isEqualToString:@"nickName_forbidden_words"]||[errorCode isEqualToString:@"nickName_used"]||[errorCode isEqualToString:@"nickName_length>20"]||[errorCode isEqualToString:@"nickName_@_forbidden"]||[errorCode isEqualToString:@"nickName_12digital_forbidden"]||[errorCode isEqualToString:@"nickName_1_10_forbidden"]||[errorCode isEqualToString:@"nickName_blankspace_forbidden"]||[errorCode isEqualToString:@"nickName_exceptional_character"])) {
            self.errorMsg = @"nickName_Failed";
        }else{
            self.errorMsg = L(errorCode);
        }
        [self didEditNickNameFinished:NO];
    }
}


- (void)didEditNickNameFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(didServiceComplete:)]) {
        [_delegate didServiceComplete:isSuccess];
    }
}

@end
