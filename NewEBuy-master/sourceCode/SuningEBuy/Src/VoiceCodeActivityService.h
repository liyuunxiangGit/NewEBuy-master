//
//  VoiceCodeActivityService.h
//  SuningEBuy
//
//  Created by JackyWu on 14-10-30.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DataService.h"
#import "VoiceActiveDTO.h"

@protocol  VoiceCodeActivityServiceDelegate <NSObject>

-(void)getVoiceCodeActivity:(VoiceActiveDTO *)dto;

@end

@interface VoiceCodeActivityService : DataService
{
    
    HttpMessage *voiceActivityHttpMsg;
    
}

@property (nonatomic, weak) id<VoiceCodeActivityServiceDelegate> voiceActivityDelegate;

//add by gjf 声波活动请求接口
- (void)getVoiceCodeActivity:(NSString *)voicecode;

@end
