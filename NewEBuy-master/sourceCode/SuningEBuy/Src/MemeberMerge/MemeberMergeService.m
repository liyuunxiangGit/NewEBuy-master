//
//  MemeberMergeService.m
//  SuningEBuy
//
//  Created by  zhang jian on 13-10-12.
//  Copyright (c) 2013年 Suning. All rights reserved.
//

#import "MemeberMergeService.h"

//参数加密盐
#define kRegisterParamEncodeSalt  @"sn201209"
//参数加密的key
#define kRegisterParamEncodeKey   @"SNMTMergeNewAccount"

@interface MemeberMergeService()
{
    
}

- (void)searchBindInfoHttpFinished:(BOOL)isSuccess;

- (void)mbrCardBindAccountHttpFinished:(BOOL)isSuccess
                        isMergeSuccess:(BOOL)isMergeSuccess;

- (void)searchMbrCardInfoHttpFinished:(BOOL)isSuccess;

- (void)getBindMbrCardViewHttpFinished:(BOOL)isSuccess;

- (void)accountBindMbrCardHttpFinished:(BOOL)isSuccess;

- (void)mergeNewAccountHttpFinished:(BOOL)isSuccess;

@end

@implementation MemeberMergeService

-(void)httpMsgRelease{
  
    HTTPMSG_RELEASE_SAFELY(SNMTMbrCardBindAccountMsg);
    HTTPMSG_RELEASE_SAFELY(SNMTSearchBindedInfoMsg);
    HTTPMSG_RELEASE_SAFELY(SNMTSearchMbrCardInfoMsg);
    HTTPMSG_RELEASE_SAFELY(SNMTGetBindMbrCardViewMsg);
    HTTPMSG_RELEASE_SAFELY(SNMTAccountBindMbrCardMsg);
    HTTPMSG_RELEASE_SAFELY(SNMTMergeNewAccountMsg);

}
//2.3	验证短信验证码&&检索出易购账号+门店会员卡
- (void)beginSearchBindInfoHttpRequestCellphone:(NSString *)cellphone withCode:(NSString *)validateCode
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dic setObject:@"10052" forKey:@"storeId"];
    [dic setObject:IsStrEmpty(cellphone)?@"":cellphone forKey:@"cellphone"];
    [dic setObject:IsStrEmpty(validateCode)?@"":validateCode forKey:@"validateCode"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTSearchBindedInfoCmd"];
    
    HTTPMSG_RELEASE_SAFELY(SNMTSearchBindedInfoMsg);
    
    SNMTSearchBindedInfoMsg = [[HttpMessage alloc] initWithDelegate:self
                                                     requestUrl:url
                                                    postDataDic:dic
                                                        cmdCode:CC_SearchBindedInfo];
    
    [self.httpMsgCtrl sendHttpMsg:SNMTSearchBindedInfoMsg];

}

//2.4	绑定易购账号logonId=&logonPassword=&cardNum=&cardPsw=
- (void)beginMbrCardBindAccountLoginId:(NSString *)logonId logonPassword:(NSString *)logonPassword cardNum:(NSString *)cardNum cardPsw:(NSString *)cardPsw
{
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setObject:@"10052" forKey:@"storeId"];
    if (IsStrEmpty(logonId)) {
        [dic setObject:@"checkCard" forKey:@"step"];
//        [dic setObject:IsStrEmpty(cardNum)?@"":cardNum forKey:@"cardNum"];
//        [dic setObject:IsStrEmpty(cardPsw)?@"":cardPsw forKey:@"cardPsw"];
    }else{
        [dic setObject:@"" forKey:@"step"];
    }
    [dic setObject:IsStrEmpty(cardNum)?@"":cardNum forKey:@"cardNum"];
    [dic setObject:IsStrEmpty(cardPsw)?@"":cardPsw forKey:@"cardPsw"];
    [dic setObject:IsStrEmpty(logonId)?@"":logonId forKey:@"logonId"];
    [dic setObject:IsStrEmpty(logonPassword)?@"":logonPassword forKey:@"logonPassword"];

    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTMbrCardBindAccountCmd"];
    
    HTTPMSG_RELEASE_SAFELY(SNMTMbrCardBindAccountMsg);
    
    SNMTMbrCardBindAccountMsg = [[HttpMessage alloc] initWithDelegate:self
                                                         requestUrl:url
                                                        postDataDic:dic
                                                            cmdCode:CC_MbrCardBindAccount];
    
    [self.httpMsgCtrl sendHttpMsg:SNMTMbrCardBindAccountMsg];
    
}

