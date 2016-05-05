//
//  UPOMP_PayTypeViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-14.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_MainViewController.h"
#import "UPOMP_CheckImageCellViewController.h"
#import "UPOMP_PhoneNumCellViewController.h"
#import "UPOMP_CardNumCellViewController.h"
#import "UPOMP_ViewController.h"
#import "UPOMP_KaNet.h"

@interface UPOMP_PayTypeViewController : UPOMP_ViewController<UITableViewDataSource,UITableViewDelegate,UPOMP_KaNetDelegate,MoreButtonDelegate>{
    
    IBOutlet UIButton *okButton;
    IBOutlet UITableViewCell *okButtonCell;
    
    IBOutlet UIButton *escButton;
    
    IBOutlet UITableView *myTabelView;
    
    IBOutlet UITableViewCell *buttonCell;
    IBOutlet UIButton *button;
    
    IBOutlet UITableViewCell *textCell;
    IBOutlet UILabel *textLabel;
    
    
    IBOutlet UITableViewCell *cardNum0Cell;
    IBOutlet UIButton *cardNum0Button;
    
    IBOutlet UITableViewCell *cardNum1Cell;
    IBOutlet UIButton *cardNum1Button;
    
    IBOutlet UITableViewCell *cardNum2Cell;
    IBOutlet UIButton *cardNum2Button;
    
    NSMutableArray *cellArray;
    
    
    UPOMP_CheckImageCellViewController *checkImage;
    UPOMP_PhoneNumCellViewController *phoneNum;
    UPOMP_CardNumCellViewController *cardNum;
    UPOMP_KaNet *net;
    
    BOOL isFirstLogin;
    BOOL isFirstCardCheck;
    BOOL hasHis;
    BOOL isSelectView;
    int selectIndex;
}
-(IBAction)okAct:(id)sender;
-(IBAction)closeAct:(id)sender;
-(IBAction)changeAct:(id)sender;
-(IBAction)selectCard:(UIButton*)sender;
@end
