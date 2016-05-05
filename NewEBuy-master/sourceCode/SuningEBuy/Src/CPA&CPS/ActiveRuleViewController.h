//
//  ActiveRuleViewController.h
//  SuningEBuy
//
//  Created by leo on 14-3-13.
//  Copyright (c) 2014年 Suning. All rights reserved.
//

#import "CommonViewController.h"
#import "InvitationService.h"


@interface ActiveRuleViewController : CommonViewController<InvitationServiceDelegate>

@property (nonatomic,strong) UIWebView *webView;
- (id)init:(NSString *)urlString;
@end