//2.11 新建易购账号并合并
- (void)beginMergeNewAccount:(MergeNewAccountDTO *)mergeNewAccountDto
{
    
    NSMutableDictionary *postDataDic = [[NSMutableDictionary alloc] initWithCapacity:9];
    
    [postDataDic setObject:kHttpRequestHomeStoreValue forKey:kHttpRequestHomeStoreKey];
    
    NSString *sendString = @"";
    
    if ([mergeNewAccountDto.actionType isEqualToString:@"sendVerifyCode"]) {
        sendString = [NSString stringWithFormat:@"actionType=%@&registerId=%@",mergeNewAccountDto.actionType,mergeNewAccountDto.registerId];
    }else{
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:8];
        [dic setObject:mergeNewAccountDto.registerId forKey:@"registerId"];
        [dic setObject:mergeNewAccountDto.registerPassword forKey:@"registerPassword"];
        [dic setObject:mergeNewAccountDto.registerPassword forKey:@"registerPasswordVerify"];
        [dic setObject:mergeNewAccountDto.cardNum forKey:@"cardNum"];
        [dic setObject:@"" forKey:@"imgCode"];
        [dic setObject:mergeNewAccountDto.validateCode?mergeNewAccountDto.validateCode:@"" forKey:@"validateCode"];
        [dic setObject:mergeNewAccountDto.mbrcardPsw forKey:@"mbrcardPsw"];
        [dic setObject:@"iPhone" forKey:@"client"];
        [dic setObject:@"" forKey:@"actionType"];
        
        sendString = [sendString queryStringNoEncodeFromDictionary:dic];
    }
    DLog(@"sendString === %@",sendString);
    NSString *encodeStr = [PasswdUtil encryptString:sendString
                                             forKey:kRegisterParamEncodeKey
                                               salt:kRegisterParamEncodeSalt];
    
    
    [postDataDic setObject:encodeStr forKey:@"encryptMT"];
    
	NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTMergeNewAccountCmd"];
	
    HTTPMSG_RELEASE_SAFELY(SNMTMergeNewAccountMsg);
    
    SNMTMergeNewAccountMsg = [[HttpMessage alloc] initWithDelegate:self
                                                 requestUrl:url
                                                postDataDic:postDataDic
                                                    cmdCode:CC_MergeNewAccount];
	TT_RELEASE_SAFELY(postDataDic);
    
    [self.httpMsgCtrl sendHttpMsg:SNMTMergeNewAccountMsg];
    

}


//2.12	登录状态查询门店卡绑定信息
- (void)beginSearchMbrCardInfoHttpRequest
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dic setObject:@"10052" forKey:@"storeId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTSearchMbrCardInfoCmd"];
    
    HTTPMSG_RELEASE_SAFELY(SNMTSearchMbrCardInfoMsg);
    
    SNMTSearchMbrCardInfoMsg = [[HttpMessage alloc] initWithDelegate:self
                                                           requestUrl:url
                                                          postDataDic:dic
                                                              cmdCode:CC_SearchMbrCardInfo];
    
    [self.httpMsgCtrl sendHttpMsg:SNMTSearchMbrCardInfoMsg];
    
}

//2.13	登录状态绑定手机号查询门店卡信息
- (void)beginGetBindMbrCardViewHttpRequest
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:1];
    [dic setObject:@"10052" forKey:@"storeId"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTGetBindMbrCardView"];
    
    HTTPMSG_RELEASE_SAFELY(SNMTGetBindMbrCardViewMsg);
    
    SNMTGetBindMbrCardViewMsg = [[HttpMessage alloc] initWithDelegate:self
                                                          requestUrl:url
                                                         postDataDic:dic
                                                             cmdCode:CC_GetBindMbrCardView];
    
    [self.httpMsgCtrl sendHttpMsg:SNMTGetBindMbrCardViewMsg];    
}

