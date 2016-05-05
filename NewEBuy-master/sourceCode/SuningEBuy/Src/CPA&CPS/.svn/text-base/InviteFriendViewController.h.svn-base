//
//  InviteFriendViewController.h
//  SuningEBuy
//
//  Created by leo on 14-3-7.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "InvitationService.h"
#import "SNShareKit.h"
#import <MessageUI/MessageUI.h>
#import "WeiboSDK.h"
@interface InviteFriendViewController : CommonViewController<InvitationServiceDelegate,WXApiDelegate,MFMessageComposeViewControllerDelegate,ShareContentViewControllerDelegate>
{
    enum WXScene _scene;

}
@property (nonatomic, copy)   NSString *nickName;
@property (nonatomic, copy) NSString *shareTitle;
@property (nonatomic, copy) NSString *shareUrl;
@property (strong,nonatomic)  InvitationService *invita;

@end
