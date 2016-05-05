//
//  InvitationService.m
//  SuningEBuy
//
//  Created by leo on 14-3-6.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "InvitationService.h"
#import "OpenUDID.h"
#import "KCOpenUDID.h"
#import "PasswdUtil.h"
@implementation InvitationService

- (void)dealloc
{
    
    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
}


- (void)beginInvitationHttpRequest{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:[KCOpenUDID value]  forKey:@"deviceNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",kHostSuningCPA, kInviteFriend];
    
    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
    informationListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:dic
                                                           cmdCode:CC_INVITATION];
    informationListHttpMsg.delegate = self;
    informationListHttpMsg.requestMethod = RequestMethodGet;
    TT_RELEASE_SAFELY(dic);
    
    [self.httpMsgCtrl sendHttpMsg:informationListHttpMsg];
}

-(void)beginQueryRewardHttpRequest:(NSString *)cipher{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:[KCOpenUDID value] forKey:@"deviceNo"];
    [dic setValue:[UserCenter defaultCenter].cipher forKey:@"cipher"];

    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostSuningCPA,kQqueryReward];
    
    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
    informationListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:dic
                                                           cmdCode:CC_QUERYREWARD];
    informationListHttpMsg.requestMethod = RequestMethodGet;
    informationListHttpMsg.delegate = self;
    TT_RELEASE_SAFELY(dic);
    
    [self.httpMsgCtrl sendHttpMsg:informationListHttpMsg];

}


-(void)beginGetRedPackEntryHttpRequest{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:[KCOpenUDID value] forKey:@"deviceNo"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostSuningCPA,kGetRedPackEntry];
    
    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
    informationListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:dic
                                                           cmdCode:CC_GETREDPACK];
    informationListHttpMsg.requestMethod = RequestMethodGet;
    TT_RELEASE_SAFELY(dic);
    
    [self.httpMsgCtrl sendHttpMsg:informationListHttpMsg];

}


-(void)beginGetRedPackHttpRequest:(NSString *)cipher{
    NSMutableDictionary *postdic = [[NSMutableDictionary alloc] initWithCapacity:5];
    NSString *device =[NSString stringWithFormat:@"%@",[KCOpenUDID value]];
    NSString *cip = [NSString stringWithFormat:@"%@",cipher];
    [postdic setValue:device forKey:@"deviceNo"];
    
    [postdic setValue:cip forKey:@"cipher"];
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostSuningCPA,kGgetRedPack];
    NSString *str = [url queryStringNoEncodeFromDictionary:postdic];
    NSString *encodeStr = [PasswdUtil encryptString:str
                                             forKey:kkey
                                               salt:kRetrieveParamEncodeSalt];
    

    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];

    [dic setObject:encodeStr forKey:@"data"];

    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
    informationListHttpMsg = [[HttpMessage alloc] initWithDelegate:self
                                                        requestUrl:url
                                                       postDataDic:dic
                                                           cmdCode:CC_GETRED];
    informationListHttpMsg.requestMethod = RequestMethodGet;
    TT_RELEASE_SAFELY(dic);
    
    [self.httpMsgCtrl sendHttpMsg:informationListHttpMsg];
    

}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if (receiveMsg.cmdCode == CC_INVITATION)
    {
        [self informationServiceFinished:NO dto:nil cmdcode:CC_INVITATION];
    }
    if (receiveMsg.cmdCode == CC_QUERYREWARD)
    {
        [self informationServiceFinished:NO dto:nil cmdcode:CC_QUERYREWARD];
    }
    if (receiveMsg.cmdCode == CC_GETREDPACK)
    {
        [self informationServiceFinished:NO dto:nil cmdcode:CC_GETREDPACK];
    }
    if (receiveMsg.cmdCode == CC_GETRED)
    {
        [self informationServiceFinished:NO dto:nil cmdcode:CC_GETRED];
    }
    
}

