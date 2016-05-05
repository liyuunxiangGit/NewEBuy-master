//
//  PlaySoundAndShacking.m
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "PlaySoundAndShacking.h"


@implementation PlaySoundAndShacking



+ (void)playSoundAndShacking:(BOOL)isSucceed
{
    
    NSNumber *isSound = [Config currentConfig].isSoundOn;
    
    NSNumber *isShacking = [Config currentConfig].isShackOn;
    
    if ([isSound boolValue]) 
    {
		if (isSucceed == 1) 
        {
			SystemSoundID soundID;
            NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"soundSucceed" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
            AudioServicesPlaySystemSound(soundID);
		}
        else 
        {
			SystemSoundID soundID;
            NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"Taito_Carousel" ofType:@"wav"];
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
            AudioServicesPlaySystemSound(soundID);
		}
	}
	if ([isShacking boolValue])
    {
		AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
	}
}

+ (void)playSound
{
    SystemSoundID soundID;
    NSString *soundFile = [[NSBundle mainBundle]pathForResource:@"soundSucceed" ofType:@"wav"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:soundFile], &soundID);
    AudioServicesPlaySystemSound(soundID);
}

+ (void)playShacking
{
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
}


@end
