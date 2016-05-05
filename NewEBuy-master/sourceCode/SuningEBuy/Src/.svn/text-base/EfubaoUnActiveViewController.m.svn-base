//
//  EfubaoUnActive.m
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EfubaoUnActiveViewController.h"
#import "ActiveEfubaoViewController.h"

@implementation EfubaoUnActiveViewController

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

-(void)loadView{
    
    [super loadView];
    
    self.hasSuspendButton = YES;
}

-(void)initActiveView{
    
    CGRect frame = self.myTableView.frame;
    
    frame.origin.x = 10;
    
    frame.size.width= 300;
    
    frame.origin.y = frame.origin.y + self.myTableView.height + 10;
    
    self.descLabel.text = L(@"activated_efubao_desc");
    self.descLabel.textColor = [UIColor orange_Light_Color];//[UIColor colorWithRed:228/255.0 green:82/255.0 blue:50/255.0 alpha:1];
    
    frame.size.height = [self getDescHeight];
    
    self.descLabel.frame = frame;

    [self.view addSubview:self.descLabel];
    
    frame.origin.y = frame.origin.y + self.descLabel.height + 10;
    
    frame.size.height = 40;
    
    self.activateButton.frame = frame;
    
    [self.view addSubview:self.activateButton];
    
    [self.activateButton setTitle:L(@"active_Efubao") forState:UIControlStateNormal];
    
}

- (void)initAlertInfo{
    
    self.alertString =  L(@"unActivated");
    
}

- (void)activeAction:(id)sender{
    //add by xingxianping
    NSString *logonName = [UserCenter defaultCenter].userInfoDTO.logonId;
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    if ([emailTest evaluateWithObject:logonName]) {
        [self presentSheet:L(@"MyEBuy_PleaseGoToWebsiteToActivateEmailAccount")];
        
        return;
    }
    ActiveEfubaoViewController *controller = [[ActiveEfubaoViewController alloc] init];
    
    [self.navigationController pushViewController:controller animated:YES];
    
    TT_RELEASE_SAFELY(controller);
    
}

@end
