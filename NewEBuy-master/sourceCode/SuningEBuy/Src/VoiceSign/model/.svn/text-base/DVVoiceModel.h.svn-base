//
//  DVVoiceModel.h
//  SuningEBuy
//
//  Created by leo on 14-4-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    VoiceToSign,//声波签到
    VoiceToPreferential//声波优惠
    
}VoiceType;

@protocol VoiceDelegate <NSObject>

@optional
- (void)VoiceGetted:(NSString *)voicetype;

@end


@interface DVVoiceModel : NSObject
{
    SNBasicBlock       voicedecodeBlock;
    NSTimer* myTimer;
}
- (void)setVoicedecodeBlock:(SNBasicBlock)block;
-(void)initwithhomelisen:(int)sec;
//-(void)dvvoicebeginlisten;
-(void)setmytimernil;
-(void)sectimecall;
@property (nonatomic, weak) id<VoiceDelegate> delegate;
@end
