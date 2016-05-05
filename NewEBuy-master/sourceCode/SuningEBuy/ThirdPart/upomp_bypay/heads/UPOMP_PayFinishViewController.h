//
//  UPOMP_PayFinishViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_ViewController.h"
#import "UPOMP_KaNet.h"

@interface UPOMP_PayFinishViewController : UPOMP_ViewController<UITableViewDataSource,UITableViewDelegate,UPOMP_KaNetDelegate>{
    IBOutlet UITableView *myTabelView;
    
    IBOutlet UITableViewCell *topCell;
    IBOutlet UIImageView *topBG;
    
    IBOutlet UITableViewCell *resultCell;
    IBOutlet UIImageView *resultBG;
    IBOutlet UILabel *resultText;
    IBOutlet UILabel *resultValue;
    IBOutlet UIView *resultLine;
    IBOutlet UIImageView *resultIcon;
    
    IBOutlet UITableViewCell *nameCell;
    IBOutlet UIImageView *nameBG;
    IBOutlet UILabel *nameText;
    IBOutlet UILabel *nameValue;
    IBOutlet UIView *nameLine;
    
    IBOutlet UITableViewCell *amtCell;
    IBOutlet UIImageView *amtBG;
    IBOutlet UILabel *amtText;
    IBOutlet UILabel *amtValue;
    IBOutlet UIView *amtLine;
    
    IBOutlet UITableViewCell *numberCell;
    IBOutlet UIImageView *numberBG;
    IBOutlet UILabel *numberText;
    IBOutlet UILabel *numberValue;
    IBOutlet UIView *numberLine;
    IBOutlet UIImageView *numberIcon;
    
    IBOutlet UITableViewCell *timeCell;
    IBOutlet UIImageView *timeBG;
    IBOutlet UILabel *timeText;
    IBOutlet UILabel *timeValue;
    IBOutlet UIView *timeLine;
    
    IBOutlet UITableViewCell *descCell;
    IBOutlet UIImageView *descBG;
    IBOutlet UILabel *descText;
    IBOutlet UILabel *descValue;
    
    IBOutlet UITableViewCell *bottomCell;
    IBOutlet UIImageView *bottomBG;
    
    IBOutlet UITableViewCell *finishCell;
    IBOutlet UIButton *finishButton;
    
    NSMutableArray *cellArray;
    BOOL isRegist;
    
    UPOMP_KaNet *net;
}
-(IBAction)finish:(id)sender;
@end
