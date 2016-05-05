//
//  VoiceCodeActivityService.m
//  SuningEBuy
//
//  Created by JackyWu on 14-10-30.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "VoiceCodeActivityService.h"

@implementation VoiceCodeActivityService

- (void)httpMsgRelease
{
    
    HTTPMSG_RELEASE_SAFELY(voiceActivityHttpMsg);
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)getVoiceCodeActivity:(NSString *)voicecode
{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@/%@.html",kEbuyWapHostURL,@"sound/soundwave",voicecode];
    
    HTTPMSG_RELEASE_SAFELY(voiceActivityHttpMsg);
    
    voiceActivityHttpMsg = [[HttpMessage alloc]initWithDelegate:self requestUrl:url postDataDic:nil cmdCode:CC_VoiceActity];
    
    voiceActivityHttpMsg.requestMethod = RequestMethodGet;
    [self.httpMsgCtrl sendHttpMsg:voiceActivityHttpMsg];
}

- (void)receiveDidFailed:(HttpMessage *)receiveMsg
{
    [super receiveDidFailed:receiveMsg];
    
    if(receiveMsg.cmdCode == CC_VoiceActity){
        [_voiceActivityDelegate getVoiceCodeActivity:nil];
    }
    
}

- (void)receiveDidFinished:(HttpMessage *)receiveMsg
{
    NSDictionary *item = receiveMsg.jasonItems;
    
    self.errorMsg =[item objectForKey:@"errorMsg"];
    
    if(receiveMsg.cmdCode == CC_VoiceActity){
        if ([[item objectForKey:@"IsSuccessFlag"] isEqualToString:@"True"]) {
            VoiceActiveDTO *voiceDTO = [[VoiceActiveDTO alloc] init];
            [voiceDTO encodeFromDictionary:item];
            [_voiceActivityDelegate getVoiceCodeActivity:voiceDTO];
        }
        else{
            VoiceActiveDTO *voiceDTO = [VoiceActiveDTO new];
            if(NotNilAndNull(EncodeStringFromDic(item,@"errorInfo")))
            {
                voiceDTO.errmsg = [item objectForKey:@"errorInfo"];
            }
            if ([[item objectForKey:@"errorCode"] isEqualToString:@"0001"]) {
                voiceDTO.errmsg=L(@"PVActivityEnded");
            }
            
            [_voiceActivityDelegate getVoiceCodeActivity:voiceDTO];
        }
    }
}

@end