//2.14	登录状态合并会员卡
- (void)beginAccountBindMbrCardWithCardNum:(NSString *)cardNum cardPsw:(NSString *)cardPsw
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [dic setObject:@"10052" forKey:@"storeId"];
    [dic setObject:IsStrEmpty(cardNum)?@"":cardNum forKey:@"cardNum"];
    [dic setObject:IsStrEmpty(cardPsw)?@"":cardPsw forKey:@"cardPsw"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostAddressForHttps,@"SNMTAccountBindMbrCardCmd"];
    
    HTTPMSG_RELEASE_SAFELY(SNMTAccountBindMbrCardMsg);
    
    SNMTAccountBindMbrCardMsg = [[HttpMessage alloc] initWithDelegate:self
                                                           requestUrl:url
                                                          postDataDic:dic
                                                              cmdCode:CC_AccountBindMbrCard];
    
    [self.httpMsgCtrl sendHttpMsg:SNMTAccountBindMbrCardMsg];
    
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    if (receiveMsg.cmdCode == CC_SearchBindedInfo) {
        [self searchBindInfoHttpFinished:NO];
    }else if (receiveMsg.cmdCode == CC_MbrCardBindAccount){
        [self mbrCardBindAccountHttpFinished:NO isMergeSuccess:NO];
    }else if (receiveMsg.cmdCode == CC_MergeNewAccount){
        [self mergeNewAccountHttpFinished:NO];
    }else if (receiveMsg.cmdCode == CC_SearchMbrCardInfo){
        [self searchMbrCardInfoHttpFinished:NO];
    }else if (receiveMsg.cmdCode == CC_GetBindMbrCardView){
        [self getBindMbrCardViewHttpFinished:NO];
    }else if (receiveMsg.cmdCode == CC_AccountBindMbrCard){
        [self accountBindMbrCardHttpFinished:NO];
    }
}

//清空数据
- (void)clearData
{
    self.cardNoList = nil;
    self.bindMbrCard = @"";
    self.suningAccount = @"";
    self.accountType = @"";
    self.accountBindCellPhone = @"";
    self.memberInfoDto = nil;
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    NSString *isSuccess = [item objectForKey:@"isSuccess"];
    NSString *errorCode = [item objectForKey:@"errorCode"];
    
    [self clearData];
    
    if (receiveMsg.cmdCode == CC_SearchBindedInfo) {
        if ([isSuccess isEqualToString:@"1"]) {
            self.suningAccount = [item objectForKey:@"suningAccount"];
            NSArray *array = [item objectForKey:@"cardNoList"];
            if (!IsArrEmpty(array)) {
                NSMutableArray *arrayList = [[NSMutableArray alloc] initWithCapacity:[array count]];
                for (int i = 0; i < [array count]; i ++) {
                    NSDictionary *dic = [array objectAtIndex:i];
                    CardNoListDTO *dto = [[CardNoListDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    if (i == 0) {
                        dto.isSelected = YES;
                    }
                    [arrayList addObject:dto];
                }
                self.cardNoList = arrayList;
            }
            [self searchBindInfoHttpFinished:YES];
        }else{
            self.errorMsg = [item objectForKey:@"errorMessage"];
            [self searchBindInfoHttpFinished:NO];
        }
    }else if (receiveMsg.cmdCode == CC_MbrCardBindAccount){
        if ([isSuccess isEqualToString:@"1"]) {
            NSString *isMergeSuccess = [item objectForKey:@"isMergeSuccess"];
            if ([isMergeSuccess isEqualToString:@"1"]) {
                MemberInfoDto *dto = [[MemberInfoDto alloc] init];
                [dto encodeFromDictionary:item];
                self.memberInfoDto = dto;
                [self mbrCardBindAccountHttpFinished:YES isMergeSuccess:YES];
            }else{
                self.accountType = [item objectForKey:@"accountType"];
                self.accountBindCellPhone = [item objectForKey:@"accountBindCellPhone"];
                self.suningAccount = [item objectForKey:@"suningAccount"];
                [self mbrCardBindAccountHttpFinished:YES isMergeSuccess:NO];
            }
        }else{
            self.errorMsg = [item objectForKey:@"errorMessage"];
            [self mbrCardBindAccountHttpFinished:NO isMergeSuccess:NO];
        }
    }else if (receiveMsg.cmdCode == CC_MergeNewAccount){
        if ([isSuccess isEqualToString:@"1"]) {
            MemberInfoDto *dto = [[MemberInfoDto alloc] init];
            [dto encodeFromDictionary:item];
            self.memberInfoDto = dto;
            [self mergeNewAccountHttpFinished:YES];
        }else{
            self.errorMsg = [item objectForKey:@"errorMessage"];
            [self mergeNewAccountHttpFinished:NO];
        }
    }else if (receiveMsg.cmdCode == CC_SearchMbrCardInfo){
        
        MemberInfoDto *dto = [[MemberInfoDto alloc] init];
        [dto encodeFromDictionary:item];
        if ([isSuccess isEqualToString:@"1"]) {
            
            self.memberInfoDto = dto;
            self.bindMbrCard = [item objectForKey:@"bindMbrCard"];
            [self searchMbrCardInfoHttpFinished:YES];
        }else{
            if ([errorCode isEqualToString:@"phoneIsNullOrInvalidate"] || [errorCode isEqualToString:@"acountNotBindMembercard"]) {
                
            }else{
                self.errorMsg = [item objectForKey:@"errorMessage"];
            }
            [self searchMbrCardInfoHttpFinished:NO];
        }
    }else if(receiveMsg.cmdCode == CC_GetBindMbrCardView){
        if ([isSuccess isEqualToString:@"1"]) {
            NSArray *array = [item objectForKey:@"cardNoList"];
            if (!IsArrEmpty(array)) {
                NSMutableArray *arrayList = [[NSMutableArray alloc] initWithCapacity:[array count]];
                for (int i = 0; i < [array count]; i ++) {
                    NSDictionary *dic = [array objectAtIndex:i];
                    CardNoListDTO *dto = [[CardNoListDTO alloc] init];
                    [dto encodeFromDictionary:dic];
                    if (i == 0) {
                        dto.isSelected = YES;
                    }
                    [arrayList addObject:dto];
                }
                self.cardNoList = arrayList;
            }
            [self getBindMbrCardViewHttpFinished:YES];
        }else{
            self.errorMsg = [item objectForKey:@"errorMessage"];
            [self getBindMbrCardViewHttpFinished:NO];
        }
    }else if (receiveMsg.cmdCode == CC_AccountBindMbrCard){
        if ([isSuccess isEqualToString:@"1"]) {
            MemberInfoDto *dto = [[MemberInfoDto alloc] init];
            [dto encodeFromDictionary:item];
            self.memberInfoDto = dto;
            [self accountBindMbrCardHttpFinished:YES];
        }else{
            self.errorMsg = [item objectForKey:@"errorMessage"];
            [self accountBindMbrCardHttpFinished:NO];
        }
    }
}


- (void)searchBindInfoHttpFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(searchBindInfoHttpComplete:isSuccess:)]) {
        [_delegate searchBindInfoHttpComplete:self isSuccess:isSuccess];
    }
}

