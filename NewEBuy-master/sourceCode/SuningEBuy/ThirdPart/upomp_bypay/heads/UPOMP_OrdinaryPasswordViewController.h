//
//  UPOMP_OrdinaryPasswordViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_MainViewController.h"
#import "UPOMP_ViewController.h"
#import "UPOMP_PinCellViewController.h"
#import "UPOMP_CheckImageCellViewController.h"
#import "UPOMP_CVN2CellViewController.h"
#import "UPOMP_PanDateCellViewController.h"
#import "UPOMP_CheckPhoneCellViewController.h"
#import "UPOMP_KaNet.h"

@interface UPOMP_OrdinaryPasswordViewController : UPOMP_ViewController<UITableViewDataSource,UITableViewDelegate,UPOMP_KaNetDelegate>{//MoreButtonDelegate
    IBOutlet UITableView *myTabelView;
    
    IBOutlet UITableViewCell *topCell;
    IBOutlet UIImageView *topBG;
    
    
    IBOutlet UITableViewCell *cardTypeCell;
    IBOutlet UIImageView *cardTypeBG;
    IBOutlet UILabel *cardTypeValue;
    IBOutlet UIView *cardTypeLine;
    IBOutlet UIImageView *cardTypeIcon;
    
    
    IBOutlet UITableViewCell *phoneNumCell;
    IBOutlet UIImageView *phoneNumBG;
    IBOutlet UILabel *phoneNumValue;
    IBOutlet UIImageView *phoneNumIcon;
    
    
    IBOutlet UITableViewCell *bottomCell;
    IBOutlet UIImageView *bottomBG;
    
    IBOutlet UIButton *nextButton;
    IBOutlet UITableViewCell *buttonCell;
    
    IBOutlet UIButton *escButton;
    
    int payType;
    NSMutableArray *cellArray;
    UPOMP_CheckPhoneCellViewController *phoneCheck;
    UPOMP_PinCellViewController *pinCell;
    UPOMP_CheckImageCellViewController *cImageCell;
    UPOMP_CVN2CellViewController *cvn2Cell;
    UPOMP_PanDateCellViewController *panDateCell;
    UPOMP_KaNet *net;
    
}
-(IBAction)next:(id)sender;
-(IBAction)back:(id)sender;
@end
