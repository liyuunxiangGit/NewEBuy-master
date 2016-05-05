//
//  VoiceSignService.h
//  SuningEBuy
//
//  Created by leo on 14-4-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "DataService.h"

@protocol VoiceSignServiceDelegate ;

@interface VoiceSignService : DataService{
    HttpMessage        *informationListHttpMsg;

}

-(void)beginSignHttpRequest:(NSString *)voicecode;
@property (nonatomic, weak) id<VoiceSignServiceDelegate> delegate;

@end

@protocol VoiceSignServiceDelegate <NSObject>

- (void)didSendSignRequestComplete:(VoiceSignService *)service  Result:(BOOL)isSuccess;

@end