- (void)mbrCardBindAccountHttpFinished:(BOOL)isSuccess isMergeSuccess:(BOOL)isMergeSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(mbrCardBindAccountHttpComplete:isMergeSuccess:isSuccess:)]) {
        [_delegate mbrCardBindAccountHttpComplete:self isMergeSuccess:isMergeSuccess isSuccess:isSuccess];
    }
}

- (void)mergeNewAccountHttpFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(mergeNewAccountHttpComplete:isSuccess:)]) {
        [_delegate mergeNewAccountHttpComplete:self isSuccess:isSuccess];
    }
}

- (void)searchMbrCardInfoHttpFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(searchMbrCardInfoHttpComplete:isSuccess:)]) {
        [_delegate searchMbrCardInfoHttpComplete:self isSuccess:isSuccess];
    }
}

- (void)getBindMbrCardViewHttpFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(getBindMbrCardViewHttpComplete:isSuccess:)]) {
        [_delegate getBindMbrCardViewHttpComplete:self isSuccess:isSuccess];
    }
}

- (void)accountBindMbrCardHttpFinished:(BOOL)isSuccess
{
    if (_delegate && [_delegate respondsToSelector:@selector(accountBindMbrCardHttpComplete:isSuccess:)]) {
        [_delegate accountBindMbrCardHttpComplete:self isSuccess:isSuccess];
    }
}

@end


@implementation CardNoListDTO

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.ecoType = EncodeStringFromDic(dic, @"ecoType");
    self.cardNo = EncodeStringFromDic(dic, @"cardNo");
    self.isBindB2CAccount = EncodeStringFromDic(dic, @"isBindB2CAccount");
}

@end


@implementation MemberInfoDto

- (void)encodeFromDictionary:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *__suningAccount = EncodeStringFromDic(dic, @"logonId");
    NSString *__cardNum = EncodeStringFromDic(dic, @"bindMbrCard");
    NSString *__cellphone = EncodeStringFromDic(dic, @"cellphone");
    
    self.suningAccount = IsStrEmpty(__suningAccount)?EncodeStringFromDic(dic, @"suningAccount"):__suningAccount;
    self.cardNum = IsStrEmpty(__cardNum)?EncodeStringFromDic(dic, @"cardNum"):__cardNum;
    self.cellphone = IsStrEmpty(__cellphone)?EncodeStringFromDic(dic, @"phoneNum"):__cellphone;
    self.achieve = EncodeStringFromDic(dic, @"achieve");
    if (!IsStrEmpty(self.achieve)) {
        [UserCenter defaultCenter].userInfoDTO.achive = self.achieve;
    }
}

@end