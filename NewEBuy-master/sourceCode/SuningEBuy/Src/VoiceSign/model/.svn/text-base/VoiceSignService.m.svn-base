//
//  VoiceSignService.m
//  SuningEBuy
//
//  Created by leo on 14-4-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceSignService.h"

@implementation VoiceSignService

- (void)dealloc
{
    
    HTTPMSG_RELEASE_SAFELY(informationListHttpMsg);
    
}

-(void)beginSignHttpRequest:(NSString *)voicecode{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [dic setValue:[UserCenter defaultCenter].cipher forKey:@"voicecode"];
    
    NSString *url = [NSString stringWithFormat:@"%@/%@", kHostSuningMts,kQqueryReward];
    
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

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    NSString *error = [NSString stringWithFormat:@"%@",[item objectForKey:@"successFlg"] ];
    
    
    if (receiveMsg.cmdCode == CC_INVITATION)
    {
        //0失败
        if ([error isEqualToString:@"1"]) {
           
            
        }
        else
        {
            
        }
    }
}

- (void)informationServiceFinished:(BOOL)isSuccess dto:(id)infodto cmdcode:(E_CMDCODE)cmdcode
{
    if (cmdcode == CC_INVITATION) {
//        if ([_delegate respondsToSelector:@selector(InvitationServiceComplete:isSuccess:)])
//        {
////            [_delegate InvitationServiceComplete:invidto isSuccess:isSuccess];
//        }
    }
}
@end
