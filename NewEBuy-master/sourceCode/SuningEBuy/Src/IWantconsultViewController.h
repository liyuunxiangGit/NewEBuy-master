//
//  IWantconsultViewController.h
//  SuningEBuy
//
//  Created by sn－wahaha on 14-6-19.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "ConsultListDTO.h"
#import "PlaceholderTextView.h"
#import "ConsultationService.h"

@interface IWantconsultViewController : CommonViewController<ConsultationDelegate,UITextViewDelegate>
@property (nonatomic,strong) SendConsultListDTO *senddto;
@property (nonatomic,strong) NSString *iscflag;
@property (nonatomic,strong) UILabel *storyname;
@property (nonatomic,strong) UIButton *consulttype;
@property (nonatomic,strong) PlaceholderTextView *textview;
@property (nonatomic,strong) NSArray  *modelarray;
@property (nonatomic,strong)    ConsultationService *httpsend;
@property (nonatomic,strong) UIView  *tablebackview;
@property (nonatomic,strong) NSString *store;
@end
