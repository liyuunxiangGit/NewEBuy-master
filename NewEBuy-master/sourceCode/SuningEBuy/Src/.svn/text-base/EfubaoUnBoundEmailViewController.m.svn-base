//
//  EfubaoUnBoundEmail.m
//  SuningEBuy
//
//  Created by shasha on 12-9-3.
//  Copyright (c) 2012年 Suning. All rights reserved.
//

#import "EfubaoUnBoundEmailViewController.h"

@implementation EfubaoUnBoundEmailViewController

- (id)init {
    
    self = [super init];
    
    if (self) {
        
    }
    return self;
}

-(void)initActiveView{
    
    CGRect frame = self.myTableView.frame;
    
    frame.origin.x = 10;
    
    frame.size.width= 300;
    
    frame.origin.y = frame.origin.y + self.myTableView.height;
    
    self.descLabel.text = L(@"Active_Email");
    self.descLabel.textColor = [UIColor darkRedColor];
    
    frame.size.height = [self getDescHeight];
    
    self.descLabel.frame = frame;
    
    [self.view addSubview:self.descLabel];
    
}

- (void)initAlertInfo{
    
    self.alertString =  L(@"unActivated");
    
}


@end
