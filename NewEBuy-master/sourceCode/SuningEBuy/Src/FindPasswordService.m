//
//  FindPasswordService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-8-19.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "FindPasswordService.h"


//参数加密盐
#define kRetrieveParamEncodeSalt  @"sn201209"
//参数加密的key
#define kRetrieveParamEncodeKey   @"SNMTRetrievePswCmdImpl"

@interface FindPasswordService()
{
    
}

- (void)findPasswordFinish:(BOOL)isSuccess;

@end


@implementation FindPasswordService

@synthesize delegate            = _delegate;;

- (void)dealloc
{
    HTTPMSG_RELEASE_SAFELY(findPasswordHTTPMsg);
    
}

- (void)beginFindPasswordHttpRequest:(FindPasswordDTO *)dto
{
    _findPasswordStep = dto.stepIndex;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"10052" forKey:@"storeId"];
    NSMutableDictionary *dicData = [[NSMutableDictionary alloc] initWithCapacity:4];
    switch (dto.stepIndex) {
        case Check_LoginID_ImageCode:
        {
            [dicData setObject:IsStrEmpty(dto.uuid)?@"":dto.uuid forKey:@"uuid"];
            [dicData setObject:IsStrEmpty(dto.imageCode)?@"":dto.imageCode forKey:@"imageCode"];
            [dicData setObject:IsStrEmpty(dto.cellPhone)?@"":dto.cellPhone forKey:@"cellPhone"];
            [dicData setObject:IsStrEmpty(dto.step)?@"":dto.step forKey:@"step"];
        }
            break;
        case Resend_ValidateCode:
        {
            [dicData setObject:IsStrEmpty(dto.step)?@"":dto.step forKey:@"step"];
        }
            break;
        case Check_ValidateCode:
        {
            [dicData setObject:IsStrEmpty(dto.validateCode)?@"":dto.validateCode forKey:@"validateCode"];
            [dicData setObject:IsStrEmpty(dto.step)?@"":dto.step forKey:@"step"];
        }
            break;
        case Reset_Password:
        {
            NSString *finalPassword = [dto.password stringByReplacingOccurrencesOfString:@"&" withString:@"<>"];
            [dicData setObject:IsStrEmpty(finalPassword)?@"":finalPassword forKey:@"password"];
            [dicData setObject:IsStrEmpty(finalPassword)?@"":finalPassword forKey:@"passwordVerify"];
            [dicData setObject:IsStrEmpty(dto.step)?@"":dto.step forKey:@"step"];
        }
            break;
        default:
            break;
    }
    
    NSString *sendString = @"";
    sendString = [sendString queryStringNoEncodeFromDictionary:dicData];

    DLog(@"send find password ==  %@",sendString);
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:kRetrieveParamEncodeKey
                                               salt:kRetrieveParamEncodeSalt];


    [dic setObject:encodeStr forKey:@"data"];

    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTRetrievePsw"];

    HTTPMSG_RELEASE_SAFELY(findPasswordHTTPMsg);

    findPasswordHTTPMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:dic
                                                    cmdCode:CC_FindPassword];
    TT_RELEASE_SAFELY(dic);
    TT_RELEASE_SAFELY(dicData);
    
    [self.httpMsgCtrl sendHttpMsg:findPasswordHTTPMsg];

}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    NSString *isSuccess = [item objectForKey:@"isSuccess"];
    
    if ([isSuccess isEqualToString:@"1"]) {
        [self findPasswordFinish:YES];
    }else{
        NSString *errorCode = [item objectForKey:@"errorCode"];
        if ([errorCode isEqualToString:@"cellPhoneInvalid"]) {
            self.errorMsg = L(@"SorryPhoneNumberModeWrong");
        }else if ([errorCode isEqualToString:@"cellPhoneNotExist"]){
            self.errorMsg = L(@"SorryPhoneNumberInexistence");
        }else if ([errorCode isEqualToString:@"wrongImageCode"]){
            self.errorMsg = L(@"Please_input_correct_Picture_VerifyNum");
        }else if ([errorCode isEqualToString:@"sendTimesLimit"]){
            self.errorMsg = L(@"SorryAuthCodeOut3TimesTryMorrow");
        }else if ([errorCode isEqualToString:@"validateCodeInvalid"]){
            self.errorMsg = L(@"Please_input_correct_message_VerifyNum");
        }else if ([errorCode isEqualToString:@"systemErr"]){
            //self.errorMsg = @"非法调用接口导致系统错误";
             self.errorMsg = L(@"NWSystemWrong");
        }else if ([errorCode isEqualToString:@"imageCodeInvalid"]){
            self.errorMsg = L(@"Please_input_correct_Picture_VerifyNum");
        }else if ([errorCode isEqualToString:@"2080"]){
            self.errorMsg = L(@"LOGIN_PasswordTwiceNotSameInputAgain");
        }else if ([errorCode isEqualToString:@"imageCodeInvalid"]){
            self.errorMsg = L(@"PasswordIs6-20characters、numbersOrGroup");
        }else {
            // xzoscar 2014/11/14 修复bug 错误提示以服务器返回为准 如易付宝密码和易购客户端密码不能相同等
            NSString *errMsg = EncodeStringFromDic(item,@"errorDesc");
            if (errMsg == nil || errMsg.length == 0) {
                errMsg = EncodeStringFromDic(item,@"errorCode");
            }
            self.errorMsg = ((nil == errMsg)?@"发生异常，请稍后再试":errMsg);
        }
        [self findPasswordFinish:NO];
    }
}

- (void)findPasswordFinish:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(findPasswordHttpComplete:isSuccess:)]) {
        [_delegate findPasswordHttpComplete:self isSuccess:isSuccess];
    }
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    [self findPasswordFinish:NO];
}

@end
