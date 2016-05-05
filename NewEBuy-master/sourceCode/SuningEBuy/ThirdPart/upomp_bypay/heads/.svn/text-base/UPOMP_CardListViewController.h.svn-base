//
//  UPOMP_CardListViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-8-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_ViewController.h"
#import "UPOMP_KaNet.h"

@interface UPOMP_CardListViewController : UPOMP_ViewController<UITableViewDataSource,UITableViewDelegate,UPOMP_KaNetDelegate>{
    IBOutlet UITableView *myTabelView;
    IBOutlet UIButton *backButton;
    NSMutableArray *allArray;
    UPOMP_KaNet *net;
    BOOL isQP;
}
-(IBAction)back:(id)sender;
@property BOOL isQP;
@end
