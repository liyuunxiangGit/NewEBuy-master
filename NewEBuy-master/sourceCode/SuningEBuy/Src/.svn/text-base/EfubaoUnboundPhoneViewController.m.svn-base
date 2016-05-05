//
//  EfubaoUnboundPhoneViewController.m
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EfubaoUnboundPhoneViewController.h"
#import "BoundPhoneViewController.h"

@implementation EfubaoUnboundPhoneViewController

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
    
    frame.origin.y = frame.origin.y + self.myTableView.height + 10 ;
    
    self.descLabel.text = L(@"activated_phone_desc");
    self.descLabel.textColor = [UIColor darkRedColor];
    
    frame.size.height = [self getDescHeight];
    
    self.descLabel.frame = frame;
    
    [self.view addSubview:self.descLabel];
    
    frame.origin.y = frame.origin.y + self.descLabel.height + 20;
    
    frame.size.height = 40;
    
    self.activateButton.frame = frame;
    
    [self.view addSubview:self.activateButton];
    
    [self.activateButton setTitle:L(@"activated_phone") forState:UIControlStateNormal];

}

- (void)initAlertInfo{
    self.alertString =  L(@"unActivated");
}

- (void)activeAction:(id)sender{
    
    BoundPhoneViewController *controller = [[BoundPhoneViewController alloc] init];
    controller.isEfubaoBound = YES;
    [self.navigationController pushViewController:controller animated:YES];
    TT_RELEASE_SAFELY(controller);
    
}

@end