-(NSString *)isFirstEn:(NSString *)str{
    if (str==NULL || str.length==0) {
        return L(@"search records is null");
    }
    NSString *temp = [str substringWithRange:NSMakeRange(0,1)];
    const char *u8Temp = [temp UTF8String];
    if (3==strlen(u8Temp)){
        return str;
    }
    return L(@"PVSubmitOvertimeRefresh");
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    NSString *error = [NSString stringWithFormat:@"%@",[item objectForKey:@"successFlg"] ];
    
    
    if (receiveMsg.cmdCode == CC_INVITATION)
    {
        //0失败
        if ([error isEqualToString:@"1"]) {
            InvitationDTO *invitationdto = [[InvitationDTO alloc] init];
            [invitationdto encodeFromDictionary:item];
            [self informationServiceFinished:YES dto:invitationdto cmdcode:CC_INVITATION];

        }
        else
        {
            InvitationDTO *invitationdto = [[InvitationDTO alloc] init];
            invitationdto.errorMsg = [self isFirstEn:[item objectForKey:@"errorMsg"]];
            
            [self informationServiceFinished:NO dto:invitationdto cmdcode:CC_INVITATION];
        }
    }
    else if (receiveMsg.cmdCode == CC_QUERYREWARD){
        if ([error isEqualToString:@"1"]) {
            QueryRewardDTO *querydto = [[QueryRewardDTO alloc] init];
            [querydto encodeFromDictionary:item];
            [self informationServiceFinished:YES dto:querydto cmdcode:CC_QUERYREWARD];

        }
        else
        {
            QueryRewardDTO *querydto = [[QueryRewardDTO alloc] init];
            querydto.errorMsg = [self isFirstEn:[item objectForKey:@"errorMsg"]];
            
            [self informationServiceFinished:NO dto:querydto cmdcode:CC_QUERYREWARD];
        }

    }
    else if(receiveMsg.cmdCode == CC_GETREDPACK){
        if ([error isEqualToString:@"1"]) {
            GetRedPackEntryDTO *querydto = [[GetRedPackEntryDTO alloc] init];
            [querydto encodeFromDictionary:item];
            [self informationServiceFinished:YES dto:querydto cmdcode:CC_GETREDPACK];
            
        }
        else
        {
            GetRedPackEntryDTO *querydto = [[GetRedPackEntryDTO alloc] init];
            querydto.errorMsg = [self isFirstEn:[item objectForKey:@"errorMsg"]];
            [self informationServiceFinished:NO dto:nil cmdcode:CC_GETREDPACK];
        }

    }
    else if(receiveMsg.cmdCode == CC_GETRED){
        if ([error isEqualToString:@"0"]) {
            NSString *errmsg =[NSString stringWithFormat:@"%@",[self isFirstEn:[item objectForKey:@"errorMsg"]]];
            [self informationServiceFinished:NO dto:errmsg cmdcode:CC_GETRED];
            
        }
        else if ([error isEqualToString:@"1"]||[[item objectForKey:@"isSuccess"] isEqualToString:@"1"]) {
                [self informationServiceFinished:YES dto:nil cmdcode:CC_GETRED];
            }
        }
}

- (void)informationServiceFinished:(BOOL)isSuccess dto:(id)infodto cmdcode:(E_CMDCODE)cmdcode
{
    if (cmdcode == CC_INVITATION) {
        InvitationDTO *invidto = (InvitationDTO *)infodto;
        if ([_delegate respondsToSelector:@selector(InvitationServiceComplete:isSuccess:)])
        {
            [_delegate InvitationServiceComplete:invidto isSuccess:isSuccess];
        }
    }
    
    else if (cmdcode == CC_QUERYREWARD){
        QueryRewardDTO *invidto = (QueryRewardDTO *)infodto;
        if ([_delegate respondsToSelector:@selector(QueryRewardServiceComplete:isSuccess:)])
        {
            [_delegate QueryRewardServiceComplete:invidto isSuccess:isSuccess];
        }
    }
    
    else if(cmdcode == CC_GETREDPACK){
        GetRedPackEntryDTO *invidto = (GetRedPackEntryDTO *)infodto;
        if ([_delegate respondsToSelector:@selector(GetRedPackServiceEntryComplete:isSuccess:)])
        {
            [_delegate GetRedPackServiceEntryComplete:invidto isSuccess:isSuccess];
        }
    }
    else if(cmdcode == CC_GETRED){
        if ([_delegate respondsToSelector:@selector(GetRedPackServiceComplete:isSuccess:)])
        {
            NSString *errcode = (NSString *)infodto;
            [_delegate GetRedPackServiceComplete:errcode isSuccess:isSuccess];
        }
    }
    
}

@end
