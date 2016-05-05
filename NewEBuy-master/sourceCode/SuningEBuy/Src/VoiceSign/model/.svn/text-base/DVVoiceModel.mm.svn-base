//
//  DVVoiceModel.m
//  SuningEBuy
//
//  Created by leo on 14-4-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "DVVoiceModel.h"
#import "dvSoundDecoder.h"

@implementation DVVoiceModel
- (void)dealloc {
    voicedecodeBlock = nil;
    TT_RELEASE_SAFELY(myTimer);

}

- (void)setVoicedecodeBlock:(SNBasicBlock)block{
    if (block != voicedecodeBlock) {
        voicedecodeBlock = [block copy];
    }
}

-(id)init{
    self = [super init];
    if(self){
    }
    return self;
}



-(void)initwithhomelisen:(int)sec{
    myTimer = [NSTimer scheduledTimerWithTimeInterval:sec target:self selector:@selector(sectimecall) userInfo:nil repeats:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector: @selector(receiveSoundData:) name:MSG_DREAMVOC_SOUNDDECODER  object: nil];
    [[dvSoundDecoder instance] dv_open];
//    [[dvSoundDecoder instance] openIbeacon];
    
}

-(void)sectimecall{
    if (myTimer) {
        [myTimer invalidate];
        myTimer = nil;
        [self dvvoiceend];
    }
}
-(void)setmytimernil{
    if (myTimer) {
        [myTimer invalidate];
        myTimer = nil;
    }
}

- (void)receiveSoundData : (NSNotification*)notification
{
    if (myTimer) {
        [myTimer invalidate];
        myTimer = nil;
        if (voicedecodeBlock) {
            voicedecodeBlock();
        }
    }
    int nVal = [[notification object] intValue];
    NSString *codereturn = (NSString *)[notification object];
    if(nVal > 0)
    {
//        [[dvSoundDecoder instance] playsound:1002];
//
//        UILocalNotification *notification = [[UILocalNotification alloc] init];
//        notification.alertBody = @"Welcome to Suning";
//        [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
        [self dvvoiceend];
        if ([_delegate respondsToSelector:@selector(VoiceGetted:)])
        {
            [_delegate VoiceGetted:codereturn];
        }


    }
}

-(void)dvvoiceend{
    [[dvSoundDecoder instance] dv_close];
//    [[dvSoundDecoder instance] closeIbeacon];
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

@end
