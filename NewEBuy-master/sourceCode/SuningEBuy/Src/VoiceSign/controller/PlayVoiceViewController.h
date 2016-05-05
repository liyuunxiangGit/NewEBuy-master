//
//  PlayVoiceViewController.h
//  SuningEBuy
//
//  Created by leo on 14-4-9.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "DVVoiceModel.h"
#import "DVCircle.h"
//#import "EZAudio.h"
#import "QYaoHttpService.h"
#import <AVFoundation/AVFoundation.h>
#import "VoiceSignDTO.h"
//#import "NearbySuningDTO.h"
//#import "SuningStoreInfoService.h"
#import "VoiceCodeActivityService.h"
#import "ActiveRuleViewController.h"
#import "VoiceActiveDTO.h"

@interface PlayVoiceViewController : CommonViewController<VoiceDelegate,VoiceCodeActivityServiceDelegate,QYaoHttpServiceDelegate>{
    NSTimer *myTimer;
}
@property (nonatomic,strong)     DVCircle *circleview;
@property (nonatomic,strong)     DVVoiceModel *dvvoice;
@property (nonatomic,strong)     UIView *loginview;
@property (nonatomic,strong)     UIImageView *circebackview;
@property (nonatomic,strong)     UIButton *backGroundBtn;
@property (nonatomic,strong)     QYaoHttpService *signservice;   //签到，摇一摇跟摇一摇抽奖页面公用同一个接口
@property (nonatomic,strong)     NSDictionary *VoiceCode;
@property (nonatomic,assign)     BOOL   issign;                 //是否只是签到
@property (nonatomic,strong)     UIImageView *backView;
@property (nonatomic,strong)    VoiceActiveDTO *voiceActiveDTO;
@property (nonatomic, strong) VoiceCodeActivityService    *listService;

-(void)listenbegin;
-(void)sendChouJiangRequest;
@end
