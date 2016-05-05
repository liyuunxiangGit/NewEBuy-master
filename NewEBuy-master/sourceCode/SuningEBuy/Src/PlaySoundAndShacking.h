//
//  PlaySoundAndShacking.h
//  SuningEBuy
//
//  Created by 刘坤 on 11-10-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PlaySoundAndShacking : NSObject


+ (void)playSoundAndShacking:(BOOL)isSucceed;

+ (void)playSound;

+ (void)playShacking;

@end
