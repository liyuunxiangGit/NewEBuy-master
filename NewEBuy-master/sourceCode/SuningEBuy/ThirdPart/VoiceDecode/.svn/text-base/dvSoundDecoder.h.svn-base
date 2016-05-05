//
//  LimsAudioQueueDecorder.h
//  AudioQueueTest1
//
//  Created by zhaoxia wang on 12-9-20.
//  Copyright (c) 2012年 limsolution. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

#define INVALID_VALUE -1
#define MSG_DREAMVOC_SOUNDDECODER @"DREAMVOC_SOUNDDECODER"

@interface dvSoundDecoder : NSObject

-(BOOL)     dv_open;
-(void)     dv_close;
-(void)     pause;
-(void)     resume;

-(void)     playsound:(int)soundid ;
- (void) openIbeacon;
- (void) closeIbeacon;


-(double)   power;
-(double)   decodeInterval;
-(Boolean)  isruning;
-(NSString*) decode_version;
-(void)     setappid:(NSString*)appid;


+(id)       instance;
@end
