//
//  VoiceSignViewController.h
//  SuningEBuy
//
//  Created by leo on 14-4-10.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "SNShareKit.h"
#import "ChooseShareWayView.h"
#import "QYaoYiYaoDTO.h"
#import "VoiceSignDTO.h"

@interface VoiceSignViewController : CommonViewController<ChooseShareWayViewDelegate>

@property(nonatomic,strong) UIView  *markwords;
@property(nonatomic,strong) UILabel *welcometext;
@property(nonatomic,strong) UIView  *infoview;
@property(nonatomic,strong) UILabel  *exchangelabel;
@property (nonatomic, strong) SNShareKit              *shareKit;
@property (nonatomic, strong) ChooseShareWayView    *chooseShareWayView; //分享方式

@property (nonatomic,strong) EGOImageButton   *buttombanner;
@property (nonatomic, strong) VoiceSignDTO *signdto;


- (id)initWithdto:(VoiceSignDTO *)dto;
@end
