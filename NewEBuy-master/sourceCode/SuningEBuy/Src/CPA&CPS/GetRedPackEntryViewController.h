//
//  GetRedPackEntryViewController.h
//  SuningEBuy
//
//  Created by leo on 14-3-11.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "InvitationService.h"
@interface GetRedPackEntryViewController : CommonViewController<InvitationServiceDelegate>

@property (nonatomic,strong) UILabel *totalcount;
@property (nonatomic,strong) UILabel *tuijian;
@property (nonatomic,strong) UILabel *xiadan;
@property (nonatomic,strong) UITextView *note;
@property(nonatomic,strong)  UITextView *invitetext;
@property (nonatomic,strong)InvitationService *invita;
@property (nonatomic,strong)NSString *activerule;
@property (nonatomic,strong)NSString *activetitle;
@property (nonatomic,strong)NSString *activeurl;

@end
