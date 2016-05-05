//
//  AccountCheckCodeService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-17.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "AccountCheckCodeService.h"

/*********************************************************************/


@interface AccountCheckCodeService()

{
    AccountCheckCodeState      _checkCodeState;
}

- (void)didGetCheckCodeFinished:(BOOL)isSuccess;

@end

@implementation AccountCheckCodeService
@synthesize delegate = _delegate;
@synthesize userCal = _userCal;
@synthesize limitTime = _limitTime;



- (id)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void)dealloc
{
}

- (void)httpMsgRelease{
    
    HTTPMSG_RELEASE_SAFELY(checkCodeHttpMsg);
    HTTPMSG_RELEASE_SAFELY(emailCodeHttpMsg);
    
}

- (MemberInfoDto *)memberInfoDto
{
    if (!_memberInfoDto) {
        _memberInfoDto = [[MemberInfoDto alloc] init];
    }
    return _memberInfoDto;
}

- (void)didGetCheckCodeFinished:(BOOL)isSuccess
{
    if ([self.delegate respondsToSelector:@selector(didGetCheckCodeComplete:errorDesc:)])
    {
        [self.delegate didGetCheckCodeComplete:isSuccess errorDesc:self.errorMsg];
    }
}


- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    
    [super receiveDidFailed:receiveMsg];
    
    [self didGetCheckCodeFinished:NO];
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{    
    NSDictionary *items = receiveMsg.jasonItems;
    if ([[items objectForKey:@"isSuccess"] isEqualToString:@"1"])
    {
        if (_checkCodeState == eMailAccountValidateOwnerVerifyMailCode || _checkCodeState == eMergeMemberCardVerifyCellphoneCode || _checkCodeState == eMergeAccountCode) {
            MemberInfoDto *dto = [[MemberInfoDto alloc] init];
            [dto encodeFromDictionary:items];
            self.memberInfoDto = dto;
        }
        [self didGetCheckCodeFinished:YES];
        
//        if (_checkCodeState == eMailAccountValidateOwnerVerifyMailCode || _checkCodeState == eMailAccountBindCellphoneVerifyCellphoneCode || _checkCodeState == eMergeMbrCardSendCellphoneCode || _checkCodeState == eMergeAccountCode || _checkCodeState == eEmailAccountBindCellVerifyMailCode || _checkCodeState == eMailAccountValidateOwnerVerifyMailCode) {
//            
//        }else{
//            if (_userCal) {
//                [eppActiveCodeCalculagraph start];
//            }
//        }
    }else{
        
        NSString *sendCount = [items objectForKey:@"sendCount"];
        if (IsStrEmpty(sendCount)) {
            if (IsStrEmpty([items objectForKey:@"errorMessage"])) {
                self.errorMsg = L(@"send Check Fail");
            }else{
                self.errorMsg = [items objectForKey:@"errorMessage"];
            }
        }else{
            if ([sendCount isEqualToString:@"3"]) {
                self.errorMsg = [NSString stringWithFormat:L(@"SorryAuthCodeOut3Times")];
            }
        }
        [self didGetCheckCodeFinished:NO];       
    }
}

- (void)beginGetCheckCode:(NSString *)phoneNum email:(NSString *)email checkCodeState:(AccountCheckCodeState)checkCodeState validateCode:(NSString *)validateCode
{

    _checkCodeState = checkCodeState;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    //storeId
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    //cellPhoneNumber
    [postDataDic setObject:IsStrEmpty(phoneNum)?@"":phoneNum forKey:@"cellphone"];
    
    //email
    [postDataDic setObject:IsStrEmpty(email)?@"":email forKey:@"email"];
    
    [postDataDic setObject:IsStrEmpty(validateCode)?@"":validateCode forKey:@"validCode"];
        
    if (checkCodeState == eValidateMemberCardContactCellphoneSendCellphoneCode){
        [postDataDic setObject:@"vmcccscc" forKey:@"step"];
        self.limitTime = 60.0f;
    }else if (checkCodeState == eMailAccountValidateOwnerSendMailCode){
        [postDataDic setObject:@"mavosmc" forKey:@"step"];
        self.limitTime = 60.0f;
    }else if (checkCodeState == eMailAccountValidateOwnerVerifyMailCode){
        [postDataDic setObject:@"mavovmc" forKey:@"step"];
    }else if (checkCodeState == eMailAccountBindCellphoneSendCellphoneCode){
        [postDataDic setObject:@"mabcscc" forKey:@"step"];
        self.limitTime = 60.0f;
    }else if (checkCodeState == eMailAccountBindCellphoneVerifyCellphoneCode){
        [postDataDic setObject:@"mabcvcc" forKey:@"step"];
    }else if (checkCodeState == eMergeMbrCardSendCellphoneCode){
        [postDataDic setObject:@"scc" forKey:@"step"];
        self.limitTime = 60.0f;
    }else if (checkCodeState == eMergeMemberCardVerifyCellphoneCode){
        [postDataDic setObject:@"vcc" forKey:@"step"];
    }else if (checkCodeState == eMergeAccountCode){
        [postDataDic setObject:@"mc" forKey:@"step"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTSendMergeValidCodeCmd"];
    
    HTTPMSG_RELEASE_SAFELY(checkCodeHttpMsg);
    
    if (_checkCodeState == eValidateMemberCardContactCellphoneSendCellphoneCode) {
        //清cookie
        NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]
                            cookiesForURL:[NSURL URLWithString:url]];
        for (NSHTTPCookie *cookie in cookies)
        {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    
    checkCodeHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_SendMergeValidCode];
    
    [self.httpMsgCtrl sendHttpMsg:checkCodeHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);
}


- (void)beginGetEmailCheckCode:(NSString *)phoneNum checkCodeState:(AccountCheckCodeState)checkCodeState validateCode:(NSString *)validateCode
{
    _checkCodeState = checkCodeState;
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:4];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    if (!IsStrEmpty(phoneNum)) {
        [postDataDic setObject:IsStrEmpty(phoneNum)?@"":phoneNum forKey:@"cellphone"];
    }
    if (!IsStrEmpty(validateCode)) {
        [postDataDic setObject:IsStrEmpty(validateCode)?@"":validateCode forKey:@"validCode"];
    }
    
    if (checkCodeState == eEmailAccountBindCellSendMailCode){
        [postDataDic setObject:@"mabcsmc" forKey:@"step"];
        self.limitTime = 60.0f;
    }else if (checkCodeState == eEmailAccountBindCellVerifyMailCode){
        [postDataDic setObject:@"mabcvmc" forKey:@"step"];
    }else if (checkCodeState == eEmailAccountBindCellSendCellCode){
        [postDataDic setObject:@"mabcscc" forKey:@"step"];
        self.limitTime = 60.0f;
    }else if (checkCodeState == eEmailAccountBindCellVerifyCellCode){
        [postDataDic setObject:@"mabcvcc" forKey:@"step"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTMailAccountBindCellCmd"];
    
    HTTPMSG_RELEASE_SAFELY(checkCodeHttpMsg);
    
    checkCodeHttpMsg = [[HttpMessage alloc] initWithDelegate:self requestUrl:url postDataDic:postDataDic cmdCode:CC_SendMergeValidCode];
    
    [self.httpMsgCtrl sendHttpMsg:checkCodeHttpMsg];
    
    TT_RELEASE_SAFELY(postDataDic);   
}

@end
