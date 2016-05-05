//
//  UPOMP_CVN2CellViewController.h
//  UPOMP
//
//  Created by pei xunjun on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UPOMP_CellViewController.h"
#import "UPOMP_KeyBoardView.h"
@interface UPOMP_CVN2CellViewController : UPOMP_CellViewController<UITextFieldDelegate,UPOMP_KeyBoardViewDelegate>{
    IBOutlet UITextField *myField;
    IBOutlet UILabel* label;
    IBOutlet UIButton* bg;
    IBOutlet UIButton *infoButton;
    UPOMP_KeyBoardView *keyBoard;
    BOOL noTitel;
}
-(IBAction)selectBG:(id)sender;
-(IBAction)infoAct:(id)sender;
@property BOOL noTitel;
@end
